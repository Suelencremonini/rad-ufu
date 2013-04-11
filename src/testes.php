<?php
require_once (__DIR__ . '/RADUFU/Autoloader.php');
use RADUFU\Resource\RelatorioResource,
	RADUFU\Service\RelatorioService;
$z = new RelatorioService();
#$y = $x->GerarRelatorio(1);
$z->GerarRelatorio(1);
?>