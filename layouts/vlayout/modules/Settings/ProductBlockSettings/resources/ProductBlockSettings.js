/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
jQuery.Class('Settings_ProductBlockSettings_Js', {}, {
    registerProductWeightEdit: function() {
        var thisInstance = this;
		jQuery(".dtcancel").on('click',function(e){
			var target =jQuery(e.currentTarget).closest('tr');
			target.find('.weightfield').addClass('hide');
			target.find('.edit').removeClass('hide');
			target.find('.display').removeClass('hide');
		});
        jQuery('.edit').on('click', function(e) {
			var target =jQuery(e.currentTarget).closest('tr');
			target.find('.weightfield').removeClass('hide');
			target.find('.edit').addClass('hide');
			target.find('.display').addClass('hide');
		});
		jQuery(".dtsave").on('click',function(e){
			var target =jQuery(e.currentTarget).closest('tr');
			var row = target.find("select").attr('data');
			var blocks = target.find("#blockids"+row).val();
			var prasentmodule = target.find("input[name='prasentmodule']").val();
			var productcategory = target.find("input[name='productcategory']").val();
			//Ended
			var params = {};
			params['blocks'] = blocks;
			params['productcategory'] = productcategory;
			params['module'] = "ProductBlockSettings";
			params['parent'] = "Settings";
			params['prasentmodule'] =  prasentmodule;
			params['action'] = "ProductBlockSave";
			AppConnector.request(params).then(
				function(data) {
					if(data.success == true) {
						var params = {
							title : app.vtranslate('JS_MESSAGE'),
							text: app.vtranslate('Data saved successfully.'),
							animation: 'show',
							type: 'info'
						};
						var blockname = "#blockids"+row;
						var selText = [];
						jQuery(blockname+" option:selected").each(function () {
						   var name = jQuery(this);
						   if (name.length) {
							selText.push(name.text());
						   }
						});
					target.find(".display").removeClass('hide');
					target.find(".display").html(selText.join("<br/>"));
					target.find(".weightfield").addClass('hide');
					target.find('.edit').removeClass('hide');
					Vtiger_Helper_Js.showPnotify(params);
						//window.location.reload();
					}
				}
			);
		});
    },
 
    registerEvents: function(e) {
        var thisInstance = this;
        this.registerProductWeightEdit();
    }
});

jQuery(document).ready(function() {
    var instance = new Settings_ProductBlockSettings_Js();
    instance.registerEvents();
})