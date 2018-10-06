<?php

//ini_set('error_reporting', E_ALL & ~E_NOTICE & ~E_WARNING & ~E_STRICT & ~E_DEPRECATED);
//ini_set('display_errors','1');

require_once 'config.inc.php';
require_once  'modules/Emails/mail.php';
require_once  'include/utils/utils.php';
require_once  'includes/runtime/BaseModel.php';
require_once  'includes/runtime/Globals.php';
require_once  'includes/Loader.php';
require_once  'includes/http/Request.php';
require_once 'modules/Vtiger/models/Record.php';
require_once 'modules/Users/models/Record.php';
require_once 'includes/runtime/LanguageHandler.php';
require_once 'include/Webservices/Create.php'; 
require_once 'include/Webservices/Retrieve.php';
require_once 'modules/Users/Users.php';
try {
        $user = new Users();
        $current_user = $user->retrieveCurrentUserInfoFromFile(Users::getActiveAdminId());
		global $adb, $current_user; 
		$query = "SELECT vc.contactid FROM vtiger_contactscf vc left join vtiger_crmentity vcm on vc.contactid = vcm.crmid where vcm.deleted = 0 and vc.quickbook_id ='' ";
		$records = $adb->query($query);
		$contact_ids_data = $adb->num_rows($records);
		if($contact_ids_data > 0){
			$qb_create = $qb_update = 0;
			while($resultrow = $adb->fetch_array($records)) {
				$contactid = $resultrow['contactid']; 
				$wsid = vtws_getWebserviceEntityId('Contacts', $contactid); // Module_Webservice_ID x CRM_ID
				$vtiger_data = vtws_retrieve($wsid, $current_user);
				//echo '<pre>';print_r($Contactsdata);
				//createContactInQuickbooks($vtiger_data);
				//die;
				
				include  'quickbooks/config.php';
				include 'quickbooks/views/header.tpl.php';	 
				if(isset($Context)){
					
					$id = $vtiger_data['id'];
					$id = explode('x',$id);
					$id = $id[1];
					$CustomerService = new QuickBooks_IPP_Service_Customer();
					//echo '<pre>';
					//update Qb Custmoer 
					$quickbook_id = $vtiger_data['quickbook_id'];
					if($quickbook_id != ''){
						$customers = $CustomerService->query($Context, $realm, "SELECT * FROM Customer WHERE Id = '$quickbook_id' ");
						$Customer = $customers[0];		
					}
					else{
						$Customer = new QuickBooks_IPP_Object_Customer();
					}
					$Customer->setTitle($vtiger_data['salutationtype']);
					$Customer->setGivenName($vtiger_data['firstname']);
					$Customer->setMiddleName($vtiger_data['lastname']);
					//$Customer->setFamilyName($vtiger_data['firstname']);
					$Customer->setDisplayName($vtiger_data['salutationtype'] .' '. $vtiger_data['firstname'] . ' '. $vtiger_data['lastname']);

					// Terms (e.g. Net 30, etc.)
					//$Customer->setSalesTermRef($id);
					
					$Customer->setActive(true);
					
					//covart company id to Name
					if($vtiger_data['account_id'] != ''){ 
						$cid = $vtiger_data['account_id'];
						$cid =  explode('x',$cid);	 
						$cid = $cid[1];	
						$q = 'SELECT accountname FROM `vtiger_account` where accountid = "'.$cid.'"';
						$records = $adb->query($q);
						$c_name = $adb->fetch_array($records);	
						$Customer->setCompanyName(html_entity_decode($c_name['accountname']));
					}
					// Phone #
					if($vtiger_data['phone'] != ''){
						$PrimaryPhone = new QuickBooks_IPP_Object_PrimaryPhone();
						$PrimaryPhone->setFreeFormNumber($vtiger_data['phone']);
						$Customer->setPrimaryPhone($PrimaryPhone);
					}
					// Mobile #
					if($vtiger_data['mobile'] != ''){
						$Mobile = new QuickBooks_IPP_Object_Mobile();
						$Mobile->setFreeFormNumber($vtiger_data['mobile']);
						$Customer->setMobile($Mobile);
					}

					// Fax #
					if($vtiger_data['fax'] != '') { 
						$Fax = new QuickBooks_IPP_Object_Fax();
						$Fax->setFreeFormNumber($vtiger_data['fax']);
						$Customer->setFax($Fax);
					}
					// Bill address
					if($vtiger_data['mailingstreet'] != '' || $vtiger_data['mailingcity'] != '' || $vtiger_data['mailingcountry'] != ''  || $vtiger_data['mailingzip'] != '' ){
						$BillAddr = new QuickBooks_IPP_Object_BillAddr();
						if($vtiger_data['mailingstreet'] != ''){ $BillAddr->setLine1($vtiger_data['mailingstreet']); }		
						//$BillAddr->setLine2($vtiger_data['mailingstreet']);
						if($vtiger_data['mailingcity'] != ''){ $BillAddr->setCity($vtiger_data['mailingcity'] . ', ' . $vtiger_data['mailingstate']); }
						if($vtiger_data['mailingcountry'] != '' ) { $BillAddr->setCountry($vtiger_data['mailingcountry']); }
						//$BillAddr->setCountrySubDivisionCode($vtiger_data['mailingcountry']);
						if($vtiger_data['mailingzip'] != '' ) { $BillAddr->setPostalCode($vtiger_data['mailingzip']);}
						$Customer->setBillAddr($BillAddr);
					}

					// Email
					if($vtiger_data['email'] != ''){ 
						$PrimaryEmailAddr = new QuickBooks_IPP_Object_PrimaryEmailAddr();
						$PrimaryEmailAddr->setAddress($vtiger_data['email']);
						$Customer->setPrimaryEmailAddr($PrimaryEmailAddr);
					}
				 
					if($quickbook_id != ''){
						
						if($CustomerService->update($Context, $realm, $Customer->getId(), $Customer)){
							print('customer ID is: (name "' . $Customer->getDisplayName() . '")');
						}else{
							//print($CustomerService->lastError($Context));
							//die;
						}
						$qb_update++;
					} else	{ 
					
						if ($resp = $CustomerService->add($Context, $realm, $Customer))
						{
							print('Our new customer ID is: [' . $resp . '] (name "' . $Customer->getDisplayName() . '")');
							$vtiger_id = $id;
							$qb_id = QuickBooks_IPP_IDS::usableIDType($resp);
							$sq = "UPDATE `vtiger_contactscf` SET `quickbook_id`= $qb_id  WHERE  contactid = $vtiger_id ";
							$adb->query($sq);
							$qb_create++;
							
						}
						else
						{
							//print($CustomerService->lastError($Context));
							//die;
						}
					}
					require_once 'quickbooks/views/footer.tpl.php';
					//die;
				} 
			}//while end 
			echo 'New Contacts '.$qb_create. ' Synced.';
			//echo $qb_update . ' updated.';
		}else{
			echo '0 Contacts synced.';
		}
		
	
} catch (WebServiceException $ex) {
	//echo $ex->getMessage();
}
//error_reporting( E_ERROR  | E_PARSE); 
 



?>