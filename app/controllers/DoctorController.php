<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \Illuminate\Database\Capsule\Manager as DB;
use \App\Models\Doctors;
use \App\Models\Clinics;
use \App\Models\Appointments;

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
    	$files = $request->getUploadedFiles();

        if (isset($files['photo']) && $files['photo']->getError() === UPLOAD_ERR_OK) {
            $post['photo'] = $files['photo'];
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
     * Update clinic
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

        if (DB::table('DoctorMeta')->where($data)->exists()) {
            return $response->withJson(['err' => 'Data already exists']);
        }

        $metaId = DB::table('DoctorMeta')->insertGetId($data);
        $data['meta_id'] = encrypt($metaId);
        $html = $this->view->fetch('dr/list_item.twig', $data);
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

        if (DB::table('DoctorMeta')->where($data)->exists()) {
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

    /**
     * Delete meta: condition, service, affiliate
     */

    public function delMeta($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $docId = session('acct.id');
        $metaId = decrypt($post['id']);

        if (!DB::table('DoctorMeta')->where('meta_id', $metaId)->exists()) {
            return $response->withJson(['err' => 'Data not found']);
        }

        DB::table('DoctorMeta')->where([
            'meta_id' => $metaId,
            'doctor_id' => $docId,
        ])->delete();

        return $response->withJson(['succ', true]);
    }

    /**
     * Appointments page
     */

    public function appointments($request, $response, $args)
    {
        $docId = session('acct.id');
        $apptsArr = Appointments::listAppts($docId);
        $pagination = getPagination($apptsArr['total'], 1);
        unset($apptsArr['total']);

        $this->view->render($response, 'dr/appts_page.twig', [
            'appts' => $apptsArr,
            'pagination' => $pagination,
            'active' => 1,
            'css' => [url('/assets/css/dr/appts_page.css')],
            'js' => [url('/assets/js/dr/appts_page.js')],
        ]);
    }

    /**
     * Get appointments
     */

    public function getAppts($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $acctId = session('acct.id');
        $page = (int) $post['page'];
        $offset = ($page - 1) * 10;
        $stat = $post['filter'];

        $apptsArr = Appointments::listAppts($acctId, $offset, $stat);
        $pagination = getPagination($apptsArr['total'], $page);
        unset($apptsArr['total']);

        $data['appts'] = $this->view->fetch('dr/appts.twig', ['appts' => $apptsArr]);
        $data['pagination'] = $this->view->fetch('dr/pagination.twig', ['pagination' => $pagination, 'active' => $page]);
        return $response->withJson($data);
    }

    /**
     * View appointment details
     */

    public function viewAppt($request, $response, $args)
    {
        $refNo = $args['appt'];
        $appt = Appointments::fetchAppt($refNo);

        if (empty($appt)) {
            return $response->withJson(['err' => 'Invalid code']);
        }
        
        $this->view->render($response, 'dr/view_appt.twig', [
            'appt' => $appt,
            'css' => [url('/assets/css/dr/view_appt.css')],
            'js' => [url('/assets/js/dr/cancel_appt.js')],
        ]);
    }

    /**
     * Cancel appointment
     */

    public function cancelAppt($request, $response, $args)
    {
        $post = $request->getParsedBody();
        $apptId = decrypt($post['appt']);
        $appt = Appointments::find($apptId)->first();

        if (empty($appt)) {
            return $response->withJson(['err' => 'No data found']);
        }

        $appt->status = 'Cancelled';
        $appt->save();

        return $response->withJson(['succ' => true]);
    }
}