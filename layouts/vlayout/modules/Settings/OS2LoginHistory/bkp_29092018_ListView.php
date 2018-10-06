<?php
/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
class Settings_OS2LoginHistory_ListView_Model extends Settings_Vtiger_ListView_Model {

	/**
	 * Funtion to get the Login history basic query
	 * @return type
	 */
    public function getBasicListQuery() {
		global $adb,$current_user;
        $module = $this->getModule();
		$cdate = date('Y-m-d H:i:s');
		$userNameSql = getSqlForNameInDisplayFormat(array('first_name'=>'vtiger_users.first_name', 'last_name' => 'vtiger_users.last_name'), 'Users');
		
		$query = "SELECT login_id, vtiger_loginhistory.user_name, user_ip, logout_time, login_time, vtiger_loginhistory.status,(SELECT count(mb.id) FROM vtiger_modtracker_basic as mb where mb.whodid = vtiger_users.id and mb.changedon between vtiger_loginhistory.login_time and   IF(vtiger_loginhistory.logout_time != '0000-00-00 00:00:00', vtiger_loginhistory.logout_time, '$cdate')  ) as total FROM $module->baseTable 
				INNER JOIN vtiger_users ON vtiger_users.user_name = $module->baseTable.user_name";
		
		$search_key = $this->get('search_key');
		$value = $this->get('search_value');
		
		$search_user = $this->get('search_user');
		$userip = $this->get('userip');
		$signintime = $this->get('signintime');
		$signouttime = $this->get('signouttime');
		$status = $this->get('status');
		if(!empty($search_key) && !empty($value)) {
			$query .= " WHERE $module->baseTable.$search_key = '$value'";
		} else if(!empty($search_user)) {
			$query .= " WHERE $module->baseTable.user_name LIKE '%$search_user%'";
		}
		if(!empty($userip)) {
			$query .= " AND $module->baseTable.user_ip LIKE '%$userip%'";
		}
		if(!empty($status) && !empty($signintime) && !empty($signouttime)) {
				$startTime = "00:00:00";
				$startTime1 = "23:59:00";
				$signtime = explode(",",$signintime);
				$dates_count = count($signtime);
				if($dates_count > 1){
					$signintime = $signtime[0];
				}
				$sigouttime = explode(",",$signouttime);
				$dates_end_count = count($sigouttime);
				if($dates_end_count > 1){
					$signouttime = $sigouttime[1];
				}
			if($status == "Signed in"){
				$signintime = date('Y-m-d',strtotime($signintime));	
				$signouttime = date('Y-m-d',strtotime($signouttime));	
				$signint_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime." ".$startTime);
				$signint_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime." ".$startTime1);
				$signintime_ser_start = date('Y-m-d H:i:s',strtotime($signint_start));
				$signintime_ser_end = date('Y-m-d H:i:s',strtotime($signint_end));
				$query .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND  '$signintime_ser_end'";
			}
			else{
				$signintime = date('Y-m-d',strtotime($signintime));	
				$signouttime = date('Y-m-d',strtotime($signouttime));
				$signoutt_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime." ".$startTime);
				$signoutt_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime." ".$startTime1);
				$signouttime_ser_start = date('Y-m-d H:i:s',strtotime($signoutt_start));
				$signouttime_ser_end = date('Y-m-d H:i:s',strtotime($signoutt_end));
				$signouttime_ser = date('Y-m-d',strtotime($signoutt));
				$query .= " AND $module->baseTable.logout_time BETWEEN '$signouttime_ser_start' AND  '$signouttime_ser_end'";
			}
		}else if(empty($status) && !empty($signintime) && !empty($signouttime)) {
				$startTime = "00:00:00";
				$startTime1 = "23:59:00";
				
				$signtime = explode(",",$signintime);
				$dates_count = count($signtime);
				if($dates_count > 1){
					$signintime_start = $signtime[0];
					$signintime_end = $signtime[1];
				}else{
					$signintime_start = $signtime[0];
					$signintime_end = $signtime[0];
				}
				
				$sigouttime = explode(",",$signouttime);
				$dates_end_count = count($sigouttime);
				if($dates_end_count > 1){
					$signouttime_strt = $sigouttime[0];
					$signouttime_end = $sigouttime[1];
				}
				else{
					$signouttime_strt = $sigouttime[0];
					$signouttime_end = $sigouttime[0];
				}
				
				$signintime_start = date('Y-m-d',strtotime($signintime_start));	
				$signintime_end = date('Y-m-d',strtotime($signintime_end));	
				
				$signint_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime_start." ".$startTime);
				$signint_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime_end." ".$startTime1);
				$signintime_ser_start = date('Y-m-d H:i:s',strtotime($signint_start));
				$signintime_ser_end = date('Y-m-d H:i:s',strtotime($signint_end));
				
				$signouttime_strt = date('Y-m-d',strtotime($signouttime_strt));	
				$signouttime_end = date('Y-m-d',strtotime($signouttime_end));
				$signoutt_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime_strt." ".$startTime);
				$signoutt_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime_end." ".$startTime1);
				$signouttime_ser_start = date('Y-m-d H:i:s',strtotime($signoutt_start));
				$signouttime_ser_end = date('Y-m-d H:i:s',strtotime($signoutt_end));
				
				
				//$query .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND  '$signintime_ser_end' OR $module->baseTable.logout_time BETWEEN '$signouttime_ser_start' AND  '$signouttime_ser_end' GROUP BY login_id";
				$query .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND '$signouttime_ser_end'";
		}
		else{
			$st = 0;
			if(!empty($signintime)) {
				$startTime = "00:00:00";
				$startTime1 = "23:59:00";
				$signtime = explode(",",$signintime);
				$datestart_count = count($signtime);
				if($datestart_count == 1){		
					$signintime = date('Y-m-d',strtotime($signintime));			
					$signint_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime." ".$startTime);
					$signint_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime." ".$startTime1);
					$signintime_ser_start = date('Y-m-d H:i:s',strtotime($signint_start));
					$signintime_ser_end = date('Y-m-d H:i:s',strtotime($signint_end));
					$query .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND  '$signintime_ser_end'";
				}
				else{
					if($status == "Signed in"){
						$signtime[0] = date('Y-m-d',strtotime($signtime[0]));
						$signtime[1] = date('Y-m-d',strtotime($signtime[1]));
						$signint_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signtime[0]." ".$startTime);
						$signint_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signtime[1]." ".$startTime1);
						$signintime_ser_start = date('Y-m-d H:i:s',strtotime($signint_start));
						$signintime_ser_end = date('Y-m-d H:i:s',strtotime($signint_end));
						$query .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND  '$signintime_ser_end'";
						$st++;
					}
				}
				
			}
			if(!empty($signouttime)) {
				$startTime = "00:00:00";
				$startTime1 = "23:59:00";
				$sigouttime = explode(",",$signouttime);
				$datend_count = count($sigouttime);
				if($datend_count == 1){
					$signouttime = date('Y-m-d',strtotime($signouttime));	
					$signoutt_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime." ".$startTime);
					$signoutt_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime." ".$startTime1);
					$signouttime_ser_start = date('Y-m-d H:i:s',strtotime($signoutt_start));
					$signouttime_ser_end = date('Y-m-d H:i:s',strtotime($signoutt_end));
					$signouttime_ser = date('Y-m-d',strtotime($signoutt));
					$query .= " AND $module->baseTable.logout_time BETWEEN '$signouttime_ser_start' AND  '$signouttime_ser_end'";
				}
				else{
					if($status != "Signed in"){
						$sigouttime[0] = date('Y-m-d',strtotime($sigouttime[0]));
						$sigouttime[1] = date('Y-m-d',strtotime($sigouttime[1]));
						$signoutt_start = Vtiger_Datetime_UIType::getDBDateTimeValue($sigouttime[0]." ".$startTime);
						$signoutt_end = Vtiger_Datetime_UIType::getDBDateTimeValue($sigouttime[1]." ".$startTime1);
						$signouttime_ser_start = date('Y-m-d H:i:s',strtotime($signoutt_start));
						$signouttime_ser_end = date('Y-m-d H:i:s',strtotime($signoutt_end));
						$signouttime_ser = date('Y-m-d',strtotime($signoutt));
						$query .= " AND $module->baseTable.logout_time BETWEEN '$signouttime_ser_start' AND  '$signouttime_ser_end'";
						$st++;
					}
				}
			}
			if(!empty($status) && $st == 0) {
				$query .= " AND $module->baseTable.status LIKE '%$status%'";
			}
		}
		
        $query .= " ORDER BY login_time DESC"; 
		//print_r($query);
		//exit;
		return $query; 
    }

	public function getListViewLinks() {
		return array();
	}


	
	/** 
	 * Function which will get the list view count  
	 * @return - number of records 
	 */

	public function getListViewCount() {
		global $log;
		global $adb;
		//$adb->setDebug(true);
		$db = PearDatabase::getInstance();

		$module = $this->getModule();
		$listQuery = "SELECT count(*) AS count FROM $module->baseTable INNER JOIN vtiger_users ON vtiger_users.user_name = $module->baseTable.user_name";

		$search_key = $this->get('search_key');
		$value = $this->get('search_value');
		
		$search_user = $this->get('search_user');
		
		$userip = $this->get('userip');
		$signintime = $this->get('signintime');
		$signouttime = $this->get('signouttime');

		//added by jyothi
		        //$signintime_ser = date('Y-m-d',strtotime($signintime));
		        
		    //$signouttime_ser = date('Y-m-d',strtotime($signouttime));
		   // $signouttime_ser = Vtiger_Datetime_UIType::getDateTimeValue($signouttime);
		//ended here

		$status = $this->get('status');
		if(!empty($search_user)) {
			//$searchquery2	=	"SELECT vtiger_users.user_name FROM vtiger_users WHERE vtiger_users.last_name LIKE '%$search_user%'";
			$searchquery2	=	"SELECT vtiger_users.user_name FROM vtiger_users WHERE vtiger_users.user_name LIKE '%$search_user%'";
			$searchResult2 = $adb->pquery($searchquery2, array());
			 $searchRow2 = $adb->fetchByAssoc($searchResult2);
			 $search_user = $searchRow2['user_name'];
			$listQuery .= " WHERE $module->baseTable.user_name LIKE '%$search_user%'";
		}
		if(!empty($userip)) {
			$listQuery .= " AND $module->baseTable.user_ip LIKE '%$userip%'";
		}
		if(!empty($status) && !empty($signintime) && !empty($signouttime)) {
				$startTime = "00:00:00";
				$startTime1 = "23:59:00";
				$signtime = explode(",",$signintime);
				$dates_count = count($signtime);
				if($dates_count > 1){
					$signintime = $signtime[0];
				}
				$sigouttime = explode(",",$signouttime);
				$dates_end_count = count($sigouttime);
				if($dates_end_count > 1){
					$signouttime = $sigouttime[1];
				}
			if($status == "Signed in"){
				$signintime = date('Y-m-d',strtotime($signintime));	
				$signouttime = date('Y-m-d',strtotime($signouttime));	
				$signint_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime." ".$startTime);
				$signint_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime." ".$startTime1);
				$signintime_ser_start = date('Y-m-d H:i:s',strtotime($signint_start));
				$signintime_ser_end = date('Y-m-d H:i:s',strtotime($signint_end));
				$listQuery .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND  '$signintime_ser_end'";
			}
			else{
				$signintime = date('Y-m-d',strtotime($signintime));	
				$signouttime = date('Y-m-d',strtotime($signouttime));
				$signoutt_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime." ".$startTime);
				$signoutt_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime." ".$startTime1);
				$signouttime_ser_start = date('Y-m-d H:i:s',strtotime($signoutt_start));
				$signouttime_ser_end = date('Y-m-d H:i:s',strtotime($signoutt_end));
				$signouttime_ser = date('Y-m-d',strtotime($signoutt));
				$listQuery .= " AND $module->baseTable.logout_time BETWEEN '$signouttime_ser_start' AND  '$signouttime_ser_end'";
			}
		}
		else if(empty($status) && !empty($signintime) && !empty($signouttime)) {
				$startTime = "00:00:00";
				$startTime1 = "23:59:00";
				
				$signtime = explode(",",$signintime);
				$dates_count = count($signtime);
				if($dates_count > 1){
					$signintime_start = $signtime[0];
					$signintime_end = $signtime[1];
				}else{
					$signintime_start = $signtime[0];
					$signintime_end = $signtime[0];
				}
				
				$sigouttime = explode(",",$signouttime);
				$dates_end_count = count($sigouttime);
				if($dates_end_count > 1){
					$signouttime_strt = $sigouttime[0];
					$signouttime_end = $sigouttime[1];
				}
				else{
					$signouttime_strt = $sigouttime[0];
					$signouttime_end = $sigouttime[0];
				}
				
				$signintime_start = date('Y-m-d',strtotime($signintime_start));	
				$signintime_end = date('Y-m-d',strtotime($signintime_end));	
				
				$signint_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime_start." ".$startTime);
				$signint_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime_end." ".$startTime1);
				$signintime_ser_start = date('Y-m-d H:i:s',strtotime($signint_start));
				$signintime_ser_end = date('Y-m-d H:i:s',strtotime($signint_end));
				
				$signouttime_strt = date('Y-m-d',strtotime($signouttime_strt));	
				$signouttime_end = date('Y-m-d',strtotime($signouttime_end));
				$signoutt_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime_strt." ".$startTime);
				$signoutt_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime_end." ".$startTime1);
				$signouttime_ser_start = date('Y-m-d H:i:s',strtotime($signoutt_start));
				$signouttime_ser_end = date('Y-m-d H:i:s',strtotime($signoutt_end));
				
				
				$listQuery .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND '$signouttime_ser_end'";
				//$listQuery .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND  '$signintime_ser_end' OR $module->baseTable.logout_time BETWEEN '$signouttime_ser_start' AND  '$signouttime_ser_end' GROUP BY login_id";
		}
		else{
			$st = 0;
			if(!empty($signintime)) {
				$startTime = "00:00:00";
				$startTime1 = "23:59:00";
				$signtime = explode(",",$signintime);
				$datestart_count = count($signtime);
				if($datestart_count == 1){		
					$signintime = date('Y-m-d',strtotime($signintime));			
					$signint_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime." ".$startTime);
					$signint_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signintime." ".$startTime1);
					$signintime_ser_start = date('Y-m-d H:i:s',strtotime($signint_start));
					$signintime_ser_end = date('Y-m-d H:i:s',strtotime($signint_end));
					$listQuery .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND  '$signintime_ser_end'";
				}
				else{
					if($status == "Signed in"){
						$signtime[0] = date('Y-m-d',strtotime($signtime[0]));
						$signtime[1] = date('Y-m-d',strtotime($signtime[1]));
						$signint_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signtime[0]." ".$startTime);
						$signint_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signtime[1]." ".$startTime1);
						$signintime_ser_start = date('Y-m-d H:i:s',strtotime($signint_start));
						$signintime_ser_end = date('Y-m-d H:i:s',strtotime($signint_end));
						$listQuery .= " AND $module->baseTable.login_time BETWEEN '$signintime_ser_start' AND  '$signintime_ser_end'";
						$st++;
					}
				}
				
			}
			if(!empty($signouttime)) {
				$startTime = "00:00:00";
				$startTime1 = "23:59:00";
				$sigouttime = explode(",",$signouttime);
				$datend_count = count($sigouttime);
				if($datend_count == 1){
					$signouttime = date('Y-m-d',strtotime($signouttime));	
					$signoutt_start = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime." ".$startTime);
					$signoutt_end = Vtiger_Datetime_UIType::getDBDateTimeValue($signouttime." ".$startTime1);
					$signouttime_ser_start = date('Y-m-d H:i:s',strtotime($signoutt_start));
					$signouttime_ser_end = date('Y-m-d H:i:s',strtotime($signoutt_end));
					$signouttime_ser = date('Y-m-d',strtotime($signoutt));
					$listQuery .= " AND $module->baseTable.logout_time BETWEEN '$signouttime_ser_start' AND  '$signouttime_ser_end'";
				}
				else{
					if($status != "Signed in"){
						$sigouttime[0] = date('Y-m-d',strtotime($sigouttime[0]));
						$sigouttime[1] = date('Y-m-d',strtotime($sigouttime[1]));
						$signoutt_start = Vtiger_Datetime_UIType::getDBDateTimeValue($sigouttime[0]." ".$startTime);
						$signoutt_end = Vtiger_Datetime_UIType::getDBDateTimeValue($sigouttime[1]." ".$startTime1);
						$signouttime_ser_start = date('Y-m-d H:i:s',strtotime($signoutt_start));
						$signouttime_ser_end = date('Y-m-d H:i:s',strtotime($signoutt_end));
						$signouttime_ser = date('Y-m-d',strtotime($signoutt));
						$listQuery .= " AND $module->baseTable.logout_time BETWEEN '$signouttime_ser_start' AND  '$signouttime_ser_end'";
						$st++;
					}
				}
			}
			if(!empty($status) && $st == 0) {
				$listQuery .= " AND $module->baseTable.status LIKE '%$status%'";
			}
		}
		if(!empty($search_key) && !empty($value)) {
			$listQuery .= " AND $module->baseTable.$search_key = '$value'";
		}
		$listResult = $db->pquery($listQuery, array());
		return $db->query_result($listResult, 0, 'count');
	}

}
