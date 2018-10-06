/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Settings_Vtiger_List_Js("Settings_OS2LoginHistory_List_Js",{},{
    
	registerFilterChangeEvent : function() {
		var thisInstance = this;
		jQuery('#usersFilter').on('change',function(e){
			jQuery('#pageNumber').val("1");
			jQuery('#pageToJump').val('1');
			jQuery('#orderBy').val('');
			jQuery("#sortOrder").val('');
			jQuery('input[name=user_name]').val('');
			var startdate = jQuery("#startdate").val();
			var enddate = jQuery("#enddate").val();
			var user_status = jQuery("#user_status").val();
			if(jQuery(this).val() != ''){
				jQuery('input[name=user_name]').attr('disabled', 'disabled');
			}
			else{
				jQuery('input[name=user_name]').removeAttr('disabled');
			}
			var params = {
				module : app.getModuleName(),
				parent : app.getParentModuleName(),
				'search_key' : 'user_name',
				'search_value' : jQuery(e.currentTarget).val(),
				'page' : 1,
				'signintime' : startdate,
				'signouttime' : enddate,
				'status' : user_status,
                'user_name' :this.options[this.selectedIndex].getAttribute("name")

			}
			//Make total number of pages as empty
			jQuery('#totalPageCount').text("");
			thisInstance.getListViewRecords(params).then(
				function(data){
					thisInstance.updatePagination();
				}
			);
		});
		jQuery('#user_status').on('change',function(e){
			jQuery('#pageNumber').val("1");
			jQuery('#pageToJump').val('1');
			jQuery('#orderBy').val('');
			jQuery("#sortOrder").val('');
			var startdate = jQuery("#startdate").val();
			var enddate = jQuery("#enddate").val();
			var search_value = jQuery('#usersFilter').val();
			var user_status = jQuery("#user_status").val();
			var user_name = jQuery("#usersFilter option:selected").text();
			var params = {
				module : app.getModuleName(),
				parent : app.getParentModuleName(),
				'search_key' : 'user_name',
				'search_value' : search_value,
				'page' : 1,
				'signintime' : startdate,
				'signouttime' : enddate,
				'status' : user_status,
                'user_name' :user_name

			}
			//Make total number of pages as empty
			jQuery('#totalPageCount').text("");
			thisInstance.getListViewRecords(params).then(
				function(data){
					thisInstance.updatePagination();
				}
			);
		});
		jQuery('#startdate').on('change',function(e){
			var startdate = jQuery("#startdate").val();
			var enddate = jQuery("#enddate").val();
			var search_value = jQuery('#usersFilter').val();
			var user_status = jQuery("#user_status").val();
			var user_name = jQuery("#usersFilter option:selected").text();
			jQuery('#pageNumber').val("1");
			jQuery('#pageToJump').val('1');
			jQuery('#orderBy').val('');
			jQuery("#sortOrder").val('');
			
			var params = {
				module : app.getModuleName(),
				parent : app.getParentModuleName(),
				'search_key' : 'user_name',
				'search_value' : search_value,
				'page' : 1,
				'signintime' : startdate,
				'signouttime' : enddate,
				'status' : user_status,
                'user_name' :user_name

			}
			//Make total number of pages as empty
			jQuery('#totalPageCount').text("");
			thisInstance.getListViewRecords(params).then(
				function(data){
					thisInstance.updatePagination();
				}
			);
		});
		jQuery('#enddate').on('change',function(e){
		
			jQuery('#pageNumber').val("1");
			jQuery('#pageToJump').val('1');
			jQuery('#orderBy').val('');
			jQuery("#sortOrder").val('');
			var startdate = jQuery("#startdate").val();
			var enddate = jQuery("#enddate").val();
			var search_value = jQuery('#usersFilter').val();
			var user_status = jQuery("#user_status").val();
			var user_name = jQuery("#usersFilter option:selected").text();
			var params = {
				module : app.getModuleName(),
				parent : app.getParentModuleName(),
				'search_key' : 'user_name',
				'search_value' : search_value,
				'page' : 1,
				'signintime' : startdate,
				'signouttime' : enddate,
				'status' : user_status,
                'user_name' :user_name

			}
			//Make total number of pages as empty
			jQuery('#totalPageCount').text("");
			thisInstance.getListViewRecords(params).then(
				function(data){
					thisInstance.updatePagination();
				}
			);
		});		
		
	},
	
	getDefaultParams : function() {
		var pageNumber = jQuery('#pageNumber').val();
		var module = app.getModuleName();
		var parent = app.getParentModuleName();
		var username	=	jQuery('input[name=user_name]').val();
		  var userip	=	jQuery('input[name=user_ip]').val();
		  var signintime	=	jQuery('input[name=login_time]').val();
		  var signouttime	=	jQuery('input[name=logout_time]').val();
		  var status	=	jQuery('input[name=status]').val();
		var user_status = jQuery("#user_status").val();
		if(user_status != ''){
			var mestatus = user_status;
		}
		else{
			var mestatus = status;
		}
		var params = {
			'module': module,
			'parent' : parent,
			'page' : pageNumber,
			'view' : "List",
			'user_name' : jQuery('select[id=usersFilter] option:selected').attr('name'),
			'search_key' : 'user_name',
			'search_value' : jQuery('#usersFilter').val(),
			'search_user' : username,
			'userip' : userip,
			'signintime' : signintime,
			'signouttime' : signouttime,
			/*'status' : status*/
			'status' : mestatus
		}

		return params;
	},
	
	/**
	 * Function to get Page Jump Params
	 */
	getPageJumpParams : function(){
		var module = app.getModuleName();
		var parent = app.getParentModuleName();
		var username	=	jQuery('input[name=user_name]').val();
		  var userip	=	jQuery('input[name=user_ip]').val();
		  var signintime	=	jQuery('input[name=login_time]').val();
		  var signouttime	=	jQuery('input[name=logout_time]').val();
		var status	=	jQuery('input[name=status]').val();
		var user_status = jQuery("#user_status").val();
		if(user_status != ''){
			var mestatus = user_status;
		}
		else{
			var mestatus = status;
		}
		var pageJumpParams = {
			'module' : module,
			'parent' : parent,
			'action' : "ListAjax",
			'mode' : "getPageCount",
			'search_value' : jQuery('#usersFilter').val(),
			'search_key' : 'user_name',
			'search_user' : username,
			'userip' : userip,
			'signintime' : signintime,
			'signouttime' : signouttime,
			'status' : mestatus
			/*'status' : status*/
			
		}
		return pageJumpParams;
	},
	registerListSearch : function() {
      var thisInstance = this;
      //jQuery('[data-trigger="listSearch"]').on('click',function(e	){
      /*jQuery('.search_btn').on('click',function(e){
		  //var pageNumber = jQuery('#pageNumber').val();
		  var usersFilter =  jQuery('#usersFilter').val();
		  var user_name = jQuery("#usersFilter option:selected").text();
		  var username	=	jQuery('input[name=user_name]').val();
		  var userip	=	jQuery('input[name=user_ip]').val();
		  var signintime	=	jQuery('input[name=login_time]').val();
		  var signouttime	=	jQuery('input[name=logout_time]').val();
		  var status	=	jQuery('input[name=status]').val();
		  var pageNumber = jQuery('#pageNumber').val();
		  var currentLocation = window.location.href+'&user_name='+user_name+'&search_key=user_name&search_value='+usersFilter+'&search_user='+username+'&userip='+userip+'&signintime='+signintime+'&signouttime='+signouttime+'&status='+status;
		  window.location.href=currentLocation;
		 
		  
      })*/

      jQuery('input.listSearchContributor').on('keypress',function(e){
          if(e.keyCode == 13){
              var element = jQuery(e.currentTarget);
              var parentElement = element.closest('tr');
              var searchTriggerElement = parentElement.find('[data-trigger="listSearch"]');
              searchTriggerElement.trigger('click');
          }
      });
    },
	registerEvents : function() {
		
		this.registerListSearch();
		this.registerFilterChangeEvent();
		this.registerPageNavigationEvents();
		//console.log("manasa");
		this.registerEventForTotalRecordsCount();
	}
});
jQuery(document).ready(function(){
	/*var settingCountersInstance = new Settings_OS2LoginHistory_List_Js();
	settingCountersInstance.registerEvents();*/
	
	
});

