Inventory_Edit_Js("PickingSlip_Edit_Js",{},{
	
	/**
	 * Function which will register event for Reference Fields Selection
	 */
	registerReferenceSelectionEvent : function(container) {
		this._super(container);
		var thisInstance = this;
		
		jQuery('input[name="account_id"]', container).on(Vtiger_Edit_Js.referenceSelectionEvent, function(e, data){
			thisInstance.referenceSelectionEventHandler(data, container);
		});
	},

	/**
	 * Function to get popup params
	 */
	getPopUpParams : function(container) {
		var params = this._super(container);
        var sourceFieldElement = jQuery('input[class="sourceField"]',container);

		if(sourceFieldElement.attr('name') == 'contact_id' || sourceFieldElement.attr('name') == 'potential_id') {
			var form = this.getForm();
			var parentIdElement  = form.find('[name="account_id"]');
			if(parentIdElement.length > 0 && parentIdElement.val().length > 0 && parentIdElement.val() != 0) {
				var closestContainer = parentIdElement.closest('td');
				params['related_parent_id'] = parentIdElement.val();
				params['related_parent_module'] = closestContainer.find('[name="popupReferenceModule"]').val();
			} else if(sourceFieldElement.attr('name') == 'potential_id') {
				parentIdElement  = form.find('[name="contact_id"]');
				if(parentIdElement.length > 0 && parentIdElement.val().length > 0) {
					closestContainer = parentIdElement.closest('td');
					params['related_parent_id'] = parentIdElement.val();
					params['related_parent_module'] = closestContainer.find('[name="popupReferenceModule"]').val();
				}
			}
        }
        return params;
    },

	/**
	 * Function to search module names
	 */
	searchModuleNames : function(params) {
		var aDeferred = jQuery.Deferred();

		if(typeof params.module == 'undefined') {
			params.module = app.getModuleName();
		}
		if(typeof params.action == 'undefined') {
			params.action = 'BasicAjax';
		}

		if (params.search_module == 'Contacts' || params.search_module == 'Potentials') {
			var form = this.getForm();
			var parentIdElement  = form.find('[name="account_id"]');
			if(parentIdElement.length > 0 && parentIdElement.val().length > 0) {
				var closestContainer = parentIdElement.closest('td');
				params.parent_id = parentIdElement.val();
				params.parent_module = closestContainer.find('[name="popupReferenceModule"]').val();
			} else if(params.search_module == 'Potentials') {
				parentIdElement  = form.find('[name="contact_id"]');
				if(parentIdElement.length > 0 && parentIdElement.val().length > 0) {
					closestContainer = parentIdElement.closest('td');
					params.parent_id = parentIdElement.val();
					params.parent_module = closestContainer.find('[name="popupReferenceModule"]').val();
				}
			}
		}

		AppConnector.request(params).then(
			function(data){
				aDeferred.resolve(data);
			},
			function(error){
				aDeferred.reject();
			}
		)
		return aDeferred.promise();
	},
	
	/**
	 * Function to register event for enabling recurrence
	 * When recurrence is enabled some of the fields need
	 * to be check for mandatory validation
	 */
	registerEventForEnablingRecurrence : function(){
		var thisInstance = this;
		var form = this.getForm();
		var enableRecurrenceField = form.find('[name="enable_recurring"]');
		var fieldsForValidation = new Array('recurring_frequency','start_period','end_period','payment_duration','invoicestatus');
		enableRecurrenceField.on('change',function(e){
			var element = jQuery(e.currentTarget);
			var addValidation;
			if(element.is(':checked')){
				addValidation = true;
			}else{
				addValidation = false;
			}
			
			//If validation need to be added for new elements,then we need to detach and attach validation
			//to form
			if(addValidation){
				form.validationEngine('detach');
				thisInstance.AddOrRemoveRequiredValidation(fieldsForValidation,addValidation);
				//For attaching validation back we are using not using attach,because chosen select validation will be missed
				form.validationEngine(app.validationEngineOptions);
				//As detach is used on form for detaching validationEngine,it will remove any actions on form submit,
				//so events that are registered on form submit,need to be registered again after validationengine detach and attach
				thisInstance.registerSubmitEvent();
			}else{
				thisInstance.AddOrRemoveRequiredValidation(fieldsForValidation,addValidation);
			}
		})
		if(!enableRecurrenceField.is(":checked")){
			thisInstance.AddOrRemoveRequiredValidation(fieldsForValidation,false);
		}else if(enableRecurrenceField.is(":checked")){
			thisInstance.AddOrRemoveRequiredValidation(fieldsForValidation,true);
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
					relatedField.attr('disabled',"disabled");
				}
				relatedField.validationEngine('hide');
				if(relatedField.is('select') && relatedField.hasClass('chzn-select')){
					var parentTd = relatedField.closest('td');
					parentTd.find('.chzn-container').validationEngine('hide');
				}
			}
		})
	},
//Manasa added the following functions
registerAutoCompleteFields : function(container) {
		var thisInstance = this;
		container.find('input.autoComplete').autocomplete({
			'minLength' : '3',
			'source' : function(request, response){
				//element will be array of dom elements
				//here this refers to auto complete instance
				var inputElement = jQuery(this.element[0]);
				var searchValue = request.term;
				var params = thisInstance.getReferenceSearchParams(inputElement);
				params.search_value = searchValue;
				thisInstance.searchModuleNames(params).then(function(data){
					var reponseDataList = new Array();
					var serverDataFormat = data.result
					if(serverDataFormat.length <= 0) {
						jQuery(inputElement).val('');
						serverDataFormat = new Array({
							'label' : app.vtranslate('JS_NO_RESULTS_FOUND'),
							'type'  : 'no results'
						});
					}
					for(var id in serverDataFormat){
						var responseData = serverDataFormat[id];
						reponseDataList.push(responseData);
					}
					response(reponseDataList);
				});
			},
			'select' : function(event, ui ){
				var selectedItemData = ui.item;
				//To stop selection if no results is selected
				if(typeof selectedItemData.type != 'undefined' && selectedItemData.type=="no results"){
					return false;
				}
				selectedItemData.name = selectedItemData.value;
				var element = jQuery(this);
				var tdElement = element.closest('td');
				thisInstance.setReferenceFieldValue(tdElement, selectedItemData);
	
				var  sourceModule= tdElement.find('input[name="popupReferenceModule"]').val();
				var rec = selectedItemData.id;//jQuery("#").val();
				var module = app.getModuleName();
				
				if(module == 'PickingSlip' && sourceModule == 'Project'){
					selectedItemData.record = selectedItemData.id;
					selectedItemData.source_module = 'Project';
					thisInstance.getProjectProductDetails(selectedItemData).then(
					function(data){
						var response = data['result'];
						jQuery("#PROJECTPRODUCTDETAILS").attr('data-value',JSON.stringify(response));
					},
					function(error, err){

					});
				}
                var sourceField = tdElement.find('input[class="sourceField"]').attr('name');
                var fieldElement = tdElement.find('input[name="'+sourceField+'"]');

                fieldElement.trigger(Vtiger_Edit_Js.postReferenceSelectionEvent,{'data':selectedItemData});
			},
			'change' : function(event, ui) {
				var element = jQuery(this);
				//if you dont have readonly attribute means the user didnt select the item
				if(element.attr('readonly')== undefined) {
					element.closest('td').find('.clearReferenceSelection').trigger('click');
				}
			},
			'open' : function(event,ui) {
				//To Make the menu come up in the case of quick create
				jQuery(this).data('autocomplete').menu.element.css('z-index','100001');

			}
		});
	},
	
/**
	 * Function which will give you all details of the selected record
	 * @params - an Array of values like {'record' : recordId, 'source_module' : searchModule, 'selectedName' : selectedRecordName}
	 */
	getProjectProductDetails : function(params) {
		var aDeferred = jQuery.Deferred();
		var url = "index.php?module="+app.getModuleName()+"&action=GetProductDetails&record="+params['record']+"&source_module="+params['source_module'];
		AppConnector.request(url).then(
			function(data){
				if(data['success']) {
					aDeferred.resolve(data);
				} else {
					aDeferred.reject(data['message']);
				}
			},
			function(error){
				aDeferred.reject();
			}
			)
		return aDeferred.promise();
	},


	
	openPopUp : function(e){
		var thisInstance = this;
		var parentElem = jQuery(e.target).closest('td');

		var params = this.getPopUpParams(parentElem);

		var isMultiple = false;
		if(params.multi_select) {
			isMultiple = true;
		}

		var sourceFieldElement = jQuery('input[class="sourceField"]',parentElem);

		var prePopupOpenEvent = jQuery.Event(Vtiger_Edit_Js.preReferencePopUpOpenEvent);
		sourceFieldElement.trigger(prePopupOpenEvent);

		if(prePopupOpenEvent.isDefaultPrevented()) {
			return ;
		}

		var popupInstance =Vtiger_Popup_Js.getInstance();
		popupInstance.show(params,function(data){
			var responseData = JSON.parse(data);
			var dataList = new Array();
			for(var id in responseData){
				var data = {
					'name' : responseData[id].name,
					'id' : id
				}
				dataList.push(data);
				if(!isMultiple) {
					thisInstance.setReferenceFieldValue(parentElem, data);
				}
			}
			//manasa Jun 27 2016 Orgnization details copy
			var module = app.getModuleName();
			var opprefmodule = jQuery('input[name="popupReferenceModule"]',parentElem).val();

			if(module == 'PickingSlip' && opprefmodule == 'Project'){
				var rec = data.id;
				var sentdata ={};
				sentdata.module ='PickingSlip';
				sentdata.record = rec;//.id;
				sentdata.source_module = 'Project';
				thisInstance.getProjectProductDetails(sentdata).then(
					function(data){
						var response = data['result'];
						jQuery("#PROJECTPRODUCTDETAILS").attr('data-value',JSON.stringify(response));
					},
					function(error, err){

					});
			}
			//manasa Jun 27 2016 Code ended here.
			if(isMultiple) {
                    sourceFieldElement.trigger(Vtiger_Edit_Js.refrenceMultiSelectionEvent,{'data':dataList});
			}
                sourceFieldElement.trigger(Vtiger_Edit_Js.postReferenceSelectionEvent,{'data':responseData});
		});
	},
	   /**
	 * Function which will register reference field clear event
	 * @params - container <jQuery> - element in which auto complete fields needs to be searched
	 */
	registerClearReferenceSelectionEvent : function(container) {
		var thisInstance =this;
		container.find('.clearReferenceSelection').on('click', function(e){
			
			var element = jQuery(e.currentTarget);
			var parentTdElement = element.closest('td');
			var fieldNameElement = parentTdElement.find('.sourceField');
			var fieldName = fieldNameElement.attr('name');
			console.log(fieldName);
			if(fieldName == 'projectid'){
				jQuery(container).find('#PROJECTPRODUCTDETAILS').attr('data-value','');
			}
			fieldNameElement.val('');
			parentTdElement.find('#'+fieldName+'_display').removeAttr('readonly').val('');
			element.trigger(Vtiger_Edit_Js.referenceDeSelectionEvent);
			e.preventDefault();
		})
	},
	registerLineItemAutoComplete : function(container) {
		var thisInstance = this;
		if(typeof container == 'undefined') {
			container = thisInstance.getLineItemContentsContainer();
		}
		container.find('input.autoComplete').autocomplete({
			'minLength' : '3',
			'source' : function(request, response){
				//element will be array of dom elements
				//here this refers to auto complete instance
				var inputElement = jQuery(this.element[0]);
				var tdElement = inputElement.closest('td');
				var searchValue = request.term;
				var params = {};
				var searchModule = tdElement.find('.lineItemPopup').data('moduleName');
				params.search_module = searchModule
				params.search_value = searchValue;
				var modulename = app.getModuleName();
				console.log(tdElement);
				if(modulename == 'PickingSlip'){
					var projectid = jQuery("input[name*='projectid']").val();
					if(projectid == ''){
						bootbox.alert("Please select project.");
						tdElement.removeClass("ui-autocomplete-loading");
						return false;
					}
					params.projectid = projectid;
				}
				thisInstance.searchModuleNames(params).then(function(data){
					var reponseDataList = new Array();
					var serverDataFormat = data.result
					if(serverDataFormat.length <= 0) {
						serverDataFormat = new Array({
							'label' : app.vtranslate('JS_NO_RESULTS_FOUND'),
							'type'  : 'no results'
						});
					}
					for(var id in serverDataFormat){
						var responseData = serverDataFormat[id];
						reponseDataList.push(responseData);
					}
					response(reponseDataList);
				});
			},
			'select' : function(event, ui ){
				var selectedItemData = ui.item;
				//To stop selection if no results is selected
				if(typeof selectedItemData.type != 'undefined' && selectedItemData.type=="no results"){
					return false;
				}
				var element = jQuery(this);
				element.attr('disabled','disabled');
				var tdElement = element.closest('td');
				var selectedModule = tdElement.find('.lineItemPopup').data('moduleName');
				var popupElement = tdElement.find('.lineItemPopup');
				var dataUrl = "index.php?module=Inventory&action=GetTaxes&record="+selectedItemData.id+"&currency_id="+jQuery('#currency_id option:selected').val();
				AppConnector.request(dataUrl).then(
					function(data){
						for(var id in data){
							if(typeof data[id] == "object"){
							var recordData = data[id];
							thisInstance.mapResultsToFields(selectedModule, popupElement, recordData);
							}
						}
					},
					function(error,err){

					}
				);
			},
			'change' : function(event, ui) {
				var element = jQuery(this);
				//if you dont have disabled attribute means the user didnt select the item
				if(element.attr('disabled')== undefined) {
					element.closest('td').find('.clearLineItem').trigger('click');
				}
			}
		});
	},

	lineItemPopupEventHandler : function(popupImageElement) {
		var aDeferred = jQuery.Deferred();
		var thisInstance = this;
		var referenceModule = popupImageElement.data('moduleName');
		var moduleName = app.getModuleName();
		//thisInstance.getModulePopUp(e,referenceModule);
		var params = {};
		params.view = popupImageElement.data('popup');
		params.module = moduleName;
		params.multi_select = true;
		params.currency_id = jQuery('#currency_id option:selected').val();
		//Manasa added this oly products of project display
		if(moduleName == 'PickingSlip'){
			var projectid = jQuery("input[name*='projectid']").val();
			if(projectid == ''){
				bootbox.alert("Please select project.");
				return false;
			}
			params.projectid = jQuery("input[name*='projectid']").val();
		}
		//Manasa ended
		this.showPopup(params).then(function(data){
			var responseData = JSON.parse(data);
			var len = Object.keys(responseData).length;
			if(len >1 ){
				for(var i=0;i<len;i++){
					if(i == 0){
						thisInstance.mapResultsToFields(referenceModule,popupImageElement,responseData[i]);
					}else if(i >= 1 && (referenceModule == 'Products' || referenceModule == 'Services')){
						if(referenceModule == 'Products') {
							var row = jQuery('#addProduct').trigger('click');
						} else if(referenceModule == 'Services') {
							var row1 = jQuery('#addService').trigger('click');
						}
						//TODO : CLEAN :  we might synchronus invocation since following elements needs to executed once new row is created
						var newRow = jQuery('#lineItemTab > tbody > tr:last');
						var targetElem = jQuery('.lineItemPopup',newRow);
						thisInstance.mapResultsToFields(referenceModule,targetElem,responseData[i]);
						aDeferred.resolve();
					}
				}
			}else{
				thisInstance.mapResultsToFields(referenceModule,popupImageElement,responseData);
				aDeferred.resolve();
			}
		})
		return aDeferred.promise();
	},
	//manasa added this on sep 15 2016 ended here
	 /*
	  * Function which will register event for quantity change (focusout event)
	  */
	 registerQuantityChangeEventHandler : function() {
		var thisInstance = this;
		var lineItemTable = this.getLineItemContentsContainer();

		lineItemTable.on('focusout','.qty',function(e){
			var element = jQuery(e.currentTarget);
			var lineItemRow = element.closest('tr.'+thisInstance.rowClass);
			var quantityInStock = lineItemRow.data('quantityInStock');
			if(typeof quantityInStock  != 'undefined') {
				//Manasa added this on apr 5th 2017
				var modulename = app.getModuleName();
				if(modulename == 'PickingSlip'){
					var productsqty = jQuery.parseJSON(jQuery("#PROJECTPRODUCTDETAILS").attr('data-value'));
					var productid = lineItemRow.find('.selectedModuleId').val();
					var productnumber = lineItemRow.data('number');
					console.log(lineItemRow);
					
					var sentdata ={};
					sentdata.record = productid;//.id;
					sentdata.source_module = 'Products';
					var productno = '';
					thisInstance.getRecordDetails(sentdata).then(function(data){
						var response = data['result'];
						productno = response['data'].product_no;
						var pickingslipqty = 0;
						//console.log("QTY Actual "+quantityInStock + " "+productno + "productid"+productid);
						if(productsqty.hasOwnProperty(productno)){
							pickingslipqty = productsqty[productno];
							console.log("pickingslipqty "+pickingslipqty);
						}
						var displayinfo = "Please use qty less than or equal to "+pickingslipqty;
						if(parseFloat(element.val()) > parseFloat(pickingslipqty)) {
							lineItemRow.find('.stockAlert').removeClass('hide').find('.maxQuantity').html(displayinfo);
						}else{
							lineItemRow.find('.stockAlert').addClass('hide').find('.maxQuantity').html('');
						}
					},
					function(error, err){

					});					
				}
				//Manasa ended here
				else{		
					if(parseFloat(element.val()) > parseFloat(quantityInStock)) {
						lineItemRow.find('.stockAlert').removeClass('hide').find('.maxQuantity').text(quantityInStock);
					}else{
						lineItemRow.find('.stockAlert').addClass('hide');
					}
				}
			}
			thisInstance.quantityChangeActions(lineItemRow);
		});
	 },


	registerEvents: function(){
		this._super();
		this.registerEventForEnablingRecurrence();
		this.registerForTogglingBillingandShippingAddress();
		this.registerEventForCopyAddress();
		this.registerQuantityChangeEventHandler();
		$('#addService').hide();
	}
});

//Manasa added for pickling slip qty purpose

Vtiger_PositiveNumber_Validator_Js("Vtiger_GreaterThanPickingSlipQty_Validator_Js",{

	/**
	 *Function which invokes field validation
	 *@param accepts field element as parameter
	 * @return error if validation fails true on success
	 */
	invokeValidation: function(field, rules, i, options){

		var GreaterThanPickingSlipQty = new Vtiger_GreaterThanPickingSlipQty_Validator_Js();
		GreaterThanPickingSlipQty.setElement(field);
		var response = GreaterThanPickingSlipQty.validate();
		if(response != true){
			return GreaterThanPickingSlipQty.getError();
		}
	}

},{

	/**
	 * Function to validate the Positive Numbers and greater than zero value
	 * @return true if validation is successfull
	 * @return false if validation error occurs
	 */
	validate: function(){
		var fieldman = this.getElement();
		var response = this._super();
		if(response != true){
			return response;
		}else{
			var fieldValue = this.getFieldValue();
			console.log(fieldValue);
			if(fieldValue == 0){
				var errorInfo = app.vtranslate('JS_VALUE_SHOULD_BE_GREATER_THAN_ZERO');
				this.setError(errorInfo);
				return false;
			}
			var stockerror = fieldman.closest('td').find('.maxQuantity').html();
			if(stockerror != ''){
				this.setError(stockerror);
				return false;
			}
		}
		return true;
	}
});


