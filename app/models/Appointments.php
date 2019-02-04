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
    			'photo',
    		])
    		->where('account_id', $acctId)
    		->first()
    		->toArray();
    		$data = array_merge($acct, $data);
    	} else if (!empty($data['photo'])) {
			$file = $data['photo'];

			if ($file->getError() === UPLOAD_ERR_OK) {
				$directory = 'appt';
		        $filename = moveUploadedFile($directory, $file);
		        $data['photo'] = "storage/$directory/$filename";
		    }
		}

		$data['clinic_id'] = $clinicId;
		$data['booked_by'] = $acctId;

    	$appt = new Appointments;
		$appt->fill($data)->save();
		$apptId = $appt->id;

		$salt = cookie('accToken');
		$char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
		$hashids = new \Hashids\Hashids($salt, 8, $char);
		$apptId = $hashids->encode($apptId);

		$result['appt'] = $apptId;
		$result['succ'] = true;

    	return $result;
	}

	/**
	 * Get appointment detials for confirmation and viewing
	 */

	public static function fetchAppt(string $apptId)
	{
		$salt = cookie('accToken');
		$char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
		$hashids = new \Hashids\Hashids($salt, 8, $char);
		$apptId = $hashids->decode($apptId);

		if (empty($apptId)) {
			return null;
		}

		$apptId = $apptId[0];
		$data = Appointments::where('appointment_id', $apptId)
		->join('Clinics', 'Clinics.clinic_id', '=', 'Appointments.clinic_id')
		->join('Doctors', 'Doctors.doctor_id', '=', 'Clinics.doctor_id')
		->join('Accounts', 'Accounts.account_id', '=', 'Appointments.booked_by')
		->first([
			'Appointments.first_name as pat_fname',
			'Appointments.middle_name as pat_mname',
			'Appointments.last_name as pat_lname',
			'Appointments.schedule',
			'Appointments.purpose',
			'Appointments.address as pat_add',
			'Appointments.birthdate',
			'Appointments.gender',
			'Appointments.email_address',
			'Appointments.photo as pat_photo',
			'Appointments.date_booked',
			'Appointments.status',
			'Appointments.for_other',
			'Clinics.name as clinic',
			'Clinics.street_address',
			'Clinics.barangay',
			'Clinics.city',
			'Clinics.schedule as clinic_hrs',
			'Doctors.doctor_id',
			'Doctors.first_name as doc_fname',
			'Doctors.middle_name as doc_mname',
			'Doctors.last_name as doc_lname',
			'Doctors.photo as doc_photo',
			'Doctors.specialization',
			'Accounts.first_name as bookedby_fname',
			'Accounts.middle_name as bookedby_mname',
			'Accounts.last_name as bookedby_lname',
			'Accounts.email_address as bookedby_email',
		]);

		if (empty($data)) {
			return null;
		}

		$data = $data->toArray();

		$fname = $data['doc_fname'];
		$mname = $data['doc_mname'];
		$lname = $data['doc_lname'];
		$fullname = formatName($fname, $mname, $lname);
		$data['doctor'] = $fullname;
		$data['doc_photo'] = getPhoto($data['doc_photo']);

		$fname = $data['pat_fname'];
		$mname = $data['pat_mname'];
		$lname = $data['pat_lname'];
		$fullname = formatName($fname, $mname, $lname);
		$data['patient'] = $fullname;
		$data['pat_photo'] = getPhoto($data['pat_photo']);

		$fname = $data['bookedby_fname'];
		$mname = $data['bookedby_mname'];
		$lname = $data['bookedby_lname'];
		$fullname = formatName($fname, $mname, $lname);
		$data['bookedby_name'] = $fullname;

		$clinicAdd = $data['street_address'] . ', ';
		$brgy = $data['barangay'];
		$city = $data['city'];

		if ($brgy) {
			$clinicAdd .= "$brgy, ";
		}

		$clinicAdd .= $city;
		$data['clinic_add'] = $clinicAdd;

		$data['schedule'] = date('l, F d, Y', strtotime($data['schedule']));
		$data['date_booked'] = date('F d, Y h:m:s A', strtotime($data['date_booked']));
		
		$data['gender'] = $data['gender'] == 'M' ? 'Male' : 'Female';
		$data['age'] = calcAge($data['birthdate']);
		$data['clinic_hrs'] = json_decode($data['clinic_hrs'], true);

		$data['appointment_id'] = $hashids->encode($apptId);
		$data['doctor_id'] = $hashids->encode($data['doctor_id']);

		unset(
			$data['doc_fname'],
			$data['doc_mname'],
			$data['doc_lname'],
			$data['pat_fname'],
			$data['pat_mname'],
			$data['pat_lname'],
			$data['bookedby_fname'],
			$data['bookedby_mname'],
			$data['bookedby_lname'],
			$data['street_address'],
			$data['barangay'],
			$data['city'],
			$data['birthdate'],
			$data['for_other'],
			$data['bookedby_photo']
		);

		return $data;
	}
}