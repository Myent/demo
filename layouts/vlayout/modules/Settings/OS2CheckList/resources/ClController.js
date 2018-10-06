var Settings_OS2Checklist_ClController_Js = {

	triggerLoad : function(checklistid){
		var thisInstance = this;
		var source_record = jQuery('#recordId').val();
		var source_module = app.getModuleName();

		var params = {};
		params['parent'] = 'Settings';
		params['module'] = 'OS2CheckList';
		params['action'] = 'AddCheckListItem';
		params['checklistid'] = checklistid;
		params['source_record'] = source_record;
		params['source_module'] = source_module;
		AppConnector.request(params).then(
			function (data) {
				if (data.result == 2 || data.result == 1) {
					//aDeferred.resolve(data);
					thisInstance.showChecklistDetails(params);
					/*progressIndicatorElement.progressIndicator({
						'mode': 'hide'
					});*/
					return;
				}
			},
			function (error, err) {
				aDeferred.resolve(data);
				progressIndicatorElement.progressIndicator({
					'mode': 'hide'
				});
			}
		)
		
	},
	
	registerAddDocument: function(){
        var thisInstance = this;
        var container = jQuery('#vte-checklist-details');
        // attach handler to form's submit event
        jQuery('.checklist-upload-form', container).submit(function(e) {
            e.preventDefault();
            // submit the form
            var form = jQuery(this);
            form.ajaxSubmit({
                
                complete: function(xhr) {
					var seq = form.attr('action');
					//console.log(); 
                    var data = jQuery.parseJSON(xhr.responseText);
					console.log(data);
					console.log(xhr);
                    var record = data.result._recordId;

                    var fileid = record + 1;
                    var title = data.result.notes_title.display_value;
                    var sourceRecord = form.find('input[name=sourceRecord]').val();
					var sequence = seq.split("count=")[1];
					var accountid = jQuery("#accountid").val();
					//var dataUrl = "index.php?module=CheckList&parent=Setting&view=SetDocumentValue&record="+record+"&sourceRecord="+sourceRecord;
					
						var params = {};
						params['parent'] = 'Settings';
						params['module'] = 'OS2CheckList';
						params['action'] = 'SetDocumentValue';
						params['source_record'] = sourceRecord;
						params['record'] = record;
						params['accountid'] = accountid;
						params['sequence'] = sequence;
						AppConnector.request(params).then(
							function (datar) {
								if (datar.result == 1) {
									return;
								}
							},
							function (error, err) {
								aDeferred.resolve(data);
								/*progressIndicatorElement.progressIndicator({
									'mode': 'hide'
								});*/
							}
						)
					
                    var newfile = '';
                    newfile += '<a href="index.php?module=Documents&action=DownloadFile&record='+record+'&fileid='+fileid+'">'+title;
                    newfile += '<span class="relationDelete pull-right" data-record="'+sourceRecord+'" data-related-record="'+record+'"><i title="Delete" class="icon-trash alignMiddle"></i></span>';
                    newfile += '</a>'
                    form.find('ul').prepend('<li>'+newfile+'</li>');
                    form.find('input[type=file]').val('');
                    //thisInstance.updateDateTimeField(sourceRecord, '');
                    /*setTimeout(function(){
                        form.find('.progress').hide();
                    }, 5000);*/
                }
            });
            // return false to prevent normal browser submit and page navigation
            return false;
        });

    },
	
	registerShowCommentBox: function () {
        var container = jQuery('#vte-checklist-details');
        jQuery(container).on('click', '.add-note', function (event) {
            event.preventDefault();
            var note_box = jQuery(this).closest('.checklist-item-related').find('.item-note-add');
            if (note_box.css('display') == 'none') {
                note_box.css('display', 'block');
            } else {
                note_box.css('display', 'none');
            }
        });
    },
	
	registerAddComment: function () {
        var container = jQuery('#vte-checklist-details');
        var thisInstance = this;
        jQuery(container).on('click', '.add-comment', function (event) {
			
			var seq = this.name;
			var sequence = seq.split("submit")[1];
            event.preventDefault();
			var note_box = jQuery(this).closest('.checklist-item-related').find('.item-note-add');
            if (note_box.css('display') == 'none') {
                note_box.css('display', 'block');
            } else {
                note_box.css('display', 'none');
            }
            var comment_box = jQuery(this).closest('.item-note-box');
            var comment_content = comment_box.find('.item-note-content').val();
            if (jQuery.trim(comment_content) == '') {
                alert(app.vtranslate('COMMENT_CONTENT_EMPTY'));
                return;
            }

            var aDeferred = jQuery.Deferred();
            var record = jQuery(this).data('record');
			console.log(record);
			var crmid = jQuery("#accountid").val();
			var checklistid = jQuery("#checklistid").val();
			
            var params = {};
            params['parent'] = 'Settings';
            params['module'] = 'OS2CheckList';
            params['action'] = 'AddCheckListComment';
            params['crmid'] = crmid;
            params['checklistid'] = record;
            params['comment'] = comment_content;
            params['sequence'] = sequence;

            AppConnector.request(params).then(
                function (data) {
                    if (data.result) {
                        comment_box.find('.item-note-list ul').prepend(data.result);
                        comment_box.find('.item-note-content').val('');
                        comment_box.find('.item-note-add').hide();
                        //thisInstance.updateDateTimeField(record, '');
                    }
                    aDeferred.resolve(data);
                },
                function (error, err) {

                }
            )
        });
    },
	
	registerDeleteDocument: function () {
        var container = jQuery('#vte-checklist-details');
        jQuery(container).on('click', '.relationDelete', function (event) {
            event.preventDefault();
            var element = jQuery(this);
            var params = {};
            params['parent'] = 'Settings';
            params['module'] = 'OS2CheckList';
            params['action'] = 'DeleteAjax';
			params['mode'] = 'deleteDocuments';
            params['src_record'] = element.data('record');
            params['related_record_list'] = element.data('related-record');
            Vtiger_Helper_Js.showConfirmationBox({'message' : 'Are you want to delete the Attachment?'}).then(
                function(e) {
                    AppConnector.request(params).then(
                        function (data) {
                            if (data.result == 1) {
                                element.closest('li').remove();
                            }
                            //aDeferred.resolve(data);
                        },
                        function (error, err) {

                        }
                    );
                },
                function(error, err){
                }
            );
        });
    },


	
	showChecklistDetails: function (actionParams, container) {
        var aDeferred = jQuery.Deferred();
        var thisInstance = this;
        var params = {};
        params['parent'] = 'Settings';
        params['module'] = 'OS2CheckList';
        params['view'] = 'CheckListDetail';
        params['checklistid'] = actionParams['checklistid'];
        params['source_record'] = actionParams['source_record'];
        params['source_module'] = actionParams['source_module'];

        AppConnector.request(params).then(
            function (data) {
                app.showModalWindow(data);
                thisInstance.registerAutoUploadFile();
                thisInstance.registerAddDocument();
                thisInstance.registerShowCommentBox();
                thisInstance.registerAddComment();
                thisInstance.registerDeleteDocument();
            },
            function (error, err) {

            }
        )
    },
	
	  registerAutoUploadFile: function (form) {
        var container = jQuery('#vte-checklist-details');
        jQuery(container).on('change', 'input[name=filename]', function (event) {
            var filePath = jQuery(this).val();
            if (filePath) {
                var form = jQuery(this).closest('form');
                form.find('input[name=notes_title]').val(filePath.replace(/.*(\/|\\)/, ''));
                form.submit();
            }
        });
    },
	
	 registerEvents: function() { 
		var thisInstance=this;	
		var container = jQuery('#checklist');
		thisInstance.registerAddDocument();		
		//thisInstance.registerChecklist();      
    },
}
jQuery(document).ready(function(){
    Settings_OS2Checklist_ClController_Js.registerEvents();
});
