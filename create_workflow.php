<?php
require_once 'include/utils/utils.php';
require 'modules/com_vtiger_workflow/VTEntityMethodManager.inc';
$emm = new VTEntityMethodManager($adb);                   
//$emm->addEntityMethod("MODULE_NAME","LABEL", "PATH_TO_FILE" , "METHOD_NAME" );
$emm->addEntityMethod("ProcessFlow", "updateStartTimeAddFirstProcess", "modules/ProcessFlow/Workflows/updateStartTimeAddFirstProcess.php", "updateStartTimeAddFirstProcess");
echo "Workflow Function Saved "; 