/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Settings_Vtiger_List_Js("Settings_OS2ForensicView_List_Js",{},{
    
	registerFilterChangeEvent : function() {
		var thisInstance = this;
		jQuery('#usersFilter').on('change',function(e){
			jQuery('#pageNumber').val("1");
			jQuery('#pageToJump').val('1');
			jQuery('#orderBy').val('');
			jQuery("#sortOrder").val('');
			var startdate = jQuery("#startdate").val();
			var enddate = jQuery("#enddate").val();
			var params = {
				module : app.getModuleName(),
				parent : app.getParentModuleName(),
				'search_key' : 'user_name',
				'search_value' : jQuery(e.currentTarget).val(),
				'page' : 1,
				'startdate' : startdate,
				'enddate' : enddate,
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

		jQuery('#startdate').on('change',function(e){
			var startdate = jQuery("#startdate").val();
			var enddate = jQuery("#enddate").val();
			var search_value = jQuery('#usersFilter').val();
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
				'startdate' : startdate,
				'enddate' : enddate,
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
			var user_name = jQuery("#usersFilter option:selected").text();
			var params = {
				module : app.getModuleName(),
				parent : app.getParentModuleName(),
				'search_key' : 'user_name',
				'search_value' : search_value,
				'page' : 1,
				'startdate' : startdate,
				'enddate' : enddate,
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

	/*
	 * Function to register List view Page Navigation
	 */
	registerPageNavigationEvents : function(){
		var aDeferred = jQuery.Deferred();
		var thisInstance = this;
		jQuery('#listViewNextPageButton').on('click',function(){
			var pageLimit = jQuery('#pageLimit').val();
			var noOfEntries = jQuery('#noOfEntries').val();
			if(noOfEntries == pageLimit){
				var orderBy = jQuery('#orderBy').val();
				var sortOrder = jQuery("#sortOrder").val();
				var cvId = thisInstance.getCurrentCvId();
				var startdate = jQuery("#startdate").val();
				var enddate = jQuery("#enddate").val();
				var search_value = jQuery('#usersFilter').val();
				var user_name = jQuery("#usersFilter option:selected").text();
				var urlParams = {
					"orderby": orderBy,
					"sortorder": sortOrder,
					'search_key' : 'user_name',
					'search_value' : search_value,
					"viewname": cvId,
					'startdate' : startdate,
					'enddate' : enddate,
					'user_name' :user_name
				}
				var pageNumber = jQuery('#pageNumber').val();
				var nextPageNumber = parseInt(parseFloat(pageNumber)) + 1;
				jQuery('#pageNumber').val(nextPageNumber);
				jQuery('#pageToJump').val(nextPageNumber);
				thisInstance.getListViewRecords(urlParams).then(
					function(data){
						thisInstance.updatePagination();
						aDeferred.resolve();
					},

					function(textStatus, errorThrown){
						aDeferred.reject(textStatus, errorThrown);
					}
				);
			}
			return aDeferred.promise();
		});
		jQuery('#listViewPreviousPageButton').on('click',function(){
			var aDeferred = jQuery.Deferred();
			var pageNumber = jQuery('#pageNumber').val();
			if(pageNumber > 1){
				var orderBy = jQuery('#orderBy').val();
				var sortOrder = jQuery("#sortOrder").val();
				var cvId = thisInstance.getCurrentCvId();
				var startdate = jQuery("#startdate").val();
				var enddate = jQuery("#enddate").val();
				var search_value = jQuery('#usersFilter').val();
				var user_name = jQuery("#usersFilter option:selected").text();
				var urlParams = {
					"orderby": orderBy,
					"sortorder": sortOrder,
					'search_key' : 'user_name',
					'search_value' : search_value,
					"viewname": cvId,
					'startdate' : startdate,
					'enddate' : enddate,
					'user_name' :user_name
				}
				var previousPageNumber = parseInt(parseFloat(pageNumber)) - 1;
				jQuery('#pageNumber').val(previousPageNumber);
				jQuery('#pageToJump').val(previousPageNumber);
				thisInstance.getListViewRecords(urlParams).then(
					function(data){
						thisInstance.updatePagination();
						aDeferred.resolve();
					},

					function(textStatus, errorThrown){
						aDeferred.reject(textStatus, errorThrown);
					}
				);
			}
		});

		jQuery('#listViewPageJump').on('click',function(e){
            if(typeof Vtiger_WholeNumberGreaterThanZero_Validator_Js.invokeValidation(jQuery('#pageToJump'))!= 'undefined') {
                var pageNo = jQuery('#pageNumber').val();
                jQuery("#pageToJump").val(pageNo);
            }
			jQuery('#pageToJump').validationEngine('hideAll');
			var element = jQuery('#totalPageCount');
			var totalPageNumber = element.text();
			if(totalPageNumber == ""){
				var totalCountElem = jQuery('#totalCount');
				var totalRecordCount = totalCountElem.val();
				if(totalRecordCount != '') {
					var recordPerPage = jQuery('#pageLimit').val();
					if(recordPerPage == '0') recordPerPage = 1;
					pageCount = Math.ceil(totalRecordCount/recordPerPage);
					if(pageCount == 0){
						pageCount = 1;
					}
					element.text(pageCount);
					return;
				}
				element.progressIndicator({});
				thisInstance.getPageCount().then(function(data){
					var pageCount = data['result']['page'];
					totalCountElem.val(data['result']['numberOfRecords']);
					if(pageCount == 0){
						pageCount = 1;
					}
					element.text(pageCount);
					element.progressIndicator({'mode': 'hide'});
			});
		}
		})

		jQuery('#listViewPageJumpDropDown').on('click','li',function(e){
			e.stopImmediatePropagation();
		}).on('keypress','#pageToJump',function(e){
			if(e.which == 13){
				e.stopImmediatePropagation();
				var element = jQuery(e.currentTarget);
				var response = Vtiger_WholeNumberGreaterThanZero_Validator_Js.invokeValidation(element);
				if(typeof response != "undefined"){
					element.validationEngine('showPrompt',response,'',"topLeft",true);
				} else {
					element.validationEngine('hideAll');
					var currentPageElement = jQuery('#pageNumber');
					var currentPageNumber = currentPageElement.val();
					var newPageNumber = parseInt(jQuery(e.currentTarget).val());
					var totalPages = parseInt(jQuery('#totalPageCount').text());
					if(newPageNumber > totalPages){
						var error = app.vtranslate('JS_PAGE_NOT_EXIST');
						element.validationEngine('showPrompt',error,'',"topLeft",true);
						return;
					}
					if(newPageNumber == currentPageNumber){
						var message = app.vtranslate('JS_YOU_ARE_IN_PAGE_NUMBER')+" "+newPageNumber;
						var params = {
							text: message,
							type: 'info'
						};
						Vtiger_Helper_Js.showMessage(params);
						return;
					}
					currentPageElement.val(newPageNumber);
					thisInstance.getListViewRecords().then(
						function(data){
							thisInstance.updatePagination();
							element.closest('.btn-group ').removeClass('open');
						},
						function(textStatus, errorThrown){
						}
					);
				}
				return false;
			}
		});
	},
	
	getDefaultParams : function() {
		var pageNumber = jQuery('#pageNumber').val();
		var module = app.getModuleName();
		var parent = app.getParentModuleName();
		var startdate = jQuery("#startdate").val();
		var enddate = jQuery("#enddate").val();
		var params = {
			'module': module,
			'parent' : parent,
			'page' : pageNumber,
			'view' : "List",
			'user_name' : jQuery('select[id=usersFilter] option:selected').attr('name'),
			'search_key' : 'user_name',
			'search_value' : jQuery('#usersFilter').val(),
			'startdate' : startdate,
			'enddate' : enddate
		}

		return params;
	},
	
	/**
	 * Function to get Page Jump Params
	 */
	getPageJumpParams : function(){
		var module = app.getModuleName();
		var parent = app.getParentModuleName();
		var startdate = jQuery("#startdate").val();
		var enddate = jQuery("#enddate").val();
		var pageJumpParams = {
			'module' : module,
			'parent' : parent,
			'action' : "ListAjax",
			'mode' : "getPageCount",
			'search_value' : jQuery('#usersFilter').val(),
			'search_key' : 'user_name',
			'startdate' : startdate,
			'enddate' : enddate,
		}
		return pageJumpParams;
	},
	
	registerEvents : function() {
		this.registerFilterChangeEvent();
		this.registerPageNavigationEvents();
		this.registerEventForTotalRecordsCount();
	}
});

function forensicDetailView(id){
	var module = app.getModuleName();
	var parent = app.getParentModuleName();
	
	if(id != 0 || id != ''){
		var sentdata ={};
		sentdata.module ='OS2ForensicView';
		sentdata.parent = 'Settings';
		sentdata.id = id;
		sentdata.action = 'ListAjax';
		sentdata.mode = 'getForensicUpdates';
		AppConnector.request(sentdata).then(
			function(data1){
				if(data1.length != 0){
					var li = "";
					jQuery.each(data1, function(index, item) {
						if(item.prevalue == ''){
							var prevalue = 'NULL';
						}else{
							var prevalue = item.prevalue;
						}
						li += '<li><div><span><strong>'+item.user_name+'</strong> updated on <strong>'+item.changedon+'</strong></span><span class="pull-right"><p class="muted"><small title='+item.changedon+'></small></p></span></div><div class="font-x-small updateInfoContainer"><i>'+item.fieldname+'</i> :&nbsp;&nbsp;from <b style="white-space:pre;">'+prevalue+'</b>&nbsp;To&nbsp;<b style="white-space:pre;">'+item.postvalue+'"</b></div></li>';
					});
					jQuery("#updates").html(li);
					jQuery("#myModal").modal("show");
				}
			}
		);
	}
}