/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/
jQuery.Class('Settings_ACMPR_Js', {}, {
    sequenceNumber: false,
    registerAddingNewGridrow: function() {
        var thisInstance = this;
        jQuery('#addDepartment').on('click', function() {
            var lineItemTable = jQuery("#lineItemTab");
            var hiderow = jQuery('.lineItemCloneCopy', lineItemTable);
            var basicrow = hiderow.clone(true, true);
            basicrow.removeClass('hide');
            basicrow.removeClass('lineItemCloneCopy');
            if (thisInstance.sequenceNumber == false) {
                sno = jQuery('.lineItemRow', lineItemTable).length;
            }

            var newRow = basicrow.addClass('lineItemRow');
            newRow = newRow.appendTo(lineItemTable);
            sno = sno + 1;
            thisInstance.sequenceNumber = sno;
            newRow.find('input.rowNumber').val(sno);
            var idFields = new Array('row','rowNumber', 'accountname','activities', 'substance');
            thisInstance.updateLineItemsElementWithSequenceNumber(newRow, sno, idFields);
        });
    },
    updateLineItemsElementWithSequenceNumber: function(lineItemRow, expectedSequenceNumber, idFields, currentSequenceNumber) {
        if (typeof currentSequenceNumber == 'undefined') {
            //by default there will zero current sequence number
            currentSequenceNumber = 0;
        }

        var expectedRowId = 'row' + expectedSequenceNumber;
        for (var idIndex in idFields) {
            var elementId = idFields[idIndex];
            var actualElementId = elementId + currentSequenceNumber;
            var expectedElementId = elementId + expectedSequenceNumber;
            lineItemRow.find('#' + actualElementId).attr('id', expectedElementId)
                .filter('[name="' + actualElementId + '"]').attr('name', expectedElementId);
        }
        lineItemRow.find('select').addClass('chzn-select');
        app.changeSelectElementView(lineItemRow);
        return lineItemRow.attr('id', expectedRowId);
    },
    //Drag and Drop of Rows
    registerDragGridRows: function() {
        var thisInstance = this;
        var lineItemTable = jQuery("#lineItemTab");
        lineItemTable.sortable({
            'containment': lineItemTable,
            'items': 'tr.lineItemRow',
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
    },

    registerDeleteGridRows: function() {
        var thisInstance = this;
        jQuery('.deleteRow').on('click', function() {
            var element = jQuery(this);
            var rowclass = jQuery(this).closest('tr').attr('class');
            element.closest('tr.' + rowclass).remove();
        });
    },
	registerSaveGridDetails : function() {
		var thisInstance = this;
		jQuery('#acrmprgrid').on('submit',function(e) {
			var formData = jQuery("#acrmprgrid").serializeFormData();
			var deturl = jQuery('#acrmprgrid').attr('data-detail-url');
			AppConnector.request(formData).then(
				function(data) {
					console.log(data.result.SUCCESS);
					if(data.result.SUCCESS == 'OK'){
						location.href=deturl;
					}
				},
				function(error,err){
					
				}
			);
			e.preventDefault();
		});
	},
	registerforButtonClick: function(){
		console.log("hello");
		jQuery(".editButton").on('click',function(){
			var url = jQuery(this).attr('data-url');
			location.href=url;
		
		});
	},
    registerEvents: function(e) {
        var thisInstance = this;
        this.registerDragGridRows();
		this.registerSaveGridDetails();
        this.registerAddingNewGridrow();
        this.registerDeleteGridRows();
		this.registerforButtonClick();

    }
});

jQuery(document).ready(function() {
    var instance = new Settings_ACMPR_Js();
    instance.registerEvents();
})