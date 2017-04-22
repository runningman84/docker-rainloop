#!/usr/bin/php
<?php

$_ENV['RAINLOOP_INCLUDE_AS_API'] = true;
include $_ENV['RAINLOOP_PATH'] . '/index.php';

$oConfig = \RainLoop\Api::Config();
$oConfig->SetPassword($_ENV['RAINLOOP_ADMIN_PASSWORD']);
echo $oConfig->Save() ? 'Done' : 'Error';
