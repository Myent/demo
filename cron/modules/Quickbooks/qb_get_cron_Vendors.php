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
include_once 'include/Webservices/Query.php';
include_once dirname(__FILE__) . '/modules/Users/Users.php';

include_once dirname(__FILE__) . '/include/Webservices/Create.php';

include_once dirname(__FILE__) . '/include/Webservices/Retrieve.php';

global $adb, $current_user;
$user = new Users();
$current_user = $user->retrieveCurrentUserInfoFromFile(Users::getActiveAdminId());
  
//Vendors 
$VendorService = new QuickBooks_IPP_Service_Vendor();

$vendors = $VendorService->query($Context, $realm, "SELECT * FROM Vendor");

//print_r($terms);

foreach ($vendors as $Vendor)
{
    //echo '<pre>';print_r($Vendor);

    print('Vendor Id=' . $Vendor->getId() . ' is named: ' . $Vendor->getDisplayName() . '<br>'); 
	
	$qb_id = QuickBooks_IPP_IDS::usableIDType($Vendor->getId());
	$data = array();	
	$data['quickbook_id'] = $qb_id;
	$data['assigned_user_id'] =  vtws_getWebserviceEntityId("Users", 1);
	$data['vendorname'] = $Vendor->getDisplayName();
	//$data['glacct'] = $Vendor->get();
	//$data['category'] = $Vendor->get();
	//$data['description'] = $Vendor->get();
	
	
	$email = $Vendor->getPrimaryEmailAddr();
	$website = $Vendor->getWebAddr();
	$PrimaryPhone = $Vendor->getPrimaryPhone();
	$Mobile = $Vendor->getMobile();
	$Fax = $Vendor->getFax();	
	$b = $Vendor->getBillAddr(); 
	
	if($PrimaryPhone != null){
		$data['phone'] = $PrimaryPhone->getFreeFormNumber();
	}	
	if($email != null){
		$data['email'] = $email->getAddress();
	}
	if($website != null){
		$data['website'] = $website->getURI();
	}	
	
	if($Mobile != null){
		$data['mobile'] = $Mobile->getFreeFormNumber();
	}	
	if($Fax != null){
		$data['fax'] = $Fax->getFreeFormNumber();
	}
	if($b != null){ 	
		$data['city'] = $b->getCity();
		$data['street'] = $b->getLine1();
		$data['country'] = $b->getCountry();
		$data['state'] = $b->getCountrySubDivisionCode();
		//$data['mailingpobox'] = QuickBooks_IPP_IDS::usableIDType($b->getId());
		$data['postalcode'] = $b->getPostalCode();
	}
	//$adb->setDebug(true);
	
	//check record present or not 	
	$q = 'SELECT * FROM `vtiger_vendor` where quickbook_id =  "'.$qb_id.'"'; 
	$records = $adb->query($q);
	$com_count = $adb->num_rows($records); 
	if($com_count == 0) {
		//insert
		$ps = vtws_create('Vendors', $data, $current_user); 
	}else{
		//update		 
	}
	//print_r($ps);
} 

  
  
 ?>