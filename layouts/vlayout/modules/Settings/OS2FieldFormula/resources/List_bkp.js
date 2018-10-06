/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
jQuery.Class('Settings_OS2FieldFormula_List_Js', {
	//holds the currency instance
	fieldFormulaInstance : false,
	triggerAdd : function(event) {
		event.stopPropagation();
		var instance = Settings_OS2FieldFormula_List_Js.fieldFormulaInstance;
		instance.registerFormulaSubmit();
		instance.showEditView();
		
	},
	triggerEdit : function(event, id) {
		event.stopPropagation();
		var instance = Settings_OS2FieldFormula_List_Js.fieldFormulaInstance;
		instance.registerFormulaSubmit();
		instance.showEditView(id);
	},
	triggerDelete : function(event, id) {
		event.stopPropagation();
		var currentTarget = jQuery(event.currentTarget);
		var currentTrEle = currentTarget.closest('tr');
		var instance = Settings_OS2FieldFormula_List_Js.fieldFormulaInstance;
		instance.deleteFormula(id, currentTrEle);
	}
}, {
	init : function() {
		Settings_OS2FieldFormula_List_Js.fieldFormulaInstance = this;
	},
	showEditView : function(id) {
		var thisInstance = this;
		var aDeferred = jQuery.Deferred();
		var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});
		var params = {};
		params['module'] = app.getModuleName();
		params['parent'] = app.getParentModuleName();
		params['view'] = 'EditAjax';
		params['record'] = id;
		AppConnector.request(params).then(
			function(data) {
				var callBackFunction = function(data) {
					var form = jQuery('#editFieldFormula');
					var record = form.find('[name="record"]').val();
					//register all select2 Elements
					app.showSelect2ElementView(form.find('select.select2'));
					thisInstance.registerCurrencyNameChangeEvent(form);
					thisInstance.registerSelectOptionEvent(form);
					if(record != ''){
						var selectedCurrencyOption = form.find('select[name="module_name"]').find('option:selected');
						var expression = form.find('select[name="fieldtype"]').find('option:selected').val();
						hcode = selectedCurrencyOption.attr('data-code');
						if(expression.indexOf('diff') != -1){
							thisInstance.regCall(hcode);
						}else{
							var typedata = form.find('select[name="fieldtype"]').find('option:selected');
							getuitype_data = typedata.attr('data-code');
							thisInstance.registerSelectingFieldType(getuitype_data,hcode);
						}
						var expressionval = form.find('input[name="expressionval"]').val();
						form.find('select[name="expression"]').val(expressionval).trigger('chosen:updated');
						var finalfield = form.find('input[name="finalfield"]').val();
						form.find('select[name="fieldname2"]').val(finalfield).trigger('chosen:updated');
					}
					var params = app.validationEngineOptions;
					params.onValidationComplete = function(form, valid){
						if(valid) {
							var formvalid = thisInstance.registerFormulaSubmit(form);
							if(formvalid){
								thisInstance.saveCurrencyDetails(form);
								return valid;
							}
						}
					}
					form.validationEngine(params);
					form.submit(function(e) {
						e.preventDefault();
					})
				}
				
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				app.showModalWindow(data,function(data){
					if(typeof callBackFunction == 'function'){
						callBackFunction(data);
					}
				}, {'width':'600px'});
			},
			function(error) {
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				//TODO : Handle error
				aDeferred.reject(error);
			}
		);
		return aDeferred.promise();
	},
	
	
	/**
	 * Register Change event for currency Name
	 */
	registerCurrencyNameChangeEvent : function(form) {
		var thisInstance = this;
		var currencyNameEle = form.find('select[name="module_name"]');
		var hcode = currencyNameEle.find('option:selected').attr('data-code');
		this.regCall(hcode);
		
		var getuitype = form.find('select[name="fieldtype"]');
		var getuitype_data = getuitype.find('option:selected').attr('data-code');
		var getexpress = form.find('select[name="expression"]');
		var getexpressval = getexpress.find('option:selected').text()
		this.registerSelectingFieldType(getuitype_data,hcode);
		currencyNameEle.on('change', function() {
			var selectedCurrencyOption = currencyNameEle.find('option:selected');
			hcode = selectedCurrencyOption.attr('data-code');
			getuitype_data = getuitype.find('option:selected').attr('data-code');
			thisInstance.regCall(hcode);
			thisInstance.registerSelectingFieldType(getuitype_data,hcode);
		})
		
		getuitype.on('change', function() {
			hcode = currencyNameEle.find('option:selected').attr('data-code');
			getuitype_data = getuitype.find('option:selected').attr('data-code');
			thisInstance.registerSelectingFieldType(getuitype_data,hcode);
		})
		
		var expressionval = jQuery("#expression option:selected").text();
		if(expressionval != 'today' || expressionval !='tomorrow' || expressionval !='yesterday'){
			jQuery('div.hideField').removeClass('hide');
		}else{
			jQuery('div.hideField').addClass('hide');
		}
		
	},
	
	
	registerSelectingFieldType : function(getuitype_data, hcode) {
		var thisInstance = this;
		var aDeferred = jQuery.Deferred();
		var optionslist1 = '<option value="" selected="selected">Select an Option</option>';
		var params = {};
		params['module'] = app.getModuleName();
		params['parent'] = app.getParentModuleName();
		params['view'] = 'EditAjax';
		params['typeofData'] = getuitype_data;
		params['moduleid'] = hcode;
		params['mode'] = 'getSelectedUIFields';
		jQuery("#fieldname").html(optionslist1).trigger("liszt:updated");
		jQuery("#fieldname2").html(optionslist1).trigger("liszt:updated");//Manasa
		var FIELD_EXPRESSIONS = jQuery('input[name="FIELD_EXPRESSIONS"]').val();
		FIELD_EXPRESSIONS = jQuery.parseJSON(FIELD_EXPRESSIONS);
		if(getuitype_data == "'D~O','D~M'"){
			var expressions = FIELD_EXPRESSIONS['Date'];
		}else if(getuitype_data == "'V~O','V~M'"){
			var expressions = FIELD_EXPRESSIONS['String'];
		}else if(getuitype_data == "'N~O','I~O','NN~O','I~M','N~M'"){
			var expressions = FIELD_EXPRESSIONS['Number'];
		}else if(getuitype_data == "'T~O','T~M'"){
			var expressions = FIELD_EXPRESSIONS['Time'];
		}
		var formula = '<option value="" selected="selected">Select An Option</option>';
		jQuery.each(expressions,function (index, value) {
					formula = formula+"<option value='"+value+"'>"+app.vtranslate(index)+"</option>";
		});
		jQuery("#expression").html(formula).trigger("liszt:updated");
		
		AppConnector.request(params).then( function(data) {
			var issuesObject1 = jQuery.parseJSON(data);
			if(issuesObject1.result == null){
				jQuery("#fieldname").html(optionslist1).trigger("liszt:updated");
				jQuery("#fieldname2").html(optionslist1).trigger("liszt:updated");//Manasa
			}else{
				jQuery.each(issuesObject1.result,function (index, value) {
					optionslist1 = optionslist1+"<option value='#"+value.fieldname+"'>"+value.fieldlabel+"</option>";
				});
				jQuery("#fieldname").html(optionslist1).trigger("liszt:updated");
				jQuery("#fieldname2").html(optionslist1).trigger("liszt:updated");//Manasa			
				
			}		 		
		}),
		
		
		function(error) {
			console.log("Very serious error. Investigate function registerSelectingFieldType in OS2FieldFormula/List.js");
		}
	},
	registerCalculateFieldChange : function(getuitype_data, hcode) {
		var thisInstance = this;
		var aDeferred = jQuery.Deferred();
		var optionslist1 = '<option value="" selected="selected">Select an Option</option>';
		var params = {};
		params['module'] = app.getModuleName();
		params['parent'] = app.getParentModuleName();
		params['view'] = 'EditAjax';
		params['typeofData'] = getuitype_data;
		params['moduleid'] = hcode;
		params['mode'] = 'getSelectedUIFields';
		jQuery("#fieldname").html(optionslist1).trigger("liszt:updated");
		jQuery("#fieldname2").html(optionslist1).trigger("liszt:updated");//Manasa
		
		AppConnector.request(params).then( function(data) {
			var issuesObject1 = jQuery.parseJSON(data);
			if(issuesObject1.result == null){
				jQuery("#fieldname").html(optionslist1).trigger("liszt:updated");
				jQuery("#fieldname2").html(optionslist1).trigger("liszt:updated");//Manasa
			}else{
				jQuery.each(issuesObject1.result,function (index, value) {
					optionslist1 = optionslist1+"<option value='#"+value.fieldname+"'>"+value.fieldlabel+"</option>";
				});
				jQuery("#fieldname").html(optionslist1).trigger("liszt:updated");
				jQuery("#fieldname2").html(optionslist1).trigger("liszt:updated");//Manasa
				
			}		 		
		}),
		
		function(error) {
			console.log("Very serious error. Investigate function registerCalculateFieldChange in OS2FieldFormula/List.js");
		}
	},

	
	registerSelectOptionEvent : function(form) {
		var thisInstance = this;
		var textfield = form.find('input[name="fieldValue"]');
		jQuery('.fieldname').on('change',function(e){
			var currentElement = jQuery(e.currentTarget);
			var newValue = currentElement.val();
			var oldValue  = form.find('.fieldValue').filter(':visible').val();
			if(currentElement.hasClass('fieldname')){
				if(oldValue != ''){
					var concatenatedValue = oldValue+newValue;
				} else {
					concatenatedValue = newValue;
				}
			} else {
				concatenatedValue = oldValue+newValue;
			}
			form.find('.fieldValue').val(concatenatedValue);
		});
		
		jQuery('.expression').on('change',function(e){
			var currentElement = jQuery(e.currentTarget);
			var newValue = currentElement.val();
			var oldValue  = form.find('.expValue').filter(':visible').val();
			if(currentElement.hasClass('expression')){
				if(oldValue != ''){
					var concatenatedValue =newValue;// oldValue+' '+
				} else {
					concatenatedValue = newValue;
				}
			} else {
				concatenatedValue = newValue;//oldValue+
			}
			if(concatenatedValue == 'BasicFormula'){
				concatenatedValue = 'BasicFormula';
				form.find('.fieldValue').val('');
			}else{
				form.find('.fieldValue').val(concatenatedValue);
			}
			form.find('.expValue').val(concatenatedValue);
			
			if(newValue == 'today' || newValue =='tomorrow' || newValue =='yesterday'){
				jQuery('div.hideField').addClass('hide');
			}else{
				jQuery('div.hideField').removeClass('hide');
			}
			var selectedCurrencyOption = form.find('select[name="module_name"]').find('option:selected');
			hcode = selectedCurrencyOption.attr('data-code');
			if(newValue.indexOf('diff') != -1){
				thisInstance.regCall(hcode);
			}else{
				var typedata = form.find('select[name="fieldtype"]').find('option:selected');
				getuitype_data = typedata.attr('data-code');
				thisInstance.registerCalculateFieldChange(getuitype_data,hcode);
			}
			
		});
		
	},
	
    regCall: function(a){
		var thisInstance = this;
		var aDeferred = jQuery.Deferred();
		var optionslist = "";
		
		var params = {};
		params['module'] = app.getModuleName();
		params['parent'] = app.getParentModuleName();
		params['view'] = 'EditAjax';
		params['moduleid'] = a;
		params['mode'] = 'getModuleFields';
		
		AppConnector.request(params).then( function(data) {
				var issuesObject = jQuery.parseJSON(data);
				jQuery.each(issuesObject.result,function (index, value) {
					optionslist = optionslist+"<option value='#"+value.fieldname+"'>"+value.fieldlabel+"</option>";
				});
				jQuery("select[name='fieldname2']").html(optionslist).trigger("liszt:updated");
				var editform = jQuery('#editFieldFormula');
				var calculatedfield = jQuery('#calculatedfield').val();
				editform.find('#fieldname2').val(calculatedfield).trigger('change');
				editform.find('#fieldname').val(calculatedfield).trigger('change');
		}),
		function(error) {
			console.log("Very serious error. Investigate function regCall in OS2FieldFormula/List.js");
		}
		
	},
	
		/**
	 * This function will save the currency details
	 */
	saveCurrencyDetails : function(form) {
		var thisInstance = this;
		var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});		
		var data = form.serializeFormData();
		data['module'] = app.getModuleName();
		data['parent'] = app.getParentModuleName();
		data['action'] = 'SaveAjax';
		AppConnector.request(data).then(
			function(data) {
				if(data['success']) {
					progressIndicatorElement.progressIndicator({'mode' : 'hide'});
					app.hideModalWindow();
					var params = {};
					params.text = app.vtranslate('JS_DETAILS_SAVED');
					Settings_Vtiger_Index_Js.showMessage(params);
					location.reload();
				}
			},
			function(error) {
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				//TODO : Handle error
			}
		);
	},
	
		/**
	 * This function will show the Transform Currency view while delete the currency
	 */
	deleteFormula : function(id, currentTrEle) {
		var params = {};
		params['module'] = app.getModuleName();
		params['parent'] = app.getParentModuleName();
		params['action'] = 'DeleteAjax';
		params['record'] = id;
		var message = app.vtranslate('LBL_DELETE_CONFIRMATION');
		Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
			function(e) {
				AppConnector.request(params).then(
					function(data) {
						app.hideModalWindow();
						var params = {};
						params.text = app.vtranslate('JS_FORMULA_DELETED_SUEESSFULLY');
						Settings_Vtiger_Index_Js.showMessage(params);
						currentTrEle.fadeOut('slow').remove();
					}, function(error, err) {
						
				});
			},
			function(error, err){
				Vtiger_List_Js.clearList();
			});
	},
	searchFormulaByModuleStatus : function(){
		jQuery(".formulasearch").on('click',function(){
			var modulename = jQuery("select[name='modulename']").val();
			var formulastatus = jQuery("select[name='formulastatus']").val();
			var data = {};
			data['module'] = app.getModuleName();
			data['parent'] = app.getParentModuleName();
			if(modulename != '' || modulename != null || formulastatus != '' || formulastatus != null){
				data['modulelist'] = modulename;
				data['formulastatus'] = formulastatus;
				data['action'] = 'SearchAjax';
				AppConnector.request(data).then(
					function(data) {
						if(data['success']) {
							var contents = jQuery("#searchdatareplace");
							var searchfields = data['result']['message'];
							var list = '';
							jQuery.each(searchfields,function(key,values){
								
								list +='<tr class="listViewEntries" data-id="'+key+'">';
								list +='<td width="1%" nowrap="" class="medium"></td>';
								list +='<td class="listViewEntryValue medium" width="16.5%" nowrap="">'+values['fieldformula_name']+'</td>';
								list +='<td class="listViewEntryValue medium" width="16.5%" nowrap="">'+values['module']+'</td>';
								list +='<td class="listViewEntryValue medium" width="16.5%" nowrap="">'+values['fieldname']+'</td>';
								list +=' <td class="listViewEntryValue medium" width="16.5%" nowrap="">'+values['expression']+'</td>';
								list +='<td class="listViewEntryValue medium" width="16.5%" nowrap="">'+values['resultfield']+'</td>';
								list +='<td class="listViewEntryValue medium" width="16.5%" nowrap="">'+values['fieldformula_status']+'</td>';
								list +='<td nowrap="" class="medium"><div class="pull-right actions"><span class="actionImages">';
								list +='<a href="index.php?module=OS2FieldFormula&parent=Settings&view=Edit&record='+key+'">';
								list +='<i class="icon-pencil alignMiddle" title="Edit"></i></a>';
								list +='<a onclick="Settings_VTFieldFormula_Js.triggerDelete(event,'+key+')">';
								list +='<i class="icon-trash alignMiddle" title="Delete"></i></a></span></div></td></tr>';
							});
							contents.html(list);
						}
					},
					function(error) {
						progressIndicatorElement.progressIndicator({'mode' : 'hide'});
						//TODO : Handle error
					}
				);
			}
		});
	},
	registerFormulaSubmit:function(form){
		if(typeof form == 'undefined'){
			var form = jQuery("#editFieldFormula");
		}
		var modulename = form.find("select[name='module_name']").val();
		var formulaname = form.find("input[name='fieldformula_name']").val();
		var fieldtype = form.find("select[name='fieldtype']").val();
		var expression = form.find("#expression").val();
		//var fieldname = form.find("#fieldname").val();//|| fieldname == ''
		var resultfield = form.find("#fieldname2").val();
		if(modulename == '' || formulaname == '' || fieldtype == '' || expression == ''  || resultfield == ''){
			var params = {};
			var params = {
				title : app.vtranslate('JS_MESSAGE'),
				text: app.vtranslate('JS_FIELDS_MANDATORY'),
				animation: 'show',
				type: 'error'
			};
			Vtiger_Helper_Js.showPnotify(params);
			return false;
		}
		return true;
	},
	formulaEditSave : function() {
		var thisInstance = this;
		jQuery('button[name="saveButton"]').on('click',function(e){
			var form = jQuery('#editFieldFormula');	
			var progressIndicatorElement = jQuery.progressIndicator({
				'position' : 'html',
				'blockInfo' : {
					'enabled' : true
				}
			});		
			var data = form.serializeFormData();
			data['module'] = app.getModuleName();
			data['parent'] = app.getParentModuleName();
			data['action'] = 'Save';
			AppConnector.request(data).then(
				function(data) {
					if(data['success']) {
						progressIndicatorElement.progressIndicator({'mode' : 'hide'});
						app.hideModalWindow();
						var params = {};
						params.text = app.vtranslate('JS_DETAILS_SAVED');
						Settings_Vtiger_Index_Js.showMessage(params);
						location.href='index.php?module=OS2FieldFormula&parent=Settings&view=List';
					}
				},
				function(error) {
					progressIndicatorElement.progressIndicator({'mode' : 'hide'});
					//TODO : Handle error
				}
			);
			e.preventDefault();
		});
		jQuery(".cancelLink").on('click',function(){
			location.href='index.php?module=OS2FieldFormula&parent=Settings&view=List';
		});
	},
	registerForChangeEvents : function(){
		var thisInstance = this;
		var editform = jQuery('#editFieldFormula');					
		var mode =  '';
		mode = jQuery("#edit-mode").val();
		if(mode){
			thisInstance.registerCurrencyNameChangeEvent(editform);
		}
		thisInstance.registerSelectOptionEvent(editform);
		thisInstance.formulaEditSave();
	},
    registerEvents : function() {
		var thisInstance = this;
		thisInstance.searchFormulaByModuleStatus();
		//thisInstance.editFieldFormula();
		thisInstance.registerForChangeEvents();
		
	}
	
});

jQuery(document).ready(function(e){
	var fieldFormulaInstance = new Settings_OS2FieldFormula_List_Js();
	fieldFormulaInstance.registerEvents();
	
});

//12-04-2018 Ganesh changing fieldtype 
function clearfun(){
	var fieldtype = jQuery("#fieldtype").val();
	jQuery("#fieldname").select2();
	jQuery("#expression").select2();
	jQuery("#fieldname2").select2();	
	jQuery(".fieldValue").val('');	
			

}
//12-04-2018 Ganesh changing fieldname 
function chngeexpression(){
	jQuery("#fieldname").select2();
	jQuery("#fieldname2").select2();
}
