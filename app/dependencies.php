<?php

/**
 * Twig templating engine
 */

$ci['view'] = function ($ci) {
    $view = new \Slim\Views\Twig('../app/views', [
        'cache' => false
    ]);

    $router = $ci->get('router');
    $uri = \Slim\Http\Uri::createFromEnvironment(new \Slim\Http\Environment($_SERVER));
    $view->addExtension(new Slim\Views\TwigExtension($router, $uri));

    // url function
    $view->getEnvironment()->addFunction(new Twig_SimpleFunction('url', function(string $path) {
	   return url($path);
	}));

    // config function
    $view->getEnvironment()->addFunction(new Twig_SimpleFunction('config', function(string $name) {
       return config($name);
    }));

    return $view;
};


/**
 * CSRF middleware
 */

$ci['csrf'] = function($ci) {
    $guard = new \Slim\Csrf\Guard;
    $guard->setPersistentTokenMode(false);
    $guard->setFailureCallable(function ($request, $response, $next) {
        $request = $request->withAttribute('csrfstat', false);
        return $next($request, $response);
    });
    return $guard;
};


/**
 * Auth middleware
 */

$ci['auth'] = function ($ci) {
    return new \App\Middlewares\Auth($ci);
};

/**
 * Eloquent ORM
 */

$capsule = new \Illuminate\Database\Capsule\Manager;
$capsule->addConnection($ci['settings']['db']);
$capsule->setAsGlobal();
$capsule->bootEloquent();

$ci['db'] = function($ci) use ($capsule) {
    return $capsule;
};


/**
 * Controllers
 */

$ci['HomeController'] = function($ci) {
	$ctrl = new \App\Controllers\HomeController();
	$ctrl->app = $ci['app'];
	$ctrl->view = $ci['view'];
	$ctrl->csrf = $ci['csrf'];
    return $ctrl;
};

$ci['AccountController'] = function($ci) {
    $ctrl = new \App\Controllers\AccountController();
    $ctrl->app = $ci['app'];
    $ctrl->view = $ci['view'];
    $ctrl->csrf = $ci['csrf'];
    return $ctrl;
};