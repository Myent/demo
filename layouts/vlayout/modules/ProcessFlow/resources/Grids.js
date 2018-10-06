/*+***********************************************************************************
 * The contents of this file are complete related grid blocks implementation wrote by Manasa APR 15 2018 
 *************************************************************************************/
//Manasa added for grid purpose :: APR 13 2018
ProcessFlow_Edit_Js("ProcessFlow_Grids_Js",{
},{
	sequenceNumber : false,
	sequenceNumber2 : false,
	sequenceNumber3 : false,
	sequenceNumber4 : false,
	Grid1FieldsMappingInModule : {
		'productid':'grid1productid',
		'productname':'grid1productName',
		'productcategory':'grid1productcategory',
		'qtyinstock':'grid1prasentqty'
	},
	Grid2FieldsMappingInModule : {
		'assetsid':'grid2assetsid',
		'assetname':'grid2assetName',
		'assetcategory':'grid2assetcategory',		 
		/*'qtyinstock':'grid2prasentqty'*/
	},
	Grid3FieldsMappingInModule : { 
		'assetsid':'grid3assetid',
		'assetname':'grid3assetName',
		'assetcategory':'grid3assetcategory',		 
		/*'qtyinstock':'grid3prasentqty'*/
	},
	Grid4FieldsMappingInModule : {
		'assetsid':'grid4assetid',
		'assetname':'grid4assetName',
		'assetcategory':'grid4assetcategory',		 
		/*'qtyinstock':'grid4prasentqty'*/
	},
	mapResultsToFields : function(referenceModule,parentElem,responseData){
		var thisInstance = this;
		var selectedItemData = {};
		var trelement = jQuery(parentElem).closest('tr');
		var rowNumber = trelement.find('.rowNumber').val();
		var rowclass = trelement.attr('class');
		selectedItemData.source_module = jQuery(trelement).find('input[name="popupReferenceModule"]').val();
		var recordId = responseData;
		selectedItemData.record = recordId;
		thisInstance.getRecordDetails(selectedItemData).then(
			function(data){
				var response = data['result'];
				var mapdata = response['data'];
				if(rowclass == 'grid1ItemRow') {
					var addressMapping = thisInstance.Grid1FieldsMappingInModule;
				} else if(rowclass == 'grid2ItemRow') {
					var addressMapping = thisInstance.Grid2FieldsMappingInModule;
				}else if(rowclass == 'grid3ItemRow') {
					var addressMapping = thisInstance.Grid3FieldsMappingInModule;
				}else if(rowclass == 'grid4ItemRow') {
					var addressMapping = thisInstance.Grid4FieldsMappingInModule;
				}
				mapdata.id = recordId;
				jQuery.each(addressMapping,function(key,v){
					var displayval = mapdata[key];
					var batchdata = {};
					/*if(key == 'cf_1648'){
						batchdata.source_module = 'Products';
						batchdata.record = displayval;
						thisInstance.getRecordDetails(batchdata).then(
							function(bdata){
								var batchresponse = bdata['result'];
								var batchinfo = batchresponse['data'];
								var displayval = batchinfo.productcategory;
							});
					}*/
					console.log(core_productcategory);
					if(key == 'productcategory' || key == 'assetcategory'){

					}else{
						var toElement = trelement.find('#'+v+rowNumber);
						toElement.val(displayval).trigger("liszt:updated");
						if(key == 'productname' || key == 'assetname'){
							toElement.attr('disabled','disabled');						
						}
						if(key == 'productid' || key == 'assetsid'){
							toElement.val(recordId);
						}
					}
					
				});
							
				/*jQuery("#earningsgrid .qty").trigger('focusout');
				jQuery("#variableearningsgrid .qty").trigger('focusout');
				jQuery("#deductionsgrid .qty").trigger('focusout');
				jQuery("#benefitsgrid .qty").trigger('focusout');*/

			},
			function(error, err){

			}
		);		
	},

	registerClearReferenceSelectionEvent : function(container) {
		var thisInstance =this;
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
 registerGridAutoComplete:function(){
	 var container = jQuery("#EditView");
	 var thisInstance = this;
		container.find('input.autoComplete').autocomplete({
			'minLength' : '3',
			'source' : function(request, response){
				
				var inputElement = jQuery(this.element[0]);
				var searchValue = request.term;
				var params = thisInstance.getReferenceSearchParams(inputElement);
				console.log(params);
				params.search_value = searchValue;
				params.module=params.search_module;
				var rowclass = inputElement.closest('tr').attr('class');
				var rowNumber =  inputElement.closest('tr').find('.rowNumber').val();
				console.log(rowNumber);
			if(rowclass == 'grid1ItemRow') {
				var pcname = 'grid1productcategory'+rowNumber;
			} else if(rowclass == 'grid2ItemRow') {
				var pcname = 'grid2assetcategory'+rowNumber;
			}else if(rowclass == 'grid3ItemRow') {
				var pcname = 'grid3assetcategory'+rowNumber;
			}else if(rowclass == 'grid4ItemRow') {
				var pcname = 'grid4assetcategory'+rowNumber;
			}

			var productcategory = inputElement.closest('tr').find('select[name="'+pcname+'"]').find(':selected').data('pc-label');
		 
			if(params.module == 'Assets'){
				params.cf_829 = productcategory;
			}else{
				params.productcategory = productcategory;
			}
		
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
	
				var  sourceModule= tdElement.find('input[name="popupReferenceModule"]').val();
				var rec = selectedItemData.id;//jQuery("#").val();
				var module = app.getModuleName();
				thisInstance.mapResultsToFields(sourceModule,tdElement,rec);
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
 getGridPopUpParams : function(container) {
		var params = {};
		var sourceModule = app.getModuleName();
		var popupReferenceModule = jQuery('input[name="popupReferenceModule"]',container).val();
		var params = {
			'module' : popupReferenceModule,
			'src_module' : sourceModule,
			
		}
		params.multi_select = true;
		return params;
	},
 regiserGridPopup : function(){
	 var aDeferred = jQuery.Deferred();
	 var thisInstance = this;
	jQuery('.lineItemPopup').on('click',function(){		
		var parentElem = jQuery(this).closest('td');
		var rowclass = jQuery(this).closest('tr').attr('class');
		var params = thisInstance.getGridPopUpParams(parentElem);
		var rowNumber =  jQuery(this).closest('tr').find('.rowNumber').val();

		var isMultiple = false;
		if(params.multi_select) {
			isMultiple = true;
		}

		var popupInstance =Vtiger_Popup_Js.getInstance();
		var referenceModule = params.module;
		if(rowclass == 'grid1ItemRow') {
			var pcname = 'grid1productcategory'+rowNumber;
		} else if(rowclass == 'grid2ItemRow') {
			var pcname = 'grid2assetcategory'+rowNumber;
		}else if(rowclass == 'grid3ItemRow') {
			var pcname = 'grid3assetcategory'+rowNumber;
		}else if(rowclass == 'grid4ItemRow') {
			var pcname = 'grid4assetcategory'+rowNumber;
		}
		var productcategory = jQuery(this).closest('tr').find('select[name="'+pcname+'"]').find(':selected').data('pc-label');
		 
		if(params.module == 'Assets'){
			params.cf_829 = productcategory;
		}else{
			params.productcategory = productcategory;
		}
		
		
		popupInstance.show(params,function(data){
			var responseData = JSON.parse(data);
			var len = Object.keys(responseData).length;
			if(len >1 ){
				i=0;
				jQuery.each(responseData,function(k,v){
					if(i == 0){
						thisInstance.mapResultsToFields(referenceModule,parentElem,k);
					}else if(i >= 1){
						if(rowclass == 'grid1ItemRow') {
							jQuery('#addGrid1').trigger('click');
							var newRow = jQuery('#grid1 > tbody > tr:last');
							
						} else if(rowclass == 'grid2ItemRow') {
							jQuery('#addGrid2').trigger('click');
							var newRow = jQuery('#grid2 > tbody > tr:last');
							
						}else if(rowclass == 'grid3ItemRow') {
							jQuery('#addGrid3').trigger('click');
							var newRow = jQuery('#grid3 > tbody > tr:last');
							
						}else if(rowclass == 'grid4ItemRow') {
							jQuery('#addGrid4').trigger('click');
							var newRow = jQuery('#grid4 > tbody > tr:last');
						}
						var targetElem = jQuery('.lineItemPopup',newRow);
						thisInstance.mapResultsToFields(referenceModule,targetElem,k);
						aDeferred.resolve();
					}
					i++;
				});
			}else{
				jQuery.each(responseData,function(k,v){
					thisInstance.mapResultsToFields(referenceModule,parentElem,k);
				});
				aDeferred.resolve();
			}
		});
		
	});
 },
 
 registerAddingNewGridrow: function(){
		var thisInstance = this;
		jQuery('#addGrid1').on('click',function(){
			var lineItemTable = jQuery("#grid1");
			var hiderow = jQuery('.grid1CloneCopy',lineItemTable);
			var basicrow = hiderow.clone(true,true);
			basicrow.removeClass('hide');
			basicrow.removeClass('grid1CloneCopy');
			//if(thisInstance.sequenceNumber == false){
				sno = jQuery('.grid1ItemRow:visible', lineItemTable).length;
			//}			
			var newRow = basicrow.addClass('grid1ItemRow');
			newRow = newRow.appendTo(lineItemTable);
			sno = sno+1;
			thisInstance.sequenceNumber = sno;
			newRow.find('input.rowNumber').val(sno);
			var idFields = new Array('row','grid1productid','grid1productName','grid1batchid','grid1productcategory','grid1prasentqty','grid1issuedqty','grid1issuedby','grid1remarks');
			thisInstance.updateLineItemsElementWithSequenceNumber(newRow,sno,idFields);
			newRow.find('input.productName').addClass('autoComplete');
			thisInstance.registerGridAutoComplete(newRow);
		});
		jQuery('#addGrid2').on('click',function(){
			var lineItemTable = jQuery("#grid2");
			var hiderow = jQuery('.grid2CloneCopy',lineItemTable);
			var basicrow = hiderow.clone(true,true);
			basicrow.removeClass('hide');
			basicrow.removeClass('grid2CloneCopy');
			//if(thisInstance.sequenceNumber2 == false){
				sno2 = jQuery('.grid2ItemRow:visible', lineItemTable).length;			 
			//}
			var newRow = basicrow.addClass('grid2ItemRow');
			newRow = newRow.appendTo(lineItemTable);
			sno2 = sno2+1;
			thisInstance.sequenceNumber2 = sno2
			newRow.find('input.rowNumber').val(sno2);
			var idFields = new Array('row','grid2assetsid','grid2assetName','grid2assetcategory', 'grid2issuedqty','grid2issuedby','grid2remarks');
			thisInstance.updateLineItemsElementWithSequenceNumber(newRow,sno2,idFields);
			newRow.find('input.assetName').addClass('autoComplete');
			thisInstance.registerGridAutoComplete(newRow);
		});
		
		jQuery('#addGrid3').on('click',function(){
			var lineItemTable = jQuery("#grid3");
			var hiderow = jQuery('.grid3CloneCopy',lineItemTable);
			var basicrow = hiderow.clone(true,true);
			basicrow.removeClass('hide');
			basicrow.removeClass('grid3CloneCopy');
			//if(thisInstance.sequenceNumber3 == false){
				sno3 = jQuery('.grid3ItemRow:visible', lineItemTable).length;
			//}
			var newRow = basicrow.addClass('grid3ItemRow');
			newRow = newRow.appendTo(lineItemTable);
			sno3 = sno3+1;
			thisInstance.sequenceNumber3 = sno3;
			newRow.find('input.rowNumber').val(sno3);
			var idFields = new Array('row','grid3assetsid','grid3assetName','grid3assetcategory','grid3issuedqty','grid3issuedby','grid3remarks');
			thisInstance.updateLineItemsElementWithSequenceNumber(newRow,sno3,idFields);
			newRow.find('input.assetName').addClass('autoComplete');
			thisInstance.registerGridAutoComplete(newRow);
		});
		
		jQuery('#addGrid4').on('click',function(){
			var lineItemTable = jQuery("#grid4");
			var hiderow = jQuery('.grid4CloneCopy',lineItemTable);
			var basicrow = hiderow.clone(true,true);
			basicrow.removeClass('hide');
			basicrow.removeClass('grid4CloneCopy');
			//if(thisInstance.sequenceNumber4 == false){
				sno4 = jQuery('.grid4ItemRow:visible', lineItemTable).length;
			//}
			var newRow = basicrow.addClass('grid4ItemRow');
			newRow = newRow.appendTo(lineItemTable);
			sno4 = sno4+1;
			thisInstance.sequenceNumber4 = sno4;
			newRow.find('input.rowNumber').val(sno4);
			var idFields = new Array('row','grid4assetsid','grid4assetName','grid4assetcategory','grid4issuedqty','grid4issuedby','grid4remarks');
			thisInstance.updateLineItemsElementWithSequenceNumber(newRow,sno4,idFields);
			newRow.find('input.assetName').addClass('autoComplete');
			thisInstance.registerGridAutoComplete(newRow);
		});
		
    },
	updateLineItemsElementWithSequenceNumber : function(lineItemRow,expectedSequenceNumber ,idFields, currentSequenceNumber){
		if(typeof currentSequenceNumber == 'undefined') {
			//by default there will zero current sequence number
			currentSequenceNumber = 0;
		}
		var expectedRowId = 'row'+expectedSequenceNumber;
		for(var idIndex in idFields ) {
			var elementId = idFields[idIndex];
			var actualElementId = elementId + currentSequenceNumber;
			var expectedElementId = elementId + expectedSequenceNumber;
			lineItemRow.find('#'+actualElementId).attr('id',expectedElementId)
					   .filter('[name="'+actualElementId+'"]').attr('name',expectedElementId);
		}
		lineItemRow.find('select').addClass('chzn-select');
		jQuery('.chzn-select').chosen({ "search_contains": true });
		app.changeSelectElementView(lineItemRow);
		return lineItemRow.attr('id',expectedRowId);
	},
	
	registerDeleteGridRows : function(){
		var thisInstance = this;
		jQuery('.deleteRow').on('click',function(){
			var element = jQuery(this);
			var rowclass = jQuery(this).closest('tr').attr('class');
			element.closest('tr.'+ rowclass).remove();
		});
	 },
	 registerClearGridRows : function(){
		var thisInstance = this;
		jQuery('.clearLineItem').on('click',function(){
			var element = jQuery(this);
			var trelement = jQuery(this).closest('tr');
			var rowclass = jQuery(this).closest('tr').attr('class');
			var itemclass = 'autoComplete';
			if(rowclass == 'grid1ItemRow') {
				var addressMapping = thisInstance.Grid1FieldsMappingInModule;
			} else if(rowclass == 'grid2ItemRow') {
				var addressMapping = thisInstance.Grid2FieldsMappingInModule;
			}else if(rowclass == 'grid3ItemRow') {
				var addressMapping = thisInstance.Grid3FieldsMappingInModule;
			}else if(rowclass == 'grid4ItemRow') {
				var addressMapping = thisInstance.Grid4FieldsMappingInModule;
			}
			var rowNumber = trelement.find('.rowNumber').val();
			jQuery.each(addressMapping,function(key,v){
					var displayval = '';
					var toElement = trelement.find('#'+v+rowNumber);
					toElement.val(displayval).trigger("liszt:updated");
			});
			element.closest('td').find('.autoComplete').removeAttr('disabled');
			/*jQuery("#grid1 .qty").trigger('focusout');
			jQuery("#grid2 .qty").trigger('focusout');
			jQuery("#grid3 .qty").trigger('focusout');
			jQuery("#grid4 .qty").trigger('focusout');*/
		});
	 },
	 //Drag and Drop of Rows
	registerDragGridRows : function(){
		var thisInstance = this;
		var lineItemTable = jQuery("#grid1");
		lineItemTable.sortable({
			'containment' : lineItemTable,
			'items' : 'tr.grid1ItemRow',
			'revert' : true,
			'tolerance':'pointer',
			'helper' : function(e,ui){
				ui.children().each(function(index,element){
					element = jQuery(element);
					element.width(element.width());
				})
				return ui;
			}
		}).mousedown(function(event){
		});
		
		//Grid2
		var lineItemTable = jQuery("#grid2");
		lineItemTable.sortable({
			'containment' : lineItemTable,
			'items' : 'tr.grid2ItemRow',
			'revert' : true,
			'tolerance':'pointer',
			'helper' : function(e,ui){
				ui.children().each(function(index,element){
					element = jQuery(element);
					element.width(element.width());
				})
				return ui;
			}
		}).mousedown(function(event){
		});
		
		//Grid3
		var lineItemTable = jQuery("#grid3");
		lineItemTable.sortable({
			'containment' : lineItemTable,
			'items' : 'tr.grid3ItemRow',
			'revert' : true,
			'tolerance':'pointer',
			'helper' : function(e,ui){
				ui.children().each(function(index,element){
					element = jQuery(element);
					element.width(element.width());
				})
				return ui;
			}
		}).mousedown(function(event){
		});
		
		//Grid4
		var lineItemTable = jQuery("#grid4");
		lineItemTable.sortable({
			'containment' : lineItemTable,
			'items' : 'tr.grid4ItemRow',
			'revert' : true,
			'tolerance':'pointer',
			'helper' : function(e,ui){
				ui.children().each(function(index,element){
					element = jQuery(element);
					element.width(element.width());
				})
				return ui;
			}
		}).mousedown(function(event){
		});
	 },
	
	registerEvents : function(){
		this._super();
		this.registerGridAutoComplete();		
		this.registerDragGridRows();
		this.regiserGridPopup();
		this.registerAddingNewGridrow();
		this.registerDeleteGridRows();
		this.registerClearGridRows();
	}
});
jQuery(document).ready(function() {
	var instance = new ProcessFlow_Grids_Js();
	instance.registerEvents();
})
