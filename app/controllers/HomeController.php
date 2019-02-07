<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Models\Accounts;
use \App\Models\Doctors;

class HomeController
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

		$this->view->render($response, 'acct/home.twig', [
			'css' => [url('/assets/css/acct/home.css')],
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
    		$result = Accounts::checkCred($email, $pass);
    	} else if ($type == 'd') {
    		$result = Doctors::checkCred($email, $pass);
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
            $result = Accounts::register([
                'email_address' => $post['email'],
                'first_name' => $post['fname'],
                'middle_name' => $post['mname'],
                'last_name' => $post['lname'],
                'gender' => $post['gen'],
                'password' => $post['pass'],
            ]);
        } else if ($post['type'] == 'd') {
            $result = Doctors::register([
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

    /**
     * Logout function
     */

    public function logout($request, $response, $args)
    {
        $id = session('acct.id');
        $type = session('acct.type');
        $uri = config('app.baseUrl');
        unset($_SESSION['acct']);

        if ($id !== null && $type == 'a') {
            Accounts::where('account_id', $id)->update(['access_token' => '']);
        } else if ($id !== null && $type == 'd') {
            Doctors::where('doctor_id', $id)->update(['access_token' => '']);
            $uri .= '/d';
        }

        return $response->withRedirect($uri);
    }
}