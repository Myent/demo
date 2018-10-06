<?php
		require_once 'include/utils/utils.php';
		require 'modules/com_vtiger_workflow/VTEntityMethodManager.inc';
		$emm = new VTEntityMethodManager($adb); 
		$emm->addEntityMethod("ProcessFlow", "update Process flow end time", "modules/ProcessFlow/Workflows/updateProcessFlowEndTime.php", "updateProcessFlowEndTime");
		
		?>
