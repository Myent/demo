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
		$query = "SELECT vc.invoiceid FROM vtiger_invoicecf vc left join vtiger_crmentity vcm on vc.invoiceid = vcm.crmid where vcm.deleted = 0 and vc.quickbook_id ='' ";
		$records = $adb->query($query);
		$num_rows = $adb->num_rows($records);
		if($num_rows > 0){
			while($resultrow = $adb->fetch_array($records)) { 
				$invoiceid = $resultrow['invoiceid']; 
				$wsid = vtws_getWebserviceEntityId('Products', $invoiceid); // Module_Webservice_ID x CRM_ID
				$vtiger_data = vtws_retrieve($wsid, $current_user);
				require_once  'quickbooks/config.php';
				require_once 'quickbooks/views/header.tpl.php';	 
				global $adb;
				if(isset($Context)){ 
					$id = $vtiger_data['id'];
					$id = explode('x',$id);	 
					$id = $id[1];  
					
					//check create/update
					$quickbook_id = $vtiger_data['quickbook_id'];
					$InvoiceService = new QuickBooks_IPP_Service_Invoice();
					if($quickbook_id != ''){
						//Existing invoice
						//Get the existing invoice 
						$invoices = $InvoiceService->query($Context, $realm, "SELECT * FROM Invoice  WHERE Id = '$quickbook_id' ");
						$Invoice = $invoices[0];
					}else{
						//new invoice
						$Invoice = new QuickBooks_IPP_Object_Invoice();
					} 
					

					$Invoice->setDocNumber($vtiger_data['invoice_no']);
					$Invoice->setTxnDate($vtiger_data['invoicedate']);
					
					if(empty($vtiger_data['contact_id'])){
						$account_id = $vtiger_data['account_id'];
						$account_id = explode('x',$account_id);	 
						$account_id = $account_id[1];
						 
						$adata = $adb->query("SELECT quickbook_customer_id FROM `vtiger_account` where accountid = '$account_id'");
						$adata = $adb->fetch_array($adata);		 
						$Invoice->setCustomerRef($adata['quickbook_customer_id']);
						
					}else{
						$cid = $vtiger_data['contact_id'];
						$cid = explode('x',$cid);	 
						$cid = $cid[1];
						 
						$cdata = $adb->query("SELECT quickbook_id FROM `vtiger_contactscf` where contactid = '$cid'");
						$cdata = $adb->fetch_array($cdata);		 
						$Invoice->setCustomerRef($cdata['quickbook_id']);
					}
					 
					
					foreach($vtiger_data['LineItems'] as $key => $item)
					{
						$Line = new QuickBooks_IPP_Object_Line();
						$SalesItemLineDetail = new QuickBooks_IPP_Object_SalesItemLineDetail();		
						$item_id = $item['productid'];
						$item_id = explode('x',$item_id);	 
						$item_id = $item_id[1]; 
						//get type of item (product/services)
						$sq = "SELECT setype FROM `vtiger_crmentity` where crmid=$item_id";
						$item_type = $adb->query($sq);
						$item_type = $adb->fetch_array($item_type);			 
						$setype = $item_type['setype'];
							if($setype == 'Services'){
								$q = "SELECT servicename as itemname,quickbook_id FROM `vtiger_servicecf` where serviceid = $item_id";
							}else{
								$q = "SELECT productname as itemname,quickbook_id FROM `vtiger_productcf` where productid = $item_id";
							}
						$itemdata = $adb->query($q);
						$itemdata = $adb->fetch_array($itemdata);	
						
						$SalesItemLineDetail->setItemRef($itemdata['quickbook_id']);
						$SalesItemLineDetail->setItemRef_name($itemdata['itemname']);
						$SalesItemLineDetail->setUnitPrice($item['listprice']);
						$SalesItemLineDetail->setQty($item['quantity']);
						
						$Line->addSalesItemLineDetail($SalesItemLineDetail);
						$tax = $item['tax1'] +  $item['tax2'] +  $item['tax3'];
						//$Line->setAmount($item['listprice'] * $item['quantity'] * ($tax/100));
						$Line->setAmount($item['listprice'] * $item['quantity'] );
						$Line->setDescription($item['description']);
						$Line->setDetailType('SalesItemLineDetail');
						$Invoice->addLine($Line);
					}
					
				 
					//$Invoice->setTax(270);
					//$Invoice->setCustomerRef($id);

					
					if($quickbook_id != ''){
						//update
						if($resp = $InvoiceService->update($Context, $realm, $Invoice->getId(), $Invoice)){
							//print('Our new Item ID is: [' . $resp . ']'); 
							$qb_update++;
						}else{
							//print($InvoiceService->lastError($Context));die;
						} 
						
					}else{
						
						//create
						if ($resp = $InvoiceService->add($Context, $realm, $Invoice))
						{
							//print('Our new Invoice ID is: [' . $resp . ']');
							$vtiger_id = $id;
							$qb_id = QuickBooks_IPP_IDS::usableIDType($resp);
							$sq = "UPDATE `vtiger_invoicecf` SET `quickbook_id`= $qb_id  WHERE  invoiceid = $vtiger_id ";
							$adb->query($sq); 
							$qb_create++;	
						}
						else
						{
							//print($InvoiceService->lastError());die;
						}
						
					}	 
				}
				
				
			}	
			echo  $qb_create. ' Invoices Synced to Quickbooks.';
		}else{
			echo '0 Invoices synced.';
		}
		
	
} catch (WebServiceException $ex) {
	echo $ex->getMessage();
}
//error_reporting( E_ERROR  | E_PARSE); 
 



?>