<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Eloquent;
use App\Models\Accounts;
use App\Models\Clinics;

class Appointments extends Eloquent
{
	const CREATED_AT = 'date_booked';
    const UPDATED_AT = null;
	protected $table = 'Appointments';
	protected $guarded = ['appointment_id', 'date_booked'];

	/**
	 * Count today's appointments for notification
	 */

	public static function countTodaysAppts(int $acctId)
	{
		return Appointments::select(['schedule', 'status'])
		->where(['booked_by' => $acctId, 'status' => 'Settled', 'schedule' => date('Y-m-d')])
		->count();
	}

	/**
	 * Get all booked appointments for logged in patient
	 */

	public static function getAppts(int $acctId, $offset = 0, string $stat = 'all')
	{
		$query = Appointments::select(
			'a.appointment_id',
			'a.clinic_id',
			'a.schedule',
			'a.status',
			'c.name as clinic',
			'd.first_name',
			'd.middle_name',
			'd.last_name'
		)
		->from('Appointments as a')
		->where('booked_by', $acctId);

		if (strtolower($stat) != 'all') {
			$query->where('a.status', $stat);
		}

		$total = $query->count();
		$result = $query->limit(10)->offset($offset)
		->join('Clinics as c', 'c.clinic_id', '=', 'a.clinic_id')
		->join('Doctors as d', 'd.doctor_id', '=', 'c.doctor_id')
		->get();

		foreach ($result as $i => $data) {
			$fname = $data['first_name'];
			$mname = $data['middle_name'];
			$lname = $data['last_name'];
			$doc = formatName($fname, $mname, $lname);
			$sched = date('l, F d, Y', strtotime($data['schedule']));
			$result[$i]['schedule'] = $sched;
			$result[$i]['doctor'] = $doc;

			unset(
				$result[$i]['first_name'],
				$result[$i]['middle_name'],
				$result[$i]['last_name']
			);
		}

		$result['total'] = $total;
		return $result;
	}

	/**
	 * Book appointment
	 */

	public static function bookAppt(int $acctId, array $data)
	{
		$result = ['succ' => false];
		$now = time();

		if (strtotime($data['schedule']) < $now && $data['schedule'] != date('Y-m-d', $now)) {
			$result['err'] = 'Invalid schedule';
			return $result;
		}

		if (!isset($data['clinic'], $data['schedule'], $data['purpose']) || (isset($data['for_other']) && !isset(
			$data['first_name'],
			$data['middle_name'],
    		$data['last_name'],
    		$data['address'],
    		$data['birthdate'],
    		$data['gender'],
    		$data['email_address']
		))) {
    		$result['err'] = 'Missing required input';
    		return $result;
    	}

    	$clinicId = decrypt($data['clinic']);
		unset($data['clinic']);

		$clinic = Clinics::select('schedule')
		->where('clinic_id', $clinicId)
		->first();

		$clinicSched = json_decode($clinic->schedule, true);
		$userSchedDay = strtolower(date('D', strtotime($data['schedule'])));
		$clinicOpen = false;

		foreach ($clinicSched as $sched) {
			$clinicSchedDay = strtolower($sched['day']);
			$closing = strtotime(date('Y-m-d').' '.$sched['closing']);
			$today = $data['schedule'] == date('Y-m-d', $now);

			if ($clinicSchedDay == $userSchedDay && !($today && $now > $closing)) {
				$clinicOpen = true;
				break;
			}
		}

		if (!$clinicOpen) {
			$result[err] =  'Clinic is closed on the preferred date';
			return $result;
		}

    	if (!isset($data['for_other'])) {
    		$acct = Accounts::select([
    			'first_name',
    			'middle_name',
    			'last_name',
    			'address',
    			'birthdate',
    			'gender',
    			'email_address',
    		])
    		->where('account_id', $acctId)
    		->first()
    		->toArray();
    		$data = array_merge($acct, $data);
    	}

		$data['clinic_id'] = $clinicId;
		$data['booked_by'] = $acctId;

    	$appt = new Appointments;
		$appt->fill($data)->save();
		$result['appt'] = $appt->id;
		$result['succ'] = true;

    	return $result;
	}
}