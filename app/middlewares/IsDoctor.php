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
		$type = session('acct.type');

		if ($type === 'a' && $request->isGet()) {
			$uri = $request->getUri()->withPath($this->router->pathFor('myacct'));
			$response = $response->withRedirect($uri, 307);
		} else if ($type == 'a') {
			$response = $response->withJson(['err' => 'Unauthorized access']);
		} else {
			$response = $next($request, $response);
		}
		
		return $response;
	}
}