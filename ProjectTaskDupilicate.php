<?php  

// api call 
  
include_once dirname(__FILE__) . '/config.inc.php';
include_once dirname(__FILE__) . '/include/utils/utils.php';
include_once dirname(__FILE__) . '/includes/runtime/BaseModel.php';
include_once dirname(__FILE__) . '/includes/runtime/Globals.php';
include_once dirname(__FILE__) . '/includes/Loader.php';
include_once dirname(__FILE__) . '/includes/http/Request.php';
include_once dirname(__FILE__) . '/modules/Vtiger/models/Record.php';
include_once dirname(__FILE__) . '/modules/Users/models/Record.php';
include_once dirname(__FILE__) . '/includes/runtime/LanguageHandler.php';
//include_once 'include/Webservices/Query.php';
include_once dirname(__FILE__) . '/modules/Users/Users.php';
include_once dirname(__FILE__) . '/include/Webservices/Create.php';
//include_once dirname(__FILE__) . '/include/Webservices/Retrieve.php';

$old_project_id = '4721'; //P2564 Paul Yeoman 682087 BC Ltd rescue app  

$new_project_id = '5342'; //P2572 anji P2564-1 Paul Yeoman 682087 BC Ltd rescue app 

global $adb, $current_user;
//$adb->setDebug(true);
$user = new Users();
$current_user = $user->retrieveCurrentUserInfoFromFile(Users::getActiveAdminId());

//get project tasks using project id

$q = "SELECT p.*,pcf.*,c.* FROM vtiger_projecttask p left join vtiger_projecttaskcf pcf on p.projecttaskid = pcf.projecttaskid  left join vtiger_crmentity c on c.crmid = p.projectid where c.deleted = 0 and p.projectid = $old_project_id ";

$records = $adb->query($q);
$com_count = $adb->num_rows($records);  $k=0;
  echo '<pre>';
  //print_r($current_user);
  $ref_project_id = array();
if($com_count > 0){
	while($row = $adb->fetch_array($records)) { 
		
		for($i=0;$i<=50;$i++){ unset($row[$i]); }	
		$row['assigned_user_id'] =  vtws_getWebserviceEntityId("Users", $row['modifiedby']);		
		$row['modifiedby'] =  vtws_getWebserviceEntityId("Users", $row['modifiedby']);	
		
		$ref_project_id[$k]['npid'] = $new_project_id;
		$ref_project_id[$k]['old_projecttask_id'] = $row['projecttaskid'];
		//users rel table copy 
		
		$user_q = "SELECT * FROM vtiger_usersprojecttasksrel where projecttaskid = '".$row['projecttaskid']."' ";
		
		unset($row['projecttaskid']);
		unset($row['projecttask_no']);
		unset($row['status']);
		unset($row['version']);
		unset($row['presence']);
		unset($row['deleted']);
		unset($row['viewedtime']);
		unset($row['label']);
		unset($row['crmid']);
		unset($row['smownerid']);
		unset($row['modifiedby']);
		unset($row['smcreatorid']);
		unset($row['setype']);
		unset($row['createdtime']);
		unset($row['modifiedtime']);
		//unset($row['pcm_parent_task_id']);
		//unset($row['pcm_assignee']);
		
		$row['projectid'] = vtws_getWebserviceEntityId("Project", $new_project_id);		 
		//$row['pcm_parent_task_id'] = vtws_getWebserviceEntityId("ProjectTask", $new_project_id);		  
		
		$final = vtws_create('ProjectTask', $row, $current_user);	 
		//print_r($final);
		//old task id = new task id 
		$new_id = explode('x',$final['id']);
		//project_id
		//old p id
		//new p id
		$newid = $new_id[1];
		$ref_project_id[$k]['new_projecttask_id'] = $newid; $k++;
		$newpids[] = $newid;
		
		//assignee data
		$userdata = $adb->query($user_q);	
		$count_userdata = $adb->num_rows($userdata);
		
		if($count_userdata > 0){
			$j = 1;
			while($userdata_row = $adb->fetch_array($userdata)) { 
				print_r($userdata_row);				 
				$adb->pquery("INSERT INTO  vtiger_usersprojecttasksrel (`projecttaskid`, `seq`, `userid`, `allocated_hours`, `worked_hours`, `status`, `start_date`, `end_date`, `notification`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",array($newid,$j,$userdata_row['userid'],$userdata_row['allocated_hours'],$userdata_row['worked_hours'],$userdata_row['status'],$userdata_row['start_date'],$userdata_row['end_date'],$userdata_row['notification']));
				$j++;
			}
		}
		//end 
	} 
	
	$newpids = implode(',',$newpids);
	foreach($ref_project_id as $key => $pdata){
		
		print_r($pdata);
		 $q = "UPDATE  vtiger_projecttaskcf SET pcm_parent_task_id = '".$pdata['new_projecttask_id'] ."' WHERE pcm_parent_task_id  = '".$pdata['old_projecttask_id'] ."' and projecttaskid in ($newpids)";
		 $adb->query($q);
		 
	}
	
}
 
 


?>