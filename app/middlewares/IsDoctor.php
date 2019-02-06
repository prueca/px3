<?php

namespace App\Middlewares;

class IsDoctor
{
	/**
	 * Bind dependencies
	 */

	public function __construct($ci)
	{
		$this->router = $ci['router'];
	}

	/**
	 * Middleware for validating page access
	 */

	public function __invoke($request, $response, $next)
	{
		if (session('acct.type') === 'a') {
			$uri = $request->getUri()->withPath($this->router->pathFor('myacct'));
			$response = $response->withRedirect($uri, 307);
		} else {
			$response = $next($request, $response);
		}
		
		return $response;
	}
}