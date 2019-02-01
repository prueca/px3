<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Account extends Model
{
	const CREATED_AT = 'created_at';
	const UPDATED_AT = null;
	protected $table = 'Accounts';
	protected $fillable = [
		'email_address',
		'password',
		'first_name',
		'middle_name',
		'last_name',
		'gender',
		'address',
		'contact_number',
		'birthdate',
		'photo',
		'reward_points',
		'access_token'
	];

	/**
	 * Check login credentials
	 */

	public static function checkCred($email, $pass)
	{
		$col = ['account_id', 'first_name', 'middle_name', 'last_name', 'email_address', 'password'];
		$data = Account::select($col)->where(['email_address' => $email])->first();

		if (null === $data || !password_verify($pass, $data->password)) {
			return false;
		}

		$acctId = $data->account_id;
		$fname = $data->first_name;
		$mname = $data->middle_name;
		$lname = $data->last_name;
		$fullname = formatName($fname, $mname, $lname);
		$accToken = encrypt("$acctId|$fullname");

		Account::where(['account_id' => $acctId])->update([
			'access_token' => $accToken
		]);

		cookie('accToken', $accToken);
		cookie('acctType', 'a');
		return url('/myaccount');
	}

	/**
	 * Create new account
	 */

	public static function register(array $data)
	{
		$emailExists = Account::where(['email_address' => $data['email_address']])->exists();

		if ($emailExists) {
			return ['err' => 'Email address already exists'];
		}

		$data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
		$newAcct = new Account;

		foreach ($data as $k => $v) {
			$newAcct->$k = $data[$k];
		}

		return $newAcct->save();
	}
}