<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Clinics extends Eloquent
{
	public $timestamps = false;
	protected $table = 'Clinics';
	protected $primaryKey = 'clinic_id';
	protected $guarded = ['clinic_id'];
	protected $searchable = ['street_address', 'barangay', 'city'];

	/**
     * Fetch doctor's Clinics
     */

	public static function getClinics(int $docId)
	{
		$data = Clinics::where('doctor_id', $docId)->get();

		if ($data->isEmpty()) {
			return null;
		}

		$data = $data->toArray();

		foreach ($data as $k => $v) {
			$sched = json_decode($v['schedule'], true);
			$data[$k]['schedule'] = $sched;
			$loc = $v['name'] . ', ' . $v['street_address'] . ', ';

			if (!empty($v['barangay'])) {
				$loc .= $v['barangay'] . ', ';
			}

			$loc .= $v['city'];
			$data[$k]['location'] = $loc;
		}

		return $data;
	}

	/**
	 * Add clinic
	 */

	public static function addClinic(int $docId, array $data)
	{
		$sched = json_decode($data['schedule'], true);

		foreach ($sched as $k => $v) {
			$sched[$k]['opening'] = date('h:i A', strtotime($v['opening']));
	    	$sched[$k]['closing'] = date('h:i A', strtotime($v['closing']));

			foreach ($sched as $key => $val) {
				if ($k != $key && $sched[$k] == $sched[$key]) {
					return ['err' => 'Duplicate schedule'];
				}
			}
		}

		$data['schedule'] = json_encode($sched);
		$data['doctor_id'] = $docId;

		if (Clinics::where($data)->exists()) {
			return ['err' => 'Clinic data already exists'];
		}

		$clinic = Clinics::create($data);
		$clinic->clinic_id = encrypt($clinic->clinic_id);
		$loc = $clinic->name . ', ' . $clinic->street_address . ', ';
		
		if (!empty($clinic->barangay)) {
			$loc .= $clinic->barangay . ', ';
		}

		$loc .= $clinic->city;
		$clinic->location = $loc;
		$clinic->schedule = json_decode($clinic->schedule, true);
		return $clinic->toArray();
	}

	/**
	 * Update clinic
	 */

	public static function updateClinic(int $docId, array $data)
	{
		$sched = json_decode($data['schedule'], true);

		foreach ($sched as $k => $v) {
			$sched[$k]['opening'] = date('h:i A', strtotime($v['opening']));
	    	$sched[$k]['closing'] = date('h:i A', strtotime($v['closing']));

			foreach ($sched as $key => $val) {
				if ($k != $key && $sched[$k] == $sched[$key]) {
					return ['err' => 'Duplicate schedule'];
				}
			}
		}

		$data['schedule'] = json_encode($sched);
		$data['doctor_id'] = $docId;
		$clinicId = $data['clinic_id'];
		$clinic = Clinics::where('clinic_id', $clinicId)->first();

		if (empty($clinic)) {
			return ['err' => 'No data found'];
		}

		$clinic->fill($data)->save();
		$clinic = $clinic->toArray();
		$clinic['clinic_id'] = encrypt($clinicId);
		$loc = $clinic['name'] . ', ' . $clinic['street_address'] . ', ';
		
		if (!empty($clinic['barangay'])) {
			$loc .= $clinic['barangay'] . ', ';
		}

		$loc .= $clinic['city'];
		$clinic['location'] = $loc;
		$clinic['schedule'] = json_decode($clinic['schedule'], true);
		return $clinic;
	}
}