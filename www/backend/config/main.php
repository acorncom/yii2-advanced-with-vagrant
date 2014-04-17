<?php
$commonParamsLocalPath = __DIR__ . '/../../common/config/params-local.php';
$commonParamsLocal = (file_exists($commonParamsLocalPath)) ? require($commonParamsLocalPath) : array();

$paramsLocalPath = __DIR__ . '/params-local.php';
$paramsLocal = (file_exists($paramsLocalPath)) ? require($paramsLocalPath) : array();

$params = array_merge(
	require(__DIR__ . '/../../common/config/params.php'),
	$commonParamsLocal,
	require(__DIR__ . '/params.php'),
	$paramsLocal
);

return [
	'id' => 'app-backend',
	'basePath' => dirname(__DIR__),
	'preload' => ['log'],
	'controllerNamespace' => 'backend\controllers',
	'modules' => [],
	'components' => [
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName'  => false,
        ],
		'user' => [
			'identityClass' => 'common\models\User',
			'enableAutoLogin' => true,
		],
		'log' => [
			'traceLevel' => YII_DEBUG ? 3 : 0,
			'targets' => [
				[
					'class' => 'yii\log\FileTarget',
					'levels' => ['error', 'warning'],
				],
			],
		],
		'errorHandler' => [
			'errorAction' => 'site/error',
		],
	],
	'params' => $params,
];
