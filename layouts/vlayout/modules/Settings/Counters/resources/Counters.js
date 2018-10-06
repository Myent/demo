/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
jQuery.Class('Settings_Counters_Js', {}, {
	getCounterFilters : function(){
		var filterid = jQuery("input[name='counterid']").val();
		if(filterid != ''){
			var modulename = $("#pickListModules").val();
			var filterName	=	$('#filterDetails').val();	
			var selectedfilters = '';
			var selectedfilters = jQuery.parseJSON($("#selectedfilters").val());
			console.log(typeof selectedfilters);
			var filterName = jQuery.parseJSON(filterName);
			var specificmodule = filterName[modulename];
			var optionslist ='';
			$("#menuListSelectElement").select2("val", "");
			jQuery.each(specificmodule,function(k,v){
				optionslist = optionslist+"<option value='"+k+"'>"+v+"</option>";
				
			});		
			
			console.log(optionslist);
			jQuery("#menuListSelectElement").html(optionslist).trigger("liszt:updated");
			app.changeSelectElementView(jQuery("#menuListSelectElement"));
				jQuery("#menuListSelectElement").val(selectedfilters).trigger('change');
		}
		jQuery("#pickListModules").on('change',function(){
			var modulename = $(this).val();
			var filterName	=	$('#filterDetails').val();
			
			var filterName = jQuery.parseJSON(filterName);
			var specificmodule = filterName[modulename];
			var optionslist ='';//<option value="">manasa</option>';
			$("#menuListSelectElement").select2("val", "");
			jQuery.each(specificmodule,function(k,v){
				optionslist = optionslist+"<option value='"+k+"'>"+v+"</option>";
			});
			jQuery("#menuListSelectElement").html(optionslist).trigger("liszt:updated");
			app.changeSelectElementView(jQuery("#menuListSelectElement"));
			
		});
	},
	/**
	 * This function will delete the pickList Dependency
	 * @params: module - selected module
	 *			sourceField - source picklist value
	 *			targetField - target picklist value
	 */
	deleteCounter : function(counterId) {
		var aDeferred = jQuery.Deferred();
		var params = {};
		params['module'] = 'Counters';
		params['parent'] = 'Settings';
		params['action'] = 'DeleteAjax';
		params['counterId'] = counterId;
		
		AppConnector.request(params).then(
			function(data) {
				aDeferred.resolve(data);
			}, function(error, err) {
				aDeferred.reject();
			}
		);
		return aDeferred.promise();
	},
	
	saveCounter : function() {
		var aDeferred = jQuery.Deferred();
		var instance = this;
		jQuery("#button_save").on('click',function(){
			var params = {};
			var form = jQuery("#counters");
			var formData = jQuery(form).serialize();
			//console.log(formData[widgetview]);
			AppConnector.request(formData).then(
				function(data) {
					var params = {};
					params.text = app.vtranslate(data.result.message);
					Settings_Vtiger_Index_Js.showMessage(params);
					window.location.href= "index.php?module=Counters&parent=Settings&view=List&block=2&fieldid=33";
					aDeferred.resolve(data);
				}, function(error, err) {
					aDeferred.reject();
				}
			);
			return false;
		});
		
	},
	
	triggerDelete : function() {
		var instance = this;
		jQuery('.deleteRecordButton').on('click',function(event){
		event.stopPropagation();
		var currentTarget = jQuery(event.currentTarget);
		var counterId= currentTarget.attr('data-id');
		var message = app.vtranslate('JS_LBL_ARE_YOU_SURE_YOU_WANT_TO_DELETE');
		Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
			function(event) {
				instance.deleteCounter(counterId).then(
					function(data){
						var params = {};
						params.text = app.vtranslate('JS_COUNTER_DELETED_SUEESSFULLY');
						Settings_Vtiger_Index_Js.showMessage(params);
						location.reload();
					}
				);
			},
			function(error, err){
				
			}
		);
		});
	},
	
	registerEvents : function(e){
		var thisInstance = this;
		var view = jQuery("#view").val();
		if(view != 'List'){
			thisInstance.getCounterFilters();
		}
		this.triggerDelete();
		this.deleteCounter();
		this.saveCounter();
	}
	
});
jQuery(document).ready(function(){
	var settingCountersInstance = new Settings_Counters_Js();
	settingCountersInstance.registerEvents();
})
