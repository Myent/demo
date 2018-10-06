/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Edit_Js("ProjectTask_Edit_Js",{},{ 
	
	//will be having class which is used to identify the rows
	rowClass : 'userslineItemRow',
	basicRow : false,
	rowSequenceHolder : false,
	registerWidthChangeEvent : function() { 
		var thisInstance = this;
		var Task_Budget_Dollars = jQuery('#ProjectTask_editView_fieldName_pcm_task_budget_dollars');
		var Task_Budget_Hours = jQuery('#ProjectTask_editView_fieldName_cf_842');
		var Hourly_Charges = jQuery('#ProjectTask_editView_fieldName_pcm_hourly_charges');	
		var Worked_Hours = jQuery('#ProjectTask_editView_fieldName_projecttaskhours');
		var Progress_in_Hours = jQuery('#ProjectTask_editView_fieldName_pcm_progress_hours');
		var Allotted_Dollars = jQuery('#ProjectTask_editView_fieldName_pcm_allotted_dollars');
		var Progress_in_Dollars = jQuery('#ProjectTask_editView_fieldName_pcm_progress_dollars');
		var Delay_days = jQuery('#ProjectTask_editView_fieldName_pcm_delay');
		var Related_Immediate_Parent = jQuery('#ProjectTask_editView_fieldName_pcm_parent_task_id');
		var pcm_task_ref_id = jQuery('#ProjectTask_editView_fieldName_pcm_task_ref_id');
		var pcm_active = jQuery('#ProjectTask_editView_fieldName_pcm_active');
		
		/* add Mode  
		Task_Budget_Dollars.val(0);
		Task_Budget_Hours.val(0);
		Hourly_Charges.val(0);
		Delay_days.val(0);
		Progress_in_Dollars.val(0);
		Progress_in_Hours.val(0);
		*/
		/* edit Mode */ 
		
		
		
		/* Default Mode */ 
		Progress_in_Dollars.attr('readonly', true);
		Progress_in_Hours.attr('readonly', true);
		Task_Budget_Hours.attr('readonly', true);
		Delay_days.attr('readonly', true);
		Related_Immediate_Parent.attr('readonly', true);
		pcm_task_ref_id.attr('readonly', true);
		pcm_active.attr('readonly', true);
		
		Worked_Hours.keyup(function(){
			Progress_in_Hours.val(function(){
				return  (( Worked_Hours.val() /  Task_Budget_Hours.val() )* 100).toFixed(2);
			});
		});
		
		Allotted_Dollars.keyup(function(){
			Progress_in_Dollars.val(function(){
				return  (( Allotted_Dollars.val() /  Task_Budget_Dollars.val() )* 100).toFixed(2);
			});
		});
		Hourly_Charges.keyup(function(){
			Task_Budget_Hours.val(function(){
				if((Task_Budget_Dollars.val() > 0 || Task_Budget_Dollars.val() != '') && Hourly_Charges.val() > 0){
					return (Task_Budget_Dollars.val() / Hourly_Charges.val()).toFixed(2);
				}else{ 
					return 0;
				}			 
			});
		});
		Task_Budget_Dollars.keyup(function(){  
			Task_Budget_Hours.val(function(){
				if((Task_Budget_Dollars.val() > 0 || Task_Budget_Dollars.val() != '') && Hourly_Charges.val() > 0){
					return (Task_Budget_Dollars.val() / Hourly_Charges.val()).toFixed(2);
				}else{ 
					return 0;
				}			 
			});
		});
		
		/* Load Tree in Edit Mode */
		var parentId = jQuery('#ProjectTask_editView_fieldName_pcm_parent_task_id').val();
		var record = jQuery('input[name="record"]').val();	
		if(parentId != ''){
			jQuery('#btnjsTreeProjectTasks').hide();
			thisInstance.callingTree();
		}
		/*Select Node*/
		jQuery('#task_tree_in_editer').on("select_node.jstree", function (e, data) { 
			/* alert("node_id: " + data.node.id); */
			var task_id = data.node.id;					
			if(parentId != '' && record == task_id){
				alert('Canot select Self Task.');
				/* jQuery("#task_tree_in_editer").jstree("select_node", parentId); */
				jQuery('#ProjectTask_editView_fieldName_pcm_parent_task_id').val('');
			}else{ 
				jQuery('#ProjectTask_editView_fieldName_pcm_parent_task_id').val(task_id);
			}	
		}); 
	},
	
	registerJsTree : function(){
		var thisInstance = this;
		jQuery('#btnjsTreeProjectTasks').on('click',function(){  
			thisInstance.callingTree();
		});
	},
	
	callingTree : function(){
		var projectid = jQuery('input[name="projectid"]').val();
		if(projectid == ''){
			alert('Please Select "Related To" Field. ');
			return false;
		} 
		var parentId = jQuery('#ProjectTask_editView_fieldName_pcm_parent_task_id').val();		
		if(parentId != ''){
			jQuery("#task_tree_in_editer").jstree("select_node", parentId); 
		}
		
		jQuery('#task_tree_in_editer').jstree({ 
			'plugins' : [  'types', 'state', 'grid','sort','themes','contextmenu','search' ],
			 
			'core' : {
				  'data' : {
					"url" : "index.php?module=ProjectTask&action=AjaxTree&mode=getJsTreeForProjectTask&projectid="+projectid,
					"dataType" : "json" 
				  }
				},		 	
			 
			"search" : { "show_only_matches" : false},
			'types' : {	
					'#' : {
						
						},
					'root' : {
						  'icon' : 'jstree-file',
						  'valid_children' : ['default']
						},			
					'default' : { 'valid_children' : ['default','file'] },
					'file' : { 'icon' : 'jstree-file' }
				},
				'grid': {
					'columns': [
						{ 'width':'20%','header': "Project Task Name" },				  
						{ 'width':'10%','header': "Type",'value': "type" },				  
						{ 'width':'10%','header': "Assigned To",'value': "user" },				  
						{ 'width':'10%','header': "Budget",'value': "Budget" },	
						{ 'width':'5%','header': "Task Hours",'value': "Task_Hours" },	
						{ 'width':'5%','header': "Pro.H",'value': "Progress_in_Hours" },	
						{ 'width':'5%','header': "Pro.A D",'value': "Progress_Allotted_Dollars" },	
						{ 'width':'10%','header': "Start Date",'value': "startdate" },
						{ 'width':'10%','header': "End Date",'value': "enddate" },
						{ 'width':'8%','header': "Delay",'value': "delay" }		
					  
					],
					resizable:true 
				}		
				
			});/*on("select_node.jstree",
				function(evt, data){
									
				}
			); */
	},

	registerAddingUserProjectTask: function(){
		var thisInstance = this;
		var lineItemTable = jQuery("#userinfotable");
		var usernameslist = jQuery.parseJSON(jQuery("#ACCESSIBLE_USER_LIST").val());
		var groupnameslist = jQuery.parseJSON(jQuery("#ACCESSIBLE_GROUP_LIST").val());
		var mergelist =  jQuery.extend(usernameslist,groupnameslist);
	
		jQuery("#pcm_assignee").on('change',function(e){  
			if(jQuery('#pcm_assignee').val() != null){
				var userslist = jQuery('#pcm_assignee').val();
				jQuery.each(userslist,function(k,v){
					var userid = jQuery("#task_userid"+v).val();
					if(userid != v){
						var newRow = thisInstance.getBasicRow().addClass(thisInstance.rowClass);
						newRow = newRow.appendTo(lineItemTable);
						thisInstance.updateLineItemsElementWithSequenceNumber(newRow,v);
						
						if(v in mergelist){
							jQuery("#task_username"+v).html(mergelist[v]);
						}
						jQuery("#task_userid"+v).val(v);
						console.log(v);
						/* jQuery("#idNotification"+v).val(v); */
					}
				});
		
				var userids = jQuery.map( mergelist, function( value, key ) {
				  return key;
				});
				
				var unique = userids.concat(userslist).filter(function (item, index, array) {
                       return array.indexOf(item) == array.lastIndexOf(item);
                   })
				   
				jQuery.each(unique , function(k,v){
					jQuery("#userrow"+v).remove();
				});
				
			}else{
				jQuery("#Userinfoblock").html(" ");
			}			
		});
    },
	loadRowSequenceNumber: function() {
		if(this.rowSequenceHolder == false) {
			this.rowSequenceHolder = jQuery('.' + this.rowClass, this.getLineItemContentsContainer()).length;
		}
		return this;
    },

	getNextLineItemRowNumber : function() {
		if(this.rowSequenceHolder == false){
			this.loadRowSequenceNumber();
		}
		return ++this.rowSequenceHolder;
	},
	/**
	 * Function that is used to get the line item container
	 * @return : jQuery object
	 */
	getLineItemContentsContainer : function() {
		if(this.lineItemContentsContainer == false) {
			this.setLineItemContainer(jQuery('#userinfotable'));
		}
		return this.lineItemContentsContainer;
	},

	/**
	 * Function to set line item container
	 * @params : element - jQuery object which represents line item container
	 * @return : current instance ;
	 */
	setLineItemContainer : function(element) {
		this.lineItemContentsContainer = element;
		return this;
	},

	/**
	 * Function which will return the basic row which can be used to add new rows
	 * @return jQuery object which you can use to
	 */
	getBasicRow : function() {
		var thisInstance = this;
		if(this.basicRow == false){
			var lineItemTable = thisInstance.getLineItemContentsContainer();;//jQuery("#userinfotable");
			this.basicRow = jQuery('.userslineItemCloneCopy',lineItemTable)
		}
		var newRow = this.basicRow.clone(true,true);
		return newRow.removeClass('hide userslineItemCloneCopy');
	},
	updateLineItemsElementWithSequenceNumber : function(lineItemRow,expectedSequenceNumber , currentSequenceNumber){
		if(typeof currentSequenceNumber == 'undefined') {
			//by default there will zero current sequence number
			currentSequenceNumber = 0;
		}

		var idFields = new Array('task_userid','task_username','task_startdate','task_enddate','task_allocatedhours','task_workedhours','task_status','taskstatus','notification');
		var expectedRowId = 'userrow'+expectedSequenceNumber;
		for(var idIndex in idFields ) {
			var elementId = idFields[idIndex];
			var actualElementId = elementId + currentSequenceNumber;
			var expectedElementId = elementId + expectedSequenceNumber;
			lineItemRow.find('#'+actualElementId).attr('id',expectedElementId)
					   .filter('[name="'+actualElementId+'"]').attr('name',expectedElementId);
		}
		lineItemRow.find('select').addClass('chzn-select');
		app.changeSelectElementView(lineItemRow);
		app.registerEventForDatePickerFields(lineItemRow);
		//manasa for employee list
		//manasa 
		return lineItemRow.attr('id',expectedRowId);
	},
	//Validation purpose department,Category

	registerEvents : function() {
        this._super();
		this.registerAddingUserProjectTask();
		this.registerWidthChangeEvent(); 
		this.registerJsTree(); 
		this.getLineItemContentsContainer();
	}
});
