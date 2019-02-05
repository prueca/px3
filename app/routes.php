<?php

/**
 * DoctorController
 */

$app->get('/d/myaccount', 'DoctorController:myaccount')->add($ci['auth']);
$app->get('/d', 'DoctorController:home')->add($ci['csrf']);

/**
 * AccountController
 */

$app->post('/myaccount/update', 'AccountController:updateAcct')->add($ci['auth']);
$app->post('/book', 'AccountController:bookAppt')->add($ci['auth']);
$app->post('/getdoctor', 'AccountController:getDoctor')->add($ci['auth']);
$app->post('/matcharea', 'AccountController:matchArea')->add($ci['auth']);
$app->post('/matchdoc', 'AccountController:matchDoc')->add($ci['auth']);
$app->post('/getappts', 'AccountController:getAppts')->add($ci['auth']);
$app->get('/myaccount/edit', 'AccountController:editAcct')->add($ci['auth']);
$app->get('/confirm/{appt}', 'AccountController:confirmAppt')->add($ci['auth']);
$app->get('/search', 'AccountController:search')->add($ci['auth']);
$app->get('/myaccount', 'AccountController:myaccount')->add($ci['auth']);

/**
 * HomeController
 */

$app->post('/register', 'HomeController:register')->add($ci['csrf']);
$app->post('/login', 'HomeController:login')->add($ci['csrf']);
$app->get('/logout', 'HomeController:logout')->add($ci['auth']);
$app->get('/', 'HomeController:home')->add($ci['csrf'])->setName('home');