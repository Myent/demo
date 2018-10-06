/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
jQuery.Class('Settings_OS2CheckList_Js', {
	
	//holds the currency instance
	checkListInstance : false,
	//ckEditorInstance: false,
	
	/**
	 * This function used to triggerAdd Currency
	 */
	triggerAdd : function(event) {
		event.stopPropagation();
		var instance = Settings_OS2CheckList_Js.checkListInstance;
		instance.showEditView();
	},
	
	triggerEdit : function(event,id) {
		event.stopPropagation();
		var instance = Settings_OS2CheckList_Js.checkListInstance;
		instance.showEditView(id);
	},
	
	triggerDelete : function(event, id) {
		event.stopPropagation();
		var currentTarget = jQuery(event.currentTarget);
		var currentTrEle = currentTarget.closest('tr');
		var instance = Settings_OS2CheckList_Js.checkListInstance;
		instance.deleteCheckList(id, currentTrEle);
	}
	
	
}, {
	
	/*
	 *Function to set the textArea element 
	 */
	setElement : function(element){
		this.element = element;
		return this;
	},
	
	/*
	 *Function to get the textArea element
	 */
	getElement : function(){
		return this.element;
	},
	
	/*
	 * Function to return Element's id atrribute value
	 */
	getElementId :function(){
		var element = this.getElement();
		return element.attr('id');
	},
	/*
	 * Function to get the instance of ckeditor
	 */
	
	getCkEditorInstanceFromName :function(){
		var elementName = this.getElementId();
		return CKEDITOR.instances[elementName];
	},
    
    /***
     * Function to get the plain text
     */
    getPlainText : function() {
        var ckEditorInstnace = this.getCkEditorInstanceFromName();
        return ckEditorInstnace.document.getBody().getText();
    },
	/*
	 * Function to load CkEditor
	 * @params : element: element on which CkEditor has to be loaded, config: custom configurations for ckeditor
	 */
	loadCkEditor : function(element,customConfig){
		
		this.setElement(element);
		var instance = this.getCkEditorInstanceFromName();
		var elementName = this.getElementId();
		var config = {}
        
		if(typeof customConfig != 'undefined'){
			var config = jQuery.extend(config,customConfig);
		}
		if(instance)
		{
			CKEDITOR.remove(instance);
		}
		
		
    
		CKEDITOR.replace( elementName,config);
	},
	
	/*
	 * Function to load contents in ckeditor textarea
	 * @params : textArea Element,contents ;
	 */
	loadContentsInCkeditor : function(contents){
		var editor = this.getCkEditorInstanceFromName();
		var editorData = editor.getData();
		var replaced_text = editorData.replace(editorData, contents); 
		editor.setData(replaced_text);	
	},
	
	//constructor
	init : function() {
		Settings_OS2CheckList_Js.checkListInstance = this;
	},
	
	/*
	 * function to show editView for Add/Edit Currency
	 * @params: id - currencyId
	 */
	showEditView : function(id) {
		var thisInstance = this;
		var aDeferred = jQuery.Deferred();
		
		var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});
		
		var params = {};
		params['module'] = app.getModuleName();
		params['parent'] = app.getParentModuleName();
		params['view'] = 'EditAjax';
		params['record'] = id;
		
		AppConnector.request(params).then(
			function(data) {
				var callBackFunction = function(data) {
					var form = jQuery('#CustomView');
					var record = form.find('[name="checklistid"]').val();
					
					//register all select2 Elements
					app.showSelect2ElementView(form.find('select.select2'));
					
					thisInstance.registerAddChecklistItem(record);
					thisInstance.registerCkEditor();
					thisInstance.registerCkEditorSingle();
					thisInstance.registerCheckboxBtn();
					
					form.validationEngine(params);
					
					form.submit(function(e) {
						e.preventDefault();
						window.location('index.php');
					})
				}
				
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				app.showModalWindow(data,function(data){
					if(typeof callBackFunction == 'function'){
						callBackFunction(data);
					}
				}, {});
			},
			function(error) {
				progressIndicatorElement.progressIndicator({'mode' : 'hide'});
				//TODO : Handle error
				aDeferred.reject(error);
			}
		);
		return aDeferred.promise();
	},
	
	loadRecords: function () {
        var thisInstance = this;
		var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
				'enabled' : true
			}
		});
        var aDeferred = jQuery.Deferred();
        var url = 'index.php?module=OS2CheckList&view=Settings&parent=Settings&ajax=true';
        AppConnector.request(url).then(
            function (data) {
                jQuery('.vte-checklist-items tbody').html(data);
                aDeferred.resolve(data);
            },
            function (error, err) {
                progressIndicatorElement.progressIndicator({'mode' : 'hide'});
            }
        );
        return aDeferred.promise();
    },
	
    
    registerRowClick : function() {
      var thisInstance = this;
      jQuery('#listViewContents').on('click','.listViewEntries',function(e) {
          var currentRow = jQuery(e.currentTarget);
          if(currentRow.find('.icon-pencil ').length <= 0) {
              return;
          } 
          thisInstance.showEditView(currentRow.data('id'));
      })  
    },
	
	registerAddChecklistItem: function (record) {
        var thisInstance = this;
        jQuery('#add-checklist-item').on('click', function (event) {
            event.preventDefault();
            var containner = jQuery(this).closest('#vte-primary-box');
            var html = jQuery('.items-list-table tr:first', containner).clone();
            jQuery('input[type=text], textarea', html).val('');
            jQuery('input[type=text]', html).each(function () {
                if (jQuery(this).attr('name') == 'date[]') {
                    jQuery(this).removeAttr('readonly');
                    jQuery(this).addClass('dateField');
                }
            });
            jQuery('input[type=checkbox]', html).attr('checked', true);
            jQuery('input.allow_note_value', html).val(1);
            jQuery('input.allow_upload_value', html).val(1);
            var textarea_id = parseInt(jQuery('#textarea_id').val()) + 1;
            jQuery('.description', html).attr('id', 'desc_' + textarea_id);
            jQuery('#textarea_id').val(textarea_id);
            jQuery('.items-list-table tbody:first', containner).append(html);
            app.registerEventForDatePickerFields();
            thisInstance.registerCkEditorSingle('desc_' + textarea_id);
        });
    },
	
	/**
     * Function to get ckEditorInstance
     */
   
	registerCkEditor: function () {
		var thisInstance = this;
        var textarea_id = 0;
        var container = jQuery('#vte-primary-box');
        var textAreaElements = jQuery('.description', container);
       // var ckEditorInstance = new Vtiger_CkEditor_Js();
        textAreaElements.each(function (index) {
            jQuery(this).attr('id', 'desc_' + index);
            textarea_id = index;
            var customConfig = {};
            customConfig['height'] = '75px';
            thisInstance.loadCkEditor(jQuery(this), customConfig);

        });
        jQuery('#textarea_id').val(textarea_id);
    },
	
	
	registerCkEditorSingle: function (id) {
		var thisInstance = this;
		//thisInstance.registerCkEditor();
        var container = jQuery('#vte-primary-box');
        var textAreaElement = jQuery('#' + id, container);
        var tdElement = textAreaElement.closest('td');
        tdElement.find('div.cke').remove();
        //var ckEditorInstance = new Vtiger_CkEditor_Js();
        var customConfig = {};
        customConfig['height'] = '75px';
        thisInstance.loadCkEditor(textAreaElement, customConfig);
    },
	
		/**
	 * This function will show the Transform Currency view while delete the currency
	 */
	deleteCheckList : function(id, currentTrEle) {
		
		var params = {};
		params['module'] = app.getModuleName();
		params['parent'] = app.getParentModuleName();
		params['action'] = 'DeleteAjax';
		params['record'] = id;
		
		AppConnector.request(params).then(
			function(data) {
				app.hideModalWindow();
				var params = {};
				params.text = 'CheckList deleted successfully';
				Settings_Vtiger_Index_Js.showMessage(params);
				currentTrEle.fadeOut('slow').remove();
			}, function(error, err) {
				
			});
	},
	
	registerCheckboxBtn: function () {
        jQuery(document).on('click', '.allow_note,.allow_upload', function (event) {

            if (jQuery(this).is(':checked')) {
                jQuery(this).parent().find('input[type=hidden]').val(1);
            } else {
                jQuery(this).parent().find('input[type=hidden]').val(0);
            }
			
        });
    },

    
    registerEvents : function() {
		var thisInstance = this;
        thisInstance.registerRowClick();
		thisInstance.registerAddChecklistItem();
		thisInstance.registerCheckboxBtn();
		//thisInstance.registerCkEditor();
		//thisInstance.registerCkEditorSingle();
	}
	
});

jQuery(document).ready(function(){
	var checkListInstance = new Settings_OS2CheckList_Js();
    checkListInstance.registerEvents();	
});
