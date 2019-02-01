<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Models\Account;

class HomeController
{
	/**
	 * Home page
	 */

    public function home($request, $response, $args)
    {
	    $tokenName = $request->getAttribute('csrf_name');
	    $tokenVal = $request->getAttribute('csrf_value');

		$this->view->render($response, 'a/home.twig', [
			'pageType' => 'a',
			'css' => [url('/assets/css/a/home.css')],
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
	 * Login function
	 */

    public function login($request, $response, $args)
    {
    	$data = ['token' => $this->csrf->generateToken()];

    	if (false === $request->getAttribute('csrfstat')) {
    		$data['err'] = 'Failed CSRF check!';
    		return $response->withJson($data);
    	}

    	$post = $request->getParsedBody();
    	$email = $post['email'];
    	$pass = $post['pass'];
    	$type = $post['type'];

    	if (!isset($email, $pass, $type)) {
    		$data['err'] = 'Missing required input';
    		return $response->withJson($data);
    	}

    	if ($type == 'a') {
    		$result = Account::checkCred($email, $pass);
    	} else if ($type == 'd') {
    		$result = Doctor::checkCred($email, $pass);
    	}

    	if ($result === false) {
			$data['err'] = 'Invalid email or password';
    	} else {
    		$data['myaccount'] = $result;
    	}

    	return $response->withJson($data);
    }

    /**
     * Creates an account
     */

    public function register($request, $response, $args)
    {
        $data = ['token' => $this->csrf->generateToken()];

        if (false === $request->getAttribute('csrfstat')) {
            $data['err'] = 'Failed CSRF check!';
            return $response->withJson($data);
        }

        $post = $request->getParsedBody();

        if (empty($post['type']) || empty($post['fname']) || empty($post['lname']) || empty($post['email']) || empty($post['pass']) || empty($post['confirm_pass']) || empty($post['gen'])) {
            $data['err'] = 'Missing required input';
            return $response->withJson($data);
        }

        if (!empty($post['email']) && !isEmail($post['email'])) {
            $data['err'] = 'Invalid email address';
            return $response->withJson($data);
        }

        if (!empty($post['pass']) && !validPass($post['pass'])) {
            $data['err'] = 'Invalid password';
            return $response->withJson($data);
        }

        if ($post['pass'] != $post['confirm_pass']) {
            $data['err'] = 'Password mismatch';
            return $response->withJson($data);
        }

        if ($post['type'] == 'a') {
            $result = Account::register([
                'email_address' => $post['email'],
                'first_name' => $post['fname'],
                'middle_name' => $post['mname'],
                'last_name' => $post['lname'],
                'gender' => $post['gen'],
                'password' => $post['pass'],
            ]);
        } else if ($post['type'] == 'd') {
            $result = Doctor::register([
                'email_address' => $post['email'],
                'first_name' => $post['fname'],
                'middle_name' => $post['mname'],
                'last_name' => $post['lname'],
                'gender' => $post['gen'],
                'password' => $post['pass'],
            ]);
        }

        if (is_array($result) && isset($result['err'])) {
            $data['err'] = $result['err'];
        } else {
            $data['succ'] = true;
        }

        return $response->withJson($data);
    }
}