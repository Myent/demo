/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Detail_Js("Calendar_Detail_Js", {
	triggerRejectReason : function(url) {
		var params = url;
		var progressIndicatorElement = jQuery.progressIndicator();
		AppConnector.request(params).then(
			function(data) {
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				var callBackFunction = function(data){
					jQuery('#addReasonReject').validationEngine({
						// to prevent the page reload after the validation has completed
						'onValidationComplete' : function(form,valid){
                             return valid;
						}
					});
					
					Vtiger_Detail_Js.getInstance().ReasonSubmit().then(function(data){
						app.hideModalWindow();
						jQuery('#addReasonReject').find('[name="saveButton"]').attr('disabled', 'disabled');
						if(data.success){
							var result = data.result;
							if(result.success){
								var info = result.info;
								var  params = {
									title : app.vtranslate('Message'),
									text : result.message,
									delay: '2000',
									type: 'success'
								}
								Vtiger_Helper_Js.showPnotify(params);
								jQuery("#Events_detailView_basicAction_Reject").addClass('hide');
								var rejectedusers = result.rejectedusers;
								var inviteeusers = result.inviteeusers; 
								jQuery("#Events_detailView_fieldValue_rejected_users").find('.value').html(rejectedusers);
								jQuery("#invitee_users_list").html(inviteeusers);
								
							}
						} else {
							var  params = {
									title : app.vtranslate('JS_ERROR'),
									text : data.error.message,
									type: 'error'
								}
							Vtiger_Helper_Js.showPnotify(params);
						}
					});
				};
				app.showModalWindow(data,function(data){
					if(typeof callBackFunction == 'function'){
						callBackFunction(data);
					}
				});
			}
		)
	},

	
},{
	ReasonSubmit : function() {
		var aDeferred = jQuery.Deferred();
		jQuery('#addReasonReject').on('submit',function(e){
			var validationResult = jQuery(e.currentTarget).validationEngine('validate');
			if(validationResult == true){
				var formData = jQuery(e.currentTarget).serializeFormData();
				var foldername = jQuery.trim(formData.foldername);
				formData.foldername = foldername;
				AppConnector.request(formData).then(
					function(data){
						aDeferred.resolve(data);
					}
				);
			}
			e.preventDefault();
		});
		return aDeferred.promise();
	},
	
});