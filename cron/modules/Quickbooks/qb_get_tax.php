<?php  

// api call 
 
include_once dirname(__FILE__) . '/quickbooks/config.php';

include_once dirname(__FILE__) . '/quickbooks/views/header.tpl.php';
 

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
 
$TaxCodeService = new QuickBooks_IPP_Service_TaxCode();

$taxcodes = $TaxCodeService->query($Context, $realm, "SELECT * FROM TaxCode");
echo '<pre>';
 

foreach ($taxcodes as $TaxCode)
{
 //  print_r($TaxCode);

   // print('TaxCode Id=' . $TaxCode->getId() . ' is named: ' . $TaxCode->getName() . '<br>');
	
	$id = QuickBooks_IPP_IDS::usableIDType($TaxCode->getId());
	$Name = $TaxCode->getName();
	$Description = $TaxCode->getDescription();
	$Active = $TaxCode->getActive();
	$Taxable = $TaxCode->getTaxable();
	$TaxGroup = $TaxCode->getTaxGroup();
	
	$query = "select * from quickbooks_TaxCode where QbTaxCodeId ='$id' ";
	$records = $adb->query($query);
	$contact_ids_data = $adb->num_rows($records);
	if($contact_ids_data == 0){
		$query = 'SELECT MAX( id ) AS id FROM  `quickbooks_TaxCode`';
		$records = $adb->query($query);
		$resultrow = $adb->fetch_array($records);
		$next_id = $resultrow['id']+1;
		$query = "INSERT INTO  quickbooks_TaxCode (`id`,`QbTaxCodeId`, `Name`, `Description`, `Active`, `Taxable`, `TaxGroup`) VALUES ($next_id,'".$id."','".$Name."','".$Description."','".$Active."','".$Taxable."','".$TaxGroup."')";
		$adb->query($query);
		
		if($SalesTaxRateLists = $TaxCode->getSalesTaxRateList())
		{ 
			$SalesTaxRateLists1 = $SalesTaxRateLists->getTaxRateDetail();
			if(is_array($SalesTaxRateLists1)){ 
				foreach($SalesTaxRateLists1 as $SalesTaxRateList){
					$TaxRateRef =  QuickBooks_IPP_IDS::usableIDType($SalesTaxRateList->getTaxRateRef());
				 
					
					$TaxCodeServiceRate = new QuickBooks_IPP_Service_TaxRate();
					$taxrates = $TaxCodeServiceRate->query($Context, $realm, "SELECT * FROM TaxRate where Id = '$TaxRateRef' ");
					foreach($taxrates as $taxrate){				 
						 $taxRateValue = $taxrate->getRateValue(); 
					}
					$query = "INSERT INTO `quickbooks_TaxRateList`(`TaxCodeId`, `QbTaxRateRefId`, `taxname`, `taxlabel`, `taxRateValue`) VALUES ('".$next_id."','".$TaxRateRef."','".$Name."','".$Name."','".$taxRateValue."')";
					$adb->query($query);
				}
			}else{
					$SalesTaxRateList = $SalesTaxRateLists1;
					$TaxRateRef =  QuickBooks_IPP_IDS::usableIDType($SalesTaxRateList->getTaxRateRef());			 
					
					$TaxCodeServiceRate = new QuickBooks_IPP_Service_TaxRate();
					$taxrates = $TaxCodeServiceRate->query($Context, $realm, "SELECT * FROM TaxRate where Id = '$TaxRateRef' ");
					foreach($taxrates as $taxrate){				 
						$taxRateValue = $taxrate->getRateValue(); 
					}
					$query = "INSERT INTO `quickbooks_TaxRateList`(`TaxCodeId`, `QbTaxRateRefId`, `taxname`, `taxlabel`, `taxRateValue`) VALUES ('".$next_id."','".$TaxRateRef."','".$Name."','".$Name."','".$taxRateValue."')";
					$adb->query($query);
			}
		}
	} 
	
}
	

 


?>