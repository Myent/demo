Vtiger_Base_Validator_Js("ACMPR_numbercountgridarpic_Validator_Js",{
},{
	validate: function(){
		var fieldValue = this.getFieldValue();
		var field = this.getElement();
		var fieldData = field.data();
		var fieldname = fieldData.fieldinfo.name;
		var arpictable = jQuery("#arpictab .arpicItemRow").length;
		
		if(parseInt(fieldValue) != parseInt(arpictable)){
			var errorInfo = app.vtranslate("Please check number of ARPIC's count does not match.");
			this.setError(errorInfo);
			return false;
		}
		return true;
	}
});

Vtiger_Base_Validator_Js("ACMPR_numbercountgridperson_Validator_Js",{
},{
	validate: function(){
		var fieldValue = this.getFieldValue();
		var field = this.getElement();
		var fieldData = field.data();
		var fieldname = fieldData.fieldinfo.name;
		var persontable = jQuery("#personTab .personItemRow").length;
		
		if(parseInt(fieldValue) != parseInt(persontable)){
			var errorInfo = app.vtranslate("Please check number of Persons your submitting count does not match.");
			this.setError(errorInfo);
			return false;
		}
		return true;
	}
});