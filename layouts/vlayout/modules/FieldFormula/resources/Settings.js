/* ********************************************************************************
 * The content of this file is subject to the Table Block ("License");
 * You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is VTExperts.com
 * Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
 * All Rights Reserved.
 * ****************************************************************************** */

jQuery.Class("FieldFormula_Settings_Js",{

},{
    //updatedBlockSequence : {},
    registerAddButtonEvent: function () {
        var thisInstance=this;
        jQuery('.contentsDiv').on("click",'.addButton', function(e) {
            var source_module = jQuery('#tableBlockModules').val();
            if(source_module !='' && source_module !='All') {
                var url=jQuery(e.currentTarget).data('url') + '&source_module='+source_module;
            }else {
                var url=jQuery(e.currentTarget).data('url');
            }
            thisInstance.showEditView(url);
        });
    },
     registerEditButtonEvent: function() {
         var thisInstance=this;
         jQuery(document).on("click",".editBlockDetails", function(e) {
             var url = jQuery(this).data('url');
             thisInstance.showEditView(url);
         });
     },
     /*
      * function to show editView for Add/Edit block
      * @params: url - add/edit url
      */
     showEditView : function(url) {
         var thisInstance = this;
         var progressIndicatorElement = jQuery.progressIndicator();
         var actionParams = {
             "type":"POST",
             "url":url,
             "dataType":"html",
             "data" : {}
         };
         AppConnector.request(actionParams).then(
             function(data) {
                 progressIndicatorElement.progressIndicator({'mode' : 'hide'});
                 if(data) {
                     var callBackFunction = function(data) {
                         var form = jQuery('#tableblocks_form');
                         var params = app.validationEngineOptions;
                         params.onValidationComplete = function(form, valid){
                             if(valid) {
                                 thisInstance.saveFormulaDetails(form);
                                 return valid;
                             }
                         }
                         form.validationEngine(params);

                         form.submit(function(e) {
                             e.preventDefault();
                         })
                     }
                     app.showModalWindow(data, function(data){
                         if(typeof callBackFunction == 'function'){
                             callBackFunction(data);
                         }
                         thisInstance.registerPopupEvents();
                     }, {'width':'700px'})
                 }
             }
         );
     },

     /**
      * This function will save the block detail
      */
     saveFormulaDetails : function(form) {         
         var thisInstance = this;
         
         //Validate formula
         var validate_params = {};
         validate_params['module'] = app.getModuleName();
         validate_params['action'] = 'ActionAjax';
         validate_params['mode'] = 'validateFormula';
         validate_params['formula'] = jQuery('#formula').val();
         validate_params['module_selected'] = jQuery('#select_module').val();;
         AppConnector.request(validate_params).then(
             function(data) {
                if(data["result"].valid)
                {
                     //save valid formula
                        var progressIndicatorElement = jQuery.progressIndicator({
                           'position' : 'html',
                           'blockInfo' : {
                               'enabled' : true
                           }
                       });


                       var data_form = form.serializeFormData();
                       data_form['module'] = app.getModuleName();
                       data_form['action'] = 'SaveAjax';
                       data_form['mode'] = 'saveFieldFormulaDetails';

                       AppConnector.request(data_form).then(                 
                           function(data) {                 
                               if(data['success']) {
                                   progressIndicatorElement.progressIndicator({'mode' : 'hide'});
                                   app.hideModalWindow();
                                   var params = {};
                                   var message = app.vtranslate('Formula saved')
                                   params = {
                                            text: message,
                                            type: 'success'
                                    }                                   
                                   Settings_Vtiger_Index_Js.showMessage(params);
                                   thisInstance.loadListFormula();

                               }                 
                           },
                           function(error) {
                               progressIndicatorElement.progressIndicator({'mode' : 'hide'});
                               //TODO : Handle error
                           }
                       );
                }
                else{
                        var error_mss = "";
                        if(data["result"].error ===0) error_mss = app.vtranslate('Formula is invalid');
                        if(data["result"].error ===1) error_mss = app.vtranslate('Only choice nummeric field');
                        if(data["result"].error ===2) error_mss = app.vtranslate('Only support duration calculate,eg EndTime - StartTime');
                        if(data["result"].error ===3) error_mss = app.vtranslate('Only support subtract dates and get result in days,eg Date2 - Date1');
                        var FormulaErrorParam = {};
                                    FormulaErrorParam = {
                            text: error_mss,
                            type: 'error'
                        }
                        Settings_Vtiger_Index_Js.showMessage(FormulaErrorParam);
                        jQuery('#formula').focus();
                        return false;;
                } 
             }
         );
     },
     loadListFormula: function() {
         var progressIndicatorElement = jQuery.progressIndicator({
             'position' : 'html',
             'blockInfo' : {
                 'enabled' : true
             }
         });
         var params = {};
         params['module'] = 'FieldFormula';
         params['view'] = 'MassActionAjax';
         params['mode'] = 'reloadListFieldFormula';
         params['source_module'] = jQuery('#tableBlockModules').val();

         AppConnector.request(params).then(
             function(data) {
                 progressIndicatorElement.progressIndicator({'mode' : 'hide'});
                 var contents = jQuery('.listViewEntriesDiv');
                 contents.html(data);
                 //thisInstance.registerSortableEvent();
             }
         );
     },
     /**
      * Function which will handle the registrations for the elements
      */
     registerPopupEvents: function() {
         var container=jQuery('#massEditContainer');
         this.registerPopupSelectModuleEvent(container);
         this.registerPopupSelectFieldEvent(container);
     },

     registerPopupSelectModuleEvent : function(container) {
         var thisInstance = this;
         container.on("change",'[name="select_module"]', function(e) {
             var progressIndicatorElement = jQuery.progressIndicator();
             var select_module=jQuery(this).val();
             var actionParams = {
                 "type":"POST",
                 "url": "index.php?module=FieldFormula&view=EditAjax&mode=getFields",
                 "dataType":"html",
                 "data" : {
                     "select_module" : select_module
                 }
             };
             AppConnector.request(actionParams).then(
                 function(data) {
                     progressIndicatorElement.progressIndicator({'mode' : 'hide'});
                     if(data) {
                         container.find('#div_field').html(data);
                         // TODO Make it better with jQuery.on
                         app.changeSelectElementView(container); 
                         app.showSelect2ElementView(container.find('select.select2'));                        
                     }
                 }
             );             
         })
     },
     registerPopupSelectFieldEvent : function(container) {
         //var thisInstance = this;
         container.on("change",'[name="field"]', function(e) {
             var select_field=jQuery(this).val();
             var formula  = container.find('#formula').val();             
             container.find('#formula').val(formula + " " + select_field);
         });
     },
     registerDeleteFormulaEvent: function () {
         var thisInstance = this;
         var contents = jQuery('.listViewEntriesDiv');
         contents.on('click','.deleteBlock', function(e) {
             var element=jQuery(e.currentTarget);
             var message = app.vtranslate('JS_LBL_ARE_YOU_SURE_YOU_WANT_TO_DELETE');
             Vtiger_Helper_Js.showConfirmationBox({'message' : message}).then(
                 function(e) {
                     var blockId = jQuery(element).data('id');
                     var params = {};
                     params['module'] = 'FieldFormula';
                     params['action'] = 'ActionAjax';
                     params['mode'] = 'deleteFormula';
                     params['record'] = blockId;

                     AppConnector.request(params).then(
                         function(data) {
                             thisInstance.loadListFormula();
                         }
                     );
                 },
                 function(error, err){
                 }
             );
         });
     },
     registerEvents : function() {
         this.registerAddButtonEvent();
         this.registerEditButtonEvent();
         this.registerDeleteFormulaEvent();
     }
});