Vtiger_PositiveNumber_Validator_Js("Vtiger_projectstatusvalidation_Validator_Js",{
},{
	/**
	 * Function to validate the email field data
	 */
	validate: function(){
		var fieldValue = this.getFieldValue();
		return this.validateValue(fieldValue);
	},
	/**
	 * Function to validate the email field data
	 * @return true if validation is successfull
	 * @return false if validation error occurs
	 */
	validateValue : function(fieldValue){
		var record = jQuery("input[name*='record']").val();
		var productscount = jQuery("#PRODUCTSCOUNT").val();
		if (record != '' && productscount == 1 && (fieldValue == 'archived' || fieldValue == 'completed')) {
			var errorInfo = app.vtranslate('Please remove remaining stock before closing project');
			this.setError(errorInfo);
			return false;
		}
        return true;
	}
});