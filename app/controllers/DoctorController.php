<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

class DoctorController
{
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
	    echo 'Myaccount page';
    }
}