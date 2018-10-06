/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
jQuery.Class('Settings_OS2ForensicView_Js', {}, {
	
	//constructor
	init : function() {
		Settings_OS2ForensicView_Js.OS2ForensicViewInstance = this;
	},
	
	/*
	 * function to show editView for Add/Edit Currency
	 * @params: id - currencyId
	 */
	

    
    registerEvents : function() {
		var thisInstance = this;
		var detailurl = '';
		//console.log("YOGITA");
		var url = window.location.href;
		var urlparams = url.split("?");
		var view = app.getViewName();
		if(view == 'Detail'){
			if(jQuery('.detailViewContainer .related ul li').length > 0){
				this.Deatilcontainer = jQuery('.detailViewContainer .related ul');
				jQuery(".nav li").on('click',function(){
				   detailurl = jQuery(this).data('url');
				   var params = {};
					params['parent'] = 'Settings';
					params['module'] = 'OS2ForensicView';
					params['action'] = 'SaveHeaderUrl';
					params['url'] = detailurl;
					params['view'] = view;
					//console.log(params);
					AppConnector.request(params).then(
						function(data) {
							if (data.success){	
							}
						},
						function(error) {
							//progressIndicatorElement.progressIndicator(hideparams);
							alert("Very serious error. Investigate!!");
						}	
					);
				});
			}
		}
		var params = {};
		params['parent'] = 'Settings';
		params['module'] = 'OS2ForensicView';
		params['action'] = 'SaveHeaderUrl';
		params['url'] = url;
		params['view'] = view;
		//console.log(params);
		
		AppConnector.request(params).then(
			function(data) {
				if (data.success){	
				}
			},
			function(error) {
				alert("Very serious error. Investigate!!");
			}	
		);
	}
	
});

jQuery(document).ready(function(){
	var OS2ForensicViewInstance = new Settings_OS2ForensicView_Js();
    OS2ForensicViewInstance.registerEvents();
	
	
})
