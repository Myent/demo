<?php
	include_once('config.inc.php');
	include_once('vtlib/Vtiger/Module.php');
	$accountsmodule = vtiger_module::getinstance('ProjectTask');
	$moduleinstance = vtiger_module::getinstance('HelpDesk');
	$relationlabel = 'HelpDesk';
	$accountsmodule->setrelatedlist($moduleinstance, $relationlabel, array('ADD'));
