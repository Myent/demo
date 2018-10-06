<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
<meta content="utf-8" http-equiv="encoding">
<?php
require_once('modules/Emails/mail.php');
require_once 'include/fields/DateTimeField.php';
require_once 'data/CRMEntity.php';
require_once 'include/Webservices/Create.php';
require_once('include/utils/utils.php');

AutoLogout();
function AutoLogout(){
	global $adb, $log;
	global $HELPDESK_SUPPORT_EMAIL_ID;//main@benchmarklabs.com
	@date_default_timezone_set('UTC');
	$date = Date('Y-m-d H:i:s');
	$loginquery = "SELECT logi.*, us.autologout_time, us.id as luser_id FROM vtiger_loginhistory as logi, vtiger_users as us  where logi.status='Signed in' and logi.user_name = us.user_name";
	$oginresult = $adb->pquery($loginquery);
	$oginnoOfRows = $adb->num_rows($oginresult);
	if($oginnoOfRows > 0){
		while($oginrow = $adb->fetch_array($oginresult)){
			$login_id = $oginrow['login_id'];
			$login_time = $oginrow['login_time'];
			$session_id = $oginrow['session_id'];
			$user_name = $oginrow['user_name'];
			$luser_id = $oginrow['luser_id'];
			$autologout_time = preg_replace("/[^0-9,.]/", "", $oginrow['autologout_time']);
			$auto = $autologout_time*60;
			$day = strtotime($date);
			$uquery = "SELECT max(u.datetime) as datetime FROM vtiger_forensic_url as u where u.user_name = '$user_name' and u.datetime >= '$login_time'";
			$uresult = $adb->pquery($uquery);
			$unoOfRows = $adb->num_rows($uresult);
			if($unoOfRows >0){
				//$url_date = $adb->fetch_array($uresult);
				$url_date = $adb->query_result($uresult, 0, 'datetime');
				if($url_date != Null || $url_date != ''){
					$urld = strtotime($url_date);
				}
				else{
					$urld ='';
				}
			}

			$mquery = "SELECT max(m.changedon) as changedon FROM vtiger_modtracker_basic as m where m.whodid=$luser_id and m.changedon >= '$login_time'";
			$mresult = $adb->pquery($mquery);
			$mnoOfRows = $adb->num_rows($mresult);
			if($mnoOfRows >0){
				$basic_date = $adb->query_result($mresult, 0, 'changedon');
				if($basic_date != Null || $basic_date != ''){
					$basicd = strtotime($basic_date);
				}
				else{
					$basicd ='';
				}
			}



			if($urld !='' && $basicd !=''){
				if($urld > $basicd){
					$check = $day - $urld;
					if($check > $auto){
						$logid[] = $login_id;
					} 
				}
				else {
					$check = $day - $basicd;
					if($check > $auto){
						$logid[] = $login_id;
					} 
				}
			}
			else if($urld !='' && $basicd ==''){
				$check = $day - $urld;
				if($check > $auto){
					$logid[] = $login_id;
				} 
			}

			else if($urld =='' && $basicd !=''){
				$check = $day - $basicd;
				if($check > $auto){
					$logid[] = $login_id;
				} 
			}
			else{
				  $logintim = strtotime($login_time);
				   $check = $day-$logintim;
				   date('Y-m-d H:i:s');
					if($check > $auto){
						$logid[] = $login_id;
					} 
			}

			

		}
	}

	$forrun = count($logid);
	if($forrun > 0){		
		//echo 'hi';
		$login_ids = implode(",",$logid);

		$update = "UPDATE vtiger_loginhistory SET logout_time= '$date',status='Signed off' WHERE login_id in ($login_ids) ";
		$update_result = $adb->pquery($update);
		if($update_result){
			echo $login_ids;
		}
	}
		
			
}	
?>
