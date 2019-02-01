<?php

// AccountController 
$app->post('/getdoctor', 'AccountController:getDoctor')->add($ci['auth']);
$app->post('/matcharea', 'AccountController:matchArea')->add($ci['auth']);
$app->post('/matchdoc', 'AccountController:matchDoc')->add($ci['auth']);
$app->post('/getappts', 'AccountController:getAppts')->add($ci['auth']);
$app->get('/search', 'AccountController:search')->add($ci['auth']);
$app->get('/myaccount', 'AccountController:myaccount')->add($ci['auth']);

// HomeController 
$app->post('/register', 'HomeController:register')->add($ci['csrf']);
$app->post('/login', 'HomeController:login')->add($ci['csrf']);
$app->get('/', 'HomeController:home')->add($ci['csrf'])->setName('home');