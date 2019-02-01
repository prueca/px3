<?php

// register csrf middleware for all routes
$app->add($ci['csrf']);

// AccountController 
$app->post('/matchdoc', 'AccountController:matchDoc')->add($ci['auth']);
$app->post('/getappts', 'AccountController:getAppts')->add($ci['auth']);
$app->get('/search', 'AccountController:search')->add($ci['auth']);
$app->get('/myaccount', 'AccountController:myaccount')->add($ci['auth']);

// HomeController 
$app->post('/register', 'HomeController:register');
$app->post('/login', 'HomeController:login');
$app->get('/', 'HomeController:home')->setName('home');