/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
Vtiger_Edit_Js("Calendar_Edit_Js",{

	instance : {}

},{

	currentInstance : false,

	eventsContainer : false,
	formElement		: false,

	init : function() {
		var statusToProceed = this.proceedRegisterEvents();
		if(!statusToProceed){
			return;
		}
		this.initiate();
	},
	/**
	 * Function to get the container which holds all the reports elements
	 * @return jQuery object
	 */
	getContainer : function() {
		return this.eventsContainer;
	},

	/**
	 * Function to set the reports container
	 * @params : element - which represents the reports container
	 * @return : current instance
	 */
	setContainer : function(element) {
		this.eventsContainer = element;
		return this;
	},


	/*
	 * Function to return the instance based on the step of the report
	 */
	getInstance : function(step) {
		if(step in Calendar_Edit_Js.instance ){
		 if(step == 2){
			var view = app.getViewName();
			var moduleClassName = app.getModuleName()+"_"+view+step+"_Js";
			Calendar_Edit_Js.instance[step] =  new window[moduleClassName]();
			return Calendar_Edit_Js.instance[step]
		   }else{
			return Calendar_Edit_Js.instance[step];
		   }
		} else {
            var view = app.getViewName();
			var moduleClassName = app.getModuleName()+"_"+view+step+"_Js";
			console.log(moduleClassName);
			Calendar_Edit_Js.instance[step] =  new window[moduleClassName]();
			return Calendar_Edit_Js.instance[step]
		}
	},

	/*
	 * Function to get the value of the step
	 * returns 1 or 2 or 3
	 */
	getStepValue : function(){
		var container = this.currentInstance.getContainer();
		return jQuery('.step',container).val();
	},

	/*
	 * Function to initiate the step 1 instance
	 */
	initiate : function(container){
		if(typeof container == 'undefined') {
			container = jQuery('.eventContents');
		}
		if(container.is('.eventContents')) {
			this.setContainer(container);
		}else{
			this.setContainer(jQuery('.eventContents',container));
		}
		this.initiateStep('1');
		this.currentInstance.registerEvents();
	},
	/*
	 * Function to initiate all the operations for a step
	 * @params step value
	 */
	initiateStep : function(stepVal) {
		var step = 'step'+stepVal;
		this.activateHeader(step);
		var currentInstance = this.getInstance(stepVal);
		this.currentInstance = currentInstance;
	},

	/*
	 * Function to activate the header based on the class
	 * @params class name
	 */
	activateHeader : function(step) {
		var headersContainer = jQuery('.crumbs');
		headersContainer.find('.active').removeClass('active');
		jQuery('#'+step,headersContainer).addClass('active');
	},
	/*
	 * Function to register the click event for next button
	 */
	registerFormSubmitEvent : function(form) {
		var thisInstance = this;
		if(jQuery.isFunction(thisInstance.currentInstance.submit)){
			form.on('submit',function(e){
				var form = jQuery(e.currentTarget);
				var recurringCheck = form.find('input[name="recurringcheck"]').is(':checked');
				//If the recurring check is not enabled then recurring type should be --None--
				if(recurringCheck == false) {
					jQuery('#recurringType').append(jQuery('<option value="--None--">None</option>')).val('--None--');
				}
				var stepVal = thisInstance.getStepValue();
				var nextStepVal = parseInt(stepVal) + 1;
				if(thisInstance.isEvents() && nextStepVal == 3) {
					jQuery('<input type="hidden" name="contactidlist" /> ').appendTo(form).val(thisInstance.getRelatedContactElement().val().split(',').join(';'));
					form.find('[name="contact_id"]').attr('name','');
					var inviteeIdsList = jQuery('#selectedUsers').val();
					if(inviteeIdsList != null) {
						inviteeIdsList = jQuery('#selectedUsers').val().join(';')
					}
					jQuery('<input type="hidden" name="inviteesid" />').appendTo(form).val(inviteeIdsList);
				}
				var specialValidation = true;
				if(jQuery.isFunction(thisInstance.currentInstance.isFormValidate)){
					var specialValidation =  thisInstance.currentInstance.isFormValidate();
				}
				if (form.validationEngine('validate') && specialValidation) {
					thisInstance.currentInstance.submit().then(function(data){
						thisInstance.getContainer().append(data);
						var stepVal = thisInstance.getStepValue();
						var nextStepVal = parseInt(stepVal) + 1;
						thisInstance.initiateStep(nextStepVal);
						thisInstance.currentInstance.initialize();
						var container = thisInstance.currentInstance.getContainer();
						thisInstance.registerFormSubmitEvent(container);
						app.changeSelectElementView(container);
						thisInstance.currentInstance.registerEvents();
					});
				}
				e.preventDefault();
			})
		}
	},

	back : function(){
		var step = this.getStepValue();
		var prevStep = parseInt(step) - 1;
		this.currentInstance.initialize();
		var container = this.currentInstance.getContainer();
		container.remove();
		this.initiateStep(prevStep);
		this.currentInstance.getContainer().show();
	},

	/*
	 * Function to register the click event for back step
	 */
	registerBackStepClickEvent : function(){
		var thisInstance = this;
		var container = this.getContainer();
		container.on('click','.backStep',function(e){
			thisInstance.back();
		});
	},
	proceedRegisterEvents : function(){
		if(jQuery('.eventEditView').length > 0){
			return true;
		}else{
			return false;
		}
	},
	getForm : function() {
		if(this.formElement == false){
			this.setForm(jQuery('.eventEditView'));
		}
		return this.formElement;
	},

	/**
	 * Function which will register change event on recurrence field checkbox
	 */
	registerRecurrenceFieldCheckBox : function() {
		var thisInstance = this;
		thisInstance.getForm().find('input[name="recurringcheck"]').on('change', function(e) {
			var element = jQuery(e.currentTarget);
			var repeatUI = jQuery('#repeatUI');
			if(element.is(':checked')) {
				thisInstance.getForm().find('input[name="recurringcheck"]').val("Yes");
				repeatUI.show();
			} else {
				thisInstance.getForm().find('input[name="recurringcheck"]').val("");
				repeatUI.hide();
			}
		});
	},
	
	/**
	 * Function which will register the change event for recurring type
	 */
	registerRecurringTypeChangeEvent : function() {
		var thisInstance = this;
		jQuery('#recurringType').on('change', function(e) {
			var currentTarget = jQuery(e.currentTarget);
			var recurringType = currentTarget.val();
			thisInstance.changeRecurringTypesUIStyles(recurringType);
			
		});
	},
	
	/**
	 * Function which will register the change event for repeatMonth radio buttons
	 */
	registerRepeatMonthActions : function() {
		var thisInstance = this;
		thisInstance.getForm().find('input[name="repeatMonth"]').on('change', function(e) {
			//If repeatDay radio button is checked then only select2 elements will be enable
			thisInstance.repeatMonthOptionsChangeHandling();
		});
	},
	
	
	/**
	 * Function which will change the UI styles based on recurring type
	 * @params - recurringType - which recurringtype is selected
	 */
	changeRecurringTypesUIStyles : function(recurringType) {
		var thisInstance = this;
		if(recurringType == 'Daily' || recurringType == 'Yearly') {
			jQuery('#repeatWeekUI').removeClass('show').addClass('hide');
			jQuery('#repeatMonthUI').removeClass('show').addClass('hide');
		} else if(recurringType == 'Weekly') {
			jQuery('#repeatWeekUI').removeClass('hide').addClass('show');
			jQuery('#repeatMonthUI').removeClass('show').addClass('hide');
		} else if(recurringType == 'Monthly') {
			jQuery('#repeatWeekUI').removeClass('show').addClass('hide');
			jQuery('#repeatMonthUI').removeClass('hide').addClass('show');
		}
	},
	
	/**
	 * This function will handle the change event for RepeatMonthOptions
	 */
	repeatMonthOptionsChangeHandling : function() {
		//If repeatDay radio button is checked then only select2 elements will be enable
			if(jQuery('#repeatDay').is(':checked')) {
				jQuery('#repeatMonthDate').attr('disabled', true);
				jQuery('#repeatMonthDayType').select2("enable");
				jQuery('#repeatMonthDay').select2("enable");
			} else {
				jQuery('#repeatMonthDate').removeAttr('disabled');
				jQuery('#repeatMonthDayType').select2("disable");
				jQuery('#repeatMonthDay').select2("disable");
			}
	},
registerReminderFieldCheckBox : function() {
		this.getForm().find('input[name="set_reminder"]').on('change', function(e) {
			var element = jQuery(e.currentTarget);
			var closestDiv = element.closest('div').next();
			if(element.is(':checked')) {
				closestDiv.show();
			} else {
				closestDiv.hide();
			}
		})
	},
	/**
	 * Function to register the event status change event
	 */
	registerEventStatusChangeEvent : function(container){
		var followupContainer = container.find('.followUpContainer');
		//if default value is set to Held then display follow up container
		var defaultStatus = container.find('select[name="eventstatus"]').val();
		if(defaultStatus == 'Held'){
			followupContainer.show();
		}
		container.find('select[name="eventstatus"]').on('change',function(e){
			var selectedOption = jQuery(e.currentTarget).val();
			if(selectedOption == 'Held'){
				followupContainer.show();
			} else{
				followupContainer.hide();
			}
		});
	},

	getPopUpParams : function(container) {
		var params = {};
		var sourceModule = app.getModuleName();
		var popupReferenceModule = jQuery('input[name="popupReferenceModule"]',container).val();
		var sourceFieldElement = jQuery('input[class="sourceField"]',container);
		var sourceField = sourceFieldElement.attr('name');
		var sourceRecordElement = jQuery('input[name="record"]');
		var sourceRecordId = '';
		if(sourceRecordElement.length > 0) {
			sourceRecordId = sourceRecordElement.val();
		}

		var isMultiple = false;
		if(sourceFieldElement.data('multiple') == true){
			isMultiple = true;
		}

		var params = {
			'module' : popupReferenceModule,
			'src_module' : sourceModule,
			'src_field' : sourceField,
			'src_record' : sourceRecordId
		}

		if(isMultiple) {
			params.multi_select = true ;
		}
		return params;
	},

//getPopUpParams,
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

			if(isMultiple) {
                    sourceFieldElement.trigger(Vtiger_Edit_Js.refrenceMultiSelectionEvent,{'data':dataList});
			}
                sourceFieldElement.trigger(Vtiger_Edit_Js.postReferenceSelectionEvent,{'data':responseData});
		});
	},

	setReferenceFieldValue : function(container, params) {
		var sourceField = container.find('input[class="sourceField"]').attr('name');
		var fieldElement = container.find('input[name="'+sourceField+'"]');
		var sourceFieldDisplay = sourceField+"_display";
		var fieldDisplayElement = container.find('input[name="'+sourceFieldDisplay+'"]');
		var popupReferenceModule = container.find('input[name="popupReferenceModule"]').val();

		var selectedName = params.name;
		var id = params.id;

		fieldElement.val(id)
		fieldDisplayElement.val(selectedName).attr('readonly',true);
		fieldElement.trigger(Vtiger_Edit_Js.referenceSelectionEvent, {'source_module' : popupReferenceModule, 'record' : id, 'selectedName' : selectedName});

		fieldDisplayElement.validationEngine('closePrompt',fieldDisplayElement);
	},
relatedContactElement : false,

    getRelatedContactElement : function() {
        if(this.relatedContactElement == false) {
            this.relatedContactElement =  jQuery('#contact_id_display');
        }
        return this.relatedContactElement;
    },
	isEvents : function() {
        var form = this.getForm();
        var moduleName = form.find('[name="module"]').val();
        if(moduleName == 'Events') {
            return true;
        }
        return false;
    },
 addNewContactToRelatedList : function(newContactInfo){
         var resultentData = new Array();
            var element =  jQuery('#contact_id_display');
            var selectContainer = jQuery(element.data('select2').containerSelector);
            var choices = selectContainer.find('.select2-search-choice');
            choices.each(function(index,element){
                resultentData.push(jQuery(element).data('select2-data'));
            });

            var select2FormatedResult = newContactInfo.data;
            for(var i=0 ; i < select2FormatedResult.length; i++) {
              var recordResult = select2FormatedResult[i];
              recordResult.text = recordResult.name;
              resultentData.push( recordResult );
            }
            jQuery('#contact_id_display').select2('data',resultentData);
    },
registerRelatedContactSpecificEvents : function() {
        var thisInstance = this;
		var form = this.getForm();
		
		form.find('[name="contact_id"]').on(Vtiger_Edit_Js.preReferencePopUpOpenEvent,function(e){
            var form = thisInstance.getForm();
            var parentIdElement  = form.find('[name="parent_id"]');
            var container = parentIdElement.closest('td');
            var popupReferenceModule = jQuery('input[name="popupReferenceModule"]',container).val();
            
            if(popupReferenceModule == 'Leads' && parentIdElement.val().length > 0) {
                e.preventDefault();
                Vtiger_Helper_Js.showPnotify(app.vtranslate('LBL_CANT_SELECT_CONTACT_FROM_LEADS'));
            }
        })
        //If module is not events then we dont have to register events
        if(!this.isEvents()) {
            return;
        }
        this.getRelatedContactElement().select2({
             minimumInputLength: 3,
             ajax : {
                'url' : 'index.php?module=Contacts&action=BasicAjax&search_module=Contacts',
                'dataType' : 'json',
                'data' : function(term,page){
                     var data = {};
                     data['search_value'] = term;
                     var parentIdElement  = form.find('[name="parent_id"]');
                     if(parentIdElement.val().length > 0) {
                        var closestContainer = parentIdElement.closest('td');
                        data['parent_id'] = parentIdElement.val();
                        data['parent_module'] = closestContainer.find('[name="popupReferenceModule"]').val();
                     }
                     return data;
                },
                'results' : function(data){
                    data.results = data.result;
                    for(var index in data.results ) {

                        var resultData = data.result[index];
                        resultData.text = resultData.label;
                    }
                    return data
                },
                 transport : function(params){
                    return jQuery.ajax(params);
                 }
             },
             multiple : true
        });
		
        //To add multiple selected contact from popup
        form.find('[name="contact_id"]').on(Vtiger_Edit_Js.refrenceMultiSelectionEvent,function(e,result){
            thisInstance.addNewContactToRelatedList(result);
        });
        
        this.fillRelatedContacts();
    },
/**
     * Function which will fill the already saved contacts on load 
     */
    fillRelatedContacts : function() {
        var form = this.getForm();
        var relatedContactValue = form.find('[name="relatedContactInfo"]').data('value');
        for(var contactId in relatedContactValue) {
            var info = relatedContactValue[contactId];
            info.text = info.name;
            relatedContactValue[contactId] = info;
        }
        this.getRelatedContactElement().select2('data',relatedContactValue);
    },
	
	/**
	 * Function to get reference search params
	 */
	getReferenceSearchParams : function(element){
		var tdElement = jQuery(element).closest('td');
		var contactField = tdElement.find('[name="contact_id"]');
		var params = {};
		if(contactField.length > 0){
			var form = this.getForm();
			var parentIdElement  = form.find('[name="parent_id"]');
			if(parentIdElement.val().length > 0) {
			   var closestContainer = parentIdElement.closest('td');
			   params['parent_id'] = parentIdElement.val();
			   params['parent_module'] = closestContainer.find('[name="popupReferenceModule"]').val();
			}
		}
		var searchModule = this.getReferencedModuleName(tdElement);
		params.search_module = searchModule;
		return params;
	},
	referenceCreateHandler : function(container) {
        var thisInstance = this;
		var form = thisInstance.getForm();
		var mode = jQuery(form).find('[name="module"]').val();
        if(container.find('.sourceField').attr('name') != 'contact_id'){
            this._super(container);
			return;
        }
         var postQuickCreateSave  = function(data) {
            var params = {};
            params.name = data.result._recordLabel;
            params.id = data.result._recordId;
			if(mode == "Calendar"){
				thisInstance.setReferenceFieldValue(container, params);
				return;
			}
            thisInstance.addNewContactToRelatedList({'data':[params]});
        }

        var referenceModuleName = this.getReferencedModuleName(container);
        var quickCreateNode = jQuery('#quickCreateModules').find('[data-name="'+ referenceModuleName +'"]');
        if(quickCreateNode.length <= 0) {
            Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_NO_CREATE_OR_NOT_QUICK_CREATE_ENABLED'))
        }
        quickCreateNode.trigger('click',{'callbackFunction':postQuickCreateSave});
    },

    registerClearReferenceSelectionEvent : function(container) {
        var thisInstance = this;
        this._super(container);

        this.getRelatedContactElement().closest('td').find('.clearReferenceSelection').on('click',function(e){
            thisInstance.getRelatedContactElement().select2('data',[]);
        });
    },
	
	proceedRegisterEvents : function(){
		if(jQuery('.eventEditView').length > 0){
			return true;
		}else{
			return false;
		}
	},

/**
	 * Function which will handle the reference auto complete event registrations
	 * @params - container <jQuery> - element in which auto complete fields needs to be searched
	 */
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
	 * Function which will register reference field clear event
	 * @params - container <jQuery> - element in which auto complete fields needs to be searched
	 */
	registerClearReferenceSelectionEvent : function(container) {
		container.find('.clearReferenceSelection').on('click', function(e){
			var element = jQuery(e.currentTarget);
			var parentTdElement = element.closest('td');
			var fieldNameElement = parentTdElement.find('.sourceField');
			var fieldName = fieldNameElement.attr('name');
			fieldNameElement.val('');
			parentTdElement.find('#'+fieldName+'_display').removeAttr('readonly').val('');
			element.trigger(Vtiger_Edit_Js.referenceDeSelectionEvent);
			e.preventDefault();
		})
	},

	registerEvents : function(){
		var module = jQuery('input[name*=moduleclass]').val();
		console.log(module);
		if(module == 'Events'){
			var statusToProceed = this.proceedRegisterEvents();
			console.log(statusToProceed);
			if(!statusToProceed){
				return;
			}
			var form = this.currentInstance.getContainer();
			this.registerFormSubmitEvent(form);
			this.registerBackStepClickEvent();
			//old calendar
			this.registerEventStatusChangeEvent(form);//Held Purpose
			this.registerReminderFieldCheckBox();
			this.registerRecurrenceFieldCheckBox();
			this.repeatMonthOptionsChangeHandling();
			this.registerRecurringTypeChangeEvent();
			this.registerRepeatMonthActions();
		}else{
			var todo = new Calendar_ToDo_Js();
			todo.registerEvents();
		}

		
	},
	//Aug 9th 2018
	registerBasicEvents : function(container) {
		this._super(container);
		this.registerRecordPreSaveEvent(container);
	},
	registerRecordPreSaveEvent : function(container){
		var thisInstance = this;		
		container.on(Vtiger_Edit_Js.recordPreSave, function(e, data) {			
				params = {};
				params.module = "Calendar";
				var module = container.find('[name="module"]').val();
				params.action = "CheckMeeting";
				params.assignedtouser = container.find("select[name='assigned_user_id'").val();
				params.date_start = container.find("input[name*='date_start']").val();
				params.time_start = container.find("input[name*='time_start']").val();
				params.due_date = container.find("input[name*='due_date']").val();
				params.time_end = container.find("input[name*='time_end']").val();
				console.log(module);
				//if(!(userName in thisInstance.duplicateCheckCache)) {
					AppConnector.request(params).then(function(recdata){
						var noofrecords = recdata['result'];						
						if(noofrecords == 0){
							container.find('button[type="submit"]').prop('disabled', true);
							container.closest('#globalmodal').find('.modal-header h3').progressIndicator({
								smallLoadingImage: true,
								imageContainerCss: {
									display: 'inline',
									'margin-left': '18%',
									position: 'absolute'
								}
							});
							thisInstance.quickCreateSave(container).then(
									function(data) {
										app.hideModalWindow();
										//fix for Refresh list view after Quick create 
										var parentModule=app.getModuleName(); 
										var viewname=app.getViewName(); 
										if((module == parentModule) && (viewname=="List")){ 
											var listinstance = new Vtiger_List_Js(); 
											listinstance.getListViewRecords();      
										}
										if(viewname == 'Detail'){
											Vtiger_Detail_Js.reloadRelatedList();
										}
										if(viewname == 'SharedCalendar' || viewname == 'Calendar'){
											window.location.reload();
										}
									},
									function(error, err) {
									}
							);
					
						}else{
							Vtiger_Helper_Js.showPnotify("Assigned To scheduled event that time.Please change time.");
						}
					});
				//}
			e.preventDefault();
		});
	},
	  quickCreateSave: function(form) {
        var aDeferred = jQuery.Deferred();
        var quickCreateSaveUrl = form.serializeFormData();
        AppConnector.request(quickCreateSaveUrl).then(
                function(data) {
                    //TODO: App Message should be shown
                    aDeferred.resolve(data);
                },
                function(textStatus, errorThrown) {
                    aDeferred.reject(textStatus, errorThrown);
                }
        );
        return aDeferred.promise();
    },
});

