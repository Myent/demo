/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Edit_Js("EmployeesandTraining_Edit_Js",{
},{
	/**
	 * Function to register event for image delete
	 */
	
	duplicateCheckCache : {},	 
	registerEventForImageDelete : function(){
			var formElement = this.getForm();
			var recordId = formElement.find('input[name="record"]').val();
			formElement.find('.imageDelete').on('click',function(e){
					var element = jQuery(e.currentTarget);
					var parentTd = element.closest('td');
					var imageUploadElement = parentTd.find(':file');
					var fieldInfo = imageUploadElement.data('fieldinfo');
					var mandatoryStatus = fieldInfo.mandatory;
					var imageId = element.closest('div').find('img').data().imageId;
					element.closest('div').remove();
					var exisitingImages = parentTd.find('[name="existingImages"]');
					if(exisitingImages.length < 1 && mandatoryStatus){
							formElement.validationEngine('detach');
							imageUploadElement.attr('data-validation-engine','validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]');
							formElement.validationEngine('attach');
					}

					if(formElement.find('[name=imageid]').length != 0) {
							var imageIdValue = JSON.parse(formElement.find('[name=imageid]').val());
							imageIdValue.push(imageId);
							formElement.find('[name=imageid]').val(JSON.stringify(imageIdValue));
					} else {
							var imageIdJson = [];
							imageIdJson.push(imageId);
							formElement.append('<input type="hidden" name="imgDeleted" value="true" />');
							formElement.append('<input type="hidden" name="imageid" value="'+JSON.stringify(imageIdJson)+'" />');
					}
			});
	},
	
	
	registerRecordPreSaveEvent : function(form){
		var thisInstance = this;
		form.on(Vtiger_Edit_Js.recordPreSave, function(e, data) {
			/*var groupingSeparatorValue = jQuery('[name="currency_grouping_separator"]', form).val();
			var decimalSeparatorValue = jQuery('[name="currency_decimal_separator"]', form).val();
			if(groupingSeparatorValue == decimalSeparatorValue){
				Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_DECIMAL_SEPARATOR_AND_GROUPING_SEPARATOR_CANT_BE_SAME'));
				e.preventDefault();
			}*/
			var cf_2164 = jQuery("select[name='cf_2164']").val();
			var userName = jQuery("input[name='cf_2177']").val();
			var primaryEmail = jQuery("input[name='cf_2178']").val();
			var lastName = jQuery("input[name='cf_2180']").val();
				var newPassword = jQuery("input[name='cf_2181']").val();
				var confirmPassword = jQuery("input[name='cf_2182']").val();
			/*var userName = jQuery('input[name="user_name"]').val();
			var newPassword = jQuery('input[name="user_password"]').val();
			var confirmPassword = jQuery('input[name="confirm_password"]').val();*/
			var record = jQuery('input[name="record"]').val();
			//alert(newPassword);
			//alert(confirmPassword);
			/*if(cf_2181 != cf_2182){		
					//bootbox.alert("Password and Conform password are not same");
					Vtiger_Helper_Js.showPnotify(app.vtranslate('Password and Conform password are not same'));
					return false;
			}*/
			if(cf_2164 == 'Pass'){
				var rdpnly = jQuery("input[name='cf_2177']").attr("readonly");
				if(userName == ''){
					Vtiger_Helper_Js.showPnotify(app.vtranslate('Plaese Enter User Name'));
					e.preventDefault();
				}
				if(primaryEmail == ''){
					Vtiger_Helper_Js.showPnotify(app.vtranslate('Plaese Enter Primary Email'));
					e.preventDefault();
				}
				if(lastName == ''){
					Vtiger_Helper_Js.showPnotify(app.vtranslate('Plaese Enter Last Name'));
					e.preventDefault();
				}
				if(newPassword == ''){
					Vtiger_Helper_Js.showPnotify(app.vtranslate('Plaese Enter Password'));
					e.preventDefault();
				}
				if(confirmPassword == ''){
					Vtiger_Helper_Js.showPnotify(app.vtranslate('Plaese Enter Confirm Password'));
					e.preventDefault();
				}
				if(newPassword != confirmPassword){
					Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_REENTER_PASSWORDS'));
					e.preventDefault();
				}
				if(rdpnly != "readonly"){
					if(!(userName in thisInstance.duplicateCheckCache)) {
						thisInstance.checkDuplicateUser(userName).then(
							function(data){
								if(data.result) {
									thisInstance.duplicateCheckCache[userName] = data.result;
									Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_USER_EXISTS'));
								}
							}, 
							function (data, error){
								thisInstance.duplicateCheckCache[userName] = data.result;
								form.submit();
							}
						);
					} else {
						if(thisInstance.duplicateCheckCache[userName] == true){
							Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_USER_EXISTS'));
						} else {
							delete thisInstance.duplicateCheckCache[userName];
							return true;
						}
					}
				}
				else{
					return true;
				}
				e.preventDefault();
			}
		})
	},
	
	
	/*registerSubmitEvent: function() {
		var form = jQuery('#EditView');
		
		form.on('submit',function(e) {
			
			if(form.data('submit') == 'true' && form.data('performCheck') == 'true') {
			alert("True");				
				return true;
			} else {
				var userName = jQuery("input[name='cf_2177']").val();
				var cf_2181 = jQuery("input[name='cf_2181']").val();
				var cf_2182 = jQuery("input[name='cf_2182']").val();
				var sub = 1;
				var thisInstance = this;
				//var modle = app.getModuleName();
				alert(userName);
				if(cf_2181 != cf_2182){					
					//sub ++;
					bootbox.alert("Password and Conform password are not same");
					return false;
				}
				
				if(!(userName in thisInstance.duplicateCheckCache)) {
					thisInstance.checkDuplicateUser(userName).then(
						function(datauser){
							if(datauser.result) {
								thisInstance.duplicateCheckCache[userName] = datauser.result;
								Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_USER_EXISTS'));
							}
						}, 
						function (datauser, error){
							thisInstance.duplicateCheckCache[userName] = datauser.result;
							//form.submit();
							form.data('submit', 'true');
						}
					);
				} else {
					if(thisInstance.duplicateCheckCache[userName] == true){
						Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_USER_EXISTS'));
					} else {
						delete thisInstance.duplicateCheckCache[userName];
						return true;
					}
				}
				e.preventDefault();
					
					
			}
		});
		var editViewForm = this.getForm();
		editViewForm.submit(function(e){
			if((editViewForm.find('[name="existingImages"]').length >= 1) || (editViewForm.find('[name="imagename[]"]').length > 1)){
				jQuery.fn.MultiFile.disableEmpty(); // before submiting the form - See more at: http://www.fyneworks.com/jquery/multiple-file-upload/#sthash.UTGHmNv3.dpuf
			}
		});
	},*/
	checkDuplicateUser: function(userName){
		var aDeferred = jQuery.Deferred();
		var params = {
				'module': "Users",
				'action' : "SaveAjax",
				'mode' : 'userExists',
				'user_name' : userName
			}
			AppConnector.request(params).then(
				function(data) {
					if(data.result){
						aDeferred.resolve(data);
					}else{
						aDeferred.reject(data);
					}
				}
			);
		return aDeferred.promise();
	},
	/*function checkUsers(cf_2177){
		//var cf_2177 = jQuery("input[name='cf_2177']").val();
		alert(cf_2177);
		var actionParams = {
					"type": "POST",
					"url": 'index.php',
					"dataType": "html",
					"data": "module="+app.getModuleName()+"&view=checkDuplicate&username="+cf_2177
				};
				AppConnector.request(actionParams).then(function(datares){
					if(datares != 1){
						//sub++;
						//jQuery("input[name='cf_2186']").val("User is already existing");
						
						//bootbox.alert("User is already existing");
						return "Fail";
					}
					else{
						//form.unbind.data('submit', 'true');
						//form.unbind.data('submit', 'true');
						//form.unbind('submit').submit();
						return "Success";
					}
					//alert(datares);
				});
	},*/
	
	/*registerLeavePageWithoutSubmit : function(form){
        InitialFormData = form.serialize();
      //  window.onbeforeunload = function(e){
           // if (InitialFormData != form.serialize() && form.data('submit') != "true") {
                return true;// app.vtranslate("JS_CHANGES_WILL_BE_LOST");
           // }
       // };
    },*/
	
   registerEventForCkEditor : function(){
		var form = this.getForm();
		form.find('textarea.richtext').each(function(){
    		var inputname=jQuery(this).attr('name');
			var elem=jQuery(this).data('fieldinfo');
			var noteContentElement=jQuery(this);
			var fieldUIType = elem.fielduitype;
			if(fieldUIType==540){
				if(noteContentElement.length > 0){
					noteContentElement.removeAttr('data-validation-engine').addClass('ckEditorSource');
					var ckEditorInstance = new Vtiger_CkEditor_Js();
					ckEditorInstance.loadCkEditor(noteContentElement);
				}
			}
			
		});
	},
	
	registerEvents : function(){
		this._super();
		//var form = jQuery('#EditView');
		var form = this.getForm();
		this.registerRecordPreSaveEvent(form);
	},
	//added by sl for signature :start
	 registerSignEvent : function(){
		 var thisInstance = this;
		var form = this.getForm();
		var attachedFiles = [];
		jQuery('#donebutton').on('click',function(e){
			 var imgsrc =jQuery('#sigimage').attr('src');
			if(imgsrc!=''){
			//alert("inside barcode"+barcode);
		     jQuery(':hidden#jbase64').val(imgsrc);
			// alert(jQuery(':hidden#jbase64').val());	

			}
			else{
			alert("Please Sign in Signature box.");
			}
			});
			
			 
        
    },
		registerEventForSignDelete : function(){
		var formElement = this.getForm();
		var recordId = formElement.find('input[name="record"]').val();
		formElement.find('.signDelete').on('click',function(e){
			var element = jQuery(e.currentTarget);
			var parentTd = element.closest('td');
			//var imageUploadElement = parentTd.find('[name="imagename[]"]');
			//var fieldInfo = imageUploadElement.data('fieldinfo');
			//var mandatoryStatus = fieldInfo.mandatory;
		 var imageId = element.closest('div').find('img').data().imageId;
		 	element.closest('div').remove();
			var exisitingImages = parentTd.find('[name="existingImages"]');
			//if(exisitingImages.length < 1 ){
			//	formElement.validationEngine('detach');
			//	imageUploadElement.attr('data-validation-engine','validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]');
			//	formElement.validationEngine('attach');
			//}
            
			if(formElement.find('[name=imageid]').length != 0) {
				var imageIdValue = JSON.parse(formElement.find('[name=imageid]').val());
				imageIdValue.push(imageId);
				formElement.find('[name=imageid]').val(JSON.stringify(imageIdValue));
			} else {
				var imageIdJson = [];
				imageIdJson.push(imageId);
				formElement.append('<input type="hidden" name="signDeleted" value="true" />');
				formElement.append('<input type="hidden" name="imageid" value="'+JSON.stringify(imageIdJson)+'" />');
			}
		});
	},
//added by sl for signature :end

	registerBasicEvents : function(container) {
		this._super(container);
		this.registerEventForCkEditor();
	}
});


//$CURRENT_VIEW
//$VIEW
//$DEFAULT_RECORD_VIEW
//$IS_AJAX_ENABLED
//$IS_DELETABLE
//$IS_EDITABLE

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
		plvalues = Object.keys(vtRecordStructure[blockid][fieldid].fieldInfo.picklistvalues);
		plparams[pllabel] = plvalues;
		vtDZ_pickBlocks[pllabel] = [];
		plFieldBlockId[pllabel] = vtRecordStructure[blockid]["id"];
		plFieldId[pllabel] = vtRecordStructure[blockid][fieldid].id;
		plFieldName[pllabel] = vtRecordStructure[blockid][fieldid].name;
		plFieldLabel2Name[vtRecordStructure[blockid][fieldid].name] = pllabel;
		plFieldValue[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].fieldvalue;
		plModuleName[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].module.name;
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
		if (Object.keys(pickBlocks).length > 0) {
			jQuery.each(pickBlocks, function(index, value){
				pickkey = plFieldValue[index];
				selectedBlockLabel = "";
				jQuery.each(value, function(i,e){
					jQuery("th.blockHeader:contains('"+e[1]+"')").closest('table').hide();
					if (i == pickkey) {
						selectedBlockLabel=e[1];
					}
				});
				jQuery("th.blockHeader:contains('"+selectedBlockLabel+"')").closest('table').show();

				// set the onchange function
				jQuery("select[name='"+index+"']").change(function(){
					selectedBlockLabel = "";
					selectedKey = index;
					pickkey = jQuery("select[name='"+index+"']").next().find("a.chzn-single").find("span").first().text().trim();
					pickKeys = pickBlocks[selectedKey];
					jQuery.each(pickKeys, function(i,e){
						jQuery("th.blockHeader:contains('"+e[1]+"')").closest('table').hide();
						if (i == pickkey) {
							selectedBlockLabel=e[1];
						}
					});
					jQuery("th.blockHeader:contains('"+selectedBlockLabel+"')").closest('table').show();
					
					//jQuery("th.blockHeader:contains('User Login & Role')").closest('table').hide();
				}); // end on change registration
			});			
		}
		var userName = jQuery("input[name='cf_2177']").val();
		var record = jQuery("input[name='record']").val();
		var hed = jQuery(".blockHeader").text();
		jQuery("th.blockHeader:contains('User Login & Role')").closest('table').hide();
		jQuery("select[name='cf_2164']").change(function(){
			var cf_2164 = jQuery("select[name='cf_2164']").val();
			if(cf_2164 == "Pass"){
				jQuery("th.blockHeader:contains('User Login & Role')").closest('table').show();				
			}
			else{
				jQuery("th.blockHeader:contains('User Login & Role')").closest('table').hide();
			}
			jQuery("input[name='cf_2177']").val('');
			jQuery("input[name='cf_2178']").val('');
			jQuery("input[name='cf_2180']").val('');
			jQuery("input[name='cf_2181']").val('');
			jQuery("input[name='cf_2182']").val('');
		});
		//alert(hed);
		
		//if(jQuery(".blockHeader").text() == "User Login & Role"){
		//	alert('hed');
		//}
		if(userName != '' && record != ''){
			jQuery("input[name='cf_2177']").attr('readonly', 'readonly');
		}
		var pass = jQuery("select[name='cf_2164']").val();
		if(pass == "Pass"){
			jQuery("th.blockHeader:contains('User Login & Role')").closest('table').show();			
		}
		else{
			jQuery("th.blockHeader:contains('User Login & Role')").closest('table').hide();
		}
	}
});
