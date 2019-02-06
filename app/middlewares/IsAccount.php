<?php

namespace App\Middlewares;

class IsAccount
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
		if (session('acct.type') === 'd') {
			$uri = $request->getUri()->withPath($this->router->pathFor('drMyacct'));
			$response = $response->withRedirect($uri, 307);
		} else {
			$response = $next($request, $response);
		}
		
		return $response;
	}
}