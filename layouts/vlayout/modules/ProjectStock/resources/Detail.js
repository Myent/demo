Inventory_Detail_Js("ProjectStock_Detail_Js",{},{
	registerRecordPreSaveEvent : function(form){
		if(typeof form == 'undefined') {
			form = this.getForm();
		}
	},
	
	/**
	 * Function to add or remove required validation for dependent fields
	 */
	AddOrRemoveRequiredValidation : function(dependentFieldsForValidation,addValidation){
		var form = this.getForm();
		jQuery(dependentFieldsForValidation).each(function(key,value){
			var relatedField = form.find('[name="'+value+'"]');
			if(addValidation){
				var validationValue = relatedField.attr('data-validation-engine');
				if(validationValue.indexOf('[f') > 0){
					relatedField.attr('data-validation-engine','validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]');
				}
				if(relatedField.is("select")){
					relatedField.attr('disabled',false).trigger("liszt:updated");
				}else{
					relatedField.removeAttr('disabled');
				}
			}else if(!addValidation){
				if(relatedField.is("select")){
					relatedField.attr('disabled',true).trigger("liszt:updated");
				}else{
					relatedField.attr('disabled','disabled');
				}
				relatedField.closest('td').find('.edit').addClass('hide');
			}
		})
	},
	
	getCustomFieldNameValueMap : function(fieldNameValueMap){
        return fieldNameValueMap;
	},
	
			//Alert of Complete Status :: Manasa added on 24th nov 2017
	saveFieldValues : function (fieldDetailList) {
		var aDeferred = jQuery.Deferred();
		var recordId = this.getRecordId();
		var data = {};
		if(typeof fieldDetailList != 'undefined'){
			data = fieldDetailList;
		}
		data['record'] = recordId;
		data['module'] = app.getModuleName();
		data['action'] = 'SaveAjax';
		
		if(data['field'] == 'stockstatus' && data['value'] == 'Approved'){
			//console.log("******************");
		//alert("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");return false;
			bootbox.confirm("Record will lock once you save. You can't edit record again.", function(result){ 
					if(result == false){
						aDeferred.resolve("1");
					}else{
						AppConnector.request(data).then(
							function(reponseData){
								aDeferred.resolve(reponseData);
							}
						);
					}
				});
		}else{
			AppConnector.request(data).then(
				function(reponseData){
					aDeferred.resolve(reponseData);
				}
			);
		}		
		return aDeferred.promise();
	},
	/**
	 * Function to handle the ajax edit for detailview and summary view fields
	 * which will expects the currentTdElement
	 */
	ajaxEditHandling : function(currentTdElement) {
			var thisInstance = this;
			var detailViewValue = jQuery('.value',currentTdElement);
			var editElement = jQuery('.edit',currentTdElement);
			var actionElement = jQuery('.summaryViewEdit', currentTdElement);
			var fieldnameElement = jQuery('.fieldname', editElement);
			var fieldName = fieldnameElement.val();
			var fieldElement = jQuery('[name="'+ fieldName +'"]', editElement);
			if(fieldElement.attr('disabled') == 'disabled'){
				return;
			}
			
			if(editElement.length <= 0) {
				return;
			}

			if(editElement.is(':visible')){
				return;
			}

			detailViewValue.addClass('hide');
			editElement.removeClass('hide').show().children().filter('input[type!="hidden"]input[type!="image"],select').filter(':first').focus();

			var saveTriggred = false;
			var preventDefault = false;
			var saveHandler = function(e) {
				var element = jQuery(e.target);
				if((element.closest('td').is(currentTdElement))){
					return;
				}

				currentTdElement.removeAttr('tabindex');
				var previousValue = fieldnameElement.data('prevValue');
				var formElement = thisInstance.getForm();
				var formData = formElement.serializeFormData();
				var ajaxEditNewValue = formData[fieldName];
				//value that need to send to the server
				var fieldValue = ajaxEditNewValue;
                var fieldInfo = Vtiger_Field_Js.getInstance(fieldElement.data('fieldinfo'));
                // Since checkbox will be sending only on and off and not 1 or 0 as currrent value
				if(fieldElement.is('input:checkbox')) {
					if(fieldElement.is(':checked')) {
						ajaxEditNewValue = '1';
					} else {
						ajaxEditNewValue = '0';
					}
					fieldElement = fieldElement.filter('[type="checkbox"]');
				}
				var errorExists = fieldElement.validationEngine('validate');
				//If validation fails
				if(errorExists) {
					return;
				}
                fieldElement.validationEngine('hide');
                //Before saving ajax edit values we need to check if the value is changed then only we have to save
                if((""+previousValue) == (""+ajaxEditNewValue)) { // Normalize(99!="099") Fix http://code.vtiger.com/vtiger/vtigercrm/issues/16 
                    editElement.addClass('hide');
                    detailViewValue.removeClass('hide');
					actionElement.show();
					jQuery(document).off('click', '*', saveHandler);
                } else {
					var preFieldSaveEvent = jQuery.Event(thisInstance.fieldPreSave);
					fieldElement.trigger(preFieldSaveEvent, {'fieldValue' : fieldValue,  'recordId' : thisInstance.getRecordId()});
					if(preFieldSaveEvent.isDefaultPrevented()) {
						//Stop the save
						saveTriggred = false;
						preventDefault = true;
						return
					}
					preventDefault = false;
					jQuery(document).off('click', '*', saveHandler);
					if(!saveTriggred && !preventDefault) {
						saveTriggred = true;
					}else{
						return;
					}
                    currentTdElement.progressIndicator();
					editElement.addClass('hide');
                    var fieldNameValueMap = {};
                    if(fieldInfo.getType() == 'multipicklist') {
                        var multiPicklistFieldName = fieldName.split('[]');
                        fieldName = multiPicklistFieldName[0];
                    }
                    fieldNameValueMap["value"] = fieldValue;
					fieldNameValueMap["field"] = fieldName;
					fieldNameValueMap = thisInstance.getCustomFieldNameValueMap(fieldNameValueMap);
                    thisInstance.saveFieldValues(fieldNameValueMap).then(function(response) {
						var postSaveRecordDetails = response.result;
						currentTdElement.progressIndicator({'mode':'hide'});
                        detailViewValue.removeClass('hide');
						actionElement.show();
						//Added for projectstatus purpose
						if(fieldName == 'stockstatus' && response == "1"){
							return false;
						}
                        detailViewValue.html(postSaveRecordDetails[fieldName].display_value);
                        fieldElement.trigger(thisInstance.fieldUpdatedEvent,{'old':previousValue,'new':fieldValue});
                        fieldnameElement.data('prevValue', ajaxEditNewValue);
                        fieldElement.data('selectedValue', ajaxEditNewValue); 
                        //After saving source field value, If Target field value need to change by user, show the edit view of target field. 
                        if(thisInstance.targetPicklistChange) { 
                                if(jQuery('.summaryView', thisInstance.getForm()).length > 0) { 
                                       thisInstance.targetPicklist.find('.summaryViewEdit').trigger('click'); 
                                } else { 
                                        thisInstance.targetPicklist.trigger('click'); 
                                } 
                                thisInstance.targetPicklistChange = false; 
                                thisInstance.targetPicklist = false; 
                        }
						//Added for projectstatus purpose
						if(fieldName == 'stockstatus' && fieldValue == "Approved"){
							var recordId = thisInstance.getRecordId();
							var reloadurl = 'index.php?module=ProjectStock&view=Detail&record='+recordId;
							location.href=reloadurl;
						}							
                        },
                        function(error){
                            //TODO : Handle error
                            currentTdElement.progressIndicator({'mode':'hide'});
                        }
                    )
                }
			}

			jQuery(document).on('click','*', saveHandler);
	},
	//Alert Ended here
	/**
    * Function which will regiter all events for this page
    */
    registerEvents : function(){
		this._super();
		var form = this.getForm();
		this.registerRecordPreSaveEvent(form);
    }
});