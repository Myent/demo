<?php  

// api call 
 
include_once dirname(__FILE__) . '/quickbooks/config.php';

include_once dirname(__FILE__) . '/quickbooks/views/header.tpl.php';
// crm call
include_once dirname(__FILE__) . '/config.inc.php';

include_once dirname(__FILE__) . '/modules/Emails/mail.php';

include_once dirname(__FILE__) . '/include/utils/utils.php';

include_once dirname(__FILE__) . '/includes/runtime/BaseModel.php';

include_once dirname(__FILE__) . '/includes/runtime/Globals.php';

include_once dirname(__FILE__) . '/includes/Loader.php';

include_once dirname(__FILE__) . '/includes/http/Request.php';

include_once dirname(__FILE__) . '/modules/Vtiger/models/Record.php';

include_once dirname(__FILE__) . '/modules/Users/models/Record.php';

include_once dirname(__FILE__) . '/includes/runtime/LanguageHandler.php';
 
include_once dirname(__FILE__) . '/modules/Users/Users.php';

include_once dirname(__FILE__) . '/include/Webservices/Create.php';

include_once dirname(__FILE__) . '/include/Webservices/Retrieve.php';

global $adb, $current_user;
$user = new Users();
$current_user = $user->retrieveCurrentUserInfoFromFile(Users::getActiveAdminId());
  
$ItemService = new QuickBooks_IPP_Service_Term();

//$items = $ItemService->query($Context, $realm, "SELECT * FROM Item WHERE Metadata.LastUpdatedTime > '2013-01-01T14:50:22-08:00' ORDER BY Metadata.LastUpdatedTime ");
$items = $ItemService->query($Context, $realm, "SELECT * FROM Item ORDER BY Metadata.LastUpdatedTime");

foreach ($items as $Item)
{
   echo '<pre>';//print_r($Item); 
    $qb_id = QuickBooks_IPP_IDS::usableIDType($Item->getId());
	
	$type =  $Item->getType();
	print('Item Id=' . $Item->getId() . ' is named: ' . $Item->getName() . '   ,type :: '.$type.'<br>');
	$data = array();	
	$data['quickbook_id'] = $qb_id;
	$data['unit_price'] =  $Item->getUnitPrice();
	$data['discontinued'] =  1;
	$data['assigned_user_id'] =  vtws_getWebserviceEntityId("Users", 1);
	 	
	//$adb->setDebug(true);
	
	$pq = 'SELECT * FROM `vtiger_productcf` where quickbook_id =  "'.$qb_id.'"';
	$precords = $adb->query($pq);
	$com_count_products = $adb->num_rows($precords);
	
	$sq = 'SELECT * FROM `vtiger_servicecf` where quickbook_id =  "'.$qb_id.'"';
	$srecords = $adb->query($sq);
	$com_count_services = $adb->num_rows($srecords); 
	
	if($com_count_products == 0 && $com_count_services == 0) {
		//insert	
		if($type == 'Service'){		
			$data['servicename'] = $Item->getName();
			$ps = vtws_create('Services', $data, $current_user);
		}else{ 
			$data['productname'] = $Item->getName();	
			if($Item->getQtyOnHand()){ 
				$data['qtyinstock'] =  $Item->getQtyOnHand();
				$data['sales_start_date'] =  $Item->getInvStartDate();
				$data['start_date'] =  $Item->getInvStartDate();
			}
			$ps = vtws_create('Products', $data, $current_user);
		}
		//print_r($ps);
		
	}else{
		//update
	}
	
}
echo "Synced "; 
?>