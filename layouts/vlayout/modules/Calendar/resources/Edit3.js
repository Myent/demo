/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
Calendar_Edit_Js("Calendar_Edit3_Js",{},{

	step3Container : false,

	

	init : function() {
		this.initialize();
	},
	/**
	 * Function to get the container which holds all the report elements
	 * @return jQuery object
	 */
	getContainer : function() {
		return this.step3Container;
	},

	/**
	 * Function to set the report step2 container
	 * @params : element - which represents the report step2 container
	 * @return : current instance
	 */
	setContainer : function(element) {
		this.step3Container = element;
		return this;
	},

	

	/**
	 * Function  to intialize the reports step2
	 */
	initialize : function(container) {
		if(typeof container == 'undefined') {
			container = jQuery('#event_step3');
		}

		if(container.is('#event_step3')) {
			this.setContainer(container);
		}else{
			this.setContainer(jQuery('#event_step3'));
		}
	},
	/*
	 * Function to validate special cases in the form
	 * returns result
	 */
	isFormValidate : function(){
		var thisInstance = this;
		var selectElement = this.getReportsColumnsList();
		var select2Element = app.getSelect2ElementFromSelect(selectElement);
		var result = Vtiger_MultiSelect_Validator_Js.invokeValidation(selectElement);
		if(result != true){
			select2Element.validationEngine('showPrompt', result , 'error','bottomLeft',true);
			var form = thisInstance.getContainer();
			app.formAlignmentAfterValidation(form);
			return false;
		} else {
			select2Element.validationEngine('hide');
			return true;
		}
	},
	
	/**
	 * Function which will register the select2 elements for columns selection
	 */
	registerSelect2ElementForReportColumns : function() {
		var selectElement = this.getReportsColumnsList();
		app.changeSelectElementView(selectElement, 'select2', {maximumSelectionSize: 25,dropdownCss : {'z-index' : 0}});
	},

	
	registerEvents : function(){
		var container = this.getContainer();
		//If the container is reloading, containers cache should be reset
		app.changeSelectElementView(container);
		container.validationEngine({
			// to prevent the page reload after the validation has completed
			'onValidationComplete' : function(form,valid){
                return valid;
			}
		});
	}
});


