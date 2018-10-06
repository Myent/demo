/* ********************************************************************************
 * The content of this file is subject to the Table Block ("License");
 * You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is VTExperts.com
 * Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
 * All Rights Reserved.
 * ****************************************************************************** */

jQuery.Class("FieldFormula_Js",{

},{
    /***
     * Function which will update the line item row elements with the sequence number
     * @params : lineItemRow - tr line item row for which the sequence need to be updated
     *			 currentSequenceNUmber - existing sequence number that the elments is having
     *			 expectedSequenceNumber - sequence number to which it has to update
     *
     * @return : row element after changes
     */
    updateLineItemsElementWithSequenceNumber : function(lineItemRow,id,expectedSequenceNumber , currentSequenceNumber){
        if(typeof currentSequenceNumber == 'undefined') {
            //by default there will zero current sequence number
            currentSequenceNumber = 0;
        }

        var selected_fields= jQuery('#selected_fields'+id).val();
        var multipicklist_fields= jQuery('#multipicklist_fields'+id).val();
        var arrFields=selected_fields.split(',');
        var expectedRowId = 'row'+expectedSequenceNumber;
        for(var idIndex in arrFields ) {
            var elementName = arrFields[idIndex];
            if (elementName != '') {
                if(currentSequenceNumber == 0) {
                    var actualElementName = elementName;
                }else{
                    var actualElementName = 'tableblocks['+id+']['+currentSequenceNumber+']['+elementName+']';
                }
                if(multipicklist_fields.indexOf(elementName) != -1) {
                    var expectedElementId = 'tableblocks['+id+']['+expectedSequenceNumber+']['+elementName+'][]';
                    actualElementName = actualElementName+'[]';
                }else{
                    var expectedElementId = 'tableblocks['+id+']['+expectedSequenceNumber+']['+elementName+']';
                }


                var expectedRowId = 'row'+expectedSequenceNumber;
                lineItemRow.find('[name="' + actualElementName + '"]').attr('id', expectedRowId)
                    .filter('[name="' + actualElementName + '"]').attr('name', expectedElementId);
            }
        }
        return lineItemRow.attr('id',expectedRowId);
    },
    registerFieldFormulaEditEvents: function(container,id) {
        var table=container.find('.blockSortable');
        var thisInstance = this;
        app.registerEventForDatePickerFields(table);
        app.registerEventForTimeFields(table);
        app.changeSelectElementView(table);
        //register all select2 Elements
        app.showSelect2ElementView(table.find('select.select2'));

        thisInstance.registerSortableEvent(container,id);
        thisInstance.registerDeleteRowEvent(container,id);
        thisInstance.updateFieldFormulaFieldsInfo(container,id);
    },

    registerFieldFormulaDetailEvents: function(container,id) {
        var thisInstance = this;
        var table=container.find('.blockSortable');
        app.registerEventForDatePickerFields(table);
        app.registerEventForTimeFields(table);
        app.changeSelectElementView(table);
        //register all select2 Elements
        app.showSelect2ElementView(table.find('select.select2'));
        //thisInstance.updateFieldFormulaFieldsInfo(container,id);
        
    },

   
    updateFieldFormulaFieldsInfo:function(container,id) {
        var dataTable=jQuery('#dataTable'+id);
        var selected_fields= jQuery('#selected_fields'+id).val();
        var multipicklist_fields= jQuery('#multipicklist_fields'+id).val();
        var arrFields=selected_fields.split(',')
        jQuery('.rowDataItem', dataTable).each(function(i,e) {
            var row=i+1;
            var basicRow = jQuery(e);
            for(var idIndex in arrFields ) {
                var elementName = arrFields[idIndex];
                if (elementName != '') {
                    var expectedRowId = 'row'+row;
                    if(multipicklist_fields.indexOf(elementName) != -1) {
                        var expectedElementId = 'tableblocks['+id+']['+row+']['+elementName+'][]';
                        elementName = elementName+'[]';
                    }else{
                        var expectedElementId = 'tableblocks['+id+']['+row+']['+elementName+']';
                    }

                    basicRow.find('[name="' + elementName + '"]').attr('id', expectedRowId)
                        .filter('[name="' + elementName + '"]').attr('name', expectedElementId);
                }
            }
        });
    },
    updateLineDataElementByOrder : function (id) {
        var dataTable=jQuery('#dataTable'+id);
        var thisInstance = this;
        jQuery('tr.rowDataItem' ,dataTable).each(function(index,domElement){
            var lineItemRow = jQuery(domElement);
            var expectedRowIndex = (index+1);
            var expectedRowId = 'row'+expectedRowIndex;
            var actualRowId = lineItemRow.attr('id');
            if(expectedRowId != actualRowId) {
                var actualIdComponents = actualRowId.split('row');
                thisInstance.updateLineItemsElementWithSequenceNumber(lineItemRow,id, expectedRowIndex, actualIdComponents[1]);
            }
        });
    },
    registerSortableEvent : function(container,id) {
        var thisInstance = this;
        var contents = container.find('.ui-sortable');
        var table = contents.find('.blockSortable');
        contents.sortable({
            'containment' : contents,
            'items' : table,
            'revert' : true,
            'tolerance':'pointer',
            'cursor' : 'move',
            'helper' : function(e,ui){
                //while dragging helper elements td element will take width as contents width
                //so we are explicity saying that it has to be same width so that element will not
                //look like distrubed
                ui.children().each(function(index,element){
                    element = jQuery(element);
                    element.width(element.width());
                })
                return ui;
            },
            'update' : function(e, ui) {
                thisInstance.updateLineDataElementByOrder(id);
            }
        });
    },
    registerDeleteRowEvent : function(container,id){
        var thisInstance = this;
        var contents = container.find('.ui-sortable');

        contents.on('click','.deleteRow',function(e){
            var element = jQuery(e.currentTarget);
            //removing the row
            element.closest('tr.rowDataItem').remove();
            thisInstance.updateLineDataElementByOrder(id);
        });
    },
    registerEvents: function() {
        var container = jQuery(document).find('form');        
    }
});
jQuery(document).ready(function(){
    var instance = new FieldFormula_Js();
    instance.registerEvents();
    app.listenPostAjaxReady(function() {
        instance.registerEvents();
    });
});