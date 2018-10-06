/* ********************************************************************************
 * The content of this file is subject to the Related Record Update ("License");
 * You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is VTExperts.com
 * Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
 * All Rights Reserved.
 * ****************************************************************************** */

Settings_Workflows_Edit_Js.prototype.preSaveSumFieldTask = function(tasktype) {
    var values = this.getVTEValues(tasktype);
    jQuery('[name="field_value_mapping"]').val(JSON.stringify(values));
};

Settings_Workflows_Edit_Js.prototype.getSumFieldTaskFieldList = function() {
    return new Array('sum_field', 'update_field','total_modulename','total_field','total_sumby');
};
Settings_Workflows_Edit_Js.prototype.getVTEValues = function(tasktype) {
    var thisInstance = this;
    //var conditionsContainer = jQuery('#save_fieldvaluemapping');
    var fieldListFunctionName = 'get'+tasktype+'FieldList';
    if(typeof thisInstance[fieldListFunctionName] != 'undefined' ){
        var fieldList = thisInstance[fieldListFunctionName].apply()
    }

    var sum_module_name_element = jQuery('[name="sum_module_name"]');
    var sum_fieldid_element= jQuery('[name="sum_field"]');
    var update_fieldid_element= jQuery('[name="update_field"]');

    var totalsum_module_name_element= jQuery('[name="totalsum_module_name"]');
    var total_update_fieldid_element= jQuery('[name="total_update_field"]');
    var total_sumby_element= jQuery('[name="sumby"]');
    //To not send empty fields to server
    if(thisInstance.isEmptyFieldSelected(sum_module_name_element)) {
        return true;
    }
    if(thisInstance.isEmptyFieldSelected(sum_fieldid_element)) {
        return true;
    }
    if(thisInstance.isEmptyFieldSelected(update_fieldid_element)) {
        return true;
    }
    if(thisInstance.isEmptyFieldSelected(totalsum_module_name_element)) {
        return true;
    }
    if(thisInstance.isEmptyFieldSelected(total_update_fieldid_element)) {
        return true;
    }
    if(thisInstance.isEmptyFieldSelected(total_sumby_element)) {
        return true;
    }
    var values = [];
    var rowValues = {};
    rowValues['sum_field']=sum_fieldid_element.find('option:selected').val();
    rowValues['update_field']=update_fieldid_element.find('option:selected').val();
    rowValues['total_modulename']=totalsum_module_name_element.val();
    rowValues['total_field']=total_update_fieldid_element.find('option:selected').val();
    rowValues['total_sumby']=total_sumby_element.find('option:selected').val();
    values.push(rowValues);

    return values;
};

Settings_Workflows_Edit_Js.prototype.SumFieldTaskCustomValidation = function () {
    var result = true;
    return result;
};
Settings_Workflows_Edit_Js.prototype.registerSumFieldTaskEvents = function () {

};

