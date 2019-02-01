<?php

// slim config
$config['settings']['displayErrorDetails'] = true;
$config['settings']['db'] = [
    'driver'    => 'mysql',
    'host'      => 'localhost',
    'database'  => 'PX3',
    'username'  => 'root',
    'password'  => '',
    'charset'   => 'utf8',
    'collation' => 'utf8_unicode_ci',
    'prefix'    => '',
];

// app custom config
$config['app']['name'] = "Comfort'NCure";
$config['app']['baseUrl'] = 'http://localhost/slim_app/public';
$config['app']['sessionExpiry'] = 20;

$config['app']['sass']['compile'] = false;
$config['app']['sass']['minified'] = true;