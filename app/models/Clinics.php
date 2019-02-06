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
}