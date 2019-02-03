<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Models\Accounts;
use \App\Models\Appointments;
use \App\Models\Doctors;
use \App\Models\Clinics;

class AccountController
{
	/**
	 * Myaccount page
	 */

	public function myaccount($request, $response, $args)
	{
		// active account data
		$acctId = $request->getAttribute('id');
		$acctName = cookie('acctName');
		$col = ['birthdate', 'gender', 'photo', 'reward_points'];
		$acct = Accounts::select($col)->where('account_id', $acctId)->first();
		$acct->age = calcAge($acct->birthdate);
		$acct->gender = $acct->gender == 'M' ? 'Male' : 'Female';
		$acct->photo = getPhoto($acct->photo);

		// appointments data
		$todaysAppts = Appointments::countTodaysAppts($acctId);
		$apptsArr = Appointments::getAppts($acctId);
		$pagination = getPagination($apptsArr['total'], 1);
		unset($apptsArr['total']);

		$this->view->render($response, 'a/myaccount.twig', [
			'pageType' => 'a',
			'loggedIn' => true,
			'acctName' => $acctName,
			'acct' => $acct,
			'appts' => $apptsArr,
			'pagination' => $pagination,
			'todaysAppts' => $todaysAppts,
			'active' => 1,
			'css' => [url('/assets/css/a/myaccount.css')],
			'js' => [url('/assets/js/a/myaccount.js')],
		]);
	}

	/**
	 * Get appointments
	 */

	public function getAppts($request, $response, $args)
	{
    	$post = $request->getParsedBody();    	
		$acctId = $request->getAttribute('id');
		$page = (int) $post['page'];
    	$offset = ($page - 1) * 10;
    	$stat = $post['filter'];

    	$apptsArr = Appointments::getAppts($acctId, $offset, $stat);
		$pagination = getPagination($apptsArr['total'], $page);
		unset($apptsArr['total']);

		$data['appts'] = $this->view->fetch('a/appts.twig', ['appts' => $apptsArr]);
		$data['pagination'] = $this->view->fetch('a/pagination.twig', ['pagination' => $pagination, 'active' => $page]);
		return $response->withJson($data);
	}

	/**
	 * Search page
	 */

	public function search($request, $response, $args)
	{
		$this->view->render($response, 'a/search.twig', [
			'pageType' => 'a',
			'loggedIn' => true,
			'acctName' => cookie('acctName'),
			'js' => [
				url('/assets/js/a/book.js'),
				url('/assets/js/jquery-ui-1.12.1.custom/jquery-ui.min.js')
			],
			'css' => [
				url('/assets/css/a/search.css'),
				url('/assets/css/a/book_modal.css'),
				url('/assets/js/jquery-ui-1.12.1.custom/jquery-ui.min.css')
			],
		]);
	}

	/**
	 * Search for matching doctor
	 */

	public function matchDoc($request, $response, $args)
	{
    	$post = $request->getParsedBody();
    	$spec = $post['spec'];
    	$srvc = $post['srvc'];
    	$area = $post['area'];
    	$offset = $post['offset'];

    	if (!isset($spec, $srvc, $area, $offset)) {
    		return $response->withJson(['err' => 'Missing required input']);
    	}

    	if ($offset != '0') {
    		$offset = (int) decrypt($offset);
    	}

    	$searchResult = Doctors::matchDoc($area, $offset, $spec, $srvc);
    	$html = '';
    	$ctr = 0;

    	if (empty($searchResult)) {
    		$data['err'] = 'No matching doctor found';
    		$data['count'] = $ctr;
			return $response->withJson($data);
		}

		foreach ($searchResult as $result) {
			$fname = $result['first_name'];
			$mname = $result['middle_name'];
			$lname = $result['last_name'];
			$doctor = formatName($fname, $mname, $lname);

			$clinics = $result['clinics'];
			$loc = '';

			foreach($clinics as $clinic) {
				$location = $clinic['name'] . ', ';

				if (!empty($clinic['street_address'])) {
					$location .= $clinic['street_address'] . ', ';
				}

				if (!empty($clinic['barangay'])) {
					$location .= $clinic['barangay'] . ', ';
				}

				$location .= $clinic['city'];
				$loc .= "<li>$location</li>";
			}

			$result['doctor'] = $doctor;
			$result['locations'] = $loc;
			$result['photo'] = getPhoto($result['photo']);
			$result['doctor_id'] = encrypt($result['doctor_id']);
			$html .= $this->view->fetch('a/search_item.twig', $result);
			$offset = $result['doctor_id'];
			$ctr++;
		}

		$data['count'] = $ctr;
		$data['offset'] = $offset;
		$data['searchResult'] = $html;
    	return $response->withJson($data);
	}

	/**
     * Search for matching area
     */

    public function matchArea($request, $response, $args)
    {
		$post = $request->getParsedBody();
		$area = $post['area'];

		if (empty($area)) {
			return $response->withJson(['err' => 'Missing required input']);
		}

        $data = Clinics::distinct('barangay', 'city')
        ->whereRaw('MATCH(`barangay`, `city`) AGAINST(? IN NATURAL LANGUAGE MODE)', [$area])
        ->get(['barangay', 'city']);

        if ($data->isEmpty()) {
			return null;
		}

		$data = $data->toArray();

		foreach ($data as $k => $row) {
			$brgy = trim($row['barangay']);
			$city = trim($row['city']);
			$data[$k]['area'] = ($brgy && $city) ? "$brgy, $city" : $city;
		}

        return $response->withJson($data);
    }

    /**
     * Get doctor's data
     */

    public function getDoctor($request, $response, $args)
    {
		$post = $request->getParsedBody();
		$docId = $post['id'];

		if (empty($docId)) {
			return $response->withJson(['err' => 'Missing required input']);
		}

		if (($docId = decrypt($docId)) == false) {
			return $response->withJson(['err' => 'Invalid input']);
		}

		$data = Doctors::getDoctor($docId);
		$clinics = $data['clinics'];
		$htmlClinics = '';

		foreach ($clinics as $k => $v) {
			$clinicId = $v['clinic_id'];
			$clinicName = $v['name'];
			$address = $v['street_address'];
			$sched = $v['schedule'];
			$htmlSched = '';

			if (!empty($v['barangay'])) {
				$address .= ', ' . $v['barangay'];
			}

			if (!empty($v['city'])) {
				$address .= ', ' . $v['city'];
			}

			foreach ($sched as $obj) {
				$day = $obj->day;
				$opening = $obj->opening;
				$closing = $obj->closing;
				$htmlSched .= "<div>$day $opening - $closing</div>";
			}

			$htmlClinics .= "
			<li>
				<div class='clinic'>
					<div class='name'>
						<input type='radio' name='clinic' value='$clinicId'> $clinicName
					</div>
					<div class='address'>$address</div>
					<div class='schedule'>$htmlSched</div>
				</div>
			</li>";
		}

		$data['clinics'] = $htmlClinics;
		return $response->withJson($data);
    }

    /**
     * Book appointment
     */

    public function bookAppt($request, $response, $args)
    {
    	$post = $request->getParsedBody();
    	$data = [];

    	if (!isset($post['clinic'], $post['schedule'], $post['purpose'])) {
    		$data['err'] = 'Missing required input';
    	} else {
    		$acctId = $request->getAttribute('id');

    		if (isset($post['for_other']) && !isset(
    			$post['first_name'],
    			$post['middle_name'],
	    		$post['last_name'],
	    		$post['address'],
	    		$post['birthdate'],
	    		$post['gender'],
	    		$post['email_address']
    		)) {
    			$data['err'] = 'Missing required input';
	    	} else if (!isset($post['for_other'])) {
	    		$acct = Accounts::select([
	    			'first_name',
	    			'middle_name',
	    			'last_name',
	    			'address',
	    			'birthdate',
	    			'gender',
	    			'email_address',
	    		])
	    		->where('account_id', $acctId)
	    		->first()
	    		->toArray();
	    		$post = array_merge($acct, $post);
	    	}

	    	$clinicId = decrypt($post['clinic']);
    		unset($post['clinic']);

    		$post['clinic_id'] = $clinicId;
    		$post['booked_by'] = $acctId;

	    	$appt = new Appointments;
    		$appt->fill($post)->save();
    		$data['appt'] = $appt->id;
    	}

    	return $response->withJson($data);
    }
}