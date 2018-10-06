/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

jQuery.Class("Quickbooks_Settings_Js",{ 

 
	forCronSettings : function() {
		 
		var instance = this;
		jQuery('.clsChkCron').click(function(){ 
		
			var params = {};
			params['module'] = 'Quickbooks';		 
			params['action'] = 'Settings';
			params['cron_module'] = jQuery(this).data('module');
			params['mode'] = jQuery(this).data('type');
			
			if(jQuery(this).prop("checked") == true){
                
				params['status'] = 'add';				
            }
            else if(jQuery(this).prop("checked") == false){
               
				params['status'] = 'delete';
            }
			 		 
			AppConnector.request(params).then(
				
				function(data) {
					var params1 = {};
					
					if (data.success){
						params1['text'] = data.result.message;
						Vtiger_Helper_Js.showMessage(params1);
					}else{
						params1['text'] = 'Not saved successfully';
						params1['type'] = 'error';
						Vtiger_Helper_Js.showMessage(params1);
					}	
					
				} ,function(error){ 
				   Vtiger_Helper_Js.showPnotify('Not saved successfully');		
				 }
			);
		});

		/* Sync button  */
		jQuery('.clsBtnSync').on('click',function(){
			 
			var progressIndicatorElement = jQuery.progressIndicator({
				'position' : 'html',
				'blockInfo' : {
				'enabled' : true
				}
			});
			hideparams = {};
			hideparams['mode'] = 'hide';

			var type = jQuery(this).data('type');
			var module = jQuery(this).data('module');			 
			var params = {};
			params['module'] = 'Quickbooks';		 
			params['action'] = 'Sync';
			params['sync_module'] = module;
			params['type'] = jQuery(this).data('type');
			AppConnector.request(params).then(
				
				function(data) {
					var params1 = {};
					progressIndicatorElement.progressIndicator(hideparams);
					if (data.success){
						params1['text'] = data.result.message;
						Vtiger_Helper_Js.showMessage(params1);
					}else{
						params1['text'] = 'Not Synced.';
						params1['type'] = 'error';
						Vtiger_Helper_Js.showMessage(params1);
					}	
					
				} ,function(error){ 
				   Vtiger_Helper_Js.showPnotify('Try Again.');		
				 }
			);


		});

	},
	 
	 
	/**
	 * Function to register events
	 */
	registerEvents : function(){
		
		this.forCronSettings(); 		 
	}
});


jQuery(document).ready(function(){
	var QuickbooksSettingsJs = new Quickbooks_Settings_Js();
	QuickbooksSettingsJs.registerEvents();
});
