<?php
	require_once 'include/utils/utils.php';
	require 'modules/com_vtiger_workflow/VTEntityMethodManager.inc';
	/*-- Vendors Workflow --*/			
	$emm = new VTEntityMethodManager($adb);                   
	//$emm->addEntityMethod("Vendors", "Save Vendors In QuickBooks", "modules/Quickbooks/Workflows/SaveVendorsInQuickBooks.php", "createVendorsInQuickbooks");	 

 
/*-- Products Workflow --*/		
	$emm->addEntityMethod("Products", "Save Products In QuickBooks", "modules/Quickbooks/Workflows/SaveProductsInQuickBooks.php", "createProductsInQuickbooks");

	/*-- Services Workflow --*/			 
//	$emm->addEntityMethod("Services", "Save Services In QuickBooks", "modules/Quickbooks/Workflows/SaveServicesInQuickBooks.php", "createServicesInQuickbooks"); 

	/*-- Invoice Workflow --*/
	//$emm->addEntityMethod("Invoice", "Save Invoice In QuickBooks", "modules/Quickbooks/Workflows/SaveInvoiceInQuickBooks.php", "createInvoiceInQuickbooks"); 

	/*-- Contacts Workflow --*/		
	//$emm->addEntityMethod("Contacts", "Save Contact In QuickBooks", "modules/Quickbooks/Workflows/SaveContactInQuickBooks.php", "createContactInQuickbooks");
	//end Workflow declaration 	

?>