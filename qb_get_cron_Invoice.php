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

error_reporting(E_ERROR | E_WARNING);
//ini_set('display_errors', 'On');
 

 

	global $adb, $current_user;
	$user = new Users();
	$current_user = $user->retrieveCurrentUserInfoFromFile(Users::getActiveAdminId());
	   
	$InvoiceService = new QuickBooks_IPP_Service_Invoice();
	
	$invoices = $InvoiceService->query($Context, $realm, "SELECT * FROM Invoice");
	print_r($invoices);die;
	//$invoices = $InvoiceService->query($Context, $realm, "SELECT * FROM Invoice WHERE DocNumber = '1002' ");
	
	foreach ($invoices as $Invoice)
	{
		//print('Invoice # ' . $Invoice->getDocNumber() . ' has a total of $' . $Invoice->getTotalAmt() . "\n");
		//print('    First line item: ' . $Invoice->getLine(0)->getDescription() . "\n");
		//print('    Internal Id value: ' . $Invoice->getId() . "\n");
		
		//print("\n");
		//echo '<pre>';
		//print_r($Invoice);
		//die;//$Line = $Invoice->getLine(0);

		//print_r($Line);
		 
		$qb_id = QuickBooks_IPP_IDS::usableIDType($Invoice->getId());
		
		$data = array();	
		$data['quickbook_id'] = $qb_id;
		$data['assigned_user_id'] =  vtws_getWebserviceEntityId("Users", 1);
		
		$qb_contactid = QuickBooks_IPP_IDS::usableIDType($Invoice->getCustomerRef());
		
		//contact details avilable or not 		
		$q = 'SELECT * FROM `vtiger_contactdetails` vcd left join vtiger_contactaddress vca on vcd.contactid = vca.contactaddressid where vcd.quickbook_id =  "'.$qb_contactid.'"'; 
		$records = $adb->query($q);
		$com_count = $adb->num_rows($records); 
		if($com_count == 0) { 
			//insert Contact 
				$CustomerService = new QuickBooks_IPP_Service_Customer();	
				$customers = $CustomerService->query($Context, $realm, "SELECT * FROM Customer WHERE Id = '$qb_contactid' ");
				$Customer = $customers[0]; 
				$BillAddr = $Customer->getBillAddr(); 
				$ShipAddr = $Customer->getShipAddr(); 
				$email = $Customer->getPrimaryEmailAddr();
				$PrimaryPhone = $Customer->getPrimaryPhone();
				$Mobile = $Customer->getMobile();
				$Fax = $Customer->getFax();
				$c_qb_id = QuickBooks_IPP_IDS::usableIDType($Customer->getId());
				$company_name = $Customer->getCompanyName();
				$WebAddr = $Customer->getWebAddr();
				
				$Company_data = array();				
				$contact_data = array(
					'assigned_user_id' => vtws_getWebserviceEntityId("Users", 1),
					'firstname' => $Customer->getGivenName(),
					'lastname' => $Customer->getMiddleName() .' '. $Customer->getFamilyName(), 	 
					'quickbook_id' => $c_qb_id
				);	
				
				if($BillAddr != null){ 	
					$contact_data['mailingcity'] = $BillAddr->getCity();
					$contact_data['mailingstreet'] = $BillAddr->getLine1();
					$contact_data['mailingcountry'] = $BillAddr->getCountry();
					$contact_data['mailingstate'] = $BillAddr->getCountrySubDivisionCode();
					$contact_data['mailingzip'] = $BillAddr->getPostalCode();
					
					$data['bill_city'] = $Company_data['bill_city'] = $BillAddr->getCity();
					$data['bill_code'] = $Company_data['bill_code'] =  $BillAddr->getPostalCode();
					$data['bill_country'] = $Company_data['bill_country'] =  $BillAddr->getCountry();
					$data['bill_state'] = $Company_data['bill_state'] =  $BillAddr->getCountrySubDivisionCode();
					$data['bill_street'] = $Company_data['bill_street'] =  $BillAddr->getLine1();			
					if(empty($BillAddr->getLine1())){ $Company_data['bill_street'] = 'line1';}
				} 
				if($ShipAddr != null){ 	 

					$data['ship_city'] = $Company_data['ship_city'] = $ShipAddr->getCity();
					$data['ship_code'] = $Company_data['ship_code'] =  $ShipAddr->getPostalCode();
					$data['ship_country'] = $Company_data['ship_country'] =  $ShipAddr->getCountry();
					$data['ship_state'] = $Company_data['ship_state'] = $ShipAddr->getCountrySubDivisionCode();
					$data['ship_street'] = $Company_data['ship_street'] =  $ShipAddr->getLine1();
					if(empty($ShipAddr->getLine1())){ $Company_data['ship_street'] = 'line1';}
				} 
				
				
				if($email != null){
					$contact_data['email'] = $email->getAddress();
					$Company_data['email1'] = $email->getAddress();
				}
				
				if($PrimaryPhone != null){
					$contact_data['phone'] = $PrimaryPhone->getFreeFormNumber();
					$Company_data['phone'] =  $PrimaryPhone->getFreeFormNumber();
				} 
				 
				if($Mobile != null){
					$contact_data['mobile'] = $Mobile->getFreeFormNumber();
					$Company_data['otherphone'] = $Mobile->getFreeFormNumber();
				}
				
				if($Fax != null){
					$contact_data['fax'] = $Fax->getFreeFormNumber();
					$Company_data['fax'] = $Fax->getFreeFormNumber();
				}
				
				if($WebAddr != null){
					//$contact_data['website'] = $WebAddr->getURI();
					$Company_data['website'] = $WebAddr->getURI();
				}
				
				if($Customer->getNotes()){
					$contact_data['Notes'] = $Customer->getNotes();
					$Company_data['Notes'] = $Customer->getNotes();
				}
				
				//check company name 
				if(!empty(trim($company_name)))
				{	 
					$q = 'SELECT accountid FROM `vtiger_account` where quickbook_customer_id = "'.$c_qb_id.'"';
					$records = $adb->query($q);
					$com_count = $adb->num_rows($records); 
					if($com_count == 0){
						//insert company name to Organization name 
						 
						$Company_data['assigned_user_id'] = vtws_getWebserviceEntityId("Users", 1);
						$Company_data['accountname'] = $company_name;
						$Company_data['quickbook_customer_id'] =  $c_qb_id;				
						$account_Data = vtws_create('Accounts', $Company_data, $current_user);
						$id = $account_Data['id'];
						$id = explode('x',$id);	 
						$contact_data['accountid'] = $id[1];	
						$vtiger_accountid = $id[1];			
					}else{
						$c_id = $adb->fetch_array($records); 
						$contact_data['accountid'] = $c_id['accountid'];
						$vtiger_accountid = $c_id['accountid'];
					}			
				}
				$vtiger_data = vtws_create('Contacts', $contact_data, $current_user);
				
				$id = $vtiger_data['id'];
				$id = explode('x',$id);	 
				$vtiger_contactid = $id[1];
			 
			 
		}else{ 
			$vtiger_contactid = $adb->query_result($records,0,'contactid');
			//add contact address here 
			$data['ship_city'] = $data['bill_city'] =   $adb->query_result($records,0,'mailingcity');
			$data['ship_code'] = $data['bill_code'] = $adb->query_result($records,0,'mailingzip');
			$data['ship_country'] = $data['bill_country'] = $adb->query_result($records,0,'mailingcountry');
			$data['ship_state'] = $data['bill_state'] = $adb->query_result($records,0,'mailingstate');
			$data['ship_street'] = $data['bill_street'] = $adb->query_result($records,0,'mailingstreet');
			//mailingpobox
			
			$aq = 'SELECT accountid FROM `vtiger_account` where quickbook_customer_id =  "'.$qb_contactid.'"'; 
			$arecords = $adb->query($aq);
			$vtiger_accountid = $adb->query_result($arecords,0,'accountid');
		}
		
		$data['contactid'] = vtws_getWebserviceEntityId("Contacts",  $vtiger_contactid);		
		// end Contact
		
		$data['subject'] = $Invoice->getDocNumber();
		$data['invoicedate'] = $Invoice->getTxnDate();			
		$data['duedate'] = $Invoice->getDueDate();	 
		$data['taxtype'] = 'group';	
		$data['invoice_no'] = $Invoice->getDocNumber();
		
		$data['account_id'] = vtws_getWebserviceEntityId("Accounts",  $vtiger_accountid);
		
		
		//{-usd} need to change id
		$currency_id = strtoupper(QuickBooks_IPP_IDS::usableIDType($Invoice->getCurrencyRef()));
		$cq = "SELECT id,conversion_rate FROM `vtiger_currency_info` where currency_code='".$currency_id."'";
		 
		$cqd = $adb->query($cq);
		$cqd_count = $adb->num_rows($cqd);
		if($cqd_count == 1){
			$cid = $adb->fetch_array($cqd);
			 
			$data['currency_id'] = vtws_getWebserviceEntityId("Currency",  $cid['id']);
			$data['conversion_rate'] = $cid['conversion_rate'];
		}else{
			$data['currency_id'] = vtws_getWebserviceEntityId("Currency",  1);
			$data['conversion_rate'] = 1;
		} 
		
		$data['subtotal'] = $Invoice->getTotalAmt();	
		$data['total'] = $Invoice->getBalance();
		 
		//line 
		$Line = $Invoice->getLine();  
		$lien_amount = $Line->getAmount();
		$lien_DetailType = $Line->getDetailType();
		$lienSalesItemLineDetail = $Line->getSalesItemLineDetail();
		 
		if($lienSalesItemLineDetail != NULl){
			$ItemRef = QuickBooks_IPP_IDS::usableIDType($lienSalesItemLineDetail->getItemRef());//{-id}			
			$ItemRef_name = $lienSalesItemLineDetail->getItemRef_name();
			$UnitPrice = $lienSalesItemLineDetail->getUnitPrice();
			$Qty = $lienSalesItemLineDetail->getQty();
		} 
		
		$TxnTaxDetail = $Invoice->getTxnTaxDetail();
		$TaxPercent  = 0;
		if($TxnTaxDetail != NULL){
			$TotalTax = $TxnTaxDetail->getTotalTax();
			$TaxLineDetail = $TxnTaxDetail->getTaxLineDetail();
			if($TaxLineDetail != NULL){
				$TaxPercent  = $TaxLineDetail->getTaxPercent();
			}
		}
		
		$product_id = getProductId($ItemRef);
		$data['productid'] = $data['LineItems'][0]['productid'] = vtws_getWebserviceEntityId("Products",  $product_id);
		$data['LineItems'][0]['quantity'] = $Qty;
		$data['LineItems'][0]['listprice'] = $UnitPrice;
		//$data['LineItems'][0]['tax3'] = $TaxPercent;
		$data['s_h_percent'] = $TotalTax ; //27 
		// add all line item unitprice 
		$pre_tax_total = $UnitPrice;
		$data['pre_tax_total'] = $pre_tax_total; 
		
		$data['balance'] = $Invoice->getBalance();
	 
		
		$BillAddr = $Invoice->getBillAddr();
		if($ShipAddr != NULL){ 					
			$data['bill_city'] = $BillAddr->getCity();
			$data['bill_code'] = $BillAddr->getPostalCode();
			$data['bill_country'] = $BillAddr->getCountry();
			$data['bill_state'] = $BillAddr->getCountrySubDivisionCode();
			$data['bill_street'] = $BillAddr->getLine1();
			//$data['bill_pobox'] = $BillAddr->get();
		}
		
		$ShipAddr = $Invoice->getShipAddr(); 		 
		if($ShipAddr != NULL){ 
			$data['ship_city'] = $ShipAddr->getCity();
			$data['ship_code'] = $ShipAddr->getPostalCode();
			$data['ship_country'] = $ShipAddr->getCountry();
			$data['ship_state'] = $ShipAddr->getCountrySubDivisionCode();
			$data['ship_street'] = $ShipAddr->getLine1();
			//$data['ship_pobox'] = $ShipAddr->get();
			// status table vtiger_invoicestatus
		}
		
		
		//$adb->setDebug(true);
		//print_r($data);
		 
		
		$q = 'SELECT * FROM `vtiger_invoice` where quickbook_id =  "'.$qb_id.'"';
		$records = $adb->query($q);
		$com_count = $adb->num_rows($records); 
		if($com_count == 0) {
			//insert
			$qi = vtws_create('Invoice', $data, $current_user);
		}else{
			//update
		} 
	}
 
 function getProductId($ItemRef){
	global $adb, $current_user;
	$pq = 'SELECT productid FROM `vtiger_products` where quickbook_id =  "'.$ItemRef.'"';
	$precords = $adb->query($pq);
	$com_count_products = $adb->num_rows($precords);
	if($com_count_products > 0 ){
		$id = $adb->fetch_array($precords);
		return $id['productid'];
	}else{
		$sq = 'SELECT serviceid FROM `vtiger_service` where quickbook_id =  "'.$ItemRef.'"';
		$srecords = $adb->query($sq);
		$com_count_services = $adb->num_rows($srecords); 
		if($com_count_services > 0){
			$id = $adb->fetch_array($srecords);
			return $id['serviceid'];
		}else{
			
			return 1;
		}
		
	}
	 
 }
 
  
 ?>