<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Clinics extends Eloquent
{
	public $timestamps = false;
	protected $table = 'Clinics';
	protected $guarded = ['clinic_id'];
	protected $searchable = ['street_address', 'barangay', 'city'];
}