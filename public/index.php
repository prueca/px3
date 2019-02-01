<?php

date_default_timezone_set('Asia/Manila');
session_start();

require '../vendor/autoload.php';
require '../app/config.php';

$app = new \Slim\App($config);
$ci = $app->getContainer();

require '../app/dependencies.php';
require '../app/routes.php';

if ($ci['app']['sass']['compile']) {
	if (!file_exists('assets/css/a')) {
	    mkdir('assets/css/a', 0777, true);
	} 

	if (!file_exists('assets/css/d')) {
	    mkdir('assets/css/d', 0777, true);
	}

	$format = $ci['app']['sass']['minified'] ? 'scss_formatter_compressed' : 'scss_formatter';

	SassCompiler::run('../app/sass/', 'assets/css/', $format);
	SassCompiler::run('../app/sass/a/', 'assets/css/a/', $format);
	SassCompiler::run('../app/sass/d/', 'assets/css/d/', $format);
}

$app->run();