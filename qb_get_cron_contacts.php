<?php  

// api call 
 
include_once dirname(__FILE__) . '/quickbooks/config.php';

include_once dirname(__FILE__) . '/quickbooks/views/header.tpl.php';

$CustomerService = new QuickBooks_IPP_Service_Customer();

$customers = $CustomerService->query($Context, $realm, "SELECT * FROM Customer MAXRESULTS 100");

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

foreach ($customers as $Customer)
{
	//echo '<pre>'; print_r($Customer);die;
	print('Customer Id=' . $Customer->getId() . ' is named: ' . $Customer->getFullyQualifiedName() . '<br>');
	 
	
	$BillAddr = new QuickBooks_IPP_Object($Customer);	 
	$b = $Customer->getBillAddr(); 
	$ShipAddr = $Customer->getShipAddr(); 
	$email = $Customer->getPrimaryEmailAddr();
	$PrimaryPhone = $Customer->getPrimaryPhone();
	$Mobile = $Customer->getMobile();
	$Fax = $Customer->getFax();
	$qb_id = QuickBooks_IPP_IDS::usableIDType($Customer->getId());
	$company_name = $Customer->getCompanyName();
	$WebAddr = $Customer->getWebAddr();
	
	$Company_data = array();
	
	$data = array(
		'assigned_user_id' => vtws_getWebserviceEntityId("Users", 1),
		//'currency_id' => vtws_getWebserviceEntityId("Currency", 1),		
		//'projectid' => vtws_getWebserviceEntityId("Project", $projectid),		
		//'contact_no' => '',
		'firstname' => $Customer->getGivenName(),
		'lastname' => $Customer->getMiddleName() .' '. $Customer->getFamilyName(), 	 
		'quickbook_id' => $qb_id
		
	);
	
	
	
	
	if($b != null){ 	
		$data['mailingcity'] = $b->getCity();
		$data['mailingstreet'] = $b->getLine1();
		$data['mailingcountry'] = $b->getCountry();
		$data['mailingstate'] = $b->getCountrySubDivisionCode();
		$data['mailingzip'] = $b->getPostalCode();
		
		$Company_data['bill_city'] = $b->getCity();
		$Company_data['bill_code'] =  $b->getPostalCode();
		$Company_data['bill_country'] =  $b->getCountry();
		$Company_data['bill_state'] =  $b->getCountrySubDivisionCode();
		$Company_data['bill_street'] =  $b->getLine1();				
	}
	
	if($ShipAddr != null){ 	 

		$Company_data['ship_city'] = $ShipAddr->getCity();
		$Company_data['ship_code'] =  $ShipAddr->getPostalCode();
		$Company_data['ship_country'] =  $ShipAddr->getCountry();
		$Company_data['ship_state'] = $ShipAddr->getCountrySubDivisionCode();
		$Company_data['ship_street'] =  $ShipAddr->getLine1();
	}
	
	
	
	if($email != null){
		$data['email'] = $email->getAddress();
		$Company_data['email1'] = $email->getAddress();
	}
	
	if($PrimaryPhone != null){
		$data['phone'] = $PrimaryPhone->getFreeFormNumber();
		$Company_data['phone'] =  $PrimaryPhone->getFreeFormNumber();
	} 
	 
	if($Mobile != null){
		$data['mobile'] = $Mobile->getFreeFormNumber();
		$Company_data['otherphone'] = $Mobile->getFreeFormNumber();
	}
	
	if($Fax != null){
		$data['fax'] = $Fax->getFreeFormNumber();
		$Company_data['fax'] = $Fax->getFreeFormNumber();
	}
	
	if($WebAddr != null){
		//$data['website'] = $WebAddr->getURI();
		$Company_data['website'] = $WebAddr->getURI();
	}
	
	if($Customer->getNotes()){
		$data['Notes'] = $Customer->getNotes();
		$Company_data['Notes'] = $Customer->getNotes();
	}
	
	//check company name 
	if(!empty(trim($company_name)))
	{	 
		$q = 'SELECT accountid FROM `vtiger_account` where quickbook_customer_id = "'.$qb_id.'"';
		$records = $adb->query($q);
		$com_count = $adb->num_rows($records); 
		if($com_count == 0){
			//insert company name to Organization name 			 
			$Company_data['assigned_user_id'] = vtws_getWebserviceEntityId("Users", 1);
			$Company_data['accountname'] = $company_name;
			$Company_data['quickbook_customer_id'] =  $qb_id;				
			$account_Data = vtws_create('Accounts', $Company_data, $current_user);
			$id = $account_Data['id'];
			$id = explode('x',$id);	 
			$data['accountid'] = $id[1];		
		}else{
			$c_id = $adb->fetch_array($records); 
			$data['accountid'] = $c_id['accountid'];
		}			
	}
	//$adb->setDebug(true); 
	
	//check record present or not 	
	$q = 'SELECT * FROM `vtiger_contactscf` where quickbook_id =  "'.$qb_id.'"';
	$records = $adb->query($q);
	$com_count = $adb->num_rows($records); 
	if($com_count == 0) {
		//insert
		$ps = vtws_create('Contacts', $data, $current_user);
	}else{
		//update
	} 

} 
	
echo "Synced"; 
 


?>