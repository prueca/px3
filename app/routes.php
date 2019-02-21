<?php

/**
 * DoctorController
 */

$app->group('', function (\Slim\App $app) use ($ci) {
	$app->post('/d/getappts', 'DoctorController:getAppts');
	$app->post('/d/meta/delete', 'DoctorController:delMeta');
	$app->post('/d/meta/update', 'DoctorController:updateMeta');
	$app->post('/d/meta/add', 'DoctorController:addMeta');
	$app->post('/d/clinic/delete', 'DoctorController:deleteClinic');
	$app->post('/d/clinic/update', 'DoctorController:updateClinic');
	$app->post('/d/clinic/get', 'DoctorController:getClinic');
	$app->post('/d/clinic/add', 'DoctorController:addClinic');
	$app->post('/d/update/spec', 'DoctorController:updateSpec');
	$app->post('/d/myaccount/update', 'DoctorController:updateAcct');
	$app->get('/d/appts', 'DoctorController:appointments');
	$app->get('/d/profile/edit', 'DoctorController:editProfile');
	$app->get('/d/myaccount/edit', 'DoctorController:editAcct');
	$app->get('/d/myaccount', 'DoctorController:myaccount')->setName('drMyacct');
})
->add($ci['authDoc']);

$app->get('/d', 'DoctorController:home')
->add($ci['csrf']);


/**
 * AccountController
 */

$app->group('', function (\Slim\App $app) use ($ci) {
	$app->post('/appt/cancel', 'AccountController:cancelAppt');
	$app->post('/myaccount/update', 'AccountController:updateAcct');
	$app->post('/book', 'AccountController:bookAppt');
	$app->post('/getdoctor', 'AccountController:getDoctor');
	$app->post('/matcharea', 'AccountController:matchArea');
	$app->post('/matchdoc', 'AccountController:matchDoc');
	$app->post('/getappts', 'AccountController:getAppts');
	$app->get('/view/{appt}', 'AccountController:viewAppt');
	$app->get('/myaccount/edit', 'AccountController:editAcct');
	$app->get('/confirm/{appt}', 'AccountController:confirmAppt');
	$app->get('/search', 'AccountController:search');
	$app->get('/myaccount', 'AccountController:myaccount')->setName('myacct');
})
->add($ci['authAcct']);


/**
 * HomeController
 */

$app->post('/register', 'HomeController:register')
->add($ci['csrf']);

$app->post('/login', 'HomeController:login')
->add($ci['csrf']);

$app->get('/logout', 'HomeController:logout');

$app->get('/', 'HomeController:home')
->add($ci['csrf'])
->setName('home');
