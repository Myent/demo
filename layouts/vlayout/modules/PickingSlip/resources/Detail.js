Inventory_Detail_Js("PickingSlip_Detail_Js",{},{
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
	
	/**
    * Function which will regiter all events for this page
    */
    registerEvents : function(){
		this._super();
		var form = this.getForm();
		this.registerRecordPreSaveEvent(form);
    }
});