<?php

// NOTE: Make sure this file is not accessible when deployed to production
if (!in_array(@$_SERVER['REMOTE_ADDR'], ['127.0.0.1', '::1'])) {
	die('You are not allowed to access this file.');
}

if(!defined('YII_DEBUG') && isset($_SERVER['YII_DEBUG'])) {
    define('YII_DEBUG', $_SERVER['YII_DEBUG']);
} else {
    define('YII_DEBUG', false);
}
if(!defined('YII_ENV') && isset($_SERVER['YII_ENV'])) {
    define('YII_ENV', $_SERVER['YII_ENV']);
} else {
    define('YII_ENV', 'prod');
}

require(__DIR__ . '/../../vendor/autoload.php');
require(__DIR__ . '/../../vendor/yiisoft/yii2/Yii.php');
require(__DIR__ . '/../../common/config/aliases.php');

$config = require(__DIR__ . '/../tests/acceptance/_config.php');

(new yii\web\Application($config))->run();
