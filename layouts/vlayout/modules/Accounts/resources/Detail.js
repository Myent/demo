/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Detail_Js("Accounts_Detail_Js",{
	
	//It stores the Account Hierarchy response data
	accountHierarchyResponseCache : {},
	
	/*
	 * function to trigger Account Hierarchy action
	 * @param: Account Hierarchy Url.
	 */
	triggerAccountHierarchy : function(accountHierarchyUrl) {
		Accounts_Detail_Js.getAccountHierarchyResponseData(accountHierarchyUrl).then(
			function(data) {
				Accounts_Detail_Js.displayAccountHierarchyResponseData(data);
			}
		);
		
	},
	
	/*
	 * function to get the AccountHierarchy response data
	 */
	getAccountHierarchyResponseData : function(params) {
		var aDeferred = jQuery.Deferred();
		
		//Check in the cache
		if(!(jQuery.isEmptyObject(Accounts_Detail_Js.accountHierarchyResponseCache))) {
			aDeferred.resolve(Accounts_Detail_Js.accountHierarchyResponseCache);
		} else {
			AppConnector.request(params).then(
				function(data) {
					//store it in the cache, so that we dont do multiple request
					Accounts_Detail_Js.accountHierarchyResponseCache = data;
					aDeferred.resolve(Accounts_Detail_Js.accountHierarchyResponseCache);
				}
			);
		}
		return aDeferred.promise();
	},
	
	/*
	 * function to display the AccountHierarchy response data
	 */
	displayAccountHierarchyResponseData : function(data) {
        var callbackFunction = function(data) {
            app.showScrollBar(jQuery('#hierarchyScroll'), {
                height: '300px',
                railVisible: true,
                size: '6px'
            });
        }
        app.showModalWindow(data, function(data){
            
            if(typeof callbackFunction == 'function' && jQuery('#hierarchyScroll').height() > 300){
                callbackFunction(data);
            }
        });
        }
},{
	//Cache which will store account name and whether it is duplicate or not
	accountDuplicationCheckCache : {},

	getDeleteMessageKey : function() {
		return 'LBL_RELATED_RECORD_DELETE_CONFIRMATION';
	},
	
	isAccountNameDuplicate : function(params) {
		var thisInstance = this;
		var accountName = params.accountName;
		var aDeferred = jQuery.Deferred();

		var analyzeResponse = function(response){
			if(response['success'] == true) {
				aDeferred.reject(response['message']);
			}else{
				aDeferred.resolve();
			}
		}

		if(accountName in thisInstance.accountDuplicationCheckCache) {
			analyzeResponse(thisInstance.accountDuplicationCheckCache[accountName]);
		}else{
			Vtiger_Helper_Js.checkDuplicateName(params).then(
				function(response){
					thisInstance.accountDuplicationCheckCache[accountName] = response;
					analyzeResponse(response);
				},
				function(response) {
					thisInstance.accountDuplicationCheckCache[accountName] = response;
					analyzeResponse(response);
				}
			);
		}
		return aDeferred.promise();
	},

	saveFieldValues : function (fieldDetailList) {
		var thisInstance = this;
		var targetFn = this._super;
		
		var fieldName = fieldDetailList.field;
		if(fieldName != 'accountname') {
			return targetFn.call(thisInstance, fieldDetailList);
		}

		var aDeferred = jQuery.Deferred();
		fieldDetailList.accountName = fieldDetailList.value;
		fieldDetailList.recordId = this.getRecordId();
		this.isAccountNameDuplicate(fieldDetailList).then(
			function() {
				targetFn.call(thisInstance, fieldDetailList).then(
					function(data){
						aDeferred.resolve(data);
					},function() {
						aDeferred.reject();
					}
				);
			},
			function(message) {
				var form = thisInstance.getForm();
				var params = {
					title: app.vtranslate('JS_DUPLICATE_RECORD'),
					text: app.vtranslate(message),
					width: '35%'
				};
				Vtiger_Helper_Js.showPnotify(params);
				form.find('[name="accountname"]').closest('td.fieldValue').trigger('click');
				aDeferred.reject();
			}
		)
		return aDeferred.promise();
	},
        
        /**
	 * Function to register event for adding related record for module
	 */
	registerEventForAddingRelatedRecord : function(){
		var thisInstance = this;
		var detailContentsHolder = this.getContentHolder();
		detailContentsHolder.on('click','[name="addButton"]',function(e){
			var element = jQuery(e.currentTarget);
			var selectedTabElement = thisInstance.getSelectedTab();
			var relatedModuleName = thisInstance.getRelatedModuleName();
            var quickCreateNode = jQuery('#quickCreateModules').find('[data-name="'+ relatedModuleName +'"]');
            if(quickCreateNode.length <= 0) {
                window.location.href = element.data('url');
                return;
            }

			var relatedController = new Vtiger_RelatedList_Js(thisInstance.getRecordId(), app.getModuleName(), selectedTabElement, relatedModuleName);
                        var postPopupViewController = function() {
                            var instance = new Contacts_Edit_Js();
                            var data = new Object;
                            var container = jQuery("[name='QuickCreate']");
                            data.source_module = app.getModuleName();
                            data.record = thisInstance.getRecordId();
                            data.selectedName = container.find("[name='account_id_display']").val();
                            instance.referenceSelectionEventHandler(data,container);
                        }
                        if(relatedModuleName == 'Contacts')
                            relatedController.addRelatedRecord(element , postPopupViewController);
                        else
                            relatedController.addRelatedRecord(element);
		})
	}

});

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