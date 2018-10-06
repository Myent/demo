<?php
require_once 'include/utils/utils.php';
require 'modules/com_vtiger_workflow/VTEntityMethodManager.inc';
global $adb;
$emm = new VTEntityMethodManager($adb); 
//$emm->addEntityMethod("MODULE_NAME","LABEL", "PATH_TO_FILE" , "METHOD_NAME" );
$emm->addEntityMethod("ProcessFlow", "ProcessflowCompletionStatusToAssignedUsers", "modules/ProcessFlow/Workflows/ProcessflowCompletionStatusToAssignedUsers.php", "ProcessflowCompletionStatusToAssignedUsers");
echo "Workflow Function Saved "; 
?>