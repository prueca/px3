<?php

namespace App\Models;

use \Illuminate\Database\Eloquent\Model as Eloquent;
use \Illuminate\Database\Capsule\Manager as DB;
use \App\Models\Clinics;

class Doctors extends Eloquent
{
	public $timestamps = false;
	protected $table = 'Doctors';
	protected $primaryKey = 'doctor_id';
	protected $guarded = ['doctor_id'];

	/**
	 * Create new account
	 */

	public static function register(array $data)
	{
		$emailExists = Doctors::where(['email_address' => $data['email_address']])->exists();

		if ($emailExists) {
			return ['err' => 'Email address already exists'];
		}

		$data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
		$newDoc = new Doctors;

		foreach ($data as $k => $v) {
			$newDoc->$k = $data[$k];
		}

		return $newDoc->save();
	}

	/**
	 * Check login credentials
	 */

	public static function checkCred($email, $pass)
	{
		$col = ['doctor_id', 'first_name', 'middle_name', 'last_name', 'email_address', 'password'];
		$doc = Doctors::select($col)->where(['email_address' => $email])->first();

		if (null === $doc || !password_verify($pass, $doc->password)) {
			return false;
		}

		$docId = $doc->doctor_id;
		$fname = $doc->first_name;
		$mname = $doc->middle_name;
		$lname = $doc->last_name;
		$fullname = formatName($fname, $mname, $lname);
		$accToken = bin2hex(random_bytes(16));
		$doc->access_token = $accToken;
		$doc->save();

		session('acct', [
			'type'  => 'd',
			'id'	=> $docId,
			'name'  => $fullname,
			'token' => $accToken,
		]);

		return url('/d/myaccount');
	}

	/**
	 * Search matching doctor
	 */

	public static function matchDoc(string $area, int $offset, string $spec, string $srvc)
	{
		$query = Doctors::select(
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
			$query = Doctors::select(
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
			$query = Doctors::select(
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
			$query = Doctors::select(
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
			$result[$i]['clinics'] = Clinics::select('name', 'street_address', 'barangay', 'city')
			->where('doctor_id', $docId)
			->get()->toArray();
		}

		return $result;
	}

	/**
     * Fetch doctor's data: name, photo, specialization, clinics
     */

	public static function getDoctor(int $docId)
	{
		$data = Doctors::select(
			'first_name',
			'middle_name',
			'last_name',
			'photo',
			'specialization'
		)
		->where('doctor_id', $docId)
		->first();

		if (empty($data)) {
			return null;
		}

		$fname = $data->first_name;
		$mname = $data->middle_name;
		$lname = $data->last_name;
		$fullname = formatName($fname, $mname, $lname);
		$photo = getPhoto($data->photo);
		$spec = ucwords($data->specialization);
		
		$data = Clinics::where('doctor_id', $docId)->get();
		$clinics = $data->isNotEmpty() ? $data->toArray() : [];

		foreach ($clinics as $k => $v) {
			$clinicId = $v['clinic_id'];
			$clinics[$k]['clinic_id'] = encrypt($clinicId);
			$sched = $v['schedule'];
			$clinics[$k]['schedule'] = json_decode($sched);
		}

		return [
			'name' => $fullname,
			'photo' => $photo,
			'spec' => $spec,
			'clinics' => $clinics
		];
	}

	/**
     * Fetch doctor's account data
     */

	public static function getAcct(int $docId)
	{
		$data = Doctors::where('doctor_id', $docId)->first([
			'specialization',
			'first_name',
			'middle_name',
			'last_name',
			'gender',
			'birthdate',
			'contact_number',
			'email_address',
		]);

		if (empty($data)) {
			return null;
		}

		$age = calcAge($data->birthdate);
		$data->age = $age;
		$gen = strtolower($data->gender) == 'm' ? 'Male' : 'Female';
		$data->gen = $gen;
		$data->photo = getPhoto($data->photo);

		return $data->toArray();
	}

	/**
     * Fetch doctor's meta data
     */

	public static function getMeta(int $docId)
	{
		$sql = DB::table('DoctorMeta')
		->select([
			'meta_key',
			'meta_value',
			'meta_id',
			'doctor_id',
		])
		->where('doctor_id', $docId)
		->toSql();

		$stmt = DB::connection()->getPdo()->prepare($sql);
		$stmt->execute([$docId]);
		$data = $stmt->fetchAll(\PDO::FETCH_GROUP|\PDO::FETCH_ASSOC);

		return $data;
	}

	/**
	 * Update account
	 */

	public static function updateAcct(int $docId, array $data)
	{
		if (!isset(
			$data['first_name'],
			$data['middle_name'],
			$data['last_name'],
			$data['gender'],
			$data['address'],
			$data['contact_number'],
			$data['birthdate']
		)) {
			return ['err' => 'Missing required input'];
		}

		$acct = Doctors::where('doctor_id', $docId)->first();

		if (empty($acct)) {
			return ['err' => 'Account not found'];
		}

		$acct->first_name = $data['first_name'];
		$acct->middle_name = $data['middle_name'];
		$acct->last_name = $data['last_name'];
		$acct->gender = $data['gender'];
		$acct->address = $data['address'];
		$acct->contact_number = $data['contact_number'];
		$acct->birthdate = $data['birthdate'];

		if (!empty($data['photo'])) {
			$directory = 'acct';
	        $filename = moveUploadedFile($directory, $data['photo']);
	        $acct->photo = "storage/$directory/$filename";
		}

		if (!$acct->save()) {
			return ['err' => 'Account update failed'];
		}

		$fname = $acct->first_name;
		$mname = $acct->middle_name;
		$lname = $acct->last_name;
		$fullname = formatName($fname, $mname, $lname);
		session('acct.name', $fullname);
		return true;
	}
}