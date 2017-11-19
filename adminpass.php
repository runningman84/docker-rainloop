#!/usr/bin/php
<?php

if (count($argv) != 3) {
  throw new Exception('Usage: ' . $argv[0] . 'WEBROOT_PATH RAINLOOP_ADMIN_PASSWORD');
}

$path = $argv[1];
$pass = $argv[2];

$_ENV['RAINLOOP_INCLUDE_AS_API'] = true;
include $path . '/index.php';

$oConfig = \RainLoop\Api::Config();
$oConfig->SetPassword($pass);
echo $oConfig->Save() ? 'Admin password changed' : 'Admin password could not be changed';
