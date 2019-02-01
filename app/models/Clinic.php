<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Clinic extends Model
{
	public $timestamps = false;
	protected $table = 'Clinics';
	protected $fillable = [
		'doctor_id',
		'namespace',
		'street_address',
		'barangay',
		'city',
	];
	protected $searchable = [
        'street_address',
		'barangay',
		'city',
    ];
}