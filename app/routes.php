<?php

/**
 * DoctorController
 */

$app->group('', function (\Slim\App $app) use ($ci) {
	$app->post('/d/myaccount/update', 'DoctorController:updateAcct');
	$app->get('/d/myaccount/edit', 'DoctorController:editAcct');
	$app->get('/d/myaccount', 'DoctorController:myaccount')->setName('drMyacct');
})
->add($ci['dtype'])
->add($ci['auth']);

$app->get('/d', 'DoctorController:home')
->add($ci['csrf']);


/**
 * AccountController
 */

$app->group('', function (\Slim\App $app) use ($ci) {
	$app->post('/myaccount/update', 'AccountController:updateAcct');
	$app->post('/book', 'AccountController:bookAppt');
	$app->post('/getdoctor', 'AccountController:getDoctor');
	$app->post('/matcharea', 'AccountController:matchArea');
	$app->post('/matchdoc', 'AccountController:matchDoc');
	$app->post('/getappts', 'AccountController:getAppts');
	$app->get('/myaccount/edit', 'AccountController:editAcct');
	$app->get('/confirm/{appt}', 'AccountController:confirmAppt');
	$app->get('/search', 'AccountController:search');
	$app->get('/myaccount', 'AccountController:myaccount')->setName('myacct');
})
->add($ci['atype'])
->add($ci['auth']);


/**
 * HomeController
 */

$app->post('/register', 'HomeController:register')
->add($ci['csrf']);

$app->post('/login', 'HomeController:login')
->add($ci['csrf']);

$app->get('/logout', 'HomeController:logout')
->add($ci['auth']);

$app->get('/', 'HomeController:home')
->add($ci['csrf'])
->setName('home');
