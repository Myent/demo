/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Detail_Js("ACMPR_Detail_Js",{},{
	ContactFieldsACMPRMapping : {
		//Legal name
		'legal_name':{
			'trade_name':'other_corporation_reg_name', //trade name :: Need to create name in contacts module
			'ship_street' : 'ship_street_address',//ship street address
			'ship_city' : 'ship_city',//ship city
			'ship_state' : 'ship_province', // ship province
			'ship_code' : 'ship_postal_code', //ship postal code
			'phone' : 'ship_phone_no', //primary phone :ship phone no 
			'fax' : 'ship_fax_no', //ship fax no
			'primary_email' : 'ship_email', // ship email :: Need to create name in contacts module
			'bill_street' : 'bill_street_address', //Bill street Address
			'bill_city' : 'bill_city', //Bill City
			'bill_state' : 'bill_province', //Bill province
			'bill_code' : 'bill_postal_code'//Bill Postal Code
		},
		//Org testing laboratory name
		'third_party_laboratory_name':{//Labratory name
			'orgfulladdress' : 'address',//address field
			'drugs_licence_number' : 'drugs_licence_number',//License number :: Need to create name in contacts module
		},
		//appilcant section2
		'applicant':{
			'title':'title',// title 
			'gender':'gender',//gender :: gender required to create contacts module
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
			'gender':'senior_gender',//gender
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
			'gender':'rpic_gender',//gender :: need to create conatct
			'birthday':'rpic_dob',//dob
			'worked_hours_days':'rpic_work_hours_days',//workedhoursanddays :: need to create conatct
			'other_title':'rpic_other_title',//othertitle :: need to create conatct
			
		},
		//Section7OwnershipofProperty
		'sameRPIC' :{//rpic_applicant
			'lastname':'spic_surname',//Lastname
			'firstname':'spic_givename',//Firstname
			'other_title':'spic_other_title',//OtherTitle :: need to create conatct
		//	'sigimage':'spic_signature',//SPICseniorsignature :: need to create conatct
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
				'gender':'qap_gender',//gender
				'birthday':'qap_dob',//DOb
				'worked_hours_days':'qap_worked_hours_days',//workedhoursanddays
		},
		//PAC Person1
		//Section 13 joint ownerDocument
		'joint_owner1' : {
			'fulladdress':'joint_owner1_address',//Fulladdress
		},
		'joint_owner2' : {
			'fulladdress':'joint_owner2_address',//Fulladdress
		},
	},
	
	
	/**
	 * Function to register event for image graphics
	 */
	registerEventForImageGraphics : function(){
		var imageContainer = jQuery('#imageContainer');
		imageContainer.cycle({ 
			fx:    'curtainX', 
			sync:  false, 
			speed:1000,
			timeout:20
		 });
		 imageContainer.find('img').on('mouseenter',function(){
			 imageContainer.cycle('pause');
		 }).on('mouseout',function(){
			 imageContainer.cycle('resume');
		 });
		var imageContainer = jQuery('.imageContainer');
		imageContainer.cycle({
				fx:    'curtainX',
				sync:  false,
				speed:1000,
				timeout:20
		 });
		 imageContainer.find('img').on('mouseenter',function(){
				 imageContainer.cycle('pause');
		 }).on('mouseout',function(){
				 imageContainer.cycle('resume');
		 });
	},
	//manasa added this on oct 12 2017 ended here
	ACMPRFieldsRedaonly : function(responsedata){
		var thisInstance = this;
		var container = jQuery("#detailView");
		var addmap = this.ContactFieldsACMPRMapping;
		jQuery.each(addmap,function(key,addressMapping) {
			jQuery.each(addressMapping ,function(k,v){
				var toElement = container.find('[name="'+v+'"]');
				toElement.attr('readonly','readonly');//.trigger("liszt:updated");
				jQuery('select[name*="'+v+'"]').prop('disabled', true).trigger('liszt:updated');
				var classname = jQuery('input[name*="'+v+'"]').attr('class');
				if(classname == 'dateField'){
					jQuery('input[name*="'+v+'"]').attr("disabled", true);
				}
			});
		});
		
		
	},
	registerUnselectRadioEvents : function(){
		var formElement = this.getForm();
		console.log(formElement);
		jQuery('#detailView').find('.radio').on('click',function(e) {
			if (this.getAttribute('checked')) {
				jQuery(this).removeAttr('checked');
				jQuery(this).val('');
			} else {
				jQuery(this).attr('checked', true);
				var disval = jQuery(this).attr('data-display');
				console.log(disval);
				jQuery(this).val(disval);
			}
		});
	},
	//manasa ended here
	/**
	 * Function to register events
	 */
	registerEvents : function(){
		this._super();
		this.registerEventForImageGraphics();
		this.ACMPRFieldsRedaonly();
		this.registerUnselectRadioEvents();
		jQuery('input[name*="appendix_a_attached"]').attr('readonly','readonly');
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
						jQuery("#"+vtRecordModel.entity.moduleName+"_detailView_fieldValue_"+index).find("span").first().html(value);
					});
				}
			}
			
			// Implementation of Pickblocks
			if (typeof pickBlocks !== 'undefined') {
				if (Object.keys(pickBlocks).length > 0) {
					jQuery.each(pickBlocks, function(index, value){
						pickkey = jQuery("#"+vtRecordModel.entity.moduleName+"_detailView_fieldValue_"+index).find("span").first().html().trim();
						selectedBlockId = "";
						jQuery.each(value, function(i,e){
							jQuery("#detailView").find("[data-id=\"" + e + "\"]").closest('table').hide();
							// TODO There is a remnant <br/>. Must be removed and readded as necessary. Also include in the onchange function
							if (i == pickkey) {
								selectedBlockId=e;
							}
							jQuery("#detailView").find("[data-id=\"" + selectedBlockId + "\"]").closest('table').show();
						});

						// set the onchange function
						jQuery("#"+vtRecordModel.entity.moduleName+"_detailView_fieldValue_"+index).change(function(){
							selectedBlockId = "";
							selectedKey = jQuery(this).closest('td').attr('id').split(vtRecordModel.entity.moduleName+"_detailView_fieldValue_")[1];
							pickkey = jQuery("#"+vtRecordModel.entity.moduleName+"_detailView_fieldValue_"+selectedKey).find("a.chzn-single").find('span').first().text().trim();
							pickKeys = pickBlocks[selectedKey];
							jQuery.each(pickKeys, function(i,e){
								jQuery("#detailView").find("[data-id=\"" + e + "\"]").closest('table').hide();
								if (i == pickkey) {
									selectedBlockId=e;
								} 
								jQuery("#detailView").find("[data-id=\"" + selectedBlockId + "\"]").closest('table').show();
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