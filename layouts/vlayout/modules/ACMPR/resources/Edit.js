/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Edit_Js("ACMPR_Edit_Js",{
},{
	registerUnselectRadioEvents : function(){
		jQuery('#EditView').find('.radio').on('click',function(e) {
			if (this.getAttribute('checked')) {
				jQuery(this).removeAttr('checked');
				jQuery(this).val('');
			} else {
				jQuery(this).attr('checked', true);
				var disval = jQuery(this).attr('data-display');
				jQuery(this).val(disval);
			}
		});
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
				jQuery.fn.MultiFile.disableEmpty(); // before submiting the form - See more at: http://www.fyneworks.com/jquery/multiple-file-upload/#sthash.UTGHmNv3.dpuf
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
	//manasa
	 accountname : '',
	ContactFieldsACMPRMapping : {
		//Legal Name Fields
		'legal_name':{
			'trade_name':'other_corporation_reg_name', //trade name 
			'ship_street' : 'ship_street_address',//ship street address
			'ship_city' : 'ship_city',//ship city
			'ship_state' : 'ship_province', // ship province
			'ship_code' : 'ship_postal_code', //ship postal code
			'phone' : 'ship_phone_no', //primary phone :ship phone no 
			'fax' : 'ship_fax_no', //ship fax no
			'primary_email' : 'ship_email', // ship email
			'bill_street' : 'bill_street_address', //Bill street Address
			'bill_city' : 'bill_city', //Bill City
			'bill_state' : 'bill_province', //Bill province
			'bill_code' : 'bill_postal_code'//Bill Postal Code
		},
		//Org testing laboratory name
		'third_party_laboratory_name':{//Labratory name
			'orgfulladdress' : 'address',//address field
			'drugs_licence_number' : 'drugs_licence_number',//License number
		},
		//appilcant section2
		'applicant':{
			'title':'title',// title 
			'gender':'gender',//gender
			'birthday':'date_of_birth',//DOB
			'mailingstreet':'street_address',//StreetAddress
			'mailingcity':'city',//City
			'mailingstate':'province',//province
			'mailingzip':'postalcode',//PostalCode
			'email':'email',//PrimaryEmail
			'fax' : 'fax_no',//fax no
			'mobile' : 'telephone_no',
			'other_title' : 'other_register_names',//other title
		},

		//Section3ProposedPersonnel
		'senior_applicant':{
			'lastname':'surname',//lastnameneedtocopySurname
			'firstname':'given_name',//firstnameneedtocopy
			'gender':'senior_gender',//Gender
			'birthday':'senior_dob',//DOB
			'mobile':'senior_telephone_no',//Phone
			'email':'senior_email',//Email
			'other_title' : 'other_title',//other title
			'fax' :'senior_fax_no',//Senior Fax no
			'fulladdress':'senior_address',//Needtocontactfulladdress
		},
		//RPICApplicant
		'rpic_applicant':{
			'lastname':'rpic_surname',//lastname
			'firstname':'rpic_givenname',//firstname
			'gender':'rpic_gender',//gender
			'birthday':'rpic_dob',//dob
			'worked_hours_days':'rpic_work_hours_days',//workedhoursanddays
			'other_title':'rpic_other_title',//othertitle
			
		},
		//Section7OwnershipofProperty
		'sameRPIC' :{//senior_applicant Senior PIC
			'lastname':'spic_surname',//Lastname
			'firstname':'spic_givename',//Firstname
			'other_title':'spic_other_title',//OtherTitle
			//'sigimage':'spic_signature',//SPICseniorsignature
		},
		//ProposedARPIC
				//Section9Notice
		//PoliceForceSeniorOfficial
		'police_force_senior_official' : {
			'fulladdress':'police_force_address',//Fulladdress
			'title':'police_force_title',
			'account_id' : 'police_force_local_authority',
		},
		
		//FireAuthorityAddress
		'fire_authority_senior_official':{
			'fulladdress':'fire_authority_address',//Fulladdress
			'title':'fire_authority_title',
			'account_id' : 'fire_local_authority',
		},
		
		'local_gov_senior_official':{
			//LocalGovernmentSeniorOfficial	
			'fulladdress':'local_gov_address',//Fulladdress
			'title':'local_government_title',
			'account_id' : 'local_gov_authority',
		},

		'proposed_qap':{
				//Section10QAP
				'lastname':'qap_surname',//QAPlastname
				'firstname':'qap_givenname',//Firstname
				'gender':'qap_gender',//Gender
				'birthday':'qap_dob',//DOb
				'worked_hours_days':'qap_worked_hours_days',//workedhoursanddays
		},

		//Section 13 joint ownerDocument
		'joint_owner1' : {
			'fulladdress':'joint_owner1_address',//Fulladdress
		},
		'joint_owner2' : {
			'fulladdress':'joint_owner2_address',//Fulladdress
		},

	},
	fullAddressFields : ['mailingpobox','mailingstreet','mailingcity','mailingstate','mailingzip','mailingcountry'],
	organizationfullAddressFields :['bill_pobox','bill_street','bill_city','bill_state','bill_country','bill_code'],
	organizationshipaddressfields : ['ship_pobox','ship_street','ship_city','ship_state','ship_country','ship_code'],
	/**
	 * Function to copy address between fields
	 * @param strings which accepts value as either odd or even
	 */
	 getContactOrgName: function(record,popfield){
		var sentdata ={};
		var thisInstance = this;			
		sentdata.record = record;
		sentdata.source_module = 'Accounts';
		thisInstance.getRecordDetails(sentdata).then(
			function(res_org){
				var response = res_org['result'];
				var orginfo = response['data'];
				thisInstance.copyorgName(orginfo,popfield);
			}
		);
		
	 },
	 copyorgName:function(orginfo,popfield){
		
		 jQuery("#EditView").find('[name="'+popfield+'"]').val(orginfo.accountname);
	 },
	CopyACMPRFields : function(responsedata,fieldkey){
		var thisInstance = this;
		var container = jQuery("#EditView");
		var addressMapping = this.ContactFieldsACMPRMapping[fieldkey];
		var fulladdfields = this.fullAddressFields;
		var organizationfullAddressFields = this.organizationfullAddressFields;
		var organizationshipaddressfields = this.organizationshipaddressfields;
		for(var key in addressMapping) {
			var displayval = '';
			if(key == 'fulladdress'){
				//fullAddressFields
				jQuery.each(fulladdfields,function(index,value){
					if(responsedata[value] != ''){
						if(value == 'mailingpobox'){
							displayval += ' PO Box ';
						}
						displayval += responsedata[value]+',';
					}
				});
				displayval = displayval.slice(0,-1);
				var toElement = container.find('[name="'+addressMapping[key]+'"]');
				toElement.val(displayval).trigger("liszt:updated");
			}else if(key == 'orgfulladdress'){
				//fullAddressFields
				jQuery.each(organizationfullAddressFields,function(index,value){
					if(responsedata[value] != ''){
						if(value == 'bill_pobox'){
							displayval += ' PO Box ';
						}
						displayval += responsedata[value]+',';
					}
				});
				displayval = displayval.slice(0,-1);
				
				var toElement = container.find('[name="'+addressMapping[key]+'"]');
				toElement.val(displayval).trigger("liszt:updated");
			}//ship organization addreess
			else if(key == 'orgfullshipaddress'){
				//fullAddressFields
				jQuery.each(organizationshipaddressfields,function(index,value){
					if(responsedata[value] != ''){
						if(value == 'ship_pobox'){
							displayval += ' PO Box ';
						}
						displayval += responsedata[value]+',';
					}
				});
				displayval = displayval.slice(0,-1);
				
				var toElement = container.find('[name="'+addressMapping[key]+'"]');
				toElement.val(displayval).trigger("liszt:updated");
			}else if(key == 'account_id'){
				thisInstance.getContactOrgName(responsedata[key],addressMapping[key]);
					
			}
			else{
				var displayval = responsedata[key];
	
				var classname = jQuery('#EditView input[name*="'+addressMapping[key]+'"]').attr('class');
	
				if(classname == 'dateField'){
				var userformat = jQuery('input[name*="'+addressMapping[key]+'"]').attr('data-date-format');
			
					if(displayval != ''){
						var userd = displayval.split("-");
						if(userformat == 'dd-mm-yyyy'){
							displayval = userd[2]+"-"+userd[1]+"-"+userd[0];
						}else if(userformat == 'mm-dd-yyyy'){
							displayval = userd[1]+"-"+userd[2]+"-"+userd[0];
						}else{
							displayval = displayval;
						}
					}
				}
				var toElement = container.find('[name="'+addressMapping[key]+'"]');
				toElement.val(displayval).trigger("liszt:updated");
			}
			
		}
		//'sameSPIC' :{//senior_applicant
		if(fieldkey == 'senior_applicant'){
			var addressMapping = this.ContactFieldsACMPRMapping['sameRPIC'];
			if(jQuery('#ACMPR_editView_fieldName_appendix_a_attached').is(":checked")){
				
			}else{
				for(var key in addressMapping) {
				var displayval = responsedata[key];
				var toElement = container.find('[name="'+addressMapping[key]+'"]');
				toElement.val(displayval).trigger("liszt:updated");
				}
			}
		}
	},
	/**
	 * Function to copy address between fields
	 * @param strings which accepts value as either odd or even
	 */
	CopyACMPRFieldsClear : function(clearkey){
		var thisInstance = this;
		var container = jQuery("#EditView");
		var addressMapping = this.ContactFieldsACMPRMapping[clearkey];
		for(var key in addressMapping) {
			var displayval = '';
			var toElement = container.find('[name="'+addressMapping[key]+'"]');
			toElement.val(displayval).trigger("liszt:updated");
		}
		//SameSPIC senior_applicant
		if(clearkey == 'senior_applicant'){
			var addressMapping = this.ContactFieldsACMPRMapping['sameRPIC'];
			for(var key in addressMapping) {
				var displayval = '';
				var toElement = container.find('[name="'+addressMapping[key]+'"]');
				toElement.val(displayval).trigger("liszt:updated");
			}
		}
	},
	
    registerAutoCompleteFields : function(container) {
		var thisInstance = this;
		container.find('input.autoComplete').autocomplete({
			'minLength' : '3',
			'source' : function(request, response){
				var inputElement = jQuery(this.element[0]);
				var searchValue = request.term;
				var params = thisInstance.getReferenceSearchParams(inputElement);
				params.search_value = searchValue;
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
				
				//manasa Jun 27 2016 Orgnization details copy
				var module = app.getModuleName();
				var opprefmodule = jQuery('input[name="popupReferenceModule"]',tdElement).val();
				if(module == 'ACMPR' && (opprefmodule == 'Contacts' || opprefmodule == 'Accounts')){
					var rec = selectedItemData.id;
					var sentdata ={};
					sentdata.module ='ACMPR';
					sentdata.record = rec;
					sentdata.source_module = opprefmodule;//'Contacts';
					
					thisInstance.getRecordDetails(sentdata).then(
						function(data){
							var response = data['result'];
							var Contactsdata = response['data'];
							 var sourceField = tdElement.find('input[class="sourceField"]').attr('name');
							thisInstance.CopyACMPRFields(Contactsdata,sourceField);
						},
						function(error, err){

						});
				}
				//manasa Jun 27 2016 Code ended here.
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
	
	openPopUp : function(e){
		var thisInstance = this;
		var parentElem = jQuery(e.target).closest('td');

		var params = this.getPopUpParams(parentElem);

		var isMultiple = false;
		if(params.multi_select) {
			isMultiple = true;
		}

		var sourceFieldElement = jQuery('input[class="sourceField"]',parentElem);

		var prePopupOpenEvent = jQuery.Event(Vtiger_Edit_Js.preReferencePopUpOpenEvent);
		sourceFieldElement.trigger(prePopupOpenEvent);

		if(prePopupOpenEvent.isDefaultPrevented()) {
			return ;
		}

		var popupInstance =Vtiger_Popup_Js.getInstance();
		popupInstance.show(params,function(data){
			var responseData = JSON.parse(data);
			var dataList = new Array();
			for(var id in responseData){
				var data = {
					'name' : responseData[id].name,
					'id' : id
				}
				dataList.push(data);
				if(!isMultiple) {
					thisInstance.setReferenceFieldValue(parentElem, data);
				}
			}
			//manasa Jun 27 2016 Orgnization details copy
			var module = app.getModuleName();
			var opprefmodule = jQuery('input[name="popupReferenceModule"]',parentElem).val();
			if(module == 'ACMPR' && (opprefmodule == 'Contacts' || opprefmodule == 'Accounts')){
				var rec = data.id;
				var sentdata ={};
				sentdata.module ='ACMPR';
				sentdata.record = rec;
				sentdata.source_module = opprefmodule;//'Contacts';
				thisInstance.getRecordDetails(sentdata).then(
					function(data){
						var response = data['result'];
						var Contactsdata = response['data'];
						var fieldkey = sourceFieldElement.attr('name');
						thisInstance.CopyACMPRFields(Contactsdata,fieldkey);
					},
					function(error, err){

					});
			}
			//manasa Jun 27 2016 Code ended here.
			if(isMultiple) {
                    sourceFieldElement.trigger(Vtiger_Edit_Js.refrenceMultiSelectionEvent,{'data':dataList});
			}
                sourceFieldElement.trigger(Vtiger_Edit_Js.postReferenceSelectionEvent,{'data':responseData});
		});
	},
	   /**
	 * Function which will register reference field clear event
	 * @params - container <jQuery> - element in which auto complete fields needs to be searched
	 */
	registerClearReferenceSelectionEvent : function(container) {
		var thisInstance =this;
		container.find('.clearReferenceSelection').on('click', function(e){
			var element = jQuery(e.currentTarget);
			var parentTdElement = element.closest('td');
			var fieldNameElement = parentTdElement.find('.sourceField');
			var fieldName = fieldNameElement.attr('name');
			/*'cf_1706',applicant
			'cf_1813',SPIC
			'cf_1823' RPIC
			'cf_1832' ARPIC
			'cf_1940' PoliceSenior
			'cf_1943'FireAuthorityAddress
			'cf_1946' Lcoal Goverment
			'cf_1949' QAP
			cf_1808 Legal Name from org*/
			//if(fieldName == 'cf_1808' || fieldName == 'cf_1884' || fieldName == 'cf_1706' || fieldName == 'cf_1813' || fieldName == 'cf_1823' || fieldName == 'cf_1832' || fieldName == 'cf_1940' || fieldName == 'cf_1943' || fieldName == 'cf_1946' || fieldName == 'cf_1949' || fieldName == 'cf_2028' || fieldName == 'cf_2030' || fieldName == 'cf_2032'){
				thisInstance.CopyACMPRFieldsClear(fieldName);
			//}
			fieldNameElement.val('');
			parentTdElement.find('#'+fieldName+'_display').removeAttr('readonly').val('');
			element.trigger(Vtiger_Edit_Js.referenceDeSelectionEvent);
			e.preventDefault();
		})
	},
	//manasa added this on oct 12 2017 ended here
	ACMPRFieldsRedaonly : function(responsedata){
		var thisInstance = this;
		var container = jQuery("#EditView");
		var addmap = this.ContactFieldsACMPRMapping;
		jQuery.each(addmap,function(key,addressMapping) {
			jQuery.each(addressMapping ,function(k,v){
				var toElement = container.find('[name="'+v+'"]');
				toElement.attr('readonly','readonly');
				jQuery('select[name*="'+v+'"]').prop('disabled', true).trigger('liszt:updated');
				var classname = jQuery('input[name*="'+v+'"]').attr('class');
				if(classname == 'dateField'){
					jQuery('input[name*="'+v+'"]').attr("disabled", true);
				}
				//
			});
		});

	},
	registerRecordPreSaveEvent : function(form){
		var thisInstance = this;
		if(typeof form == 'undefined') {
			form = this.getForm();
		}
		form.on('submit', function(e, data) {
			jQuery('select').removeAttr("disabled");
			jQuery('.dateField').removeAttr("disabled");
		});
	},
	//manasa ended here
	registerEvents : function(){
		this._super();
		var form = this.getForm();
		this.ACMPRFieldsRedaonly();//manasa
		this.registerRecordPreSaveEvent(form);//manasa
	},
	//oct 28th 2017 manasa added for grid purpose
	//Drag and Drop of Rows
registerDragGridRows : function(){
		var thisInstance = this;
		var lineItemTable = jQuery("#lineItemTab");
		lineItemTable.sortable({
			'containment' : lineItemTable,
			'items' : 'tr.lineItemRow',
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
			//TODO : work around for issue of mouse down even hijack in sortable plugin
			//thisInstance.getClosestLineItemRow(jQuery(event.target)).find('input:focus').trigger('focusout');
		});
},
getGridPopUpParams : function(container) {
	var params = {};
	var sourceModule = app.getModuleName();
	var popupReferenceModule =  jQuery('input[name="popupReferenceModule"]',container).val();
	var params = {
		'module' : popupReferenceModule,
		'src_module' : sourceModule,
		
	}
	params.multi_select = true;
	return params;
},
sequenceNumber : false,
 registerAddingNewGridrow: function(){
		var thisInstance = this;
		jQuery('#addDepartment').on('click',function(){
			var lineItemTable = jQuery("#lineItemTab");
			var hiderow = jQuery('.lineItemCloneCopy',lineItemTable);
			var basicrow = hiderow.clone(true,true);
			basicrow.removeClass('hide');
			basicrow.removeClass('lineItemCloneCopy');
			if(thisInstance.sequenceNumber == false){
				sno = jQuery('.lineItemRow', lineItemTable).length;
			}
			
			var newRow = basicrow.addClass('lineItemRow');
			newRow = newRow.appendTo(lineItemTable);
			sno = sno+1;
			thisInstance.sequenceNumber = sno;
			newRow.find('input.rowNumber').val(sno);
			var idFields = new Array('row','accountname','accountid','activities','substance');
			thisInstance.updateLineItemsElementWithSequenceNumber(newRow,sno,idFields);
			newRow.find('input.accountname').addClass('autoComplete');
			//thisInstance.registerGridAutoComplete(newRow);
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
		app.changeSelectElementView(lineItemRow);
		return lineItemRow.attr('id',expectedRowId);
	},
registerDeleteGridRows : function(){
	var thisInstance = this;
	jQuery('.deleteRow').on('click',function(){
		var element = jQuery(this);
		var rowclass = jQuery(this).closest('tr').attr('class');
		element.closest('tr.'+ rowclass).remove();
		//Calcuations function need to add here also
	});
},
registerGridAutoComplete:function(){
	 var container = jQuery("#EditView");
	 var thisInstance = this;
		container.find('input.autoComplete').autocomplete({
			'minLength' : '3',
			'source' : function(request, response){
				//element will be array of dom elements
				//here this refers to auto complete instance
				var inputElement = jQuery(this.element[0]);
				var searchValue = request.term;
				var params = thisInstance.getReferenceSearchParams(inputElement);
				params.search_value = searchValue;
				//params.search_module = "Accounts";
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
	
				var  sourceModule= tdElement.find('input[name="popupReferenceModule"]').val();//params.search_module;
				var rec = selectedItemData.id;//jQuery("#").val();
				var module = app.getModuleName();
				thisInstance.CopyACMPRFields(Contactsdata,sourceField);
				
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
 
GridFieldsMapping : {
	'accountname':'accountname',
	'id':'accountid',
	//'cf_1511':'earnings_maxval',
	//'id':'earningid'
},
registerClearGridRows : function(){
		var thisInstance = this;
		jQuery('.clearLineItem').on('click',function(){
			var element = jQuery(this);
			var trelement = jQuery(this).closest('tr');
			var rowclass = jQuery(this).closest('tr').attr('class');
			var itemclass = 'autoComplete';
			var addressMapping = thisInstance.GridFieldsMapping;
			var rowNumber = trelement.find('.rowNumber').val();
			
			jQuery.each(addressMapping,function(key,v){
					var displayval = '';
					var toElement = trelement.find('#'+v+rowNumber);
					toElement.val(displayval);
			});
			element.closest('td').find('.autoComplete').removeAttr('disabled');
		});
	 },

regiserGridPopup : function(){
	 var aDeferred = jQuery.Deferred();
	 var thisInstance = this;
	jQuery('.lineItemPopup').on('click',function(){		
		var parentElem = jQuery(this).closest('td');
		var rowclass = jQuery(this).closest('tr').attr('class');
		var params = thisInstance.getGridPopUpParams(parentElem);
		var isMultiple = false;
		if(params.multi_select) {
			isMultiple = true;
		}

		var popupInstance =Vtiger_Popup_Js.getInstance();
		var referenceModule = params.module;
		popupInstance.show(params,function(data){
			var responseData = JSON.parse(data);
			var len = Object.keys(responseData).length;
			if(len >1 ){
				i=0;
				jQuery.each(responseData,function(k,v){
					if(i == 0){
						thisInstance.mapResultsToFields(referenceModule,parentElem,k);
					}else if(i >= 1){

						jQuery('#addDepartment').trigger('click');
						var newRow = jQuery('#lineItemTab > tbody > tr:last');
						//TODO : CLEAN :  we might synchronus invocation since following elements needs to executed once new row is created
						
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
 	mapResultsToFields : function(referenceModule,parentElem,responseData){
		var thisInstance = this;
		var selectedItemData = {};
		selectedItemData.name = 'ACMPR';
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
				var addressMapping = thisInstance.ContactFieldsACMPRMapping;
				mapdata.id = recordId;
				jQuery.each(addressMapping,function(key,v){
					var displayval = mapdata[key];
					var toElement = trelement.find('#'+v+rowNumber);
					toElement.val(displayval).trigger("liszt:updated");
					if(key == 'accountname'){
						toElement.attr('disabled',true);
					}
				});
				
				//trelement.find('.autoComplete')
			},
			function(error, err){

			}
		);		
	},
//Section 7 checkbox based 
registerCheckboxAppendix : function(){
	var thisInstance = this;	
	jQuery("#ACMPR_editView_fieldName_appendix_a_attached").on('click',function(){
		if(jQuery('#ACMPR_editView_fieldName_appendix_a_attached').is(":checked")){
			jQuery("input[name*='spic_surname']").val('');
			jQuery("input[name*='spic_givename']").val('');
			jQuery("input[name*='spic_other_title']").val('');
		}else{
			jQuery("input[name*='spic_surname']").val(jQuery("input[name*='surname']").val());
			jQuery("input[name*='spic_givename']").val(jQuery("input[name*='given_name']").val());
			jQuery("input[name*='spic_other_title']").val(jQuery("input[name*='other_title']").val());
		}
		
	});
	if(jQuery('#ACMPR_editView_fieldName_appendix_a_attached').is(":checked")){
		jQuery("input[name*='spic_surname']").val('');
		jQuery("input[name*='spic_givename']").val('');
		jQuery("input[name*='spic_other_title']").val('');
	}else{
		jQuery("input[name*='spic_surname']").val(jQuery("input[name*='surname']").val());
		jQuery("input[name*='spic_givename']").val(jQuery("input[name*='given_name']").val());
		jQuery("input[name*='spic_other_title']").val(jQuery("input[name*='other_title']").val());
	}
},
	//oct 28 2017 ended
	registerBasicEvents : function(container) {
		this._super(container);
		this.registerEventForCkEditor();
		this.registerUnselectRadioEvents();
		this.registerCheckboxAppendix();
		//Grid purpose
		this.registerDragGridRows();
		this.registerAddingNewGridrow();
		this.registerDeleteGridRows();
		
		//ARPIC Fields Nov 3rd 2017
		this.registerARPICFieldNumberChange();
		this.registerAPRICAutoSearch(container);
		this.referenceModuleAPRICPopup(container);
		
		//Persons Block Purpose
		this.registerPersonFieldNumberChange();
		this.registerPersonAutoSearch(container);
		this.referenceModulePersonPopup(container);

	},
registerARPICFieldNumberChange: function() {
        var thisInstance = this;
        var ARPICTable = jQuery("#arpictab");
        var i = '';var k = '';
        //ARPICFieldsMapping
        jQuery('#APRICUSERS').on('click', function(e) { 
            var arpicno = jQuery('select[name="num_arpic_submitting"]').val();
            jQuery(".arpicItemRow").remove();
            var idFields = new Array('arpicrow', 'arpicname', 'arpicid', 'surname', 'givenname', 'gender', 'dateofbirth', 'ranking', 'whdays', 'othertitle');
            var currentSequenceNumber = 0;
            for (i = 1; i <= arpicno; i++) {
                var hiderow = jQuery('.arpicCloneCopy', ARPICTable);
                var APRPICItemRow = hiderow.clone(true, true);
                APRPICItemRow.removeClass('hide');
                APRPICItemRow.removeClass('arpicCloneCopy');
                APRPICItemRow.addClass('arpicItemRow');
                for (var idIndex in idFields) {
                    var elementId = idFields[idIndex];
                    var actualElementId = elementId + currentSequenceNumber;
                    var expectedElementId = elementId + i;
                    APRPICItemRow.find('#' + actualElementId).attr('id', expectedElementId)
                        .filter('[name="' + actualElementId + '"]').attr('name', expectedElementId);
                }
                APRPICItemRow.appendTo(ARPICTable);
                APRPICItemRow.attr('id', 'arpicrow' + i);
                APRPICItemRow.find("#arpicrow" + i).val(i);
                APRPICItemRow.find('input.arpicname').addClass('autoapricComplete');
                thisInstance.registerAPRICAutoSearch(APRPICItemRow);
            }
			var arpicdetails = jQuery.parseJSON(jQuery("#ArpicDeails").attr('data-value'));
			k=1;
			jQuery(arpicdetails).each(function(keys,values){
				ARPICTable.find('#arpicname'+k).val(values['arpicname']);
				ARPICTable.find('#arpicname'+k).attr('readonly','readonly');
				ARPICTable.find('#arpicid'+k).val(values['contactid']);
				ARPICTable.find('#surname'+k).val(values['surname']);
				ARPICTable.find('#givenname'+k).val(values['givenname']);
				ARPICTable.find('#gender'+k).val(values['gender']);
				ARPICTable.find('#dateofbirth'+k).val(values['dateofbirth']);
				ARPICTable.find('#ranking'+k).val(values['ranking']);
				ARPICTable.find('#whdays'+k).val(values['whdays']);
				ARPICTable.find('#othertitle'+k).val(values['othertitle']);
				k++;
			});
			
            e.preventDefault();
        });
        //DeleteRow Code
        jQuery('.arpicdeleteRow').on('click', function() {
            var element = jQuery(this);
            var rowclass = jQuery(this).closest('tr').attr('class');
            element.closest('tr.' + rowclass).remove();
            //Calcuations function need to add here also
        });
        //Drag code
        ARPICTable.sortable({
            'containment': ARPICTable,
            'items': 'tr.arpicItemRow',
            'revert': true,
            'tolerance': 'pointer',
            'helper': function(e, ui) {
                ui.children().each(function(index, element) {
                    element = jQuery(element);
                    element.width(element.width());
                })
                return ui;
            }
        }).mousedown(function(event) {
            //TODO : work around for issue of mouse down even hijack in sortable plugin
            //thisInstance.getClosestLineItemRow(jQuery(event.target)).find('input:focus').trigger('focusout');
        });
        //Clear Grid
        jQuery('.clearArpicItem').on('click', function() {
            var element = jQuery(this);
            var trelement = jQuery(this).closest('tr');
            var addressMapping = thisInstance.ARPICFieldsMapping;
            var rowNumber = trelement.find('.arpicrow').val();
            jQuery.each(addressMapping, function(key, v) {
                var displayval = '';
                var toElement = trelement.find('#' + v + rowNumber);
                toElement.val(displayval);
            });
            element.closest('tr').find('.arpicname').val('');
            element.closest('tr').find('.arpicname').removeAttr('readonly');
			element.closest('tr').find('.arpicname').removeAttr('disabled');
            element.closest('tr').find('.arpicid').val('');
        });
    },
    //ProposedARPIC
    ARPICFieldsMapping: {
        'lastname': 'givenname', //lastname
        'firstname': 'surname', //firstname
        'gender': 'gender', //gender
        'birthday': 'dateofbirth', //dob
       'worked_hours_days': 'whdays', //workedhoursanddays
        'title': 'ranking', //title
       'other_title': 'othertitle', //othertitle
    },
    ARPICFieldsCopy: function(responsedata, rowno) {
        var thisInstance = this;
        var container = jQuery("#arpictab");
        var addressMapping = this.ARPICFieldsMapping;
        for (var key in addressMapping) {
            var displayval = responsedata[key];
            
            if (key == 'birthday') {
                var userformat = container.find('.dateField').attr('data-date-format');
                if (displayval != '') {
                    var userd = displayval.split("-");
                    if (userformat == 'dd-mm-yyyy') {
                        displayval = userd[2] + "-" + userd[1] + "-" + userd[0];
                    } else if (userformat == 'mm-dd-yyyy') {
                        displayval = userd[1] + "-" + userd[2] + "-" + userd[0];
                    } else {
                        displayval = displayval;
                    }
                }
            }
		
            var toElement = container.find('"#' + addressMapping[key] + rowno + '"');
            toElement.val(displayval);
        }
    },
    openARPICPopUp: function(e) {
        var thisInstance = this;
        var parentElem = jQuery(e.target).closest('tr');
        var params = this.getPopUpParams(parentElem);
        var isMultiple = false;
    
        params.src_module = "ACMPR";
        params.module = "Contacts";
        var sourceFieldElement = jQuery('input[class="arpicid"]', parentElem);
        var prePopupOpenEvent = jQuery.Event(Vtiger_Edit_Js.preReferencePopUpOpenEvent);
        sourceFieldElement.trigger(prePopupOpenEvent);
        if (prePopupOpenEvent.isDefaultPrevented()) {
            return;
        }

        var popupInstance = Vtiger_Popup_Js.getInstance();
        popupInstance.show(params, function(data) {
            var responseData = JSON.parse(data);
            var dataList = new Array();
            for (var id in responseData) {
                var data = {
                    'name': responseData[id].name,
                    'id': id
                }
                dataList.push(data);
            }
            var module = app.getModuleName();
            var opprefmodule = 'Contacts';
            var rec = data.id;
            var sentdata = {};
            sentdata.module = 'ACMPR';
            sentdata.record = rec;
            sentdata.source_module = opprefmodule;
            var rownumber = parentElem.find(".arpicrow").val();
            parentElem.find(".arpicname").val(data.name);
            parentElem.find(".arpicname").attr('readonly', true);
            thisInstance.getRecordDetails(sentdata).then(
                function(data) {
                    var response = data['result'];
                    var Contactsdata = response['data'];
                    var fieldkey = sourceFieldElement.attr('name');
                    thisInstance.ARPICFieldsCopy(Contactsdata, rownumber);
                },
                function(error, err) {

                });
            sourceFieldElement.trigger(Vtiger_Edit_Js.postReferenceSelectionEvent, {
                'data': responseData
            });
        });
    },
    referenceModuleAPRICPopup: function(container) {
        var thisInstance = this;
        container.on("click", '.arpicItemPopup', function(e) {
            thisInstance.openARPICPopUp(e);
        });
    },
    registerAPRICAutoSearch: function(container) {
        var thisInstance = this;
        container.find('input.autoapricComplete').autocomplete({
            'minLength': '3',
            'source': function(request, response) {
                var inputElement = jQuery(this.element[0]);
                var searchValue = request.term;
                var params = thisInstance.getReferenceSearchParams(inputElement);
                params.search_value = searchValue;
                params.search_module = "Contacts";
                thisInstance.searchModuleNames(params).then(function(data) {
                    var reponseDataList = new Array();
                    var serverDataFormat = data.result
                    if (serverDataFormat.length <= 0) {
                        jQuery(inputElement).val('');
                        serverDataFormat = new Array({
                            'label': app.vtranslate('JS_NO_RESULTS_FOUND'),
                            'type': 'no results'
                        });
                    }
                    for (var id in serverDataFormat) {
                        var responseData = serverDataFormat[id];
                        reponseDataList.push(responseData);
                    }
                    response(reponseDataList);
                });
            },
            'select': function(event, ui) {
                var selectedItemData = ui.item;
                //To stop selection if no results is selected
                if (typeof selectedItemData.type != 'undefined' && selectedItemData.type == "no results") {
                    return false;
                }
                selectedItemData.name = selectedItemData.value;
                var element = jQuery(this);
                var tdElement = element.closest('td');
                var rownumber = element.closest('tr').find('.arpicrow').val();
                thisInstance.setReferenceFieldValue(tdElement, selectedItemData);
                element.closest('tr').find('.arpicid').val(selectedItemData.id);
                element.closest('tr').find('.arpicname').attr('readonly', true);
                var rec = selectedItemData.id;
                var module = app.getModuleName();
                //manasa Jun 27 2016 Orgnization details copy
                var module = app.getModuleName();
                var opprefmodule = 'Contacts';
                var rec = selectedItemData.id;
                var sentdata = {};
                sentdata.module = 'ACMPR';
                sentdata.record = rec;
                sentdata.source_module = opprefmodule; //'Contacts';
                thisInstance.getRecordDetails(sentdata).then(
                    function(data) {
                        var response = data['result'];
                        var Contactsdata = response['data'];
                        var sourceField = tdElement.find('input[class="arpicid"]').attr('name');
                        thisInstance.ARPICFieldsCopy(Contactsdata, rownumber);
                    },
                    function(error, err) {

                    }
                );
                var fieldElement = tdElement.find('"#arpicid' + rownumber + '"');
                fieldElement.trigger(Vtiger_Edit_Js.postReferenceSelectionEvent, {
                    'data': selectedItemData
                });
            },
            'change': function(event, ui) {
                var element = jQuery(this);
                //if you dont have readonly attribute means the user didnt select the item
                if (element.attr('readonly') == undefined) {
                    //element.closest('td').find('.clearArpicItem').trigger('click');
                }
            }
        });
    },
    registerPersonFieldNumberChange: function() {
        var thisInstance = this;
        var PersonTable = jQuery("#personTab");
        var i = '';
		var k ='';
        //PersonFieldsMapping
        jQuery('#PERSONLIST').on('click', function(e) {
            var personno = jQuery('select[name="num_persons_cannabis"]').val();
            jQuery(".personItemRow").remove();
            var idFields = new Array('personrow', 'personname', 'personid', 'surname', 'givenname', 'gender');
            var currentSequenceNumber = 0;
			
            for (i = 1; i <= personno; i++) {
                var hiderow = jQuery('.personCloneCopy', PersonTable);
                var PERSONItemRow = hiderow.clone(true, true);
                PERSONItemRow.removeClass('hide');
                PERSONItemRow.removeClass('personCloneCopy');
                PERSONItemRow.addClass('personItemRow');
                for (var idIndex in idFields) {
                    var elementId = idFields[idIndex];
                    var actualElementId = elementId + currentSequenceNumber;
                    var expectedElementId = elementId + i;
                    PERSONItemRow.find('#' + actualElementId).attr('id', expectedElementId)
                        .filter('[name="' + actualElementId + '"]').attr('name', expectedElementId);
                }
                PERSONItemRow.appendTo(PersonTable);
                PERSONItemRow.attr('id', 'personrow' + i);
                PERSONItemRow.find("#personrow" + i).val(i);
                PERSONItemRow.find('input.personname').addClass('autopersonComplete');
                thisInstance.registerPersonAutoSearch(PERSONItemRow);
            }
			var personexistingdetails = jQuery.parseJSON(jQuery("#PersonDeails").attr('data-value'));
			k=1;
			jQuery(personexistingdetails).each(function(keys,values){
				PersonTable.find('#personname'+k).val(values['personname']);
				PersonTable.find('#personname'+k).attr('readonly','readonly');
				PersonTable.find('#personid'+k).val(values['contactid']);
				PersonTable.find('#surname'+k).val(values['surname']);
				PersonTable.find('#givenname'+k).val(values['givenname']);
				PersonTable.find('#gender'+k).val(values['gender']);
				k++;
			});
            e.preventDefault();
        });
        //DeleteRow Code
        jQuery('.persondeleteRow').on('click', function() {
            var element = jQuery(this);
            var rowclass = jQuery(this).closest('tr').attr('class');
            element.closest('tr.' + rowclass).remove();
            //Calcuations function need to add here also
        });
        //Drag code

        //Clear Grid
        jQuery('.clearpersonItem').on('click', function() {
            var element = jQuery(this);
            var trelement = jQuery(this).closest('tr');
            var addressMapping = thisInstance.PersonFieldsMapping;
            var rowNumber = trelement.find('.personrow').val();
            jQuery.each(addressMapping, function(key, v) {
                var displayval = '';
                var toElement = trelement.find('#' + v + rowNumber);
                toElement.val(displayval);
            });
            element.closest('tr').find('.personname').val('');
            element.closest('tr').find('.personname').removeAttr('readonly');
			element.closest('tr').find('.personname').removeAttr('disabled');
            element.closest('tr').find('.personid').val('');
        });
    },
    //ProposedPerson
    PersonFieldsMapping: {
        'lastname': 'givenname', //lastname
        'firstname': 'surname', //firstname
        'gender': 'gender'
    },
    PersonFieldsCopy: function(responsedata, rowno) {
        var thisInstance = this;
        var container = jQuery("#personTab");
        var addressMapping = this.PersonFieldsMapping;
        for (var key in addressMapping) {
            var displayval = responsedata[key];
			
            var toElement = container.find('"#' + addressMapping[key] + rowno + '"');
            toElement.val(displayval);
        }
    },
    openPersonPopUp: function(e) {
        var thisInstance = this;
        var parentElem = jQuery(e.target).closest('tr');
        var params = this.getPopUpParams(parentElem);
        var isMultiple = false;
    
        params.src_module = "ACMPR";
        params.module = "Contacts";
        var sourceFieldElement = jQuery('input[class="personid"]', parentElem);
        var prePopupOpenEvent = jQuery.Event(Vtiger_Edit_Js.preReferencePopUpOpenEvent);
        sourceFieldElement.trigger(prePopupOpenEvent);
        if (prePopupOpenEvent.isDefaultPrevented()) {
            return;
        }

        var popupInstance = Vtiger_Popup_Js.getInstance();
        popupInstance.show(params, function(data) {
            var responseData = JSON.parse(data);
            var dataList = new Array();
            for (var id in responseData) {
                var data = {
                    'name': responseData[id].name,
                    'id': id
                }
                dataList.push(data);
            }
            var module = app.getModuleName();
            var opprefmodule = 'Contacts';
            var rec = data.id;
            var sentdata = {};
            sentdata.module = 'ACMPR';
            sentdata.record = rec;
            sentdata.source_module = opprefmodule;
            var rownumber = parentElem.find(".personrow").val();
            parentElem.find(".personname").val(data.name);
            parentElem.find(".personname").attr('readonly', true);
            thisInstance.getRecordDetails(sentdata).then(
                function(data) {
                    var response = data['result'];
                    var Contactsdata = response['data'];
                    var fieldkey = sourceFieldElement.attr('name');
                    thisInstance.PersonFieldsCopy(Contactsdata, rownumber);
                },
                function(error, err) {

                });
            sourceFieldElement.trigger(Vtiger_Edit_Js.postReferenceSelectionEvent, {
                'data': responseData
            });
        });
    },
    referenceModulePersonPopup: function(container) {
        var thisInstance = this;
        container.on("click", '.personItemPopup', function(e) {
            thisInstance.openPersonPopUp(e);
        });
    },
    registerPersonAutoSearch: function(container) {
        var thisInstance = this;
        container.find('input.autopersonComplete').autocomplete({
            'minLength': '3',
            'source': function(request, response) {
                var inputElement = jQuery(this.element[0]);
                var searchValue = request.term;
                var params = thisInstance.getReferenceSearchParams(inputElement);
                params.search_value = searchValue;
                params.search_module = "Contacts";
                thisInstance.searchModuleNames(params).then(function(data) {
                    var reponseDataList = new Array();
                    var serverDataFormat = data.result
                    if (serverDataFormat.length <= 0) {
                        jQuery(inputElement).val('');
                        serverDataFormat = new Array({
                            'label': app.vtranslate('JS_NO_RESULTS_FOUND'),
                            'type': 'no results'
                        });
                    }
                    for (var id in serverDataFormat) {
                        var responseData = serverDataFormat[id];
                        reponseDataList.push(responseData);
                    }
                    response(reponseDataList);
                });
            },
            'select': function(event, ui) {
                var selectedItemData = ui.item;
                //To stop selection if no results is selected
                if (typeof selectedItemData.type != 'undefined' && selectedItemData.type == "no results") {
                    return false;
                }
                selectedItemData.name = selectedItemData.value;
                var element = jQuery(this);
                var tdElement = element.closest('td');
                var rownumber = element.closest('tr').find('.personrow').val();
                thisInstance.setReferenceFieldValue(tdElement, selectedItemData);
                element.closest('tr').find('.personid').val(selectedItemData.id);
                element.closest('tr').find('.personname').attr('readonly', true);
                var rec = selectedItemData.id;
                var module = app.getModuleName();
                //manasa Jun 27 2016 Orgnization details copy
                var module = app.getModuleName();
                var opprefmodule = 'Contacts';
                var rec = selectedItemData.id;
                var sentdata = {};
                sentdata.module = 'ACMPR';
                sentdata.record = rec;
                sentdata.source_module = opprefmodule; //'Contacts';
                thisInstance.getRecordDetails(sentdata).then(
                    function(data) {
                        var response = data['result'];
                        var Contactsdata = response['data'];
                        var sourceField = tdElement.find('input[class="personid"]').attr('name');
                        thisInstance.PersonFieldsCopy(Contactsdata, rownumber);
                    },
                    function(error, err) {

                    }
                );
                var fieldElement = tdElement.find('"#personid' + rownumber + '"');
                fieldElement.trigger(Vtiger_Edit_Js.postReferenceSelectionEvent, {
                    'data': selectedItemData
                });
            },
            'change': function(event, ui) {
                var element = jQuery(this);
                if (element.attr('readonly') == undefined) {

                }
            }
        });
    }
});


//$CURRENT_VIEW
//$VIEW
//$DEFAULT_RECORD_VIEW
//$IS_AJAX_ENABLED
//$IS_DELETABLE
//$IS_EDITABLE

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
		plvalues = Object.keys(vtRecordStructure[blockid][fieldid].fieldInfo.picklistvalues);
		plparams[pllabel] = plvalues;
		vtDZ_pickBlocks[pllabel] = [];
		plFieldBlockId[pllabel] = vtRecordStructure[blockid]["id"];
		plFieldId[pllabel] = vtRecordStructure[blockid][fieldid].id;
		plFieldName[pllabel] = vtRecordStructure[blockid][fieldid].name;
		plFieldLabel2Name[vtRecordStructure[blockid][fieldid].name] = pllabel;
		plFieldValue[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].fieldvalue;
		plModuleName[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].module.name;
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
