<?php

namespace App\Middlewares;

class IsAccountType
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

		if ($type === 'd' && $request->isGet()) {
			$uri = $request->getUri()->withPath($this->router->pathFor('drMyacct'));
			$response = $response->withRedirect($uri, 307);
		} else if ($type == 'd') {
			$response = $response->withJson(['err' => 'Unauthorized access']);
		} else {
			$response = $next($request, $response);
		}
		
		return $response;
	}
}