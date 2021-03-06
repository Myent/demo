/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Detail_Js("Contacts_Detail_Js",{},{
	
	/**
	 * Function to register recordpresave event
	 */
	registerRecordPreSaveEvent : function(form){
		var thisInstance = this;
		var primaryEmailField = jQuery('[name="email"]');
		if(typeof form == 'undefined') {
			form = this.getForm();
		}

		form.on(this.fieldPreSave,'[name="portal"]', function(e, data) {
			var portalField = jQuery(e.currentTarget);
			
			var primaryEmailValue = primaryEmailField.val();
			var isAlertAlreadyShown = jQuery('.ui-pnotify').length;
					
			
			if(portalField.is(':checked')){
				if(primaryEmailField.length == 0){
					if(isAlertAlreadyShown <= 0) {
						Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_PRIMARY_EMAIL_FIELD_DOES_NOT_EXISTS'));
					}
					e.preventDefault();
				} 
				if(primaryEmailValue == ""){
					if(isAlertAlreadyShown <= 0) {
						Vtiger_Helper_Js.showPnotify(app.vtranslate('JS_PLEASE_ENTER_PRIMARY_EMAIL_VALUE_TO_ENABLE_PORTAL_USER'));
					}
					e.preventDefault();
 				} 
			}
		})
	},
	
	/**
	 * Function which will register all the events
	 */
    registerEvents : function() {
		var form = this.getForm();
		this._super();
		this.registerRecordPreSaveEvent(form);
	}
})

/* vtDZiner code here for Detail View functions
	// 1. Panel Blocks
	// 2. Relatedfield value loading
	// 3. Pickblocks
	*/ 

	function showBlocksForPanel(paneltab){
		jQuery("#detailView").find("table").each(function(index, value){
			if (panelTabs[paneltab].indexOf(jQuery(this).data("tableforblock")) != -1) {
				jQuery(this).show();
				jQuery(this).next('br').removeClass("hide");
			} else {
				jQuery(this).hide();
				jQuery(this).next('br').addClass("hide");
			}
		});
	}

	// Getting the related fields on page and obtaining latest values
	// modified code from http://stackoverflow.com/questions/17546739/loop-through-nested-objects-with-jquery
	var path = "";
	var mypath = [];
	var allpaths =[];
	var aparams =[];
	function walker(key, value) {
		var savepath = path;
		path = path ? (path + "::||::" + key) : key;
		if (key=="fieldDataType" && value=="relatedfield"){
			//console.log(mypath);
			var fieldid=mypath.pop();
			var blockid=mypath.pop();
			mypath.push(blockid);
			mypath.push(fieldid);
			typeofdata = eval("vtRecordStructure[\""+blockid+"\"][\""+fieldid+"\"][\"typeofdata\"]").split(",");
			parentfieldid = typeofdata[0];
			parentfieldid = parentfieldid.split("=");
			parentfieldid = parentfieldid[1];
			relatedfieldid = typeofdata[1];
			relatedfieldid = relatedfieldid.split("=");
			relatedfieldid = relatedfieldid[1];
			tabid = typeofdata[2];
			tabid = tabid.split("=");
			tabid = tabid[1];
			parentfieldname = typeofdata[3];
			parentfieldname = parentfieldname.split("=");
			parentfieldname = parentfieldname[1];
			parentid = vtRecordModel["entity"]["column_fields"][parentfieldname];
			aparams.push([parentfieldid, tabid, parentid, fieldid, relatedfieldid]);
			var newpath=mypath.toString().split(",");
			allpaths.push(newpath);
		}
		if (value !== null && typeof value === "object") {
			// Recurse into children
			mypath.push(key);
			jQuery.each(value, walker);
			mypath.pop();
		}
		path = savepath;
	}

	jQuery(document).ready(function() {
		if (typeof(vtRecordStructure) !== 'undefined') {
			// Implementation of Pickblocks in DetailView
			// Loop the top level for related fields
			jQuery.each(vtRecordStructure, walker);

			// Getting the values of the linked record
			if (aparams.length > 0) {
				aparams.sort((function(index){
					return function(a, b){
						return (a[index] === b[index] ? 0 : (a[index] < b[index] ? -1 : 1));
					};
				})(0)); // 0 is the index to sort on

				params=JSON.stringify(aparams);
				var fieldsrequest = new XMLHttpRequest();
				//fieldsrequest.open('GET', 'modules/vtDZiner/getvalues.php?params='+params, false);  // `false` makes the request synchronous
				fieldsrequest.open('GET', 'index.php?module=vtDZiner&parent=Settings&sourceModule='+sourceModule+'&view=IndexAjax&mode=getRelatedValues&params='+params, false);  // `false` makes the request synchronous
				fieldsrequest.send(null);
				if (fieldsrequest.status === 200 && fieldsrequest.responseText != "") {
					var relatedvalues = eval("(" + fieldsrequest.responseText + ')');
					jQuery.each(relatedvalues, function(index, value){
						jQuery("#Products_detailView_fieldValue_"+index).find("span").first().html(value);
					});
				}
			}
			
			// Implementation of Pickblocks
			if (typeof multipickBlocks !== 'undefined') {
				if (Object.keys(multipickBlocks).length > 0) {
					var mn = app.getModuleName();
					jQuery.each(multipickBlocks, function(index, value){
					//	var modulename = app.getModuleName();
						//Accounts_detailView_fieldValue_accounttype
						pickkey = jQuery("#"+mn+"_detailView_fieldValue_"+index).find("span").first().html().trim();
						selectedBlockId = "";
						jQuery.each(value, function(i,e){
							jQuery.each(e,function(subk,subv){
								jQuery("#detailView").find("[data-id=\"" + subv + "\"]").closest('table').hide();
							});
							if (i == pickkey) {
								selectedBlockId=e;
							}
							jQuery.each(selectedBlockId,function(subk,subv){
								jQuery("#detailView").find("[data-id=\"" + subv + "\"]").closest('table').show();
							});
						});

						// set the onchange function
						jQuery("#"+mn+"_detailView_fieldValue_"+index).change(function(){
							selectedBlockId = "";
							selectedKey = jQuery(this).closest('td').attr('id').split(mn+"_detailView_fieldValue_")[1];
							pickkey = jQuery("#"+mn+"_detailView_fieldValue_"+selectedKey).find("a.chzn-single").find('span').first().text().trim();
							pickKeys = multipickBlocks[selectedKey];
							jQuery.each(pickKeys, function(i,e){
								jQuery.each(e,function(subk,subv){
								jQuery("#detailView").find("[data-id=\"" + subv + "\"]").closest('table').hide();
							});
							if (i == pickkey) {
								selectedBlockId=e;
							}
							
							jQuery.each(selectedBlockId,function(subk,subv){
								jQuery("#detailView").find("[data-id=\"" + subv + "\"]").closest('table').show();
							});
							});
						}); // end on change registration
					});
				}
			}
		}

		// Panel Tabs Implementation
		if (typeof panelTabs !== 'undefined') {
			if (jQuery(panelTabs).length > 0) {
				//console.log(Object.keys(panelTabs).length, "PanelTabs present");
				var tabsHTML = "";
				jQuery.each(panelTabs, function(index, value){
					tabsHTML+='<li class="vtPanelTab '+index+'"><a data-toggle="tab" href="#relatedTabOrder"><strong>'+index+'</strong></a></li>';
				});
				jQuery("#detailView").find(".contents").prepend('<div class="tabbable"><ul class="nav nav-tabs layoutTabs massEditTabs">'+tabsHTML+'</ul><div class="tab-content layoutContent padding20 themeTableColor overflowVisible"></div></div>');

				// setup the tabs click event to show the linked blocks
				jQuery("#detailView").find(".contents").find(".tabbable").find("li").each(function(){
					jQuery(this).click(function(){
						showBlocksForPanel(jQuery(this).text());
					});
				});

				jQuery(".blockHeader").each(function() {
					var blockId = jQuery(this).find("img").filter(":first").data('id');
					jQuery(this).find("img").filter(":first").closest("table").data( "tableforblock", blockId );
					jQuery(this).find("img").filter(":first").closest("table").hide();
					//console.log("Block Id ", blockId, " Blocklabel ", jQuery(this).text());
				});
				jQuery("#detailView").find(".vtPanelTab").first().addClass("active");
				//console.log(Object.keys(panelTabs)[0], panelTabs[Object.keys(panelTabs)[0]]);
					showBlocksForPanel(Object.keys(panelTabs)[0]);
			} else {
				//console.log("PanelTabs absent");
			}
		}
	});