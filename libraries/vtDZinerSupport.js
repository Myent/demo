function initialize() {
	jQuery("head").append(jQuery("<script type='text/javascript' src='libraries/locationpicker.jquery.js'>"));
	jQuery(".geography").each(function(){
		if (endsWith(jQuery(this).attr('id'), "-vtdzmap")){
			str=jQuery(this).attr('id');
			str=str.substring(0, str.length - 8);
			jQuery('#'+str+'-vtdzmap').locationpicker({
					location: {latitude: vtLatitude, longitude: vtLongitude },
					radius: 300,
					inputBinding: {
					latitudeInput: $('#'+str+'-lat'),
					longitudeInput: $('#'+str+'-lon'),
					radiusInput: $('#'+str+'-radius'),
					locationNameInput: $('#'+str+'-address')
					},
					enableAutocomplete: true,
					onchanged: function (currentLocation, radius, isMarkerDropped) {
						var addressComponents = $(this).locationpicker('map').location.addressComponents;
						updateControls(addressComponents, str);
						$('#'+str).val( currentLocation.latitude + ", " + currentLocation.longitude + ":||:" + jQuery("#"+str+"-address").val());
					},
					oninitialized: function(component) {
						var addressComponents = $(component).locationpicker('map').location.addressComponents;
						updateControls(addressComponents, str);
					}

			});
		}
	});
	jQuery(".googleclass").each(function(){
			var mapid = jQuery(this).attr('id');
			console.log(mapid);
			jQuery("#"+mapid).locationpicker({
                inputBinding: {
                   locationNameInput: $('#'+mapid)
                },
                enableAutocomplete: true,
				oninitialized: function(component) {
					var address = jQuery("#"+mapid+"_display").val();
				
					jQuery("#"+mapid).val(address);
				}
           });
	});
}


function endsWith(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
}

function log(str){
  console.log('['+new Date().getTime()+']\n'+str+'\n\n');
}

function loadScript(src,callback){
    var script = document.createElement("script");
    script.type = "text/javascript";
    //if(callback)script.onload=callback;
    document.getElementsByTagName("head")[0].appendChild(script);
    script.src = src;
  }

function updateControls(addressComponents, id) {
    $('#'+id+'-street1').val(addressComponents.addressLine1);
    $('#'+id+'-city').val(addressComponents.city);
    $('#'+id+'-state').val(addressComponents.stateOrProvince);
    $('#'+id+'-zip').val(addressComponents.postalCode);
    $('#'+id+'-country').val(addressComponents.country);
}

if ($(".geography")[0] || $(".googleclass")[0]){
    // Do something if class exists
	var key = '';
	jQuery.get('test/user/googlemap.txt', function(data) {
		key = data;
		loadScript('http://maps.googleapis.com/maps/api/js?v=3&sensor=false&callback=initialize&libraries=places&key='+key, function(){log('google-loader has been loaded, but not the maps-API ');});
	});
}

if ($(".googleclass")[0]){
    
}
if ($(".color")[0]){
    // Do something if class exists
	$("head").append($('<script type="text/javascript" src="libraries/jscolor/jscolor.js"></script>')); 
}

// vtComputedFields
/*-- console.log(jQuery("#view"));
console.log(jQuery("#module"));
compfields = [];
jQuery('.recordEditView').find('input').each(function(i,v){
	if (typeof jQuery(this).data('fieldinfo')!== "undefined"){
		compfield = jQuery(this).data('fieldinfo');
		compfields.push([i,compfield['label'], compfield['name'], compfield['fielduitype'], compfield['type']]);
		jQuery(this).on('change', function(){
			bootbox.alert('A compute field was changed');
		});
	}
});
//console.table(compfields);
console.log('Set up link in Settings on page');
vtComputeFields_HTML = '<div class="btn-group cursorPointer"><img width="24px" height="24px" class="alignMiddle" src="libraries/vtCFields.png" alt="Compute Fields" title="Click for Compute Fields Options" data-toggle="dropdown"><ul class="dropdown-menu"><li class="moduleComputations"><a title="Manage intra field computations">Compute Fields</a></li></ul></div>';
jQuery(".quickActions").find(".commonActionsButtonContainer").filter(":last").append(vtComputeFields_HTML);

console.log('get the saved vtiger_fieldcomputations for current module and UX form by Ajax');
console.log('Register onchange events for selected fields'); 

console.log('Register click event for link');
jQuery(".moduleComputations").click(function(e){
	cf_HTML = '<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script><style> .ui-widget-content {border-color: #ffffff;border-radius: 6px;box-shadow: 0 0 3px -1px inset;margin-left: 5px;margin-top: 2px; } </style> <div style="float:right"><button data-dismiss="modal" type="button" class="close vtButton">x</button></div><br style="clear:both" /><div id="tabs"><ul><li><a href="#tabs-1">Tab1</a></li><li><a href="#tabs-2">Tab2</a></li><li><a href="#tabs-3">Tab3</a></li></ul><div id="tabs-1"><p>Tab 1</p></div><div id="tabs-2"><p>Tab 2</p></div><div id="tabs-3"><p>Tab 3 </p></div></div><script>$(function() {$( "#tabs" ).tabs();});</script>';
	bootbox.alert(cf_HTML);
	console.table(compfields);
});*/

// Modal form UI
// New
// List with Edit/Delete/Move Up/Down for precedence sequence
Vtiger_Base_Validator_Js("Vtiger_mobilenumvalidation_Validator_Js",{
	/**
	 *Function which invokes field validation
	 *@param accepts field element as parameter
	 * @return error if validation fails true on success
	 */
	invokeValidation: function(field, rules, i, options){
		var positiveNumberInstance = new Vtiger_otherphone_Validator_Js();
		positiveNumberInstance.setElement(field);
		var response = positiveNumberInstance.validate();
		if(response != true){
			return positiveNumberInstance.getError();
		}
	}

},{

	/**
	 * Function to validate the Positive Numbers
	 * @return true if validation is successfull
	 * @return false if validation error occurs
	 */
	validate: function(){
		var fieldValue = this.getFieldValue();
		var field = this.getElement();
		var actfel = field.attr('data-name');
		var stdcode = field.closest('td').find("#"+actfel+"_stdcode").val();
		var phone = field.closest('td').find("#"+actfel+"_phone").val();
		var fieldlen =parseInt(fieldValue).toString().length;
		if( isNaN(fieldValue)){
			var errorInfo = app.vtranslate('Please Enter only numbers.');
			this.setError(errorInfo);
			return false;
		}
		var stdcon = stdcode+"-"+phone;
		jQuery("#"+actfel).val(stdcon);
		return true;
	}
});

Vtiger_Base_Validator_Js("Vtiger_vtdate_Validator_Js",{

	/**
	 *Function which invokes field validation
	 *@param accepts field element as parameter
	 * @return error if validation fails true on success
	 */
	invokeValidation: function(field, rules, i, options){
		var dateValidatorInstance = new Vtiger_Date_Validator_Js();
		dateValidatorInstance.setElement(field);
		var response = dateValidatorInstance.validate();
		if(response != true){
			return dateValidatorInstance.getError();
		}
		return response;
	}

},{

	/**
	 * Function to validate the Positive Numbers and whole Number
	 * @return true if validation is successfull
	 * @return false if validation error occurs
	 */
	validate: function(){
		var fieldValue = this.getFieldValue();
		var field = this.getElement();
		var fieldData = field.data();
		var fieldname = fieldData.fieldName;

		var fieldDateFormat = fieldData.dateFormat;
		var container=jQuery('#EditView');
		if(container.length == 0){
			var container=jQuery('form');
		}

		try{
			Vtiger_Helper_Js.getDateInstance(fieldValue,fieldDateFormat);
		}
		catch(err){
			container.find('[name="'+fieldname+'"]').prev('div').show();
			var errorInfo = app.vtranslate("JS_PLEASE_ENTER_VALID_DATE");
			this.setError(errorInfo);
			return false;
		}
		var fieldDateInstance = Vtiger_Helper_Js.getDateInstance(fieldValue,fieldDateFormat);
		fieldDateInstance.setHours(0,0,0,0);
	
		var calfield = fieldname.slice(0,-5);
		var timefield = jQuery("input[name*='"+calfield+"_time']").val();
		//Lessthanorequal today
		if(timefield == ''){
			var errorInfo = app.vtranslate("Please fill both the fields.");
			this.setError(errorInfo);
			return false;
		}
		calculate_formatted_dt_time(calfield);
		return true;
	}


});

Vtiger_Base_Validator_Js("Vtiger_vttime_Validator_Js",{

	/**
	 * Function which invokes field validation
	 * @param accepts field element as parameter
	 * @return error if validation fails true on success
	 */
	invokeValidation : function(field, rules, i, options) {
		var validatorInstance = new Vtiger_Time_Validator_Js();
		validatorInstance.setElement(field);
		var result = validatorInstance.validate();
		if(result == true){
			return result;
		} else {
			return validatorInstance.getError();
		}
	}

},{

	/**
	 * Function to validate the Time Fields
	 * @return true if validation is successfull
	 * @return false if validation error occurs
	 */
	validate: function(){
		var fieldValue = this.getFieldValue();
		var field = this.getElement();
		var fieldData = field.data();
		var fieldname = fieldData.fieldName;
		var time = fieldValue.replace(fieldValue.match(/[AP]M/i),'');
		var timeValue = time.split(":");
		if(isNaN(timeValue[0]) && isNaN(timeValue[1])) {
			var errorInfo = app.vtranslate("JS_PLEASE_ENTER_VALID_TIME");
			this.setError(errorInfo);
			return false;
		}
		var calfield = fieldname.slice(0,-5);
		var datefield = jQuery("input[name*='"+calfield+"_date']").val();
		if(datefield == ''){
			var errorInfo = app.vtranslate("Please fill both the fields.");
			this.setError(errorInfo);
			return false;
		}
		calculate_formatted_dt_time(calfield);
		return true;
	}

});
 function calculate_formatted_dt_time(fieldname){
		var container=jQuery('form');
		var dt_field=fieldname+'_date';
		var dt=container.find('[name="'+dt_field+'"]').val();
		var fieldDateFormat = container.find('[name="'+dt_field+'"]').attr("data-date-format");
		var fieldValue = dt;
		var time_field=fieldname+'_time';
		container.find('[name="'+dt_field+'"]').prev('div').hide();
		container.find('[name="'+time_field+'"]').prev('div').hide();
		var tim=container.find('[name="'+time_field+'"]').val();

		if(dt!=""){
			var datet = dt.split("-");
			
			if(fieldDateFormat == "mm-dd-yyyy"){
				var dt = datet[2]+"-"+datet[0]+"-"+datet[1];
				
			}else if(fieldDateFormat == "dd-mm-yyyy"){
				var dt = datet[2]+"-"+datet[1]+"-"+datet[0];
			}else{
					var dt = dt;
			}
		 console.log(dt);
		}
        var tim = tim!='' ? am_pm_to_hours(tim) : '';
		var dt_n_tim = dt+' '+tim;
		container.find('[name="'+fieldname+'"]').val(dt_n_tim);
	}
 function am_pm_to_hours(timeStr) {
		var colon = timeStr.indexOf(':');
		var hours = timeStr.substr(0, colon),
		minutes = timeStr.substr(colon+1, 2),
		meridian = timeStr.substr(colon+4, 2).toUpperCase();
		var hoursInt = parseInt(hours, 10),
		offset = meridian == 'PM' ? 12 : 0;
		if (hoursInt === 12) {
		hoursInt = offset;
		} else {
		hoursInt += offset;
		}
		return hoursInt + ":" + minutes;
    }
Vtiger_Base_Validator_Js("Vtiger_RangeNumber_Validator_Js",{

	/**
	 * Function which invokes field validation
	 * @param accepts field element as parameter
	 * @return error if validation fails true on success
	 */
	invokeValidation : function(field, rules, i, options) {
		var validatorInstance = new Vtiger_Time_Validator_Js();
		validatorInstance.setElement(field);
		var result = validatorInstance.validate();
		if(result == true){
			return result;
		} else {
			return validatorInstance.getError();
		}
	}

},{

	/**
	 * Function to validate the Time Fields
	 * @return true if validation is successfull
	 * @return false if validation error occurs
	 */
	validate: function(){
		var fieldValue = this.getFieldValue();
		var field = this.getElement();
		var fieldData = field.data();
		var fieldname = fieldData.fieldName;
		var negativeRegex=  /(^[-]+\d+)$/  ;
		if(isNaN(fieldValue) || fieldValue <= 0 || fieldValue.match(negativeRegex) || fieldValue > 10){
			var errorInfo = "Please give number between 1 to 10.";
			this.setError(errorInfo);
			return false;
		}
		return true;
	}

});

