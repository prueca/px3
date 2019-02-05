<?php

date_default_timezone_set('Asia/Manila');
ini_set('session.gc_maxlifetime', 1440); // 24 min
session_start();

require '../vendor/autoload.php';
require '../app/config.php';

$app = new \Slim\App($config);
$ci = $app->getContainer();

require '../app/dependencies.php';
require '../app/routes.php';

if ($ci['app']['sass']['compile']) {
	if (!file_exists('assets/css/acct')) {
	    mkdir('assets/css/acct', 0777, true);
	} 

	if (!file_exists('assets/css/dr')) {
	    mkdir('assets/css/dr', 0777, true);
	}

	$format = $ci['app']['sass']['minified'] ? 'scss_formatter_compressed' : 'scss_formatter';

	SassCompiler::run('../app/sass/', 'assets/css/', $format);
	SassCompiler::run('../app/sass/acct/', 'assets/css/acct/', $format);
	SassCompiler::run('../app/sass/dr/', 'assets/css/dr/', $format);
}

$app->run();