<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
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
        $htmlClinics = '';
        $htmlSrvcs = '';
        $htmlAffil = '';
        $htmlConds = '';

        if (!empty($clinics)) {
            foreach ($clinics as $k => $v) {
                $v['clinic_id'] = encrypt($v['clinic_id']);
                $htmlClinics .= $this->view->fetch('dr/clinic_item.twig', ['clinic' => $v]);
            }
        }

        if (!empty($meta['service'])) {
            foreach ($meta['service'] as $k => $v) {
                $v['meta_id'] = encrypt($v['meta_id']);
                $htmlSrvcs = $this->view->fetch('dr/list_item.twig', $v);
            }
        }

        if (!empty($meta['affiliate'])) {
            foreach ($meta['affiliate'] as $k => $v) {
                $v['meta_id'] = encrypt($v['meta_id']);
                $htmlAffil = $this->view->fetch('dr/list_item.twig', $v);
            }
        }

        if (!empty($meta['condition'])) {
            foreach ($meta['condition'] as $k => $v) {
                $v['meta_id'] = encrypt($v['meta_id']);
                $htmlConds = $this->view->fetch('dr/list_item.twig', $v);
            }
        }        

        $this->view->render($response, 'dr/profile_edit.twig', [
            'js' => [url('/assets/js/dr/profile_edit.js')],
            'css' => [url('/assets/css/dr/profile_edit.css')],
            'clinics' => $htmlClinics,
            'conditions' => $htmlConds,
            'services' => $htmlSrvcs,
            'affiliates' => $htmlAffil,
        ]);
    }
}