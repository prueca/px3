<?php

/**
 * Twig templating engine
 */

$ci['view'] = function ($ci) {
    $view = new \Slim\Views\Twig('../app/views', ['cache' => false ]);
    $env = $view->getEnvironment();
    $env->addGlobal('session', $_SESSION);
    $env->addGlobal('app', $ci['app']);
    return $view;
};


/**
 * Eloquent ORM
 */

$capsule = new \Illuminate\Database\Capsule\Manager;
$capsule->addConnection($ci['settings']['db']);
$capsule->setAsGlobal();
$capsule->bootEloquent();

$ci['db'] = function ($ci) use ($capsule) {
    return $capsule;
};


/**
 * Middlewares
 */

$ci['csrf'] = function ($ci) {
    $guard = new \Slim\Csrf\Guard;
    $guard->setPersistentTokenMode(false);
    $guard->setFailureCallable(function ($request, $response, $next) {
        $request = $request->withAttribute('csrfstat', false);
        return $next($request, $response);
    });
    return $guard;
};

$ci['authAcct'] = function ($ci) {
    return new \App\Middlewares\AuthAcct($ci);
};

$ci['authDoc'] = function ($ci) {
    return new \App\Middlewares\AuthDoc($ci);
};


/**
 * Controllers
 */

$ci['HomeController'] = function ($ci) {
	return new \App\Controllers\HomeController($ci);
};

$ci['AccountController'] = function ($ci) {
    return new \App\Controllers\AccountController($ci);
};

$ci['DoctorController'] = function ($ci) {
    return new \App\Controllers\DoctorController($ci);
};