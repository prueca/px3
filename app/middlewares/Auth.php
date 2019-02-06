<?php

namespace App\Middlewares;

use Illuminate\Database\Capsule\Manager as DB;

class Auth
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

		if (isset($id, $type, $token)) {
			if ($type == 'a') {
				$tbl = 'Accounts';
				$cond = ['account_id' => $id];
			} else if ($type == 'd') {
				$tbl = 'Doctors';
				$cond = ['doctor_id' => $id];
			}

			$cond['access_token'] = $token;
			$access = DB::table($tbl)->where($cond)->exists();
		}

		if (!$access && $request->isGet()) {
			$uri = $request->getUri()->withPath($this->router->pathFor('home'));
			$response = $response->withRedirect($uri, 307);
		} else if (!$access) {
			$response = $response->withJson(['err' => 'Unauthorized access']);
		} else {
			$response = $next($request, $response);
		}
		
		return $response;
	}
}