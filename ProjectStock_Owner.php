<?php
error_reporting(-1);
include_once 'config.inc.php';
include_once 'modules/Users/Users.php';
include_once 'include/Webservices/Create.php';
include_once 'include/Webservices/Retrieve.php'; 
require_once 'data/VTEntityDelta.php';
require_once 'include/events/VTEntityData.inc';
require_once 'include/database/PearDatabase.php';
global $adb;
$entity_id = $_REQUEST['record'];
$statusChanged = false;
$moduleName = "ProjectStock";
$statusFieldName = 'stockstatus';
$vtEntityDelta = new VTEntityDelta ();
echo $oldEntity = $vtEntityDelta-> getOldValue($moduleName, $entity_id, $statusFieldName);

$user = new Users();
$current_user = $user->retrieveCurrentUserInfoFromFile(Users::getActiveAdminId());

echo $projectstockid = vtws_getWebserviceEntityId("ProjectStock",$entity_id);
$wsid = vtws_getWebserviceEntityId('ProjectStock', $projectstockid);
$ProjectStockDetails = vtws_retrieve($wsid, $current_user);
print_r($ProjectStockDetails);
	
$statusChanged = $vtEntityDelta->hasChanged($moduleName, $entity_id, $statusFieldName);
?>