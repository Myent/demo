/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Detail_Js("Project_Detail_Js",{},{
	
	detailViewRecentTicketsTabLabel : 'Trouble Tickets',
	detailViewRecentTasksTabLabel : 'Project Tasks',
	detailViewRecentMileStonesLabel : 'Project Milestones',
	
	/**
	 * Function to register event for create related record
	 * in summary view widgets
	 */
	registerSummaryViewContainerEvents : function(summaryViewContainer){
		this._super(summaryViewContainer);
		this.registerStatusChangeEventForWidget();
		this.registerEventForAddingModuleRelatedRecordFromSummaryWidget();
	},
	
	/**
	* Function to get records according to ticket status
	*/
	registerStatusChangeEventForWidget : function(){
		var thisInstance = this;
		jQuery('[name="ticketstatus"],[name="projecttaskstatus"],[name="projecttaskprogress"]').on('change',function(e){
            var picklistName = this.name;
			var statusCondition = {};
			var params = {};
			var currentElement = jQuery(e.currentTarget);
			var summaryWidgetContainer = currentElement.closest('.summaryWidgetContainer');
			var widgetDataContainer = summaryWidgetContainer.find('.widget_contents');
			var referenceModuleName = widgetDataContainer.find('[name="relatedModule"]').val();
			var recordId = thisInstance.getRecordId();
			var module = app.getModuleName();
			var selectedStatus = currentElement.find('option:selected').text();
			if(selectedStatus != "Select Status" && referenceModuleName == "HelpDesk"){
				statusCondition['vtiger_troubletickets.status'] = selectedStatus;
				params['whereCondition'] = statusCondition;
			} else if(selectedStatus != app.vtranslate('JS_LBL_SELECT_STATUS') && referenceModuleName == "ProjectTask" && picklistName == 'projecttaskstatus'){
				statusCondition['vtiger_projecttask.projecttaskstatus'] = selectedStatus;
				params['whereCondition'] = statusCondition;
			}
            else if(selectedStatus != app.vtranslate('JS_LBL_SELECT_PROGRESS') && referenceModuleName == "ProjectTask" && picklistName == 'projecttaskprogress'){
				statusCondition['vtiger_projecttask.projecttaskprogress'] = selectedStatus;
				params['whereCondition'] = statusCondition;
			}
			
			params['record'] = recordId;
			params['view'] = 'Detail';
			params['module'] = module;
			params['page'] = widgetDataContainer.find('[name="page"]').val();
			params['limit'] = widgetDataContainer.find('[name="pageLimit"]').val();
			params['relatedModule'] = referenceModuleName;
			params['mode'] = 'showRelatedRecords';
			AppConnector.request(params).then(
				function(data) {
					widgetDataContainer.html(data);
				}
			);
	   })
	},
	
	/**
	 * Function to add module related record from summary widget
	 */
	registerEventForAddingModuleRelatedRecordFromSummaryWidget : function(){
		var thisInstance = this;
		jQuery('#createProjectMileStone,#createProjectTask').on('click',function(e){
			var currentElement = jQuery(e.currentTarget);
			var summaryWidgetContainer = currentElement.closest('.summaryWidgetContainer');
			var widgetDataContainer = summaryWidgetContainer.find('.widget_contents');
			var referenceModuleName = widgetDataContainer.find('[name="relatedModule"]').val();
			var quickcreateUrl = currentElement.data('url');
			var parentId = thisInstance.getRecordId();
			var quickCreateParams = {};
			var relatedField = currentElement.data('parentRelatedField');
			var moduleName = currentElement.closest('.widget_header').find('[name="relatedModule"]').val();
			var relatedParams = {};
			relatedParams[relatedField] = parentId;
			
			var postQuickCreateSave = function(data) {
				thisInstance.postSummaryWidgetAddRecord(data,currentElement);
				if(referenceModuleName == "ProjectTask"){
					thisInstance.loadModuleSummary();
				}
			}
			
			if(typeof relatedField != "undefined"){
				quickCreateParams['data'] = relatedParams;
			}
			quickCreateParams['noCache'] = true;
			quickCreateParams['callbackFunction'] = postQuickCreateSave;
			var progress = jQuery.progressIndicator();
			var headerInstance = new Vtiger_Header_Js();
			headerInstance.getQuickCreateForm(quickcreateUrl, moduleName,quickCreateParams).then(function(data){
				headerInstance.handleQuickCreateData(data,quickCreateParams);
				progress.progressIndicator({'mode':'hide'});
			});
		})
	},
	
	/**
	 * Function to load module summary of Projects
	 */
	loadModuleSummary : function(){
		var summaryParams = {};
		summaryParams['module'] = app.getModuleName();
		summaryParams['view'] = "Detail";
		summaryParams['mode'] = "showModuleSummaryView";
		summaryParams['record'] = jQuery('#recordId').val();
		
		AppConnector.request(summaryParams).then(
			function(data) {
				jQuery('.summaryView').html(data);
			}
		);
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
		if(data['field'] == 'projectstatus' && data['value'] == 'completed'){
			bootbox.confirm("Record will lock once you save. You can't edit Status again.", function(result){ 
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
						if(fieldName == 'projectstatus' && response == "1"){
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
						if(fieldName == 'projectstatus' && fieldValue == "completed"){
							var recordId = thisInstance.getRecordId();
							var reloadurl = 'index.php?module=Project&view=Detail&record='+recordId;
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
	registerEvents : function(){
		var detailContentsHolder = this.getContentHolder();
		var thisInstance = this;
		this._super();
		
		detailContentsHolder.on('click','.moreRecentMilestones', function(){
			var recentMilestonesTab = thisInstance.getTabByLabel(thisInstance.detailViewRecentMileStonesLabel);
			recentMilestonesTab.trigger('click');
		});
		
		detailContentsHolder.on('click','.moreRecentTickets', function(){
			var recentTicketsTab = thisInstance.getTabByLabel(thisInstance.detailViewRecentTicketsTabLabel);
			recentTicketsTab.trigger('click');
		});
		
		detailContentsHolder.on('click','.moreRecentTasks', function(){
			var recentTasksTab = thisInstance.getTabByLabel(thisInstance.detailViewRecentTasksTabLabel);
			recentTasksTab.trigger('click');
		});
		jQuery(".showpopup").click(function(){
			var id = $(this).data("id").trim();
			var mode = "";
			var modal_title ="";
			if(id == "Pending Decision")
			{
				mode = "PendingDecision";
				modal_title = id+" Details";
			}
			if(id == "Pending Approval")
			{
				mode = "PendingApproval";
				modal_title = id+" Details";
			}
			if(id == "Task Completed")
			{
				mode = "TaskCompleted";
				modal_title = id+" Details";
			}
			if(id == "Total Time Spent")
			{
				mode = "TotalTimeSpent";
				modal_title = id+" Details";
			}
			var pfsummaryParams = {};
			pfsummaryParams['module'] = app.getModuleName();
			pfsummaryParams['view'] = "Pfwidgets";
			pfsummaryParams['mode'] = mode;
			pfsummaryParams['record'] = jQuery('#recordId').val();

			AppConnector.request(pfsummaryParams).then(
				function(pfdata) {
					jQuery(".modal-body").html(pfdata);
					jQuery(".modal-title").html(modal_title);
					jQuery("#myModal").modal("show");
				}
			);
		});
	}
})