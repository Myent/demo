<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
<meta content="utf-8" http-equiv="encoding">
<?php
require_once('modules/Emails/mail.php');
require_once 'include/fields/DateTimeField.php';
require_once 'data/CRMEntity.php';
require_once 'include/Webservices/Create.php';
require_once('include/utils/utils.php');

DailyActivityMail();
function DailyActivityMail(){
	global $adb, $log;
	global $HELPDESK_SUPPORT_EMAIL_ID;//main@benchmarklabs.com
	//echo Date('Y-m-d H:i:s').'<br>';//UTC
	//date_default_timezone_set('America/Denver');
	$today = Date('Y-m-d H:i:s');//current date with time
	$tdy =  Date('Y-m-d');
	//echo 'today date '.$today;
	//echo "</br>";
	
	//echo $HELPDESK_SUPPORT_EMAIL_ID;
	$userquery = "select id, user_name as name, email1, time_zone from vtiger_users";
	$userresult = $adb->pquery($userquery);
	$rows_user = $adb->num_rows($userresult);
	
	if($rows_user>0){
			for($i=0; $i<$rows_user; $i++){
				
				$name = $adb->query_result($userresult, $i, "name");
				$id = $adb->query_result($userresult, $i, "id");
				$timezone = $adb->query_result($userresult, $i, "time_zone");
				//echo 'timezone '.$timezone; echo $name; echo "</br>";
				$td = new DateTime($tdy, new DateTimeZone($timezone));
				$td->setTimeZone(new DateTimeZone($timezone));
				$ttd =  $td->format('Y-m-d');
				//echo 'ttd '.$ttd;  echo "</br>";
				
				$c_query = "SELECT vtiger_activity.activityid, vtiger_activity.date_start, vtiger_activity.time_start FROM vtiger_activity
							LEFT JOIN vtiger_crmentity ON 
							vtiger_crmentity.crmid = vtiger_activity.activityid
							WHERE 
							vtiger_crmentity.setype='Calendar' and 
							vtiger_crmentity.deleted=0 and vtiger_activity.date_start=? and vtiger_crmentity.smownerid=?";
				$c_result = $adb->pquery($c_query, array($ttd, $id));
				$c_rows = $adb->num_rows($c_result);
				if($c_rows > 0){
					for($k=0;$k<$c_rows;$k++){
						$sm_activityid = $adb->query_result($c_result,$k,'activityid');
						$date_start = $adb->query_result($c_result,$k,'date_start');
						$time_start = $adb->query_result($c_result,$k,'time_start');
						
						$start1 =  $date_start.' '.$time_start;
						$sd1 = new DateTime($start1, new DateTimeZone('UTC'));
						$sd1->setTimeZone(new DateTimeZone($timezone));
						$startt1 =  $sd1->format('Y-m-d');
						
						if($startt1 == $ttd){
							if($sm_activityid != ''){
								$activity_arr[$id]['id'][] = $sm_activityid;
							}
							if($sm_activityid != ''){
								$activity_arr[$id]['date'][] = $ttd;
							}
						}
					}
				}
				
				$query1 = $adb->pquery("SELECT vtiger_activity.activityid, vtiger_activity.date_start, vtiger_activity.time_start
					FROM vtiger_activity
					LEFT JOIN vtiger_crmentity
					ON vtiger_activity.activityid = vtiger_crmentity.crmid
					LEFT JOIN vtiger_invitees
					ON vtiger_invitees.activityid = vtiger_crmentity.crmid
					WHERE vtiger_activity.activityid=vtiger_crmentity.crmid AND vtiger_crmentity.setype='Calendar' AND vtiger_crmentity.deleted=0 AND vtiger_activity.date_start=? AND vtiger_invitees.inviteeid =? ",array($ttd,$id));
				$row1 = $adb->num_rows($query1);
				//echo $query1;
				if($row1 > 0){
					for($j=0;$j<$row1;$j++){
						$in_activityid = $adb->query_result($query1,$j,'activityid');
						$date_start = $adb->query_result($query1,$j,'date_start');
						$time_start = $adb->query_result($query1,$j,'time_start');
						
						//$inarray[$id][] = $in_activityid;
						$start2 =  $date_start.' '.$time_start;
						//$sd2 = new DateTime($start2, new DateTimeZone('UTC'));
						//$sd2->setTimeZone(new DateTimeZone($timezone));
						//$startt2 =  $sd2->format('Y-m-d');
						
						$zone1 = new DateTimeZone($timezone);
						$strtime1 = strtotime($start2);
						$get_start1 = new DateTime($start2, $zone1);
						$seconds1 = date_offset_get($get_start1);
						$unixtime1 =  $strtime1 + $seconds1 ;
						//echo date("Y-m-d H:i:s",$unixtime);
						$startt2 =  date("Y-m-d",$unixtime1);
						
						if($startt2 == $ttd){
							if($in_activityid != ''){
							$activity_arr[$id]['id'][] = $in_activityid;
							}
							
							if($in_activityid != ''){
								$activity_arr[$id]['date'][] = $ttd;
							}
						}
						//print_r($activity_arr);
					}
				}
				
			}
		}
		//echo "<pre>";
		//print_r($activity_arr);
		
			foreach($activity_arr as $key=>$value){
				$userid = $key;
				//print_r($userid);
				$inner_arr_cnt = count(array_filter(array_unique($activity_arr[$key]['id'])));
				//echo $activity_arr[$key]['date'][0];
				$query2 = $adb->pquery("SELECT CONCAT(first_name,' ',last_name)as name, time_zone, email1 FROM vtiger_users WHERE id=?",array($userid));
				$username = $adb->query_result($query2, 0, 'name');
				$timezone1 = $adb->query_result($query2, 0, 'time_zone');
				//echo $timezone1;
				$usermail = $adb->query_result($query2, 0, 'email1');
				
				$table = "Dear ".$username.", <br></font><br><br>Scheduled activities for the day are..<br><br>
							<table width='100%' border='2' cellspacing='0' cellpadding='0' bordercolor='#3366cc' style='border-radius:4px;'>
							<th style='background-color: #fd9a00;'>Subject</th>
							<th style='background-color: #fd9a00;'>Status</th>
							<th style='background-color: #fd9a00;'>Type Of Activtiy</th>
							<th style='background-color: #fd9a00;'>Related to</th>
							<th style='background-color: #fd9a00;'>Start Time</th>
							<th style='background-color: #fd9a00;'>End Time</th>
							<th style='background-color: #fd9a00;'>Location</th>
							<th style='background-color: #fd9a00;'>Description</th>
							<th style='background-color: #fd9a00;'>Invitees</th>
							<tr style='background-color: #e6f2ff;'>";
				
				for($l=0;$l<$inner_arr_cnt;$l++){
					$inner_arr = array_filter(array_unique($activity_arr[$key]['id']));
					$query3 = "SELECT vtiger_activity.subject,vtiger_crmentity.smownerid, vtiger_activity.eventstatus, vtiger_activity.time_start, vtiger_activity.time_end, vtiger_activity.activitytype,
					vtiger_activity.location, vtiger_crmentity.description ,vtiger_activity.date_start
					FROM vtiger_activity,vtiger_crmentity
					WHERE vtiger_activity.activityid=vtiger_crmentity.crmid AND setype='Calendar' AND deleted=0 AND date_start=? AND vtiger_activity.activityid=?";
					$result3 = $adb->pquery($query3, array($activity_arr[$key]['date'][0],$inner_arr[$l]));
					$subject = $adb->query_result($result3,0,'subject');
					$status = $adb->query_result($result3,0,'eventstatus');
					$type = $adb->query_result($result3,0,'activitytype');
					$start = $adb->query_result($result3,0,'time_start');
					$date_start = $adb->query_result($result3,0,'date_start');
					$end = $adb->query_result($result3,0,'time_end');
					$location = $adb->query_result($result3,0,'location');
					$description = $adb->query_result($result3,0,'description');
					$assigned = $adb->query_result($result3,0,'smownerid');
					//echo $assigned;
					
					$time_l = $adb->pquery("SELECT time_zone FROM vtiger_users WHERE id=?",array($assigned));
					$timezone_assigned = $adb->query_result($time_l,0,'time_zone');
					
					//Date Format--start
					/* $sd = new DateTime($start, new DateTimeZone('UTC'));
					$sd->setTimeZone(new DateTimeZone($timezone_assigned));
					$startt =  $sd->format('H:i:s'); */
					
					$zone2 = new DateTimeZone($timezone1);
					$strtime2 = strtotime($date_start.' '.$start);
					$get_start2 = new DateTime($date_start.' '.$start, $zone2);
					$seconds2 = date_offset_get($get_start2);
					$unixtime2 =  $strtime2 + $seconds2 ;
					$startt =  date("H:i:s",$unixtime2);
					
					/* $dd = new DateTime($end, new DateTimeZone('UTC'));
					$dd->setTimeZone(new DateTimeZone($timezone_assigned));
					$endt =  $dd->format('H:i:s'); */
					
					$zone3 = new DateTimeZone($timezone1);
					$strtime3 = strtotime($end);
					$get_start3 = new DateTime($end, $zone3);
					$seconds3 = date_offset_get($get_start3);
					$unixtime3 =  $strtime3 + $seconds3 ;
					$endt =  date("H:i:s",$unixtime3);
					//echo $ddt;exit();
					//Date Format--end
					
						$table .= "<td align='center'>$subject</td>";
						$table .= "<td align='center'>$status</td>";
						$table .= "<td align='center'>$type</td>";
					
					$contact_q = $adb->pquery("select vtiger_contactdetails.firstname, vtiger_contactdetails.lastname from vtiger_contactdetails, vtiger_cntactivityrel where vtiger_contactdetails.contactid=vtiger_cntactivityrel.contactid and vtiger_cntactivityrel.activityid=?",array($inner_arr[$l]));
					$contact_q_row = $adb->num_rows($contact_q);
					if($contact_q_row>0){
						$contact_strng = '';
						for($t=0; $t<$contact_q_row; $t++){
							$fname = $adb->query_result($contact_q, $t, "firstname");
							$lname = $adb->query_result($contact_q, $t, "lastname");
							$contact_strng .= $fname.' '.$lname."<br>";
						}
						$contact_list = rtrim($contact_strng,'\n');
						$table .= "<td align='center'>$contact_list</td>";
					}else{
						$table .= "<td align='center'></td>";
					}
					
						$table .= "<td align='center'>$startt</td>";
						$table .= "<td align='center'>$endt</td>";
						$table .= "<td align='center'>$location</td>";
						$table .= "<td align='center'$description></td>";
						
						$i_query = $adb->pquery("select vtiger_users.user_name from vtiger_users, vtiger_invitees where vtiger_users.id=vtiger_invitees.inviteeid and vtiger_invitees.activityid=?",array($inner_arr[$l]));
						$i_rows = $adb->num_rows($i_query);
						if($i_rows>0){
							$usr_strng = '';
							for($x=0; $x<$i_rows; $x++){
								$uname = $adb->query_result($i_query, $x, "user_name");
								$usr_strng .= $uname." <br>";
							}
							$usr_list = rtrim($usr_strng,'\n');
							$table .= "<td align='center'>$usr_list</td>";
						}else{
							$table .= "<td align='center'></td>";
						}
													
						$table .= "</td></tr><tr style='background-color: #e6f2ff;'>";	
					
				}
				$table .= "</tr></table>";
				echo $table;
				
					//$schedule_date = new DateTime($today, new DateTimeZone('UTC'));
					//$schedule_date->setTimeZone(new DateTimeZone($timezone1));
					//echo $schedule_date->format('Y-m-d H:i:s');echo "</br>";
					//$triggerOn =  $schedule_date->format('H');
					//echo "triggerOn ".$triggerOn;echo "</br>";
					
					$zone3 = new DateTimeZone($timezone1);
					$strtime3 = strtotime($today);
					$get_start3 = new DateTime($today, $zone3);
					$seconds3 = date_offset_get($get_start3);
					$unixtime3 =  $strtime3 + $seconds3 ;
					$triggerOn =  date("i",$unixtime3);
					//echo "triggerOn ".$triggerOn;echo "</br>";
					
					if($triggerOn == '08'){	
						send_mail('',$usermail,'',$HELPDESK_SUPPORT_EMAIL_ID,'Your activities for the day',$table,'','','','','',true);						
					}	
			}
}	
?>
