/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/



jQuery.Class('Settings_OS2LoginHistory_Detail_Js', {}, {

getcounterlists : function() {
		var thisInstance = this;
		jQuery(document).click(function(e) {	
			var hd = jQuery("#listViewPageJumpDropDown").css("display");
			if (jQuery(event.target).closest('#listViewPageJumpDropDown').length) {
				jQuery("#listViewPageJumpDropDown").css({"display": "block"});
			}
			
			else{
				jQuery("#listViewPageJumpDropDown").css({"display": "none"});
			}
				
		});
		jQuery(document).ready(function(){	
			
			
			jQuery("#listViewPageJumpDropDown").css({"display": "none"});
			jQuery("#listViewPageJump").click(function(){
				jQuery("#listViewPageJumpDropDown").css({"display": "block"});
			});
			jQuery("#listViewNextPageButton").click(function(){
				var pagenumber = parseInt(jQuery("#pageToJump").val())+1;
				var recordid = jQuery("#recordid").val();
				var submodule = jQuery("#submodule").val();
				thisInstance.showIssuesList(pagenumber,recordid,submodule);
			});
			jQuery("#listViewPreviousPageButton").click(function(){
				var pagenumber = parseInt(jQuery("#pageToJump").val())-1;
				var recordid = jQuery("#recordid").val();
				var submodule = jQuery("#submodule").val();
				thisInstance.showIssuesList(pagenumber,recordid,submodule);
			});

			jQuery("#pageToJump").change(function(){	
				jQuery("#listViewPageJumpDropDown").css({"display": "none"});			
				var pagenumber = parseInt(jQuery("#pageToJump").val());
				var recordid = jQuery("#recordid").val();
				var submodule = jQuery("#submodule").val();
				thisInstance.showIssuesList(pagenumber,recordid,submodule);
			});
			
		});	
	},
	showIssuesList : function(page,recordid,submodule)
     {
		 var search_username	=	jQuery('input[name=search_username]').val();
		 var search_modulename	=	jQuery('input[name=search_modulename]').val();
		 var search_fieldname	=	jQuery('input[name=search_fieldname]').val();
		 var search_prevalue	=	jQuery('input[name=search_prevalue]').val();
		 var search_postvalue	=	jQuery('input[name=search_postvalue]').val();
		 var search_changedon	=	jQuery('input[name=search_changedon]').val();
			var params = {};
			params['module'] = 'OS2LoginHistory';
			params['parent'] = 'Settings';
			params['action'] = 'loginHistoryAjax';
			params['submodule'] = submodule;
			params["pagenumber"] = page;
			params["recordid"] = recordid;
			params["search_username"] = search_username;
			params["search_modulename"] = search_modulename;
			params["search_fieldname"] = search_fieldname;
			params["search_prevalue"] = search_prevalue;
			params["search_postvalue"] = search_postvalue;
			params["search_changedon"] = search_changedon;
			AppConnector.request(params).then( function(data) {
				var params = {};
				if(data.success){ 					
					var issuesObject = jQuery.parseJSON(data.result.result);
					jQuery(".login_table > tbody").empty();
					//jQuery(".login_table").append("<tr><td>"+'<input type="text" name="search_username" class="span1 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value =""/>' +"</td><td>"+'<input type="text" name="search_username" class="span1 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value =""/>'+"</td><td>"+'<input type="text" name="search_username" class="span1 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value =""/>'+"</td><td>"+'<input type="text" name="search_username" class="span1 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value =""/>'+"</td><td>"+'<input type="text" name="search_username" class="span1 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value =""/>'+"</td><td>"+'<input type="text" name="search_username" class="span1 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value =""/>'+"</td><td>"+'<button class="btn search_btn" data-trigger="listSearch">Search</button>'+"</td></tr>");				
					jQuery.each(issuesObject, function( index, value ) {
						if('id' in value){ 
							jQuery(".login_table").append("<tr><td>"+value.whodid+"</td><td>"+value.module+"</td><td>"+value.fieldname+"</td><td>"+value.prevalue+"</td><td>"+value.postvalue+"</td><td>"+value.changedon+"</td><td>"+' '+"</td></tr>");
						}else{
							console.log(value);
							jQuery("#pageToJump").val(page);
							//jQuery("#pageNumbersText").text(value.range.start+" to "+value.range.end);
							jQuery("#totalNumberOfRecords").text("of "+value.totalcount);
							jQuery("#totalPageCount").text(value.pageCount);
							if(value.prevPageExists){
								jQuery("#listViewPreviousPageButton").removeAttr("disabled");
							}else{
								jQuery("#listViewPreviousPageButton").attr("disabled",true);
							}
							if(value.nextPageExists){
								jQuery("#listViewNextPageButton").removeAttr("disabled");
							}else{
								jQuery("#listViewNextPageButton").attr("disabled",true);
							}
						}
					});			
				}
			}),
			function(error) {
			alert("Very serious error. Investigate!!");
		}

	},
	getModuleData : function(page){
			 jQuery("#picklistFilter").on('change',function(){
				var modulename = $(this).val();
				var url = window.location.href+ '&submodule='+modulename;
				window.location.href= url;
	});
},
	
	registerDetailSearch : function() {
      var thisInstance = this;
      jQuery('[data-trigger="listSearch"]').on('click',function(e){
		  var search_username	=	jQuery('input[name=search_username]').val();
		  var search_modulename	=	jQuery('input[name=search_modulename]').val();
		  var search_fieldname	=	jQuery('input[name=search_fieldname]').val();
		  var search_prevalue	=	jQuery('input[name=search_prevalue]').val();
		  var search_postvalue	=	jQuery('input[name=search_postvalue]').val();
		  var search_changedon	=	jQuery('input[name=search_changedon]').val();
		  var currentLocation = window.location.href+'&search_username='+search_username+'&search_modulename='+search_modulename+'&search_fieldname='+search_fieldname+'&search_prevalue='+search_prevalue+'&search_postvalue='+search_postvalue+'&search_changedon='+search_changedon;
		  window.location.href=currentLocation;
		  
      })

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
		this.showIssuesList(1);
		this.getcounterlists();
		this.getModuleData();
		this.registerDetailSearch();
	}
});
jQuery(document).ready(function(){
	var settingVTLoginHistoryInstance = new Settings_OS2LoginHistory_Detail_Js();
	settingVTLoginHistoryInstance.registerEvents();
	
})
