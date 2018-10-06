<?php

// Turn on debugging level
$Vtiger_Utils_Log = true;

// Include necessary classes
include_once('vtlib/Vtiger/Module.php');

// Define instances
$users = Vtiger_Module::getInstance('Users');

// Nouvelle instance pour le nouveau bloc
$block = Vtiger_Block::getInstance('LBL_MORE_INFORMATION', $users);


// Add field
$fieldInstance = new Vtiger_Field();
$fieldInstance->name = 'autologout_time';			              //Usually matches column name
$fieldInstance->table = 'vtiger_users';
$fieldInstance->column = 'autologout_time';		                     //Must be lower case
$fieldInstance->label = 'Auto Logout Time';		            //Upper case preceeded by LBL_
$fieldInstance->columntype = 'VARCHAR(128)';	    //
$fieldInstance->uitype = 16;			                   //Multi-Combo picklist
$fieldInstance->typeofdata = 'V~O~LE~128';	  //V=Varchar?, M=Mandatory, O=Optional
$fieldInstance->setPicklistValues( Array ('15 mins','30 mins','45 mins','60 mins') );
$block->addField($fieldInstance);
?>
