<?php

//ini_set('error_reporting', E_ALL & ~E_NOTICE & ~E_WARNING & ~E_STRICT & ~E_DEPRECATED);
ini_set('display_errors','0');

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
		$query = "SELECT vv.vendorid FROM vtiger_vendor vv left join vtiger_crmentity vcm on vv.vendorid = vcm.crmid where vcm.deleted = 0 and vv.quickbook_id ='' ";
		$records = $adb->query($query);
		$vendors_ids_data = $adb->num_rows($records);
		if($vendors_ids_data > 0){
			$qb_create = $qb_update = 0;
			while($resultrow = $adb->fetch_array($records)) {
				$vendorid = $resultrow['vendorid']; 
				$wsid = vtws_getWebserviceEntityId('Vendors', $vendorid); // Module_Webservice_ID x CRM_ID
				$vtiger_data = vtws_retrieve($wsid, $current_user);
			
				require_once  'quickbooks/config.php';
				require_once 'quickbooks/views/header.tpl.php';	 
				if(isset($Context)){ 
					$id = $vtiger_data['id'];
					$id = explode('x',$id);	 
					$id = $id[1];

					$quickbook_id = $vtiger_data['quickbook_id'];
					$VendorService = new QuickBooks_IPP_Service_Vendor();
					if($quickbook_id != ''){
						//Existing Vendor
						//Get the existing Vendor 
						$vendors = $VendorService->query($Context, $realm, "SELECT * FROM Vendor WHERE Id = '$quickbook_id' ");
						$Vendor = $vendors[0];
					}else{
						//new Vendor
						$Vendor = new QuickBooks_IPP_Object_Vendor();
					}
					
					//$Vendor->setTitle('Mr');
					$Vendor->setGivenName($vtiger_data['vendorname']); 
					$Vendor->setDisplayName($vtiger_data['vendorname']);
					
					// Email
					if($vtiger_data['email'] != ''){
						$PrimaryEmailAddr = new QuickBooks_IPP_Object_PrimaryEmailAddr();
						$PrimaryEmailAddr->setAddress($vtiger_data['email']);
						$Vendor->setPrimaryEmailAddr($PrimaryEmailAddr);
					}
					// Phone #
					if($vtiger_data['phone'] != ''){
						$PrimaryPhone = new QuickBooks_IPP_Object_PrimaryPhone();
						$PrimaryPhone->setFreeFormNumber($vtiger_data['phone']);
						$Vendor->setPrimaryPhone($PrimaryPhone);
					}
					// Mobile #
					if($vtiger_data['phone'] != ''){
						$Mobile = new QuickBooks_IPP_Object_Mobile();
						$Mobile->setFreeFormNumber($vtiger_data['phone']);
						$Vendor->setMobile($Mobile);
					}
					
					
					if($quickbook_id != ''){
						//Existing Vendor
						if($resp = $VendorService->update($Context, $realm, $Vendor->getId(), $Vendor)){
							//print('Vendor ID is: [' . $resp . ']'); 
						}else{
							//print($VendorService->lastError($Context));die;
						}
						$qb_update++;
					}else{

						if ($resp = $VendorService->add($Context, $realm, $Vendor))
						{
							//print('Our new Vendor ID is: [' . $resp . ']');
							global $adb;
							$vtiger_id = $id;
							$qb_id = QuickBooks_IPP_IDS::usableIDType($resp);
							$sq = "UPDATE `vtiger_vendor` SET `quickbook_id`= $qb_id  WHERE  vendorid = $vtiger_id ";
							$adb->query($sq); 
							$qb_create++;
						}
						else
						{
							print($VendorService->lastError($Context));
						}
					}
				}
			}//end while 
			echo ' vendors '.$qb_create. ' Synced to Quickbooks.';
			//echo $qb_update . ' updated.';
		}else{
			echo '0 Vendors synced.';
		}
		
	
} catch (WebServiceException $ex) {
	echo $ex->getMessage();
}
//error_reporting( E_ERROR  | E_PARSE); 
 



?>