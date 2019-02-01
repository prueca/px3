<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use \App\Models\Clinic;

class Doctor extends Model
{
	public $timestamps = false;
	protected $table = 'Doctors';
	protected $guarded = ['doctor_id'];

	/**
	 * Search matching doctor
	 */

	public static function matchDoc(string $area, int $offset, string $spec, string $srvc)
	{
		$query = Doctor::select(
			'doctor_id',
			'first_name',
			'middle_name',
			'last_name',
			'specialization',
			'photo'
		)->whereIn('doctor_id', function($query) use ($area, $offset) {
			$query->select('doctor_id')
			->from('Clinics')
			->where('doctor_id', '>', $offset)
			->whereRaw('MATCH(`barangay`, `city`) AGAINST(? IN NATURAL LANGUAGE MODE)', [$area]);
		});

		$genericSrvcs = ['consultation', 'prescription', 'medical certification'];
		$srvc = strtolower($srvc);
		$spec = strtolower($spec);

		if ($spec != 'doctor' && !in_array($srvc, $genericSrvcs)) {
			$query = Doctor::select(
				'd.doctor_id',
				'd.first_name',
				'd.middle_name',
				'd.last_name',
				'd.specialization',
				'd.photo'
			)
			->from('Doctors AS d')
			->whereRaw('LOWER(d.specialization) = ?', [$spec])
			->join('DoctorMeta AS dm', 'dm.doctor_id', '=', 'd.doctor_id')
			->where([
				'dm.meta_key' => 'service',
				'dm.meta_value' => $srvc,
			])
			->whereIn('d.doctor_id', function($query) use ($area, $offset) {
				$query->select('doctor_id')
				->from('Clinics')
				->where('doctor_id', '>', $offset)
				->whereRaw('MATCH(`barangay`, `city`) AGAINST(? IN NATURAL LANGUAGE MODE)', [$area]);
			});
		} else if ($spec != 'doctor') {
			$query = Doctor::select(
				'doctor_id',
				'first_name',
				'middle_name',
				'last_name',
				'specialization',
				'photo'
			)
			->whereRaw('LOWER(specialization) = ?', [$spec])
			->whereIn('doctor_id', function($query) use ($area, $offset) {
				$query->select('doctor_id')
				->from('Clinics')
				->where('doctor_id', '>', $offset)
				->whereRaw('MATCH(`barangay`, `city`) AGAINST(? IN NATURAL LANGUAGE MODE)', [$area]);
			});
		} else if (!in_array($srvc, $genericSrvcs)) {
			$query = Doctor::select(
				'd.doctor_id',
				'd.first_name',
				'd.middle_name',
				'd.last_name',
				'd.specialization',
				'd.photo'
			)
			->from('Doctors AS d')
			->join('DoctorMeta AS dm', 'dm.doctor_id', '=', 'd.doctor_id')
			->where([
				'dm.meta_key' => 'service',
				'dm.meta_value' => $srvc,
			])
			->whereIn('d.doctor_id', function($query) use ($area, $offset) {
				$query->select('doctor_id')
				->from('Clinics')
				->where('doctor_id', '>', $offset)
				->whereRaw('MATCH(`barangay`, `city`) AGAINST(? IN NATURAL LANGUAGE MODE)', [$area]);
			});
		}

		$result = $query->orderBy('doctor_id', 'ASC')->limit(10)->get();

		if ($result->isEmpty()) {
			return null;
		}

		$result = $result->toArray();

		foreach ($result as $i => $data) {
			$docId = $data['doctor_id'];
			$result[$i]['clinics'] = Clinic::select('name', 'street_address', 'barangay', 'city')
			->where('doctor_id', $docId)
			->get()->toArray();
		}

		return $result;
	}
}