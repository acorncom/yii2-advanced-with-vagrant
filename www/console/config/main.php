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
	'id' => 'app-console',
	'basePath' => dirname(__DIR__),
	'controllerNamespace' => 'console\controllers',
	'modules' => [],
	'components' => [
		'log' => [
			'targets' => [
				[
					'class' => 'yii\log\FileTarget',
					'levels' => ['error', 'warning'],
				],
			],
		],
	],
	'params' => $params,
];
