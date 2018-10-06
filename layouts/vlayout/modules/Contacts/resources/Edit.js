/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
Vtiger_Edit_Js("Contacts_Edit_Js",{},{
	
	//Will have the mapping of address fields based on the modules
	addressFieldsMapping : {'Accounts' :
									{'mailingstreet' : 'bill_street',  
									'otherstreet' : 'ship_street', 
									'mailingpobox' : 'bill_pobox',
									'otherpobox' : 'ship_pobox',
									'mailingcity' : 'bill_city',
									'othercity' : 'ship_city',
									'mailingstate' : 'bill_state',
									'otherstate' : 'ship_state',
									'mailingzip' : 'bill_code',
									'otherzip' : 'ship_code',
									'mailingcountry' : 'bill_country',
									'othercountry' : 'ship_country'
									}
							},
							
	//Address field mapping within module
	addressFieldsMappingInModule : {
										'otherstreet' : 'mailingstreet',
										'otherpobox' : 'mailingpobox',
										'othercity' : 'mailingcity',
										'otherstate' : 'mailingstate',
										'otherzip' : 'mailingzip',
										'othercountry' : 'mailingcountry'
								},
	
	
	/**
	 * Function which will register event for Reference Fields Selection
	 */
	registerReferenceSelectionEvent : function(container) {
		var thisInstance = this;
		
		jQuery('input[name="account_id"]', container).on(Vtiger_Edit_Js.referenceSelectionEvent, function(e, data){
			thisInstance.referenceSelectionEventHandler(data, container);
		});
	},
	
	/**
	 * Reference Fields Selection Event Handler
	 * On Confirmation It will copy the address details
	 */
	referenceSelectionEventHandler :  function(data, container) {
		var thisInstance = this;
		var message = app.vtranslate('OVERWRITE_EXISTING_MSG1')+app.vtranslate('SINGLE_'+data['source_module'])+' ('+data['selectedName']+') '+app.vtranslate('OVERWRITE_EXISTING_MSG2');
		Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
			function(e) {
				thisInstance.copyAddressDetails(data, container);
			},
			function(error, err){
			});
	},
	
	/**
	 * Function which will copy the address details - without Confirmation
	 */
	copyAddressDetails : function(data, container) {
		var thisInstance = this;
		var sourceModule = data['source_module'];
		thisInstance.getRecordDetails(data).then(
			function(data){
				var response = data['result'];
				thisInstance.mapAddressDetails(thisInstance.addressFieldsMapping[sourceModule], response['data'], container);
			},
			function(error, err){

			});
	},
	
	/**
	 * Function which will map the address details of the selected record
	 */
	mapAddressDetails : function(addressDetails, result, container) {
		for(var key in addressDetails) {
            if(container.find('[name="'+key+'"]').length == 0) {
                var create = container.append("<input type='hidden' name='"+key+"'>");
            }
			container.find('[name="'+key+'"]').val(result[addressDetails[key]]);
			container.find('[name="'+key+'"]').trigger('change');
		}
	},
	
	/**
	 * Function to swap array
	 * @param Array that need to be swapped
	 */ 
	swapObject : function(objectToSwap){
		var swappedArray = {};
		var newKey,newValue;
		for(var key in objectToSwap){
			newKey = objectToSwap[key];
			newValue = key;
			swappedArray[newKey] = newValue;
		}
		return swappedArray;
	},
	
	/**
	 * Function to copy address between fields
	 * @param strings which accepts value as either odd or even
	 */
	copyAddress : function(swapMode, container){
		var thisInstance = this;
		var addressMapping = this.addressFieldsMappingInModule;
		if(swapMode == "false"){
			for(var key in addressMapping) {
				var fromElement = container.find('[name="'+key+'"]');
				var toElement = container.find('[name="'+addressMapping[key]+'"]');
				toElement.val(fromElement.val());
			}
		} else if(swapMode){
			var swappedArray = thisInstance.swapObject(addressMapping);
			for(var key in swappedArray) {
				var fromElement = container.find('[name="'+key+'"]');
				var toElement = container.find('[name="'+swappedArray[key]+'"]');
				toElement.val(fromElement.val());
			}
		}
	},
	
	
	/**
	 * Function to register event for copying address between two fileds
	 */
	registerEventForCopyingAddress : function(container){
		var thisInstance = this;
		var swapMode;
		jQuery('[name="copyAddress"]').on('click',function(e){
			var element = jQuery(e.currentTarget);
			var target = element.data('target');
			if(target == "other"){
				swapMode = "false";
			} else if(target == "mailing"){
				swapMode = "true";
			}
			thisInstance.copyAddress(swapMode, container);
		})
	},

    /**
	 * Function to check for Portal User
	 */
	checkForPortalUser : function(form){
		var element = jQuery('[name="portal"]',form);
		var response = element.is(':checked');
	        var primaryEmailField = jQuery('[name="email"]',form);
		var primaryEmailValue = primaryEmailField.val();
		if(response){
			if(primaryEmailField.length == 0){
				Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_PRIMARY_EMAIL_FIELD_DOES_NOT_EXISTS'));
				return false;
			}
			if(primaryEmailValue == ""){
				Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_PLEASE_ENTER_PRIMARY_EMAIL_VALUE_TO_ENABLE_PORTAL_USER'));
				return false;
			}
		}
		return true;
	},

	/**
	 * Function to register recordpresave event
	 */
	registerRecordPreSaveEvent : function(form){
		var thisInstance = this;
		if(typeof form == 'undefined') {
			form = this.getForm();
		}

		form.on(Vtiger_Edit_Js.recordPreSave, function(e, data) {
			var result = thisInstance.checkForPortalUser(form);
			if(!result){
				e.preventDefault();
			}
		})
	},
	
	registerBasicEvents : function(container){
		this._super(container);
		this.registerReferenceSelectionEvent(container);
		this.registerEventForCopyingAddress(container);
		this.registerRecordPreSaveEvent(container);
	}
})

var path = "";
var vtRsPath = [];
var plparams ={};
var pickBlock = {};			// will hold the array of blockids assigned as pickblock for each picklist item
var vtDZ_pickBlocks = {};	// will hold the array of blockids that have been chosed as pickblocks for the picklist 
var plFieldId = {};			// will hold the fieldid of the picklist field
var plFieldName = {};		// will hold the fieldname of the picklist field
var plFieldBlockId = {};	// will hold the blockid of the picklist field, used to prevent selection as pickblock
var plFieldLabel2Name = {}; // will hold the field label as value of the picklist field, used to preload
var plFieldValue = {};		// will hold the field value of the picklist field, used to preload
var plModuleName = {};		// will hold the module name as value of the picklist field, used to preload

function plwalker(key, value) {
	var savepath = path;
	path = path ? (path + "::||::" + key) : key;
	if (key=="uitype" && (value=="15" || value=="16")){
		var fieldid=vtRsPath.pop();
		var blockid=vtRsPath.pop();
		vtRsPath.push(blockid);
		vtRsPath.push(fieldid);
		pllabel = vtRecordStructure[blockid][fieldid].label;
		var x = vtRecordStructure[blockid][fieldid].fieldInfo;
		plvalues='';
		if(typeof x != 'undefined'){
		plvalues = Object.keys(vtRecordStructure[blockid][fieldid].fieldInfo.picklistvalues);
		}
		plparams[pllabel] = plvalues;
		vtDZ_pickBlocks[pllabel] = [];
		plFieldBlockId[pllabel] = vtRecordStructure[blockid]["id"];
		plFieldId[pllabel] = vtRecordStructure[blockid][fieldid].id;
		plFieldName[pllabel] = vtRecordStructure[blockid][fieldid].name;
		plFieldLabel2Name[vtRecordStructure[blockid][fieldid].name] = pllabel;
		plFieldValue[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].fieldvalue;
		plModuleName[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].modulename;
	}
	if (value !== null && typeof value === "object") {
		// Recurse into children
		vtRsPath.push(key);
		jQuery.each(value, plwalker);
		vtRsPath.pop();
	}
	path = savepath;
}
jQuery(document).ready(function() {
	if (typeof(vtRecordStructure) !== 'undefined') {
		// Implementation of Pickblocks in EditView

		jQuery.each(vtRecordStructure, plwalker);
		if (Object.keys(multipickBlocks).length > 0) {
			jQuery.each(multipickBlocks, function(index, value){
				pickkey = plFieldValue[index];
				selectedBlockLabel = "";
				jQuery.each(value, function(i,e){
					jQuery.each(e,function(subk,subv){
							jQuery("th.blockHeader:contains('"+subv+"')").closest('table').hide();
					});
					if (i == pickkey) {
						selectedBlockLabel=e;
					}
				});
				jQuery.each(selectedBlockLabel,function(subk,subv){
					jQuery("th.blockHeader:contains('"+subv+"')").closest('table').show();
				});
				// set the onchange function
				jQuery("select[name='"+index+"']").change(function(){
					selectedBlockLabel = "";
					selectedKey = index;
					pickkey = jQuery("select[name='"+index+"']").next().find("a.chzn-single").find("span").first().text().trim();
					pickKeys = multipickBlocks[selectedKey];
					jQuery.each(pickKeys, function(i,e){
						jQuery.each(e,function(subk,subv){
							jQuery("th.blockHeader:contains('"+subv+"')").closest('table').hide();
						});
						if (i == pickkey) {
							selectedBlockLabel=e;
						}
					});
					jQuery.each(selectedBlockLabel,function(subk,subv){
						jQuery("th.blockHeader:contains('"+subv+"')").closest('table').show();
					});
					
				}); // end on change registration
			});
		}
	}
});
