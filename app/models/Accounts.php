<?php

namespace App\Models;

use \Illuminate\Database\Eloquent\Model as Eloquent;

class Accounts extends Eloquent
{
	public $timestamps = false;
	protected $table = 'Accounts';
	protected $primaryKey = 'account_id';
	protected $guarded = ['account_id'];

	/**
	 * Check login credentials
	 */

	public static function checkCred($email, $pass)
	{
		$col = ['account_id', 'first_name', 'middle_name', 'last_name', 'email_address', 'password'];
		$acct = Accounts::select($col)->where(['email_address' => $email])->first();

		if (null === $acct || !password_verify($pass, $acct->password)) {
			return false;
		}

		$acctId = $acct->account_id;
		$fname = $acct->first_name;
		$mname = $acct->middle_name;
		$lname = $acct->last_name;
		$fullname = formatName($fname, $mname, $lname);
		$accToken = bin2hex(random_bytes(16));
		$acct->access_token = $accToken;
		$acct->save();

		session('acct', [
			'type'  => 'a',
			'id'	=> $acctId,
			'name'  => $fullname,
			'token' => $accToken,
		]);

		return url('/myaccount');
	}

	/**
	 * Create new account
	 */

	public static function register(array $data)
	{
		$emailExists = Accounts::where(['email_address' => $data['email_address']])->exists();

		if ($emailExists) {
			return ['err' => 'Email address already exists'];
		}

		$data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
		$newAcct = new Accounts;

		foreach ($data as $k => $v) {
			$newAcct->$k = $data[$k];
		}

		return $newAcct->save();
	}

	/**
	 * Update account
	 */

	public static function updateAcct(int $acctId, array $data)
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

		$acct = Accounts::where('account_id', $acctId)->first();

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