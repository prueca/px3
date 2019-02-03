<?php

namespace App\Middlewares;

class Auth
{
	/**
	 * Bind dependencies
	 */

	public function __construct($ci)
	{
		$this->router = $ci['router'];
		$this->db = $ci['db'];
	}

	/**
	 * Middleware for validating access
	 */

	public function __invoke($request, $response, $next)
	{
		$access = false;
		$token = cookie('accToken');

		if (isset($token) && ($data = decrypt($token)) !== false) {
			$data = explode('|', $data);
			$id = $data[0];
			$type = $data[1];
			$db = $this->db;

			if ($type == 'a') {
				$tbl = 'Accounts';
				$cond = ['account_id' => $id];
			} else if ($type == 'd') {
				$tbl = 'Doctors';
				$cond = ['doctor_id' => $id];
			}

			$cond['access_token'] = $token;
			$result = $db->table($tbl)->where($cond)->exists();

			if ($result) {
				$access = true;
				$request = $request
				->withAttribute('id', $id)
				->withAttribute('type', $type);
			}
		}

		if (!$access) {
			if ($request->isGet()) {
				$uri = $request->getUri()->withPath($this->router->pathFor('home'));
				$response = $response->withRedirect($uri, 307);
			} else {
				$response = $response->withJson(['err' => 'Unauthorized access']);
			}
		} else {
			$response = $next($request, $response);
		}
		
		return $response;
	}
}