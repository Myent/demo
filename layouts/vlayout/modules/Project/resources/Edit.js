/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Edit_Js("Project_Edit_Js",{ },{
    
    
    /**
	 * Function to get popup params
	**/
   registerEventForDigitalSignature : function(){
			var formElement = this.getForm();
			var thisInstance = this;
			var i = 0;var j = 0; var k = 0;
			jQuery( ".signatureclass" ).one('mouseenter',function(e){
				var signid = e.currentTarget.id;
				if(i == 0 && signid == 'cf_962'){
						++i;
					  thisInstance.registerSignatureGenaration(e); 
				}
				if(j == 0 && signid == 'cf_1018'){
						++j;
					  thisInstance.registerSignatureGenaration(e); 
				}
				if(k == 0 && signid == 'cf_1022'){
						++k;
					  thisInstance.registerSignatureGenaration(e); 
				}
			  });

    },
		registerSignatureGenaration:function(e){
				var signid = e.currentTarget.id;
			   jQuery("#"+signid).jSignature();
			   jQuery('#donebutton'+signid).click(function() {
				var signatureCheck =  jQuery("#"+signid).jSignature('getData', 'image');
				if (signatureCheck.length === 0) {
				  alert('Signature required.');
				} else {
				 var imgsrc = jQuery('#sigimage'+signid).attr('src', jQuery('#'+signid).jSignature('getData'));
				  jQuery('#sigimage'+signid).show();
				  var imgsrcorg =jQuery('#sigimage'+signid).attr('src');
					if(imgsrcorg !=''){
					 jQuery('#jbase64'+signid).val(imgsrcorg);
					}
				 }
			  });
			  jQuery('#clearbutton'+signid).click(function () {
					jQuery("#"+signid).jSignature('clear');
					jQuery("#"+signid).show();
					jQuery('#sigimage'+signid).hide();
					jQuery('#jbase64'+signid).val("");
				});
			  //jQuery(thisInstance).unbind('mouseenter');
	},

		registerEventForSignDelete : function(){
		var formElement = this.getForm();
		var recordId = formElement.find('input[name="record"]').val();
		formElement.find('.signDelete').on('click',function(e){
			var element = jQuery(e.currentTarget);
			var parentTd = element.closest('td');
		 var imageId = element.closest('div').find('img').data().imageId;
		 	element.closest('div').remove();
			var exisitingImages = parentTd.find('[name="existingImages"]');            
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
	//Alert of Complete Status :: Manasa added on 24th nov 2017
	registerProjectStatusChange : function(){
		var thisInstance =this;
		jQuery('select[name="projectstatus"]').on('change', function(e){
			var projectstatus = jQuery(this).val();
			if(projectstatus == 'completed'){
				bootbox.alert("Record will lock once you save. You can't edit Status again.");
	
			}
			
		});
	},
	//Ended here
	//Project Pickingslip Duplicate alert Purpose :: Dec 7th 2017
	duplicateCheckCache : {},
	registerRecordPreSaveEvent : function(form){
		var thisInstance = this;
		form.on(Vtiger_Edit_Js.recordPreSave, function(e, data) {
			var oldrecord = jQuery('input[name="oldrecord"]').val();
			if(oldrecord != ''){
				if(!(oldrecord in thisInstance.duplicateCheckCache)) {
					thisInstance.checkDuplicateProjects(oldrecord).then(
						function(data){
							if(data.result) {
								thisInstance.duplicateCheckCache[oldrecord] = data.result;
								/*Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_USER_EXISTS'));*/
								var msg = "Project can not be created as related product quantity is not available";
								bootbox.alert(msg);
							}
						}, 
						function (data, error){
							thisInstance.duplicateCheckCache[oldrecord] = data.result;
							form.submit();
						}
					);
				} else {
					if(thisInstance.duplicateCheckCache[oldrecord] == true){
						/*Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_USER_EXISTS'));*/
						var msg = "Project can not be created as related product quantity is not available";
						bootbox.alert(msg);
					} else {
						delete thisInstance.duplicateCheckCache[oldrecord];
						return true;
					}
				}
				e.preventDefault();
			}
		})
	},
	checkDuplicateProjects: function(oldrecord){
		var aDeferred = jQuery.Deferred();
		var params = {
				'module': app.getModuleName(),
				'action' : "ProjectDuplicateCheck",
				'mode' : 'DuplicateProductsQtyCheck',
				'record' : oldrecord
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
	
	//Ended here :: Duplicate projects
    registerEvents: function(){
        this._super();
		this.registerEventForDigitalSignature();
		//manasa added :: 7th Dec 2017
		this.registerProjectStatusChange();
		var form = this.getForm();
		this.registerRecordPreSaveEvent(form);
		//ended here
    }

});
