/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
Calendar_Edit_Js("Calendar_Edit2_Js",{},{

	step2Container : false,

	

	init : function() {
		this.initialize();
	},
	/**
	 * Function to get the container which holds all the report elements
	 * @return jQuery object
	 */
	getContainer : function() {
		return this.step2Container;
	},

	/**
	 * Function to set the report step2 container
	 * @params : element - which represents the report step2 container
	 * @return : current instance
	 */
	setContainer : function(element) {
		this.step2Container = element;
		return this;
	},

	

	/**
	 * Function  to intialize the reports step2
	 */
	initialize : function(container) {
		if(typeof container == 'undefined') {
			container = jQuery('#event_step2');
		}

		if(container.is('#event_step2')) {
			this.setContainer(container);
		}else{
			this.setContainer(jQuery('#event_step2'));
		}
	},



submit : function(){
		var thisInstance = this;
		var aDeferred = jQuery.Deferred();
		var form = this.getContainer();
		var formData = form.serializeFormData();
		var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});
		 
		AppConnector.request(formData).then(
				function(data) {
					form.hide();
					console.log("Hide inside request");
					progressIndicatorElement.progressIndicator({
						'mode' : 'hide'
					})
					aDeferred.resolve(data);
				},
				function(error,err){

				}
			);
			return aDeferred.promise();
	},
	
	registerInvtieeChange : function(){
		var thisInstance = this;
		jQuery('#selectedUsers').on('click', function(e) {
			var element = jQuery(e.currentTarget);
			thisInstance.updateUsers();
			
		});
	},
	updateUsers : function(){
		if(jQuery('#selectedUsers').val() != null){
			var thisInstance = this;
			var inviteeIdsList = jQuery('#selectedUsers').val().join(';');
				params = {};
				params.module = "Calendar";
				params.action = "MeetingUsers";
				params.inviteeusers = inviteeIdsList;
				params.date_start = jQuery("input[name*='date_start']").val();
				params.time_start = jQuery("input[name*='time_start']").val();
				params.due_date = jQuery("input[name*='due_date']").val();
				params.time_end = jQuery("input[name*='time_end']").val();
				params.record = jQuery("input[name*='record']").val();
				params.isDuplicate = jQuery("input[name*='isDuplicate']").val();
				var count = 0;
				AppConnector.request(params).then(function(data){
					var res = data['result'];
					var invdata = '';
					jQuery.each( res, function( key, value ) {
						//<a class='useradd'><i data-add = "+key+" >Add</i></a>&nbsp;/&nbsp; 
					  var action ="<a class='userdelete'><i  data-delete = "+key+">Delete</i></a>";
					  if(value.possible == 'Yes'){
						   var action = '';
					  }else{
						 count = count+1;
						 //console.log("count"+count);
					  }
					   invdata += "<tr><td>"+value.name+"</td><td>"+value.time_zone+"</td><td>"+value.possible+"<td>"+action+"</td></tr>";
					});
					jQuery("#inviteedata").html(invdata);
					jQuery("#nousers").val(count);
					thisInstance.unavailableUsers();
				});
		}else{
			jQuery("#inviteedata").html(" ");
			jQuery("#nousers").val(0);
		}

	},
	addInviteeUser : function(){
		var thisInstance = this;
		jQuery("#event_step2").on('click','.useradd', function(e) {
			var element = jQuery(e.currentTarget);
			var userid = element.find('i').data('add');
			
		});
	},
	unavailableUsers: function(){
		var nousers = jQuery("#nousers").val();
		if(nousers !=0 || nousers != ''){
			//bootbox.alert("Please delete users are not avilable for meeting at that specific time." );
			//return false;
		}
	},
	removeInviteeUser : function(){
		var thisInstance = this;
		jQuery("#event_step2").on('click','.userdelete', function(e) {
			var element = jQuery(e.currentTarget);
			var userid = element.find('i').data('delete');
			var users = jQuery("#selectedUsers").val();
			users = jQuery.grep(users, function(value) {
			  return value != userid;
			});
			jQuery("#selectedUsers").val(users).trigger('change');
			thisInstance.updateUsers();			
			thisInstance.unavailableUsers();
		});
	},
	checkAssignedUser: function(){
		params = {};
		params.module = "Calendar";
		params.action = "CheckMeeting";
		params.assignedtouser = jQuery("select[name='assigned_user_id'").val();
		params.date_start = jQuery("input[name*='date_start']").val();
		params.time_start = jQuery("input[name*='time_start']").val();
		params.due_date = jQuery("input[name*='due_date']").val();
		params.time_end = jQuery("input[name*='time_end']").val();
		params.record = jQuery("input[name*='record']").val();
		params.isDuplicate = jQuery("input[name*='isDuplicate']").val();
		AppConnector.request(params).then(function(data){
			var res = data['result'];
			if(res != 0 && res != ''){
				jQuery("#assignedtouserstatus").val("1");
				bootbox.alert("Assigned To schduled event that time.Please change time.");
				return false;
			}else{
				jQuery("#assignedtouserstatus").val(" ");
			}
		});
				
	},
	registerEvents : function(){
		var container = this.getContainer();
		//If the container is reloading, containers cache should be reset
		console.log(container);
		var thisInstance =this;
		app.changeSelectElementView(jQuery("#selectedUsers"),'select2');
		this.removeInviteeUser();
		this.addInviteeUser();
		this.checkAssignedUser();
		//PopupParams
		this.registerInvtieeChange();
		this.updateUsers();
		this.registerAutoCompleteFields(container);
		this.registerClearReferenceSelectionEvent(container);
		this.referenceModulePopupRegisterEvent(container);
		this.registerReferenceCreate(container);
		this.registerRelatedContactSpecificEvents();
		container.validationEngine({
			// to prevent the page reload after the validation has completed
			'onValidationComplete' : function(form,valid){
				var nousers = jQuery("#nousers").val();

				if(nousers != 0){
					bootbox.alert("Please delete users are not avilable for meeting at that specific time." );
					return false;
				}
				var assignedtouserstatus = jQuery("#assignedtouserstatus").val();
				if(assignedtouserstatus == 1){
					bootbox.alert("Assigned To schduled event that time.Please change time.");
					return false;
				}
				
                return valid;
			}
		});

	}
});


