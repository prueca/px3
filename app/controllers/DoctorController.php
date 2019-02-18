<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \Illuminate\Database\Capsule\Manager as DB;
use \App\Models\Doctors;
use \App\Models\Clinics;

class DoctorController
{
	/**
	 * Bind dependencies
	 */

	public function __construct(\Slim\Container $ci)
	{
		$this->app = $ci['app'];
    	$this->view = $ci['view'];
    	$this->csrf = $ci['csrf'];
	}

	/**
	 * Home page
	 */

    public function home($request, $response, $args)
    {
	    $tokenName = $request->getAttribute('csrf_name');
	    $tokenVal = $request->getAttribute('csrf_value');

		$this->view->render($response, 'dr/home.twig', [
			'pagetype' => 'd',
			'css' => [url('/assets/css/dr/home.css')],
			'js' => [
                url('/assets/js/login.js'),
                url('/assets/js/register.js'),
            ],
			'token' => [
				'name' => $tokenName,
				'val' => $tokenVal
			]
		]);
    }

    /**
	 * Myaccount page
	 */

    public function myaccount($request, $response, $args)
    {
    	$docId = session('acct.id');
    	$acct = Doctors::getAcct($docId);
    	$meta = Doctors::getMeta($docId);
    	$clinics = Clinics::getClinics($docId);

	    $this->view->render($response, 'dr/myaccount.twig', [
	    	'acct' => $acct,
	    	'meta' => $meta,
	    	'clinics' => $clinics,
	    	'css' => [url('/assets/css/dr/myaccount.css')],
	    ]);
    }

    /**
     * Myaccount edit page
     */

    public function editAcct($request, $response, $args)
    {
    	$docId = session('acct.id');
    	$acct = Doctors::where('doctor_id', $docId)->first();
    	$acct->photo = getPhoto($acct->photo);

    	$this->view->render($response, 'dr/myaccount_edit.twig', [
    		'acct' => $acct,
    		'css' => [url('/assets/css/dr/myaccount_edit.css')],
    		'js' => [url('/assets/js/dr/myaccount_edit.js')],
    	]);
    }

    /**
     * Update myaccount
     */

    public function updateAcct($request, $response, $args)
    {
    	$post = $request->getParsedBody();
    	$uploadedFiles = $request->getUploadedFiles();
    	$photo = $uploadedFiles['photo'];

    	if ($photo->getError() === UPLOAD_ERR_OK) {
    		$post['photo'] = $photo;
    	}

    	$docId = session('acct.id');
    	$data = Doctors::updateAcct($docId, $post);
    	return $response->withJson($data);
    }

    /**
     * Profile edit page
     */

    public function editProfile($request, $response, $args)
    {
        $docId = session('acct.id');
        $clinics = Clinics::getClinics($docId);
        $meta = Doctors::getMeta($docId);
        $spec = Doctors::select('specialization')
        ->where('doctor_id', $docId)
        ->first()
        ->specialization;

        $htmlClinics = '';
        $htmlMeta = [];

        if (!empty($clinics)) {
            foreach ($clinics as $k => $v) {
                $v['clinic_id'] = encrypt($v['clinic_id']);
                $htmlClinics .= $this->view->fetch('dr/clinic_item.twig', $v);
            }
        }

        if (!empty($meta)) {
            foreach ($meta as $type => $arr) {
                $htmlMeta[$type] = '';

                foreach ($arr as $k => $v) {
                    $v['meta_id'] = encrypt($v['meta_id']);
                    $v['meta_key'] = $type;
                    $htmlMeta[$type] .= $this->view->fetch('dr/list_item.twig', $v);
                }
            }
        }

        $this->view->render($response, 'dr/profile_edit.twig', [
            'js' => [url('/assets/js/dr/profile_edit.js')],
            'css' => [url('/assets/css/dr/profile_edit.css')],
            'html' => ['meta' => $htmlMeta, 'clinic' => $htmlClinics],
            'spec' => $spec
        ]);
    }

    /**
     * Update specialization
     */

    public function updateSpec($request, $response, $args)
    {
        $docId = session('acct.id');
        $doc = Doctors::select('doctor_id', 'specialization')
        ->where('doctor_id', $docId)
        ->first();

        if (empty($doc)) {
            return $response->withJson([
                'err' => 'Account not found'
            ]);
        }

        $post = $request->getParsedBody();
        $doc->specialization = $post['spec'];

        if (!$doc->save()) {
            return $response->withJson([
                'err' => 'Application error occurred'
            ]);
        }

        return $response->withJson(['succ' => true]);
    }

    /**
     * Add clinic
     */

    public function addClinic($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $docId = session('acct.id');
        $data = Clinics::addClinic($docId, $post);

        if (!empty($data['err'])) {
            return $response->withJson($data);
        }

        $html = $this->view->fetch('dr/clinic_item.twig', $data);
        return $response->withJson(['html' => $html, 'append' => true]);
    }

    /**
     * Get single clinic data
     */

    public function getClinic($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $clinicId = decrypt($post['id']);
        $docId = session('acct.id');
        
        $data = Clinics::where([
            'clinic_id' => $clinicId,
            'doctor_id' => $docId,
        ])->first();

        if (empty($data)) {
            return $response->withJson(['err' => 'No data found']);
        }

        $data = $data->toArray();
        $data['clinic_id'] = encrypt($data['clinic_id']);
        $data['schedule'] = json_decode($data['schedule'], true);
        unset($data['doctor_id']);
        return $response->withJson($data);
    }

    /**
     * Get single clinic data
     */

    public function updateClinic($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $post['clinic_id'] = decrypt($post['clinic']);
        unset($post['clinic']);

        $docId = session('acct.id');
        $data = Clinics::updateClinic($docId, $post);

        if (!empty($data['err'])) {
            return $response->withJson($data);
        }

        $html = $this->view->fetch('dr/clinic_item.twig', $data);
        return $response->withJson(['html' => $html]);
    }

    /**
     * Delete clinic
     */

    public function deleteClinic($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $clinicId = decrypt($post['id']);
        $docId = session('acct.id');

        $succ = Clinics::where([
            'doctor_id' => $docId,
            'clinic_id' => $clinicId,
        ])->delete();

        return $response->withJson(['succ' => $succ]);
    }

    /**
     * Add meta: condition, service, affiliate
     */

    public function addMeta($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $docId = session('acct.id');
        $data = [
            'doctor_id' => $docId,
            'meta_key' => $post['type'],
            'meta_value' => $post['value'],
        ];

        $dataExists = DB::table('DoctorMeta')
        ->where($data)
        ->exists();

        if ($dataExists) {
            return $response->withJson(['err' => 'Data already exists']);
        }

        $meta = DB::table('DoctorMeta')->insert($data);

        if (empty($meta)) {
            return $response->withJson(['err' => 'Data insertion failed']);
        }

        $html = $this->view->fetch('dr/list_item.twig', $meta);
        return $response->withJson(['html' => $html]);
    }

    /**
     * Update meta: condition, service, affiliate
     */

    public function updateMeta($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $docId = session('acct.id');
        $data = [
            'doctor_id' => $docId,
            'meta_key' => $post['type'],
            'meta_value' => $post['val'],
        ];

        $dataExists = DB::table('DoctorMeta')
        ->where($data)
        ->exists();

        if ($dataExists) {
            return $response->withJson(['err' => 'Data already exists']);
        }

        $metaId = decrypt($post['id']);
        $metaVal = $post['val'];
        $metaKey = $post['type'];

        DB::table('DoctorMeta')
        ->where('meta_id', $metaId)
        ->update(['meta_value' => $metaVal]);

        $metaId = encrypt($metaId);
        $html = $this->view->fetch('dr/list_item.twig', [
            'meta_id' => $metaId,
            'meta_value' => $metaVal,
            'meta_key' => $metaKey,
            'doctor_id' => $metaVal,
        ]);

        return $response->withJson(['html' => $html]);
    }
}