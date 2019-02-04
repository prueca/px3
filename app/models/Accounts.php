<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Accounts extends Eloquent
{
	public $timestamps = false;
	protected $table = 'Accounts';
	protected $guarded = ['account_id'];

	/**
	 * Check login credentials
	 */

	public static function checkCred($email, $pass)
	{
		$col = ['account_id', 'first_name', 'middle_name', 'last_name', 'email_address', 'password'];
		$data = Accounts::select($col)->where(['email_address' => $email])->first();

		if (null === $data || !password_verify($pass, $data->password)) {
			return false;
		}

		$acctId = $data->account_id;
		$fname = $data->first_name;
		$mname = $data->middle_name;
		$lname = $data->last_name;
		$fullname = formatName($fname, $mname, $lname);
		$accToken = encrypt("$acctId|a");

		Accounts::where(['account_id' => $acctId])->update([
			'access_token' => $accToken
		]);

		session('accToken', $accToken);
		session('acctName', $fullname);
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
}