<?php
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

$commonMainLocalPath = __DIR__ . '/../../common/config/main-local.php';
$commonMainLocal = (file_exists($commonMainLocalPath)) ? require($commonMainLocalPath) : array();

$mainLocalPath = __DIR__ . '/../config/main-local.php';
$mainLocal = (file_exists($mainLocalPath)) ? require($mainLocalPath) : array();

$config = yii\helpers\ArrayHelper::merge(
	require(__DIR__ . '/../../common/config/main.php'),
	$commonMainLocal,
	require(__DIR__ . '/../config/main.php'),
	$mainLocal
);

$application = new yii\web\Application($config);
$application->run();
