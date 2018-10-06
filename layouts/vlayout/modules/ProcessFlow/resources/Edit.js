/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Edit_Js("ProcessFlow_Edit_Js",{
},{

	registerOnLoad : function(){
		var is_recordid = jQuery('#recordid').val();
		var thisInstance = this; 
		var recordId = jQuery('input[name="record"]').val();
		if(recordId > 0){
			this.reloadProcessHtml(recordId);
			jQuery('#ProcessFlow_editView_fieldName_strain_name').attr('readonly', true);	

			var pf_process_status = jQuery('[name="pf_process_status"]').val();

			if(pf_process_status == "Destructed")
			{
				relatedDestruectscrpt("hide");
				jQuery("#idTblDestructionInformation").show();
			}else if(pf_process_status == "Planning" || pf_process_status == "Select an Option"){
				relatedDestruectscrpt("show");
				jQuery("#idTblDestructionInformation").hide();
			}else{
				relatedDestruectscrpt("hide");
				jQuery("#idTblDestructionInformation").hide();
			}

			/* grid show/hide */
			if(jQuery('#idIsVessels').val() == 0){ jQuery('.grid2').remove(); jQuery('#addGrid2').remove(); }
			if(jQuery('#idIsTools').val() == 0){ jQuery('.grid3').remove(); jQuery('#addGrid3').remove(); }
			if(jQuery('#idIsMachinery').val() == 0){ jQuery('.grid4').remove(); jQuery('#addGrid4').remove(); }
		}else{
			jQuery('[name="pf_process_status"] option[value="Completed"]').remove();
			jQuery('[name="pf_process_status"] option[value="Destructed"]').remove();
			jQuery('.chzn-select').trigger('liszt:updated');
			
		}

		/*ProcessFlow_editView_fieldName_processflowname */
	 
		jQuery('#ProcessFlow_editView_fieldName_processflowname').on('change',function(){ 
			var originalString = jQuery(this).val();
			var updatedString = originalString.replace("PF", "WP");		 
			jQuery('#ProcessFlow_editView_fieldName_strain_name').val(updatedString).attr('readonly', true);	 

		});

		jQuery('.chzn-select').chosen({ "search_contains": true });
		jQuery("#id_raw_materials").chosen().change(function(e, params){
			var values =jQuery("#id_raw_materials").chosen().val(); 
			jQuery('#raw_materials').val(values);
		});

		var height = jQuery( window ).height();		 
		jQuery('#idDivBody').height(height-220);

		jQuery('#id_end_product_category').on('change',function(){ 
			var product_category = jQuery(this).val();		 
			jQuery('input[name="end_product_category"]').val(product_category);
		});
		
		jQuery('[name="pf_process_status"]').chosen().change(function(e){
			var value = $(this).val();
			if(is_recordid == "true")
			{
				if(value == "Destructed")
				{
					relatedDestruectscrpt("hide");

					bootbox.confirm("Are you sure you want Abort Batch(Destruct Batch)", function(result){ 
						if(result){   
							bootbox.confirm("really you want to Destruct Batch(if yes do Witness  Signature then Save)", function(result){ 
								if(result){   
									jQuery("#idTblDestructionInformation").show();
								}
								else{
									jQuery('[name="pf_process_status"]').chosen().val('In Progress').trigger("liszt:updated");
								}
							});
						}
						else{
							jQuery('[name="pf_process_status"]').chosen().val('In Progress').trigger("liszt:updated");
						}
					});
				}else if(value == "Planning"  || value == "Select an Option"){
					bootbox.alert("Processflow Cannot be changed", function(){});
					var pf_process_status_hidden = jQuery("#pf_process_status_hidden").val();
					jQuery('[name="pf_process_status"]').chosen().val(pf_process_status_hidden).trigger("liszt:updated");
					return false;
				}else{
					relatedDestruectscrpt("hide");
				}
			}else if(is_recordid == "false")
			{
				
			}
		});

		function relatedDestruectscrpt(id)
		{
			if(id == "show")
			{
				jQuery(".clearReferenceSelection").removeClass('hide');
				jQuery(".clearReferenceSelection").addClass('show');
				jQuery(".relatedPopup").removeClass('hide');
				jQuery(".relatedPopup").addClass('show');
				jQuery(".createReferenceRecord").removeClass('hide');
				jQuery(".createReferenceRecord").addClass('show');
				jQuery('#pf_project_id_display').removeAttr('readonly', 'readonly');

			}else if(id="hide")
			{
				jQuery(".clearReferenceSelection").addClass('hide');
				jQuery(".relatedPopup").addClass('hide');
				jQuery(".createReferenceRecord").addClass('hide');
				jQuery('#pf_project_id_display').attr('readonly', 'readonly');
			}
		}
		
		jQuery('#idProcessmasterid').on('change',function(){ 

			var progressIndicatorElement = jQuery.progressIndicator();	
			var processid = jQuery(this).val();		 
			jQuery('input[name="processmasterid"]').val(processid);
			
			var sentdata ={};
			sentdata.module ='ProcessFlow'; 
			sentdata.action = 'AjaxValidations';	
			sentdata.mode = 'getProductsCategorysList';					 
			sentdata.processid = processid;  

			AppConnector.request(sentdata).then(
				function(data){ 			 
					if(data.result.status == true){ 
						
						/*  materials */
						//console.log(data.result);
						jQuery('#id_end_product_category').val(data.result.productcategory);		 
						jQuery('#end_product_category').val(data.result.productcategory);		 
						jQuery('#id_end_product_category').trigger("liszt:updated");
						
						var pcidArray = data.result.materials;	
						console.log(pcidArray);				 
						 
						jQuery('#idtbodyGrid1 >.grid1ItemRow').remove();
						if(pcidArray.length > 0){
							for(var i=1;i<=pcidArray.length;i++){
								jQuery('#addGrid1').trigger('click');
							}
							jQuery.each(pcidArray, function( index, value ) {
								var c = index+1;							 
								jQuery('#grid1productcategory'+c).val(value.productcategory).trigger("liszt:updated");
								jQuery('#grid1productName'+c).val(value.productname).attr('readonly', true);
								jQuery('#grid1productid'+c).val(value.productid).trigger("liszt:updated");
								jQuery('#grid1issuedqty'+c).val(value.qty);
								jQuery('#grid1prasentqty'+c).val(value.qtyinstock);
								/* jQuery('#grid1productcategory'+c).prop('disabledd', true).trigger("liszt:updated");*/
							});
						}
						
						/*  vessels */
						var vesselsArray = data.result.vessels;
						var is_vessels = data.result.is_vessels;
						if(is_vessels == 0){
							jQuery('.grid2').remove();
							jQuery('#addGrid2').remove();
						}else{
							jQuery('#idtbodyGrid2 >.grid2ItemRow').remove();
							if(vesselsArray.length > 0){
								for(var i=1;i<=vesselsArray.length;i++){
									jQuery('#addGrid2').trigger('click');
								}
								jQuery.each(vesselsArray, function( index, value ) {
									console.log(value.assetname);
									var c = index+1;							 
									jQuery('#grid2assetName'+c).val(value.assetname).prop('readonly', true);
									jQuery('#grid2assetsid'+c).val(value.assetsid);
									/* jQuery('#grid2assetcategory'+c).val(value.cf_829).trigger("liszt:updated"); //cf_829 is assect category  */
								});	 
							}
						}
						
						/* tools */
						var toolsArray = data.result.tools;					 
						var is_tools = data.result.is_tools;
						if(is_tools == 0){
							jQuery('.grid3').remove();
							jQuery('#addGrid3').remove();
						}else{
							jQuery('#idtbodyGrid3 >.grid3ItemRow').remove();
							if(toolsArray.length > 0){
								for(var i=1;i<=toolsArray.length;i++){
									jQuery('#addGrid3').trigger('click');
								}
								jQuery.each(toolsArray, function( index, value ) { 							 
									var c = index+1;							 
									jQuery('#grid3assetName'+c).val(value.assetname).prop('readonly', true);
									jQuery('#grid3assetsid'+c).val(value.assetsid);
									/* jQuery('#grid3assetcategory'+c).val(value.cf_829).trigger("liszt:updated"); */
								});
							}
						}

						/* machinery */
						var machineryArray = data.result.machinery;					 
						var is_machinery = data.result.is_machinery;
						if(is_machinery == 0){
							jQuery('.grid4').remove();
							jQuery('#addGrid4').remove();
						}else{
							jQuery('#idtbodyGrid4 >.grid4ItemRow').remove();
							if(machineryArray.length > 0){
								for(var i=1;i<=machineryArray.length;i++){
									jQuery('#addGrid4').trigger('click');
								}
								jQuery.each(machineryArray, function( index, value ) { 							 
									var c = index+1;							 
									jQuery('#grid4assetName'+c).val(value.assetname).prop('readonly', true);
									jQuery('#grid4assetsid'+c).val(value.assetsid);
									/* jQuery('#grid4assetcategory'+c).val(value.cf_829).trigger("liszt:updated"); */
								});
							}
						}
						progressIndicatorElement.progressIndicator({'mode' : 'hide'});					
					}else{
						this.disabledd = false;
						bootbox.alert("Try again");				 
					}
				}
			);
			
		 });
		 
		 
		 var processid = jQuery('input[name="processmasterid"]').val();		 
		 if(processid != ''){
			jQuery('#idProcessmasterid').val(processid);		 
			jQuery('#idProcessmasterid').trigger("liszt:updated");
			jQuery('#idProcessmasterid').prop('disabledd', true).trigger("liszt:updated");
			jQuery("input[name='process_flow_start_time']").prop('disabledd',true);
			jQuery("input[name='process_flow_end_time']").prop('disabledd',true);			
			jQuery("select[name='termination']").prop('disabledd', true).trigger("liszt:updated");
		} 	
	},
	
	reloadProcessHtml :function(recordId){ 
		var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.view = 'AjaxProcesses';		 
		sentdata.recordId = recordId; 
		AppConnector.request(sentdata).then(
			function(data){ 						
				jQuery('#idProceessData').html(data);	 
			}
		);
	},

	/**
	 * Function to get Status of stock avilability in inventory 
	 */
	checkStockInInventory : function(productid,product_quantity){
		var pdata ={};
		pdata.module ='ProcessFlow'; 
		pdata.action = 'AjaxValidations';	
		pdata.mode = 'check_inventory';					 
		pdata.productid = productid;	 		 
		pdata.product_quantity = product_quantity; 

		AppConnector.request(pdata).then(
			function(data){ 						
			 
				if(data.success == true){ 			
					 				
					 return data.result;					
				}else{
					 
					bootbox.alert("Try again");				 
				}
			}
		); 
	},

	/**
	 * Function to register event for image delete
	 */
	registerEventForImageDelete : function(){
			var formElement = this.getForm();
			var recordId = formElement.find('input[name="record"]').val();
			formElement.find('.imageDelete').on('click',function(e){
					var element = jQuery(e.currentTarget);
					var parentTd = element.closest('td');
					var imageUploadElement = parentTd.find(':file');
					var fieldInfo = imageUploadElement.data('fieldinfo');
					var mandatoryStatus = fieldInfo.mandatory;
					var imageId = element.closest('div').find('img').data().imageId;
					element.closest('div').remove();
					var exisitingImages = parentTd.find('[name="existingImages"]');
					if(exisitingImages.length < 1 && mandatoryStatus){
							formElement.validationEngine('detach');
							imageUploadElement.attr('data-validation-engine','validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]');
							formElement.validationEngine('attach');
					}

					if(formElement.find('[name=imageid]').length != 0) {
							var imageIdValue = JSON.parse(formElement.find('[name=imageid]').val());
							imageIdValue.push(imageId);
							formElement.find('[name=imageid]').val(JSON.stringify(imageIdValue));
					} else {
							var imageIdJson = [];
							imageIdJson.push(imageId);
							formElement.append('<input type="hidden" name="imgDeleted" value="true" />');
							formElement.append('<input type="hidden" name="imageid" value="'+JSON.stringify(imageIdJson)+'" />');
					}
			});
	},
	 
	registerSubmitEvent: function() {
		var form = jQuery('#EditView');
		form.on('submit',function(e) {
			if(form.data('submit') == 'true' && form.data('performCheck') == 'true') {
				return true;
			} else {
				form.data('submit', 'true');
			}
		});
		var editViewForm = this.getForm();
		editViewForm.submit(function(e){
			if((editViewForm.find('[name="existingImages"]').length >= 1) || (editViewForm.find('[name="imagename[]"]').length > 1)){
				jQuery.fn.MultiFile.disabledEmpty(); // before submiting the form - See more at: http://www.fyneworks.com/jquery/multiple-file-upload/#sthash.UTGHmNv3.dpuf
			}
		});
	},

   registerEventForCkEditor : function(){
		var form = this.getForm();
		form.find('textarea.richtext').each(function(){
    		var inputname=jQuery(this).attr('name');
			var elem=jQuery(this).data('fieldinfo');
			var noteContentElement=jQuery(this);
			var fieldUIType = elem.fielduitype;
			if(fieldUIType==540){
				if(noteContentElement.length > 0){
					noteContentElement.removeAttr('data-validation-engine').addClass('ckEditorSource');
					var ckEditorInstance = new Vtiger_CkEditor_Js();
					ckEditorInstance.loadCkEditor(noteContentElement);
				}
			}
			
		});
	},
	
	registerEvents : function(){
		this._super();
	},

	registerBasicEvents : function(container) {
		this._super(container);
		this.registerEventForCkEditor();
		this.registerOnLoad();
	}
});

 

var path = "";
var vtRsPath = [];
var plparams ={};
var pickBlock = {};			// will hold the array of blockids assigned as pickblock for each picklist item
var vtDZ_pickBlocks = {};	// will hold the array of blockids that have been chosed as pickblocks for the picklist 
var plFieldId = {};			// will hold the fieldid of the picklist field
var plFieldName = {};		// will hold the fieldname of the picklist field
var plFieldBlockId = {};	// will hold the blockid of the picklist field, used to prevent selection as pickblock
var plFieldLabel2Name = {}; // will hold the field label as value of the picklist field, used to preload
var plFieldValue = {};		// will hold the field value of the picklist field, used to preload
var plModuleName = {};		// will hold the module name as value of the picklist field, used to preload

function plwalker(key, value) {
	var savepath = path;
	path = path ? (path + "::||::" + key) : key;
	if (key=="uitype" && (value=="15" || value=="16")){
		var fieldid=vtRsPath.pop();
		var blockid=vtRsPath.pop();
		vtRsPath.push(blockid);
		vtRsPath.push(fieldid);
		pllabel = vtRecordStructure[blockid][fieldid].label;
		plvalues = '';
		if(typeof vtRecordStructure[blockid][fieldid].fieldInfo != 'undefined'){
			plvalues = Object.keys(vtRecordStructure[blockid][fieldid].fieldInfo.picklistvalues);
		}
		plparams[pllabel] = plvalues;
		vtDZ_pickBlocks[pllabel] = [];
		plFieldBlockId[pllabel] = vtRecordStructure[blockid]["id"];
		plFieldId[pllabel] = vtRecordStructure[blockid][fieldid].id;
		plFieldName[pllabel] = vtRecordStructure[blockid][fieldid].name;
		plFieldLabel2Name[vtRecordStructure[blockid][fieldid].name] = pllabel;
		plFieldValue[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].fieldvalue;
		plModuleName[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].modulename;
	}
	if (value !== null && typeof value === "object") {
		// Recurse into children
		vtRsPath.push(key);
		jQuery.each(value, plwalker);
		vtRsPath.pop();
	}
	path = savepath;
}

jQuery(document).ready(function() {
	if (typeof(vtRecordStructure) !== 'undefined') {
		// Implementation of Pickblocks in EditView
		jQuery.each(vtRecordStructure, plwalker);
		if (Object.keys(pickBlocks).length > 0) {
			jQuery.each(pickBlocks, function(index, value){
				pickkey = plFieldValue[index];
				selectedBlockLabel = "";
				jQuery.each(value, function(i,e){
					jQuery("th.blockHeader:contains('"+e[1]+"')").closest('table').hide();
					if (i == pickkey) {
						selectedBlockLabel=e[1];
					}
				});
				jQuery("th.blockHeader:contains('"+selectedBlockLabel+"')").closest('table').show();

				// set the onchange function
				jQuery("select[name='"+index+"']").change(function(){
					selectedBlockLabel = "";
					selectedKey = index;
					pickkey = jQuery("select[name='"+index+"']").next().find("a.chzn-single").find("span").first().text().trim();
					pickKeys = pickBlocks[selectedKey];
					jQuery.each(pickKeys, function(i,e){
						jQuery("th.blockHeader:contains('"+e[1]+"')").closest('table').hide();
						if (i == pickkey) {
							selectedBlockLabel=e[1];
						}
					});
					jQuery("th.blockHeader:contains('"+selectedBlockLabel+"')").closest('table').show();
				}); // end on change registration
			});
		}
	}
});
