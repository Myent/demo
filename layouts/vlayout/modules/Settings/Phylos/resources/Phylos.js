/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

jQuery.Class("Settings_Phylos_Js",{},{
	
	/*
	 * function to Save the Outgoing Server Details
	 */
	savePhylosDetails : function(form) {
		var thisInstance = this;
		var data = form.serializeFormData();
		var progressIndicatorElement = jQuery.progressIndicator({
				'position' : 'html',
				'blockInfo' : {
					'enabled' : true
				}
			});
		
		if(typeof data == 'undefined' ) {
			data = {};
		}
		data.module = app.getModuleName();
		data.parent = app.getParentModuleName();
		data.action = 'PhylosSaveAjax';

		AppConnector.request(data).then(
			function(data) {
				if(data['success']) {
					var PhylosDetailUrl = form.data('detailUrl');
					//after save, load detail view contents and register events
					thisInstance.loadContents(PhylosDetailUrl).then(
						function(data) {
							thisInstance.registerDetailViewEvents();
							progressIndicatorElement.progressIndicator({'mode':'hide'});
						},
						function(error, err) {
							progressIndicatorElement.progressIndicator({'mode':'hide'});
						}
					);
				} else {
					var errmsg = data['error']['message'][0];
					progressIndicatorElement.progressIndicator({'mode':'hide'});
					jQuery('.errorMessage', form).removeClass('hide');
					jQuery('.errormessagedisplay',form).html(errmsg);
				}
			},
			function(error, errorThrown){
			}
		);
	},
	
	/*
	 * function to load the contents from the url through pjax
	 */
	loadContents : function(url) {
		var aDeferred = jQuery.Deferred();
		AppConnector.requestPjax(url).then(
			function(data){
				jQuery('.contentsDiv').html(data);
				aDeferred.resolve(data);
			},
			function(error, err){
				aDeferred.reject();
			}
		);
		return aDeferred.promise();
	},
	
	/*
	 * function to register the events in editView
	 */
	registerEditViewEvents : function() {
		var thisInstance = this;
		var form = jQuery('#PhylosForm');
		var cancelLink = jQuery('.cancelLink', form);
		
		//register validation engine
		var params = app.validationEngineOptions;
		params.onValidationComplete = function(form, valid){
			if(valid) {
				thisInstance.savePhylosDetails(form);
				return valid;
			}
		}
		form.validationEngine(params);
		
		form.submit(function(e) {
			e.preventDefault();
		})
		
		//register click event for cancelLink
		cancelLink.click(function(e) {
			var PhylosDetailUrl = form.data('detailUrl');
			var progressIndicatorElement = jQuery.progressIndicator({
				'position' : 'html',
				'blockInfo' : {
					'enabled' : true
				}
			});
			
			thisInstance.loadContents(PhylosDetailUrl).then(
				function(data) {
					progressIndicatorElement.progressIndicator({'mode':'hide'});
					//after loading contents, register the events
					thisInstance.registerDetailViewEvents();
				},
				function(error, err) {
					progressIndicatorElement.progressIndicator({'mode':'hide'});
				}
			);
		})
	},
	
	/*
	 * function to register the events in DetailView
	 */
	registerDetailViewEvents : function() {
		var thisInstance = this;
		//Detail view container
		var container = jQuery('#PhylosDetails');
		console.log(container);
		var editButton = jQuery('.editButton', container);

		//register click event for edit button
		editButton.click(function(e) {
			var progressIndicatorElement = jQuery.progressIndicator({
				'position' : 'html',
				'blockInfo' : {
					'enabled' : true
				}
			});

			var url = editButton.data('url');
	
			thisInstance.loadContents(url).then(
				function(data) {
					//after load the contents register the edit view events
					thisInstance.registerEditViewEvents();
					progressIndicatorElement.progressIndicator({'mode':'hide'});
				},
				function(error, err) {
					progressIndicatorElement.progressIndicator({'mode':'hide'});
				}
			);
		});
	},/*
	 * function to register the events in Kit List
	 */
	registerKitListViewEvents : function() {
		var thisInstance = this;
		//Detail view container
		var container = jQuery('#PhylosDetails');
		console.log(container);
		var kitlistButton = jQuery('.kitlistButton', container);

		//register click event for edit button
		kitlistButton.click(function(e) {
			var progressIndicatorElement = jQuery.progressIndicator({
				'position' : 'html',
				'blockInfo' : {
					'enabled' : true
				}
			});

			var url = kitlistButton.data('url');
	
			thisInstance.loadContents(url).then(
				function(data) {
					//after load the contents register the edit view events
					thisInstance.registerEditViewEvents();
					progressIndicatorElement.progressIndicator({'mode':'hide'});
				},
				function(error, err) {
					progressIndicatorElement.progressIndicator({'mode':'hide'});
				}
			);
		});
	},
	
	registerEvents: function() {
		var thisInstance = this;
		
		if(jQuery('#PhylosForm').length > 0) {
			thisInstance.registerEditViewEvents();
		} else {
			thisInstance.registerDetailViewEvents();
			thisInstance.registerKitListViewEvents();
		}
			
	}

});

jQuery(document).ready(function(e){
	var instance = new Settings_Phylos_Js();
	instance.registerEvents();
})