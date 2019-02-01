<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Eloquent;

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
}