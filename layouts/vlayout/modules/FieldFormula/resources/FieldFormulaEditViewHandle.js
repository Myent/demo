jQuery(document).ready(function () {
    // ================ Handle EditView to pre-popular data =============================== //
    var current_url = jQuery.url();
    var current_module = current_url.param('module');
    var current_view = current_url.param('view');
    var current_record = current_url.param('record');
    if(current_view=='Edit'){
        jQuery('#EditView input').change(function(){
            var field_name = jQuery(this).attr('name');
            if(this.value != '' && field_name !="record"){
                handleFields(field_name, this.value);
            }
        });

        jQuery('#EditView select').change(function(){			
            var field_name = jQuery(this).attr('name');
			if(this.value != ''){
                handleFields(field_name, this.value);
            }
        });

    }
    jQuery( document ).ajaxComplete(function(event, xhr, settings) {
        var url_posted = getQueryParams(settings.data);
        if(typeof(url_posted) != 'undefined' ){
            var posted_action= url_posted.action;
            // do not reload page when saving record via RelatedListviewEdits module
            var arr_ignore_modules = ["RelatedListviewEdits", "Users", "SMSNotifier", "Settings"];
            if(posted_action === "SaveAjax" && jQuery.inArray(url_posted.module,arr_ignore_modules) == -1 && url_posted.parent !='Settings'){
                handleFields(url_posted.field,url_posted.value,true);
            }
        }
    });
});
function getQueryParams(qs) {
    if(typeof(qs) != 'undefined' ){
        qs = qs.toString().split('+').join(' ');

        var params = {},
            tokens,
            re = /[?&]?([^=]+)=([^&]*)/g;

        while (tokens = re.exec(qs)) {
            params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);
        }
        return params;
    }
}

function handleFields(field_name, fieldvalue,on_details){
    var current_url = jQuery.url();
    var current_module = current_url.param('module');
    var current_view = current_url.param('view');
    var current_record = current_url.param('record');
    jQuery.ajax({
        type: "POST",
        url: "index.php",
        data: {
            module: "FieldFormula",
            action: "ActionAjax",
            mode: "CheckIsBelongToFormulaFieldForEdit",
            pmodule: current_module,
            fieldname: field_name,
            fieldvalue: fieldvalue,
            record: current_record
        },
        success:function (response) {
            if(response.result.existed){
                var return_formula = response.result.return_formula;
                jQuery.each( return_formula, function( i, val ) {
                    var formula_field = val.formula_field;
                    var formula = val.formula;
                    String.prototype.replaceAll = function (find, replace) {
                        var str = this;
                        return str.replace(new RegExp(find, 'g'), replace);
                        //return str.replace(/find/g, replace);
                    };
                    //container
                    var is_time_calculate = false;
                    var is_date_calculate = false;
                    var form_fields = jQuery("#EditView input, select");
                    if(on_details) form_fields = jQuery("#detailView input, select");
                    form_fields.each(function(){
                        var input_field_name = jQuery(this).attr('name');
                        if(jQuery(this).is( ":text" )){
                            if(formula.indexOf(input_field_name)!== -1){
                                var input_ctrl = jQuery('#'+current_module+'_editView_fieldName_'+input_field_name);
                                var input_type = input_ctrl.data('fieldinfo').type;
                                var input_val = input_ctrl.val();
                                if(input_type == 'currency'){
                                    var data_group_seperator = input_ctrl.data('group-seperator');
                                    if(data_group_seperator == '.') {
                                        input_val = input_val.toString().replace(/\./g,'');
                                    }else{
                                        input_val = input_val.toString().replaceAll(data_group_seperator,'');
                                    }
                                    input_val = input_val.replace(/,/g, "").replace(/ /g, "");
                                }
                                if((input_val == '' || isNaN(input_val)) && input_type !== 'time' && input_type !== 'date' ) {
                                    input_val=0;
                                }
                                if(input_type === 'time' ) {
                                    is_time_calculate = true;
                                }
                                if(input_type === 'date' ) {
                                    is_date_calculate = true;
                                    //input_val = input_val.replace('-','/');
                                    input_val = input_val.replace(/-/gi, "/");
                                    formula = formula.replaceAll(input_field_name,input_val);
                                }
                                else{
                                    formula = formula.replaceAll(input_field_name,input_val);
                                }

                            }
                        }
                        else if(jQuery(this).is( "select" )) {
                            if(formula.indexOf(input_field_name)!== -1){
                                var input_ctrl = jQuery('[name="'+input_field_name+'"]');
                                var input_type = input_ctrl.data('fieldinfo').type;
                                var input_val = input_ctrl.val();
                                if(input_type == 'currency'){
                                    var data_group_seperator = input_ctrl.data('group-seperator');
                                    if(data_group_seperator == '.') {
                                        input_val = input_val.toString().replace(/\./g,'');
                                    }else{
                                        input_val = input_val.toString().replaceAll(data_group_seperator,'');
                                    }
                                    input_val = input_val.replace(/,/g, "").replace(/ /g, "");
                                }
                                if((input_val == '' || isNaN(input_val)) && input_type !== 'time' && input_type !== 'date' ) {
                                    input_val=0;
                                }
                                if(input_type === 'time' ) {
                                    is_time_calculate = true;
                                }
                                if(input_type === 'date' ) {
                                    is_date_calculate = true;
                                    //input_val = input_val.replace('-','/');
                                    input_val = input_val.replace(/-/gi, "/");
                                    formula = formula.replaceAll(input_field_name,input_val);
                                }
                                else{
                                    formula = formula.replaceAll(input_field_name,input_val);
                                }

                            }
                        }
                    });
                    var new_formula_field = 0;
                    if(is_time_calculate){
                        new_formula_field = timer_calulating(formula).toFixed(2);
                    }
                    else if(is_date_calculate){
                        new_formula_field = date_calulating(formula);
                    }
                    else {
                        new_formula_field = eval(formula).toFixed(2);
                    }
                    jQuery('#'+current_module+'_editView_fieldName_'+formula_field).val(new_formula_field);
                    if(on_details) {
                        var td_value = jQuery('#'+current_module+'_detailView_fieldValue_'+formula_field);
                        td_value.find('span:first').html(new_formula_field);
                    }
                    jQuery('#'+current_module+'_editView_fieldName_'+formula_field).trigger('change');
                });

            }
        }
    });
}
function checkIsBelongToFormulaField(fieldname){
    var current_url = jQuery.url();
    var current_module = current_url.param('module');
    jQuery.ajax({
        type: "POST",
        url: "index.php",
        data: {
            module: "FieldFormula",
            action: "ActionAjax",
            mode: "CheckIsBelongToFormulaField",
            pmodule: current_module,
            fieldname: fieldname
        },
        success:function (response) {
            if(response.result.existed){
                return response.result.formula;
            }else{
                return "";
            }
        }
    });
}
function timer_calulating(fomular){
    var arr_f = fomular.split("-");
    var timeStart = new Date("01/01/2016 " + arr_f[1]);
    var timeEnd = new Date("01/01/2016 " + arr_f[0]);
    var diff = timeEnd.valueOf() - timeStart.valueOf();
    var diffInHours = diff/1000/60/60; // Convert milliseconds to hours
    return diffInHours
}
function date_calulating(fomular){
    var arr_f = fomular.split("-");
    var date_field_search = jQuery('.dateField:first');
    var current_date_format = date_field_search.data('date-format');
    if(isDate(arr_f[0]) && isDate(arr_f[1])){
        var date1 = parseDate(arr_f[0].trim(),current_date_format);
        var date2 = parseDate(arr_f[1].trim(),current_date_format);
        var diff = date1.valueOf() - date2.valueOf();
        var diffInDays= diff/1000/60/60/24; // Convert milliseconds to day
        return Math.round(diffInDays - 0.5);
    }
    else{
        return 0;
    }

}
function parseDate(input, format) {
    format = format || 'yyyy-mm-dd'; // default format
    var parts = input.match(/(\d+)/g),
        i = 0, fmt = {};
    // extract date-part indexes from the format
    format.replace(/(yyyy|dd|mm)/g, function(part) { fmt[part] = i++; });

    return new Date(parts[fmt['yyyy']], parts[fmt['mm']]-1, parts[fmt['dd']]);
}
function isDate(value) {
    var date_field_search = jQuery('.dateField:first');
    var current_date_format = date_field_search.data('date-format');
    if(current_date_format == "dd-mm-yyyy"){
        var arr_date1 = value.trim().split("/");
        value = new Date(arr_date1[2],arr_date1[1],arr_date1[0]).toString();
    }
    var dateWrapper = new Date(value);
    return !isNaN(dateWrapper.getDate());
}
