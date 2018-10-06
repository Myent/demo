/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Edit_Js("Accounts_Edit_Js",{
   
},{
   
    //Stored history of account name and duplicate check result
	duplicateCheckCache : {},
	
	//This will store the editview form
	editViewForm : false,
   
	//Address field mapping within module
	addressFieldsMappingInModule : {
										'bill_street':'ship_street',
										'bill_pobox':'ship_pobox',
										'bill_city'	:'ship_city',
										'bill_state':'ship_state',
										'bill_code'	:'ship_code',
										'bill_country':'ship_country'
								},
   
   // mapping address fields of MemberOf field in the module              
   memberOfAddressFieldsMapping : {
                                        'bill_street':'bill_street',
										'bill_pobox':'bill_pobox',
										'bill_city'	:'bill_city',
										'bill_state':'bill_state',
										'bill_code'	:'bill_code',
										'bill_country':'bill_country',
                                        'ship_street' : 'ship_street',        
                                        'ship_pobox' : 'ship_pobox',
                                        'ship_city':'ship_city',
                                        'ship_state':'ship_state',
                                        'ship_code':'ship_code',
                                        'ship_country':'ship_country'
                                   },                          
								
	/**
	 * This function will return the current form
	 */
	getForm : function(){
		if(this.editViewForm == false) {
			this.editViewForm = jQuery('#EditView');
		}
		return this.editViewForm;
	},
        
	/**
	 * This function will return the account name
	 */
	getAccountName : function(container){
		return jQuery('input[name="accountname"]',container).val();
	},
        
	/**
	 * This function will return the current RecordId
	 */
	getRecordId : function(container){
		return jQuery('input[name="record"]',container).val();
	},
       
	/**
	 * This function will register before saving any record
	 */
	registerRecordPreSaveEvent : function(form) {
		var thisInstance = this;
		if(typeof form == 'undefined') {
			form = this.getForm();
		}
		
		form.on(Vtiger_Edit_Js.recordPreSave, function(e, data) {
			var accountName = thisInstance.getAccountName(form);
			var recordId = thisInstance.getRecordId(form);
			var params = {};
            if(!(accountName in thisInstance.duplicateCheckCache)) {
                Vtiger_Helper_Js.checkDuplicateName({
                    'accountName' : accountName, 
                    'recordId' : recordId,
                    'moduleName' : 'Accounts'
                }).then(
                    function(data){
                        thisInstance.duplicateCheckCache[accountName] = data['success'];
                        form.submit();
                    },
                    function(data, err){
                        thisInstance.duplicateCheckCache[accountName] = data['success'];
                        thisInstance.duplicateCheckCache['message'] = data['message'];
						var message = app.vtranslate('JS_DUPLICTAE_CREATION_CONFIRMATION');
						Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
							function(e) {
								thisInstance.duplicateCheckCache[accountName] = false;
								form.submit();
							},
							function(error, err) {
								
							}
						);
                    }
				);
            }
           
			else {
				if(thisInstance.duplicateCheckCache[accountName] == true){
					var message = app.vtranslate('JS_DUPLICTAE_CREATION_CONFIRMATION');
					Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
						function(e) {
							thisInstance.duplicateCheckCache[accountName] = false;
							form.submit();
						},
						function(error, err) {
							
						}
					);
				} else {
					delete thisInstance.duplicateCheckCache[accountName];
					return true;
				}
			}
            e.preventDefault();
		})
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
			if(target == "billing"){
				swapMode = "false";
			}else if(target == "shipping"){
				swapMode = "true";
			}
			thisInstance.copyAddress(swapMode, container);
		})
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
		thisInstance.getRecordDetails(data).then(
			function(data){
				var response = data['result'];
				thisInstance.mapAddressDetails(thisInstance.memberOfAddressFieldsMapping, response['data'], container);
			},
			function(error, err){

			});
	},
	
	/**
	 * Function which will map the address details of the selected record
	 */
	mapAddressDetails : function(addressDetails, result, container) {
		for(var key in addressDetails) {
			// While Quick Creat we don't have address fields, we should  add
            if(container.find('[name="'+key+'"]').length == 0) { 
                   container.append("<input type='hidden' name='"+key+"'>"); 
            } 
			container.find('[name="'+key+'"]').val(result[addressDetails[key]]);
			container.find('[name="'+key+'"]').trigger('change');
			container.find('[name="'+addressDetails[key]+'"]').val(result[addressDetails[key]]);
			container.find('[name="'+addressDetails[key]+'"]').trigger('change');
		}
	},
	
	/**
	 * Function which will register basic events which will be used in quick create as well
	 *
	 */
	registerBasicEvents : function(container) {
		this._super(container);
		this.registerRecordPreSaveEvent(container);
		this.registerEventForCopyingAddress(container);
		this.registerReferenceSelectionEvent(container);
			//container.trigger(Vtiger_Edit_Js.recordPreSave, {'value': 'edit'});
	}
});

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
