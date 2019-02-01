<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Models\Account;
use \App\Models\Appointment;
use \App\Models\Doctor;

class AccountController
{
	/**
	 * Myaccount page
	 */

	public function myaccount($request, $response, $args)
	{
		if (!$request->getAttribute('access')) {
			return $response->withJson(['err' => 'Unauthorized access']);
		}

		// csrf token
		$tokenName = $request->getAttribute('csrf_name');
	    $tokenVal = $request->getAttribute('csrf_value');

		// active account data
		$acctId = $request->getAttribute('id');
		$acctName = $request->getAttribute('name');
		$col = ['birthdate', 'gender', 'photo', 'reward_points'];
		$acct = Account::select($col)->where('account_id', $acctId)->first();
		$acct->name = $acctName;
		$acct->age = calcAge($acct->birthdate);
		$acct->gender = $acct->gender == 'M' ? 'Male' : 'Female';
		$acct->photo = getPhoto($acct->photo);

		// appointments data
		$todaysAppts = Appointment::countTodaysAppts($acctId);
		$apptsArr = Appointment::getAppts($acctId);
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
			'token' => ['name' => $tokenName, 'val' => $tokenVal],
		]);
	}

	/**
	 * Get appointments
	 */

	public function getAppts($request, $response, $args)
	{
		if (!$request->getAttribute('access')) {
			return $response->withJson(['err' => 'Unauthorized access']);
		}

		if (false === $request->getAttribute('csrfstat')) {
    		return $response->withJson(['err' => 'Failed CSRF check!']);
    	}

    	$data = ['token' => $this->csrf->generateToken()];
    	$post = $request->getParsedBody();
    	
		$acctId = $request->getAttribute('id');
		$page = (int) $post['page'];
    	$offset = ($page - 1) * 10;
    	$stat = $post['filter'];

    	$apptsArr = Appointment::getAppts($acctId, $offset, $stat);
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
		if (!$request->getAttribute('access')) {
			return $response->withJson(['err' => 'Unauthorized access']);
		}

		// csrf token
		$tokenName = $request->getAttribute('csrf_name');
	    $tokenVal = $request->getAttribute('csrf_value');

	    // active account data
	    $acctId = $request->getAttribute('id');
	    $acctName = $request->getAttribute('name');

		$this->view->render($response, 'a/search.twig', [
			'pageType' => 'a',
			'loggedIn' => true,
			'acctName' => $acctName,
			'token' => ['name' => $tokenName, 'val' => $tokenVal],
			'js' => [url('/assets/js/a/book.js')],
			'css' => [
				url('/assets/css/a/search.css'),
				url('/assets/css/a/book_modal.css'),
			],
		]);
	}

	/**
	 * Search for matching doctor
	 */

	public function matchDoc($request, $response, $args)
	{
		if (!$request->getAttribute('access')) {
			return $response->withJson(['err' => 'Unauthorized access']);
		}

		if (false === $request->getAttribute('csrfstat')) {
    		return $response->withJson(['err' => 'Failed CSRF check!']);
    	}

    	$data = ['token' => $this->csrf->generateToken()];
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

    	$searchResult = Doctor::matchDoc($area, $offset, $spec, $srvc);
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
}