<?php

//error_reporting(E_ALL);
ini_set('display_errors', 'off');

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
		
		 $query = "SELECT * FROM `quickbooks_TaxCode` where QbTaxCodeId = '' "; 
		echo '<pre>';
		$records = $adb->query($query);
		$contact_ids_data = $adb->num_rows($records);
		if($contact_ids_data > 0){
			
			$qb_create = $qb_update = 0;
			
			while($resultrow = $adb->fetch_array($records)) {
				print_r($resultrow);
				$id = $resultrow['id']; 
				$Name = $resultrow['name']; 
				//$Description = $resultrow['Description']; 
				//$TaxGroup = $resultrow['TaxGroup'];  
				
				include  'quickbooks/config.php';
				include 'quickbooks/views/header.tpl.php';	 
				if(isset($Context)){
					
				 
					$TaxService = new QuickBooks_IPP_Service_TaxService();
					//$TaxService = new QuickBooks_IPP_Service_TaxCode();
					$TaxCode = new QuickBooks_IPP_Object_TaxService();
					 
					 $TaxCode->setTaxCode($Name);
						
					$rqurty = "SELECT * FROM `quickbooks_TaxRateList` where taxCodeId =1 and deleted=0";
					$rrecords = $adb->query($rqurty);
					while($vtiger_data = $adb->fetch_array($rrecords)) {
						print_r($vtiger_data);
						$TaxRateDetails = new QuickBooks_IPP_Object_TaxRateDetail();
							$TaxRateDetails->setTaxRateName($vtiger_data['taxlabel']);
							$TaxRateDetails->setRateValue($vtiger_data['taxratevalue']);
							$TaxRateDetails->setTaxAgencyId(1);
							//$TaxRateDetails->setTaxApplicableOn($Name);
							$TaxRateDetails->setTaxApplicableOn('Sales');
						$TaxCode->setTaxRateDetails($TaxRateDetails);
					}
						 
					 
					
						if ($resp = $TaxService->add($Context, $realm, $TaxCode))
						{
							print('Our new customer ID is: [' . $resp . '] (name "'   . '")');
							/* $vtiger_id = $id;
							$qb_id = QuickBooks_IPP_IDS::usableIDType($resp);
							$sq = "UPDATE `vtiger_contactdetails` SET `quickbook_id`= $qb_id  WHERE  contactid = $vtiger_id ";
							$adb->query($sq);
							$qb_create++;*/
							
						}
						else
						{
							print($TaxService->lastError($Context));
							//die;
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
		echo $ex->getMessage();
	}
//error_reporting( E_ERROR  | E_PARSE); 
 



?>