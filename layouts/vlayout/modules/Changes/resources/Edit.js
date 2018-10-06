/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Edit_Js("Changes_Edit_Js",{},{  
	
	
		
	registerOnLoadPage : function(){ 
			
		var Task_Budget_Dollars = jQuery('#Changes_editView_fieldName_c_task_budget');		
		var Hourly_Charges = jQuery('#Changes_editView_fieldName_c_hourly_charges');
		var Task_Budget_Hours = jQuery('#Changes_editView_fieldName_c_task_budget_hours');
		
		Task_Budget_Hours.prop("readonly", true);	
		var thisInstance = this;
		Task_Budget_Dollars.focusout(function(){  
			thisInstance.getTaskBudgetHours();
		});
		Hourly_Charges.focusout(function(){  
			thisInstance.getTaskBudgetHours();
		});	
	}, 
	
	getTaskBudgetHours : function() {
		var Task_Budget_Dollars = jQuery('#Changes_editView_fieldName_c_task_budget');		
		var Hourly_Charges = jQuery('#Changes_editView_fieldName_c_hourly_charges');
		var Task_Budget_Hours = jQuery('#Changes_editView_fieldName_c_task_budget_hours');
		Task_Budget_Hours.val(function(){
		 
			if((Task_Budget_Dollars.val().replace(/,/g, "") > 0 || Task_Budget_Dollars.val() != '') && Hourly_Charges.val() > 0){
				return (Task_Budget_Dollars.val().replace(/,/g, "") / Hourly_Charges.val()).toFixed(2);
			}else{ 
				return 0;
			}			 
		});
	},
	
	BaseModeFields : function(){
		var CoMode = jQuery('#idCoMode').val();		
		var Task_Budget_Dollars = jQuery('#Changes_editView_fieldName_c_task_budget');		
		var Hourly_Charges = jQuery('#Changes_editView_fieldName_c_hourly_charges');
		var Task_Budget_Hours = jQuery('#Changes_editView_fieldName_c_task_budget_hours');
		var Start_Date = jQuery('#Changes_editView_fieldName_c_start_date');
		var End_Date = jQuery('#Changes_editView_fieldName_c_end_date');
		
		switch(CoMode){			
			case 'Schedule':
				Hourly_Charges.prop("readonly", true);	
				Task_Budget_Dollars.prop("readonly", true);	
				break;
			case 'Budget':
				Start_Date.prop("readonly", true);
				End_Date.prop("readonly", true);
				break;
			case 'Scope':
				
				break;
			default:				 
		}
	},
	
	registerEvents : function() { 
        this._super();
		this.registerOnLoadPage();		
		this.BaseModeFields();
	}
});
