<?php

namespace App\Middlewares;

use Illuminate\Database\Capsule\Manager as DB;

class AuthAcct
{
	/**
	 * Bind dependencies
	 */

	public function __construct($ci)
	{
		$this->router = $ci['router'];
	}

	/**
	 * Middleware for validating access
	 */

	public function __invoke($request, $response, $next)
	{
		$id = session('acct.id');
		$type = session('acct.type');
		$token = session('acct.token');
		$access = false;

		if (isset($id, $type, $token) && $type == 'a') {
			$access = DB::table('Accounts')->where([
				'account_id' => $id,
				'access_token' => $token,
			])->exists();
		}

		if (!$access && $request->isGet()) {
			$routeName = 'home';

			if ($type == 'a') {
				$routeName = 'myacct';
			} else if ($type == 'd') {
				$routeName = 'drMyacct';
			}

			$uri = $request->getUri()->withPath($this->router->pathFor($routeName));
			return $response->withRedirect($uri, 307);
		}

		if (!$access) {
			return $response->withJson(['err' => 'Unauthorized access']);
		}

		return $next($request, $response);
	}
}