/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
jQuery.Class('Settings_Customer_Portal_Js', {}, {
	
	//This will store the CustomerPortal Form
	customerPortalForm : false,
	
	//store the class name for customer portal module row
	rowClass : 'portalModuleRow',
	
	/**
	 * Function to get the customerPortal form
	 */
	getForm : function() {
		if(this.customerPortalForm == false) {
			this.customerPortalForm = jQuery('#customerPortalForm');
		}
		return this.customerPortalForm;
	},
	
	/**
	 * Function to regiser the event to make the portal modules list sortable
	 */
	makeModulesListSortable : function() {
		var thisInstance = this;
		var modulesTable = jQuery('#portalModulesTable');
		modulesTable.sortable({
			'containment' : modulesTable,
			'items' : 'tr.'+this.rowClass,
			'revert' : true,
			'tolerance':'pointer',
			'dealy' : '3000',
			'helper' : function(e,ui){
				//while dragging helper elements td element will take width as contents width
				//so we are explicity saying that it has to be same width so that element will not
				//look like distrubed
				ui.children().each(function(index,element){
					element = jQuery(element);
					element.width(element.width());
				})
				return ui;
			},
			'update' : function(e, ui) {
				thisInstance.showSaveButton();
			}
		});
	},
	
	/**
	 * Function which will enable the save button in customer portal form
	 */
	showSaveButton : function() {
		var form = this.getForm();
		var saveButton = form.find('[name="savePortalInfo"]');
		if(saveButton.attr('disabled') ==  'disabled') {
			saveButton.removeAttr('disabled');
		}
	},
	
	/**
	 * Function which will disable the save button in customer portal form
	 */
	disableSaveButton : function(form) {
		var saveButton = form.find('[name="savePortalInfo"]');
		saveButton.attr('disabled', 'disabled');
	},
	
	/**
	 * Function which will update sequence numbers of portal modules list by order
	 */
	updatePortalModulesListByOrder : function() {
		var form = this.getForm();
		jQuery('tr.'+this.rowClass ,form).each(function(index,domElement){
			var portalModuleRow = jQuery(domElement);
			var tabId = portalModuleRow.data('id');
			var sequenceEle = portalModuleRow.find('[name="portalModulesInfo['+tabId+'][sequence]"]');
			var expectedRowSequence = (index+1);
			var actualRowSequence = sequenceEle.val();
			if(expectedRowSequence != actualRowSequence) {
				return sequenceEle.val(expectedRowSequence);
			}
		});
	},

		/*
	 * function to save the customer portal settings
	 * @params: form - customer portal form.
	 */
	typePortal : function() {
		jQuery('#portaltype').on('change',function(e) {
			var thisInstance = this;
			var portaltype = this.options[e.target.selectedIndex].text;
			// $("#portalval").val(portaltype);
  			  // alert(portaltype);
  			var typeofPortal = portaltype;

  			var params = {
			'module': 'CustomerPortal',
			'parent': 'Settings',
			'action' : 'PortalType',
			'portaltype' : typeofPortal
			}
			// console.log(params);console.log('portal');
			AppConnector.request(params).then( function(data) {
				if(data.success){ 				
					var issuesObject = data.result;
					jQuery("#portalModulesTable > tbody").empty();				
					jQuery.each(issuesObject, function( index, value ) {

						var drag = "<span class='span1' style='padding: 20px;'><a><img src='layouts/vlayout/skins/images/drag.png' border='0' title='Drag'></a></span>";	

						var seq = "<input type='hidden' name='portalModulesInfo["+value.tabid+"][sequence]' value='"+value.sequence+"'/>";

						if(value.tablabel == 'Accounts'){
							value.tablabel = 'Organizations';
						}else if(value.tablabel == 'HelpDesk'){
							value.tablabel = 'Tickets';
						}else if(value.tablabel == 'Project'){
							value.tablabel = 'Projects';
						}else if(value.tablabel == 'Changes'){
							value.tablabel = 'Change Order';
						}else{
							value.tablabel = value.tablabel
							;	
						}
						if(value.prefvalue == '1'){
							var hiddvar = "<input type='hidden' name='portalModulesInfo["+value.tabid+"][visible]' value='0'>";
							if(value.visible == '1'){
								var check = "<input type='checkbox' name='portalModulesInfo["+value.tabid+"][visible]' value='1' checked />";
							}
							else{
								var check = "<input type='checkbox' name='portalModulesInfo["+value.tabid+"][visible]' value='1'>";
							}

							jQuery("#portalModulesTable").append("<tr class='portalModuleRow' data-id='"+value.tabid+"' data-sequence='"+value.sequence+"' data-module='"+value.tablabel+"'><td>"+drag+""+value.tablabel+""+seq+"</td><td>"+hiddvar+""+check+"</td><td><span><input type='radio' style='padding: 10px;' name='portalModulesInfo["+value.tabid+"][prefValue]' value='1' checked='checked'>Yes</span><span><input type='radio' style='padding: 10px;' name='portalModulesInfo["+value.tabid+"][prefValue]' value='0'>No<span></td></tr>");
						}
						if(value.prefvalue == '0'){
							var hiddvar = "<input type='hidden' name='portalModulesInfo["+value.tabid+"][visible]' value='0'>";
							if(value.visible == '1'){
								var check = "<input type='checkbox' name='portalModulesInfo["+value.tabid+"][visible]' value='1' checked />";
							}
							else{
								var check = "<input type='checkbox' name='portalModulesInfo["+value.tabid+"][visible]' value='1'>";
							}
							jQuery("#portalModulesTable").append("<tr class='portalModuleRow' data-id='"+value.tabid+"' data-sequence='"+value.sequence+"' data-module='"+value.tablabel+"'><td>"+drag+""+value.tablabel+""+seq+"</td><td>"+hiddvar+""+check+"</td><td><span><input type='radio' style='padding: 10px;' name='portalModulesInfo["+value.tabid+"][prefValue]' value='1'>Yes</span><span><input type='radio' style='padding:10px;' name='portalModulesInfo["+value.tabid+"][prefValue]' value='0' checked='checked'>No<span></td></tr>");
						}
						
					});					
				}
			}),
			function(error) {
				console.log("Very serious error. Investigate function typePortal in CustomerPortal.tpl");
			}
			
  		});

	},


	/*
	 * function to save the customer portal settings
	 * @params: form - customer portal form.
	 */
	saveCustomerPortal : function(form) {
		var aDeferred = jQuery.Deferred();
		
		var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});

		var typeofPortal = jQuery('#portaltype').val();

		var data = form.serializeFormData();
		data['module'] = app.getModuleName();
		data['parent'] = app.getParentModuleName();
		data['action'] = 'Save';
		data['portaltype'] =  typeofPortal;

	
		AppConnector.request(data).then(
			function(data) {
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				aDeferred.resolve(data);
			},
			function(error) {
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				//TODO : Handle error
				aDeferred.reject(error);
			}
		);
		return aDeferred.promise();
	},
	
	registerEvents : function(e){
		var thisInstance = this;
		var form = thisInstance.getForm();
		
		//register all select2 Elements
		app.showSelect2ElementView(form.find('select.select2'), {maximumSelectionSize: 7, dropdownCss : {'z-index' : 0}});
		
		//To make customer portal modules list sortable
		thisInstance.makeModulesListSortable();
		
		//If any change happened, then enable the save button
		form.find('select.select2').on('change', function() {
			thisInstance.showSaveButton();
		});
		form.find('input:checkbox, input:radio').on('change', function() {
			thisInstance.showSaveButton();
		})
		
		form.submit(function(e) {
			e.preventDefault();
			thisInstance.disableSaveButton(form);
			
			//update the sequence of customer portal modules
			thisInstance.updatePortalModulesListByOrder();
			
			//save the customer portal settings
			thisInstance.saveCustomerPortal(form).then(
				function(data) {
					var result = data['result'];
					if(result['success']) {
						var params = {
							text: app.vtranslate('JS_PORTAL_INFO_SAVED')
						}
						Settings_Vtiger_Index_Js.showMessage(params);
					}
				},
				function(error){
					//TODO: Handle Error
				}
			);
		});
		
	}
});

jQuery(document).ready(function(){
	var instance = new Settings_Customer_Portal_Js();
	instance.registerEvents();
	instance.typePortal();

})
