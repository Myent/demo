/* ********************************************************************************
 * The content of this file is subject to the Collaboration ("License");
 * You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is VTExperts.com
 * Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
 * All Rights Reserved.
 * ****************************************************************************** */

var Vtiger_Rooms_Js = {

    container: null,

    /**
     * variable stores client side language strings
     */
    languageString : [],

    load : function(){
        var thisInstance = this;
        var scrollBarOption = {theme:"minimal"};
        var aDeferred = jQuery.Deferred();
        var urlParams = {};
        urlParams['module'] = 'Rooms';
        urlParams['view'] = 'Home';
        AppConnector.request(urlParams).then(
            function (data) {
                $('#collaboration-home').html(data);
                thisInstance.registerEventNotification();
                if($('#collaboration-home #collaboration-container').length>0){
                    thisInstance.container = $('#collaboration-container');
                    app.changeSelectElementView($('#collaboration-home'));
                    thisInstance.registerShowHistoryBoxEvent();
                    thisInstance.registerShowAllRoomBtnEvent();
                    thisInstance.registerAddRoomBtnEvent();
                    thisInstance.registerCancelRoomBtnEvent();
                    thisInstance.registerSaveRoomEvent();
                    thisInstance.registerOpenRoomDetailEvent();
                    thisInstance.registerArchiveRoomEvent();
                    thisInstance.registerRemoveArchiveRoomEvent();
                    thisInstance.registerLeaveRoomEvent();
                    thisInstance.registerPushNotification();
                    thisInstance.addRelatedTab();
                }
                aDeferred.resolve(data);
            },

            function (error) {
                aDeferred.reject(error);
            }
        );

        return aDeferred.promise();
    },

    addRelatedTab: function(){
        var currentModuleName = app.getModuleName();
        var currentModuleView = app.getViewName();
        var currentRecordId = this.getRecordId();
        var listRelatedModulesString = jQuery('#list-related-modules').val();
        var listRelatedModules = jQuery.parseJSON(listRelatedModulesString);
        if(listRelatedModules.indexOf(currentModuleName)>-1 && currentModuleView == 'Detail'){
            var relatedTabContainer = jQuery('.detailViewContainer div.related ul.nav');
            var conversationTab = '';
            conversationTab +=  '<li class="" data-url="module=Rooms&relatedModule='+currentModuleName+'&view=RelatedListCustom&record='+currentRecordId+'&tab_label='+this.vtranslate('LBL_CONVERSATION')+'" data-label-key="'+this.vtranslate('LBL_CONVERSATION')+'">';
            conversationTab +=      '<a href="javascript:void(0);" class="textOverflowEllipsis" style="width:auto" title="'+this.vtranslate('LBL_CONVERSATION')+'">';
            conversationTab +=          '<strong>'+this.vtranslate('LBL_CONVERSATION')+'</strong>';
            conversationTab +=      '</a>';
            conversationTab +=  '</li>';
            relatedTabContainer.append(conversationTab);
        }
    },

    registerScrollBar: function(container, options){
        $.mCustomScrollbar.defaults.scrollButtons.enable=true; //enable scrolling buttons by default
        $.mCustomScrollbar.defaults.axis="y"; //enable 2 axis scrollbars by default
        container.mCustomScrollbar(options);
    },

    registerPushMessages: function(record){
        var thisInstance = this;
        setInterval(function(){
            thisInstance.pushMessages(record);
        }, 1500);
    },

    registerPushNotification: function(){
        var thisInstance = this;
        setInterval(function(){
            thisInstance.pushNotification();
        }, 5000);
    },

    pushMessages: function(record){
        var thisInstance = this;
        if(jQuery('#messageForm'+record).length>0){
            var container = jQuery('#messageForm'+record).closest('#c-detail-container');
            var messageListElements = container.find('.message-list');
            var params = {};
            params['module'] = 'RoomsMessages';
            params['action'] = 'PushMessages';
            params['room_id'] = record;
            var aDeferred = jQuery.Deferred();
            AppConnector.request(params).then(
                function (data) {
                    if(data.result.length>0){
                        var messages = data.result;
                        var len = messages.length;
                        for(var i=0; i<len; i++){
                            var messageHtml = thisInstance.buildMessage(messages[i]);
                            if(thisInstance.container.find('.c-details .message-box').length>0 && thisInstance.container.find('.c-details .message-box #msg'+messages[i]._recordId).length==0){
                                messageListElements.append(messageHtml);
                                thisInstance.container.find('.c-details .message-box').animate({scrollTop: $('.message-box').get(0).scrollHeight}, 2000);
                                thisInstance.showEmoticonsGraphic();
                            }
                        }
                    }
                },

                function (error) {
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();

        }
    },

    pushNotification: function(){
        var thisInstance = this;
        var aDeferred = jQuery.Deferred();
        var urlParams = {};
        urlParams['module'] = 'RoomsMessages';
        urlParams['action'] = 'PushNotifications';

        AppConnector.request(urlParams).then(
            function (data) {
                if(data.success){
                    var notifications = data.result;
                    var rooms = notifications.rooms;
                    var len = rooms.length;
                    var total = notifications.total;
                    $('#c-notification-icon small').text(total).attr('title', total.toString()+' '+thisInstance.vtranslate('LBL_NEW_MESSAGE_TITLE'));
                    if(len>0){
                        for(var i=0; i<len; i++){
                            if(rooms[i].unread>0){
                                if(thisInstance.container.find('.c-panel-sub-available .c-panel-room-title .unread-number-'+rooms[i].room_id).length>0){
                                    thisInstance.container.find('.c-panel-sub-available .c-panel-room-title .unread-number-'+rooms[i].room_id).html('<small>'+rooms[i].unread+'</small>');
                                }else{
                                    //add to list
                                    var room_type = rooms[i].type;
                                    var room_type_class = room_type.replace(' ', '-').toLowerCase();
                                    var roomListBox = thisInstance.container.find('.c-panel-sub-available .c-panel-'+room_type_class+' ul');
                                    var newElement = '';
                                    newElement += '<li data-room-type="Private Group" data-record="'+rooms[i].room_id+'" data-record-user="'+rooms[i].roomsusersid+'" class="c-panel-room-title">';
                                    newElement +=   '<span>'+rooms[i].name+'</span>';
                                    newElement +=   '<label class="room-unread-number unread-number-'+rooms[i].room_id+'"><small>'+rooms[i].unread+'</small></label>';
                                    if(room_type=='Private Group'){
                                        newElement +=   '<i class="icon-off pull-right icon-white hide room-leave-btn"></i>';
                                    }
                                    newElement +=   '<i class="icon-eye-close pull-right icon-white hide room-archive-btn"></i>';
                                    newElement += '</li>';
                                    roomListBox.prepend(newElement);
                                    thisInstance.registerOpenRoomDetailEvent();
                                    thisInstance.registerArchiveRoomEvent();
                                    thisInstance.registerLeaveRoomEvent();
                                    //console.log(room_type_class);
                                }
                            }else{
                                thisInstance.container.find('.c-panel-sub-available .c-panel-room-title .unread-number-'+rooms[i].room_id).html('');
                            }
                        }
                    }
                }
            },

            function (error) {
                aDeferred.reject(error);
            }
        );

        return aDeferred.promise();
    },

    registerShowAllRoomBtnEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel-sub-available .group-more').on('click', function(e){
            e.preventDefault();
            thisInstance.container.find('.c-panel-sub-available').hide();
            thisInstance.container.find('.c-panel .c-me').hide();
            thisInstance.container.find('.c-panel-sub-all').show();
            var aDeferred = jQuery.Deferred();
            var type = $(this).data('type');
            var box = thisInstance.container.find('.c-panel-sub-all .c-panel-all-rooms');
            box.progressIndicator({});

            var urlParams = {};
            urlParams['module'] = 'Rooms';
            urlParams['view'] = 'AllRooms';
            urlParams['type'] = type;
            AppConnector.request(urlParams).then(
                function (data) {
                    box.progressIndicator({'mode':'hide'});
                    box.html(data);
                    thisInstance.registerCloseAllRoomBtnEvent();
                    thisInstance.registerFilterRoomsInAll();
                    thisInstance.registerOpenRoomDetailEvent();
                },

                function (error) {
                    box.progressIndicator({'mode':'hide'});
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    registerCloseAllRoomBtnEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel-sub-all .c-panel-all-rooms .close').on('click', function(e){
            e.preventDefault();
            thisInstance.container.find('.c-panel-sub-all .c-panel-all-rooms').html('');
            thisInstance.container.find('.c-panel-sub-all').hide();
            thisInstance.container.find('.c-panel .c-me').show();
            thisInstance.container.find('.c-panel-sub-available').show();
        });
    },

    registerFilterRoomsInAll: function(){
        var thisInstance = this;
        this.container.find('.c-panel-sub-all .c-panel-all-rooms #search-room-in-all').on('keyup', function(e){
            var searchValue = $(this).val();
            thisInstance.container.find('.c-panel-sub-all .c-panel-all-rooms ul li').hide();
            thisInstance.container.find('.c-panel-sub-all .c-panel-all-rooms ul li span').each(function(){
                var room_name = $(this).text();
                if(room_name.indexOf(searchValue)>=0){
                    $(this).closest('li').show();
                }
                //console.log(room_name.indexOf(searchValue));
            });
        });
    },

    registerAddRoomBtnEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel-sub-available .icon-plus').on('click', function(){
            var type = $(this).data('type');
            thisInstance.container.find('.c-panel-sub-available').hide();
            thisInstance.container.find('.c-panel-sub-form .c-panel-sub-form-child').hide();
            thisInstance.container.find('.c-panel-sub-form').show();
            thisInstance.container.find('.c-panel-sub-form .c-panel-'+type+'-form').show();
            thisInstance.container.find('.c-panel-sub-form #'+type+'-name').focus();
        });
    },

    registerCancelRoomBtnEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel-sub-form .cancelLink').on('click', function(){
            thisInstance.container.find('.c-panel-sub-available').show();
            thisInstance.container.find('.c-panel-sub-form .c-panel-sub-form-child').hide();
            thisInstance.container.find('.c-panel-sub-form').hide();
            var form = $(this).closest('.c-panel-sub-form-child');
            $('input', form).each(function(){
                $(this).val('');
            });
            $('select', form).each(function(){
                $(this).val('').trigger("liszt:updated");
            });
        });
    },

    registerEventNotification: function(){
        var thisInstance = this;
        $('#c-notification-icon').on('click', function(){
            if($('#collaboration-home').css('display')=='none'){
                $('#collaboration-home').toggle('slide', {direction: 'right'});
                var last_room_active = app.cacheGet('collaboration_last_room_active', null);
                if(last_room_active){
                    thisInstance.openRoomDetail(last_room_active);
                }
            } else {
                $('#collaboration-home').toggle('slide', {direction: 'right'});
            }
        });
    },

    showRoomDetailFromRelatedList: function(record){
        app.cacheSet('collaboration_last_room_active', record);
        $('#c-notification-icon').trigger('click');
    },

    registerSaveRoomEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel-sub-form .btn-success').on('click', function(){
            var type = $(this).data('type');
            if(type=='channel'){
                thisInstance.saveChannelRoom();
            }
            if(type=='direct-message'){
                thisInstance.saveDirectMessageRoom();
            }
            if(type=='private-group'){
                thisInstance.savePrivateGroupRoom();
            }
        });
    },

    saveChannelRoom: function(){
        var thisInstance = this;
        var aDeferred = jQuery.Deferred();
        var urlParams = {};
        var channel_name = this.container.find('.c-panel-sub-form #channel-name').val();

        if(channel_name==''){
            var params = {
                title : this.vtranslate('JS_CREATE_CHANNEL'),
                text: this.vtranslate('CHANNEL_NAME_EMPTY'),
                animation: 'show',
                type: 'error'
            };
            Vtiger_Helper_Js.showPnotify(params);
            return;
        }

        var formElement = thisInstance.container.find('.c-panel-channel-form');
        //formElement.progressIndicator({});
        formElement.append('<div class="collaboration-loading-panel"><img src="layouts/vlayout/modules/Rooms/resources/mini-loader.gif" /></div>');
        urlParams['module'] = 'Rooms';
        urlParams['action'] = 'SaveAjax';
        urlParams['room_type'] = 'Channel';
        urlParams['name'] = channel_name;

        AppConnector.request(urlParams).then(
            function (data) {
                if(data.result._recordId){
                    thisInstance.load();
                    formElement.find('.collaboration-loading-panel').remove();
                    thisInstance.openRoomDetail(data.result._recordId);
                }
            },

            function (error) {
                formElement.find('.collaboration-loading-panel').remove();
                aDeferred.reject(error);
            }
        );

        return aDeferred.promise();
    },

    saveDirectMessageRoom: function(){
        var thisInstance = this;
        var aDeferred = jQuery.Deferred();
        var urlParams = {};
        var who = this.container.find('.c-panel-sub-form #who').val();
        if(who==''){
            var params = {
                title : this.vtranslate('JS_CREATE_DIRECT_MESSAGE'),
                text: this.vtranslate('DIRECT_MESSAGE_MEMBER_EMPTY'),
                animation: 'show',
                type: 'error'
            };
            Vtiger_Helper_Js.showPnotify(params);
            return;
        }
        var formElement = thisInstance.container.find('.c-panel-direct-message-form');
        //formElement.progressIndicator({});
        formElement.append('<div class="collaboration-loading-panel"><img src="layouts/vlayout/modules/Rooms/resources/mini-loader.gif" /></div>');
        urlParams['module'] = 'Rooms';
        urlParams['action'] = 'SaveAjax';
        urlParams['room_type'] = 'Direct Message';
        urlParams['members'] = who;
        AppConnector.request(urlParams).then(
            function (data) {
                if(data.result._recordId){
                    thisInstance.load();
                    formElement.find('.collaboration-loading-panel').remove();
                    thisInstance.openRoomDetail(data.result._recordId);
                }
            },

            function (error) {
                formElement.find('.collaboration-loading-panel').remove();
                aDeferred.reject(error);
            }
        );

        return aDeferred.promise();
    },

    savePrivateGroupRoom: function(){
        var thisInstance = this;
        var aDeferred = jQuery.Deferred();
        var urlParams = {};
        var group_name = this.container.find('.c-panel-sub-form #private-group-name').val();
        var group_members = this.container.find('.c-panel-sub-form #private-group-members').val();
        /*console.log(group_members);
        return;*/
        if(group_name==''){
            var params = {
                title : this.vtranslate('JS_CREATE_PRIVATE_GROUP'),
                text: this.vtranslate('PRIVATE_GROUP_NAME_EMPTY'),
                animation: 'show',
                type: 'error'
            };
            Vtiger_Helper_Js.showPnotify(params);
            return;
        }
        if(group_members=='' || group_members === null){
            var params = {
                title : this.vtranslate('JS_CREATE_PRIVATE_GROUP'),
                text: this.vtranslate('PRIVATE_GROUP_MEMBER_EMPTY'),
                animation: 'show',
                type: 'error'
            };
            Vtiger_Helper_Js.showPnotify(params);
            return;
        }
        var formElement = thisInstance.container.find('.c-panel-private-group-form');
        //formElement.progressIndicator({});
        formElement.append('<div class="collaboration-loading-panel"><img src="layouts/vlayout/modules/Rooms/resources/mini-loader.gif" /></div>');
        urlParams['module'] = 'Rooms';
        urlParams['action'] = 'SaveAjax';
        urlParams['room_type'] = 'Private Group';
        urlParams['name'] = group_name;
        urlParams['members'] = group_members;
        AppConnector.request(urlParams).then(
            function (data) {
                if(data.result._recordId){
                    thisInstance.load();
                    formElement.find('.collaboration-loading-panel').remove();
                    thisInstance.openRoomDetail(data.result._recordId);
                }
            },

            function (error) {
                formElement.find('.collaboration-loading-panel').remove();
                aDeferred.reject(error);
            }
        );

        return aDeferred.promise();
    },

    registerOpenRoomDetailEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel .c-panel-room-title span').on('click', function(){
            var liElement = $(this).closest('li');
            var record = liElement.data('record');
            thisInstance.openRoomDetail(record);
        });
    },
    registerArchiveRoomEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel .c-panel-room-title .room-archive-btn').on('click', function(){
            var archiveElement = $(this);
            var liElement = archiveElement.closest('li');
            var record = liElement.data('record-user');
            if(record=='' || record == 0){
                return;
            }
            var aDeferred = jQuery.Deferred();
            var urlParams = {};
            urlParams['module'] = 'RoomsUsers';
            urlParams['action'] = 'SaveAjax';
            urlParams['field'] = 'archived';
            urlParams['value'] = 1;
            urlParams['record'] = record;
            AppConnector.request(urlParams).then(
                function (data) {
                    var newArchived = liElement;
                    liElement.remove();
                    newArchived.find('i.room-archive-btn').removeClass('icon-eye-close').removeClass('room-archive-btn').addClass('icon-eye-open').addClass('room-restore-archive-btn').attr('title', thisInstance.vtranslate('LBL_REMOVE_ARCHIVE_TOOLTIP_TITLE'));
                    //newArchived.append('<i class="icon-eye-open pull-right icon-white hide room-restore-archive-btn"></i>');
                    thisInstance.container.find('.c-panel .archived-list ul').append(newArchived);
                    thisInstance.registerOpenRoomDetailEvent();
                    thisInstance.registerRemoveArchiveRoomEvent();
                    thisInstance.registerLeaveRoomEvent();
                },

                function (error) {
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    registerRemoveArchiveRoomEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel .c-panel-room-title .room-restore-archive-btn').on('click', function(){
            var rmArchiveElement = $(this);
            var liElement = rmArchiveElement.closest('li');
            var room_type = liElement.data('room-type');
            var room_type_class = room_type.replace(' ', '-').toLowerCase();
            var record = liElement.data('record-user');
            if(record=='' || record == 0){
                return;
            }
            var aDeferred = jQuery.Deferred();
            var urlParams = {};
            urlParams['module'] = 'RoomsUsers';
            urlParams['action'] = 'SaveAjax';
            urlParams['field'] = 'archived';
            urlParams['value'] = 0;
            urlParams['record'] = record;
            AppConnector.request(urlParams).then(
                function (data) {
                    var newRestoreArchived = liElement;
                    newRestoreArchived.find('i.room-restore-archive-btn').removeClass('icon-eye-open').removeClass('room-restore-archive-btn').addClass('icon-eye-close').addClass('room-archive-btn').attr('title', thisInstance.vtranslate('LBL_ARCHIVE_TOOLTIP_TITLE'));
                    thisInstance.container.find('.c-panel .c-panel-'+room_type_class+' ul').prepend(newRestoreArchived);
                    thisInstance.registerOpenRoomDetailEvent();
                    thisInstance.registerArchiveRoomEvent();
                    thisInstance.registerLeaveRoomEvent();
                },

                function (error) {
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    registerJoinRoomEvent: function(record){
        var thisInstance = this;
        this.container.find('#c-detail-container .join-btn').on('click', function(){
            var user_record = $(this).data('record');
            if(user_record=='' || user_record == 0){
                return;
            }
            var parentElement = $(this).closest('.user-join-box');
            parentElement.progressIndicator({});
            var aDeferred = jQuery.Deferred();
            var urlParams = {};
            urlParams['module'] = 'RoomsUsers';
            urlParams['action'] = 'SaveAjax';
            urlParams['field'] = 'room_status';
            urlParams['value'] = 'Joined';
            urlParams['record'] = user_record;
            AppConnector.request(urlParams).then(
                function (data) {
                    parentElement.progressIndicator({'mode':'hide'});
                    thisInstance.openRoomDetail(record);
                },

                function (error) {
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    registerLeaveRoomEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel .c-panel-room-title .room-leave-btn').on('click', function(){
            var leaveElement = $(this);
            var liElement = leaveElement.closest('li');
            var record = liElement.data('record-user');
            if(record=='' || record == 0){
                return;
            }
            var aDeferred = jQuery.Deferred();
            var urlParams = {};
            urlParams['module'] = 'RoomsUsers';
            urlParams['action'] = 'SaveAjax';
            urlParams['field'] = 'room_status';
            urlParams['value'] = 'Leave';
            urlParams['record'] = record;
            AppConnector.request(urlParams).then(
                function (data) {
                    liElement.remove();
                    //remove archived
                    if(thisInstance.container.find('.cpanel .c-panel-archived li[data-record-user='+record+']').length > 0){
                        thisInstance.container.find('.cpanel .c-panel-archived li[data-record-user='+record+']').remove();
                    }
                    if(thisInstance.container.find('.cpanel .c-panel-favorites li[data-record-user='+record+']').length > 0){
                        thisInstance.container.find('.cpanel .c-panel-favorites li[data-record-user='+record+']').remove();
                    }
                },

                function (error) {
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    openRoomDetail: function(record,msgid){
        var thisInstance = this;
        if(record=='' || record == 0){
            return;
        }
        thisInstance.container.find('.c-details').html('<div class="collaboration-loading"><img src="layouts/vlayout/modules/Rooms/resources/loading.gif" /></div>');
        var aDeferred = jQuery.Deferred();
        var urlParams = {};
        urlParams['module'] = 'Rooms';
        urlParams['view'] = 'Details';
        urlParams['record'] = record;
        AppConnector.request(urlParams).then(
            function (data) {
                thisInstance.container.find('.c-details').html(data);
                thisInstance.container.find('.c-details .message-box').animate({scrollTop: $('.message-box').get(0).scrollHeight}, 2000);
                thisInstance.registerSubmitMessage(record);
                thisInstance.registerFavoriteEvent(record);
                thisInstance.registerPushMessages(record);
                thisInstance.registerAttachments(record);
                thisInstance.registerAliasFileInputSelection(record);
                thisInstance.registerUsersTagEvent(record);
                thisInstance.registerSearchMessagesInBox(record);
                thisInstance.registerEmoticonBtnEvent(record);
                thisInstance.registerSelectedEmoticonEvent(record);
                thisInstance.showEmoticonsGraphic();
                thisInstance.registerBBCodeEventNormalBtn(record);
                thisInstance.registerBBCodeEventColorBtn(record);
                thisInstance.registerBBCodeEventSizeBtn(record);
                thisInstance.registerLoadMoreMessages(record);
                thisInstance.registerShowMembersBtn();
                thisInstance.registerAddMembersBtn();
                var roomDetail = thisInstance.container.find('.c-details');
                if(roomDetail.find('#room-status').val()=='Pending' && roomDetail.find('#room-type').val()=='Channel'){
                    thisInstance.registerJoinRoomEvent(record);
                }
                roomDetail.find('textarea[name=message]').focus();
                app.cacheSet('collaboration_last_room_active', record);
                if(typeof msgid != undefined){
                    var params = {};
                    params['id'] = msgid;
                    thisInstance.jumpToMessageItem(record, params);
                }

                thisInstance.showParent(record);
            },

            function (error) {
                thisInstance.container.find('.c-details').html('');
                aDeferred.reject(error);
            }
        );

        return aDeferred.promise();
    },

    showParent: function(record){
        if(this.container.find('#room-related-record .room-related-record-remove').length == 0){
            var currentModuleName = app.getModuleName();
            var currentModuleView = app.getViewName();
            var currentRecordId = this.getRecordId();
            var listRelatedModulesString = this.container.find('#list-related-modules').val();
            var listRelatedModules = jQuery.parseJSON(listRelatedModulesString);
            if(currentModuleView=='Detail' && listRelatedModules.indexOf(currentModuleName) > -1){
                var thisInstance = this;
                var aDeferred = jQuery.Deferred();
                var urlParams = {};
                urlParams['module'] = 'Rooms';
                urlParams['action'] = 'GetData';
                urlParams['record'] = currentRecordId;
                urlParams['source_module'] = currentModuleName;
                AppConnector.request(urlParams).then(
                    function (data) {
                        if(data.success===true){
                            var parent_label = data.result.label;
                            thisInstance.container.find('#room-related-record').html('<a href="javascript:void(0)" onclick="Vtiger_Rooms_Js.addParent('+record+')">'+thisInstance.vtranslate('LBL_LINK_TO_RECORD_BEGIN')+parent_label+thisInstance.vtranslate('LBL_LINK_TO_RECORD_END')+'</a>');
                        }
                    },

                    function (error) {
                        aDeferred.reject(error);
                    }
                );

                return aDeferred.promise();
            }
        }
    },

    addParent: function(record){
        var thisInstance = this;
        var currentModuleName = app.getModuleName();
        var currentRecordId = thisInstance.getRecordId();
        var aDeferred = jQuery.Deferred();
        var urlParams = {};
        urlParams['module'] = 'Rooms';
        urlParams['action'] = 'RelatedRecord';
        urlParams['record'] = record;
        urlParams['parent_record'] = currentRecordId;
        urlParams['source_module'] = currentModuleName;
        AppConnector.request(urlParams).then(
            function (data) {
                if(data.success===true){
                    var parent_label = data.result.parent_label;
                    thisInstance.container.find('#room-related-record').html('<a href="index.php?module='+currentModuleName+'&view=Detail&record='+currentRecordId+'" target="_blank">'+parent_label+'</a><a href="javascript:void(0);" class="room-related-record-remove" onclick="Vtiger_Rooms_Js.removeParent('+record+')">x</a>');
                }
            },

            function (error) {
                aDeferred.reject(error);
            }
        );

        return aDeferred.promise();
    },

    removeParent: function(record){
        var thisInstance = this;
        var currentModuleName = app.getModuleName();
        var currentRecordId = thisInstance.getRecordId();
        var aDeferred = jQuery.Deferred();
        var urlParams = {};
        urlParams['module'] = 'Rooms';
        urlParams['action'] = 'RelatedRecord';
        urlParams['record'] = record;
        urlParams['parent_record'] = '';
        urlParams['source_module'] = '';
        AppConnector.request(urlParams).then(
            function (data) {
                if(data.success===true){
                    thisInstance.container.find('#room-related-record').html('');
                    thisInstance.showParent(record);
                }
            },

            function (error) {
                aDeferred.reject(error);
            }
        );

        return aDeferred.promise();
    },

    split: function(val) {
        return val.split(/[@]\s*/);
    },

    extractLast: function (term) {
        return this.split(term).pop();
    },

    registerUsersTagEvent: function(record){
        var thisInstance = this;
        var availableUsersString =  this.container.find('#messageForm'+record+' #users_tag').val();
        var availableUsers = $.parseJSON(availableUsersString);
        this.container.find('#messageForm'+record+' textarea[name=message]')
        // don't navigate away from the field on tab when selecting an item
            .on("click", function(event) {
                $('colorpicker').hide();
                $('#room-emotion-list').hide();
            }).bind("keydown", function(event) {
                if (event.keyCode === $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active) {
                    event.preventDefault();
                }
            }).autocomplete({
                minLength: 0,
                position: {  my: "left bottom", at: "left top", collision: "none"  },
                source: function(request, response) {
                    var term = request.term, results = [];
                    if (term.indexOf("@") >= 0) {
                        term = thisInstance.extractLast(request.term);
                        if (term.length > 0) {
                            results = $.ui.autocomplete.filter(
                                availableUsers, term);
                        } else {
                            results = ['Typing...'];
                        }
                    }
                    response(results);
                },
                focus: function() {
                    // prevent value inserted on focus
                    return false;
                },
                select: function(event, ui) {
                    var terms = thisInstance.split(this.value);
                    // remove the current input
                    terms.pop();
                    // add the selected item
                    terms.push(ui.item.value);
                    // add placeholder to get the comma-and-space at the end
                    terms.push("");
                    this.value = '@'+terms.join("")+': ';
                    return false;
                }
            });
    },

    registerSearchMessagesInBox: function(record){
        var thisInstance = this;
        this.container.find('input#search_message_internal')
            // don't navigate away from the field on tab when selecting an item
            .bind("keydown", function(event) {
                if (event.keyCode === $.ui.keyCode.TAB && $(this).data("autocomplete").menu.active) {
                    event.preventDefault();
                }
            }).autocomplete({
                minLength: '3',
                html:true,
                position: { my : "right top", at: "right bottom" },
                source: function(request, response) {
                    var term = request.term, results = [];
                    var aDeferred = jQuery.Deferred();
                    var urlParams = {};
                    urlParams['module'] = 'Rooms';
                    urlParams['action'] = 'SearchMessages';
                    urlParams['record'] = record;
                    urlParams['value'] = term;
                    var aDeferred = jQuery.Deferred();
                    AppConnector.request(urlParams).then(
                        function (data) {
                            var reponseDataList = new Array();
                            var serverDataFormat = data.result
                            if(serverDataFormat.length <= 0) {
                                serverDataFormat = new Array({
                                    'label' : app.vtranslate('JS_NO_RESULTS_FOUND'),
                                    'type'  : 'no results'
                                });
                            }
                            for(var id in serverDataFormat){
                                var responseData = serverDataFormat[id];
                                reponseDataList.push(responseData);
                            }
                            response(reponseDataList);
                        },

                        function (error) {
                            aDeferred.reject(error);
                        }
                    );
                },
                focus: function() {
                    // prevent value inserted on focus
                    return false;
                },
                select: function(event, ui) {
                    var selectedItemData = ui.item;
                    thisInstance.jumpToMessageItem(record, selectedItemData);
                    return false;
                }
            });
    },

    registerFavoriteEvent: function(record){
        var thisInstance = this;
        thisInstance.container.find('.c-details .favorite-action').on('click', function(event){
            event.preventDefault();
            var element = jQuery(this);
            if ( element.data('requestRunning') ) {
                return;
            }
            element.data('requestRunning', true);
            var currentFavorite = element.data('favorite');
            var room_id = thisInstance.container.find('.c-details form input[name=room_id]').val();
            var room_title = thisInstance.container.find('.c-details .c-detail-header .room-title').text();
            var urlParams = {};
            urlParams['module'] = 'RoomsUsers';
            urlParams['action'] = 'SaveAjax';
            urlParams['record'] = element.data('record');
            urlParams['field'] = 'favorite';
            if(currentFavorite==1){
                urlParams['value'] = 0;
            }else{
                urlParams['value'] = 1;
            }
            var aDeferred = jQuery.Deferred();
            AppConnector.request(urlParams).then(
                function (data) {
                    if(currentFavorite==1){
                        element.data('favorite', 0);
                        element.removeClass('star-favorite');
                        element.addClass('star-empty');
                        thisInstance.removeFavoritePanel(room_id);

                    }else{
                        element.data('favorite', 1);
                        element.removeClass('star-empty');
                        element.addClass('star-favorite');
                        thisInstance.addFavoritePanel(room_id, room_title);
                    }
                    element.data('requestRunning', false);
                },

                function (error) {
                    element.data('requestRunning', false);
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    addFavoritePanel: function(room_id, room_title){
        var favoriteItem = '';
        favoriteItem += '<li data-record="'+room_id+'" class="c-panel-room-title"><span>';
        favoriteItem += room_title;
        favoriteItem += '</span></li>';
        jQuery('.c-panel-favorites ul').append(favoriteItem);
        this.registerOpenRoomDetailEvent();
    },

    removeFavoritePanel: function(room_id){
        jQuery('.c-panel-favorites ul li').each(function(){
            if(jQuery(this).data('record')==room_id){
                jQuery(this).remove();
            }
        });
    },

    registerSubmitMessage: function(record){
        var thisInstance = this;
        this.container.find('#messageForm'+record+' textarea[name=message]').keypress(function(e){
            if (e.keyCode == 13 && !e.shiftKey)
            {
                e.preventDefault();
                //now call the code to submit your form
                var messageBox = $(this);
                if($.trim(messageBox.val())==''){
                    return;
                }
                var form = messageBox.closest('form');
                var params = form.serialize();
                messageBox.attr('disabled', 'disabled');
                var aDeferred = jQuery.Deferred();
                AppConnector.request(params).then(
                    function (data) {
                        if(data.success===true){
                            var message = thisInstance.buildMessage(data.result);
                            if(thisInstance.container.find('.c-details .message-box #msg'+data.result._recordId).length==0){
                                thisInstance.container.find('.message-box .message-list').append(message);
                                thisInstance.container.find('.c-details .message-box').animate({scrollTop: $('.message-box').get(0).scrollHeight}, 2000);
                            }
                            thisInstance.container.find('#messageForm'+record+' textarea[name=message]').val('').focus();
                            thisInstance.showEmoticonsGraphic();
                        }
                        messageBox.removeAttr('disabled').focus();
                    },

                    function (error) {
                        messageBox.removeAttr('disabled');
                        aDeferred.reject(error);
                    }
                );

                return aDeferred.promise();
            }

            if (e.keyCode == 13 && (e.shiftKey || e.ctrlKey))
            {
                /*var messageBox = $(this);
                var current_val = messageBox.val();
                messageBox.val(current_val+"\r\n");*/
            }
        });
    },

    registerAliasFileInputSelection: function(record){
        this.container.find('#attachmentForm'+record+' .room-attachment-alias').on('click', function(event){
            event.preventDefault();
            $(this).closest('form').find('input[type=file]').trigger('click');
        });
    },

    registerAttachments: function(record){
        var thisInstance = this;
        this.container.find('#attachmentForm'+record+' input[type=file]').on('change', function(event){
            event.preventDefault();
            var element = $(this);
            var form = $('#attachmentForm'+record);
            var val = $(this).val();
            val.replace(/\\/g, "/");
            var filename = val.substring(val.lastIndexOf("/") + 1);
            /*var val = $(this).val().toLowerCase();
            var regex = new RegExp("(.*?)\.(jpg|png|gif)$");
            if (!(regex.test(val))) {
                $(this).val('');
                var params = {};
                params['text']=this.vtranslate('IMG_TYPE_FORMAT_WRONG_MSG');
                Vtiger_Helper_Js.showMessage(params);
                return;
            }*/

            //now call the code to submit your form
            var params = {};
            params['module'] = 'RoomsMessages';
            params['action'] = 'SaveAjax';
            params['room_id'] = record;
            params['message'] = filename;
            var aDeferred = jQuery.Deferred();
            AppConnector.request(params).then(
                function (data) {
                    if(data.success===true){
                        var message = thisInstance.buildMessage(data.result, 'attachment');
                        if(thisInstance.container.find('.c-details .message-box #msg'+data.result._recordId).length==0){
                            thisInstance.container.find('.message-box .message-list').append(message);
                            thisInstance.container.find('.c-details .message-box').animate({scrollTop: $('.message-box').get(0).scrollHeight}, 2000);

                            //upload file
                            var liElement = thisInstance.container.find('.c-details .message-box #msg'+data.result._recordId);
                            var progress = liElement.find('.progress');
                            var bar = liElement.find('.bar');
                            var percent = liElement.find('.percent');
                            progress.show();
                            var url = 'index.php?' + form.serialize() + '&record='+data.result._recordId;
                            form.ajaxSubmit({
                                'url': url,
                                'type': 'POST',
                                beforeSend: function () {
                                    var percentVal = '0%';
                                    bar.width(percentVal);
                                    percent.html(percentVal);
                                },
                                uploadProgress: function (event, position, total, percentComplete) {
                                    var percentVal = percentComplete + '%';
                                    bar.width(percentVal);
                                    percent.html(percentVal);
                                },
                                complete: function (xhr) {
                                    var response = $.parseJSON(xhr.responseText);
                                    element.val('');
                                    progress.hide();
                                    var filename = '<a href="'+response.result.download_link+'">'+response.result.file_name+'</a>';
                                    liElement.find('.member-message-body').html(filename);
                                },
                                error: function (xhr, status, error){
                                    progress.hide();
                                    liElement.find('.member-message-body').append('-- !error');
                                }
                            });
                        }
                    }
                },

                function (error) {
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    buildMessage: function(data, type){
        if(typeof  type == 'undefined'){
            type = '';
        }
        var message = '';
        message += '<li class="message-item" id="msg'+data._recordId+'">';
        message +=     '<div class="member-avatar">';
        if(typeof data.avatar != 'undefined' && data.avatar.length > 0){
            message +=     '<img src="'+data.avatar+'">';
        }else{
            //message +=     '<span>'+data.avatar_alias+'</span>';
            message +=     ' <span style="background-color: '+data.avatar_alias_bg+'">'+data.avatar_alias_html+'</span>';
        }

        message +=     '</div>';
        message +=     '<div class="member-message">';
        message +=         '<div class="member-message-header">';
        message +=             '<span class="member-name">'+data.assigned_user_id.display_value+'</span>';
        message +=             ' <span class="message-item-date">'+data.CreatedTime.display_value+'</span>';
        message +=         '</div>';
        var display_value = $("#myDecoderSpan").html($('#myDecoderSpan').html(data.message.display_value).text()).text();
        message +=         '<div class="member-message-body">'+ display_value +'</div>';
        message +=     '</div>';
        if(type=='attachment'){
            message += '<div class="progress" style="display: none;">';
            message +=  '<div class="bar"></div >';
            message +=  '<div class="percent">0%</div >';
            message += '</div>';
        }
        message += '</li>';

        return message;
    },

    registerEmoticonBtnEvent: function(record){
        var thisInstance = this;
        this.container.find('.room-emotion-btn').on('click', function(event){
            event.preventDefault();
            var parent = $(this).closest('#room-emotion');
            parent.find('#room-emotion-list').toggle('slide', {direction: 'down'});
        });
    },

    registerSelectedEmoticonEvent: function(record){
        var thisInstance = this;
        this.container.find('#room-emotion-list .emoticon').on('click', function(event){
            event.preventDefault();
            var emoticonVal = $(this).html();
            var parent = $(this).closest('#room-message-form');
            var form = parent.find('#messageForm'+record);
            var textBox = form.find('textarea');
            var pos = textBox.getCursorPosition();
            var content = textBox.val();
            //console.log(content);
            //console.log(pos);
            var newContent = content.substr(0, pos) + " " + emoticonVal + " " + content.substr(pos);
            textBox.val(newContent);
        });
    },

    showEmoticonsGraphic : function(){
        if($('#c-detail-container .member-message-body').length){
            $('#c-detail-container .member-message-body').each(function(){
                var msg = $(this).html();
                $(this).html($.emoticons.replace(msg));
            });
        }
    },

    registerBBCodeEventNormalBtn: function(record){
        var thisInstance = this;
        this.container.find('#room-message-form .formatting-normal').on('click', function(event){
            event.preventDefault();
            var parent = $(this).closest('#room-message-form');
            var form = parent.find('#messageForm'+record);
            var textBox = form.find('textarea');
            var selectionStart = textBox.getSelectionStart();
            var selectionEnd = textBox.getSelectionEnd();
            var selectionStr = textBox.getSelection();
            var content = textBox.val();
            var bbcodetype = $(this).data('type');
            var bbcode_type_start = '['+bbcodetype+']';
            var bbcode_type_end = '[/'+bbcodetype+']';
            if(selectionEnd==selectionStart){
                var bbcodeContent = bbcode_type_start+bbcode_type_end;
            }else{
                var bbcodeContent = bbcode_type_start+selectionStr+bbcode_type_end;
            }

            var newContent = content.substr(0, selectionStart) + bbcodeContent + content.substr(selectionEnd);
            textBox.val(newContent);

            if(bbcodetype=='url'){
                textBox.setCursorPosition(selectionStart+5);
            }else{
                textBox.setCursorPosition(selectionStart+3);
            }
        });
    },

    registerBBCodeEventColorBtn: function(record){
        var thisInstance = this;
        this.container.find('#room-message-form .formatting-font-color').ColorPicker({
            flat: false,
            onSubmit: function(hsb, hex, rgb, el) {
                var parent = $(el).closest('#room-message-form');
                var form = parent.find('#messageForm'+record);
                var textBox = form.find('textarea');
                var selectionStart = textBox.getSelectionStart();
                var selectionEnd = textBox.getSelectionEnd();
                var selectionStr = textBox.getSelection();
                var content = textBox.val();
                var bbcode_type_start = '[color=#'+hex+']';
                var bbcode_type_end = '[/color]';
                if(selectionEnd==selectionStart){
                    var bbcodeContent = bbcode_type_start+bbcode_type_end;
                }else{
                    var bbcodeContent = bbcode_type_start+selectionStr+bbcode_type_end;
                }
                var newContent = content.substr(0, selectionStart) + bbcodeContent + content.substr(selectionEnd);
                textBox.val(newContent);
                $('.colorpicker').hide();
                textBox.setCursorPosition(selectionStart+15);
            }
        });
    },

    registerBBCodeEventSizeBtn: function(record){
        var thisInstance = this;
        this.container.find('#room-message-form .formatting-font-size').on('click', function(event){
            event.preventDefault();
            $(this).find('.formatting-font-size-list').toggle('slide', {direction: 'down'});
        });
        this.container.find('#room-message-form .formatting-font-size-list li').on('click', function(event){
            event.preventDefault();
            var fontSize = $(this).find('font').attr('size');
            if(fontSize){
                var parent = $(this).closest('#room-message-form');
                var form = parent.find('#messageForm'+record);
                var textBox = form.find('textarea');
                var selectionStart = textBox.getSelectionStart();
                var selectionEnd = textBox.getSelectionEnd();
                var selectionStr = textBox.getSelection();
                var content = textBox.val();
                var bbcode_type_start = '[size='+fontSize+']';
                var bbcode_type_end = '[/size]';
                if(selectionEnd==selectionStart){
                    var bbcodeContent = bbcode_type_start+bbcode_type_end;
                }else{
                    var bbcodeContent = bbcode_type_start+selectionStr+bbcode_type_end;
                }
                var newContent = content.substr(0, selectionStart) + bbcodeContent + content.substr(selectionEnd);
                textBox.val(newContent);
                thisInstance.container.find('#room-message-form .formatting-font-list').hide();
                textBox.setCursorPosition(selectionStart+8);
            }
        });
    },

    registerShowHistoryBoxEvent: function(){
        var thisInstance = this;
        this.container.find('.c-panel .c-panel-history').on('click', function(event){
            event.preventDefault();
            var aDeferred = jQuery.Deferred();
            var urlParams = {};
            urlParams['module'] = 'Rooms';
            urlParams['view'] = 'History';
            AppConnector.request(urlParams).then(
                function (data) {
                    thisInstance.container.find('.c-details').html(data);
                    thisInstance.registerSearchHistoryBoxEvent();
                    app.changeSelectElementView(thisInstance.container.find('#collaboration-history'));
                },

                function (error) {
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    registerSearchHistoryBoxEvent: function(){
        var thisInstance = this;
        this.container.find('.c-details input#history-search-box').on('keyup', function(event){
            var val = $(this).val();
            var parentElement = $(this).closest('.collaboration-history-search-box');
            var historyTypeElement = $('#history-type', parentElement);
            var historyTypeValue = historyTypeElement.val();
            if(val.length<3){
                thisInstance.container.find('#collaboration-history .collaboration-history-result').html('');
                return;
            }
            var aDeferred = jQuery.Deferred();
            var urlParams = {};
            urlParams['module'] = 'Rooms';
            urlParams['view'] = 'HistoryAjax';
            urlParams['value'] = val;
            urlParams['history_type'] = historyTypeValue;
            AppConnector.request(urlParams).then(
                function (data) {
                    thisInstance.container.find('#collaboration-history .collaboration-history-result').html(data);
                    thisInstance.container.find('#collaboration-history .collaboration-history-result li').on('click', function(){
                        if(historyTypeValue=='M'){
                            thisInstance.openRoomDetail($(this).data('room-id'), $(this).data('record'));
                        }else{
                            thisInstance.openRoomDetail($(this).data('room-id'));
                        }
                    });
                },

                function (error) {
                    aDeferred.reject(error);
                }
            );

            return aDeferred.promise();
        });
    },

    registerLoadMoreMessages: function(record){
        var thisInstance = this;
        var loading_more_msg = false;
        $(".message-box").scroll(function() {
            var page_number = thisInstance.container.find('#c-detail-container .c-detail-header input[name=message_page_number]').val();
            var page_end = thisInstance.container.find('#c-detail-container .c-detail-header input[name=message_page_end]').val();
            if($(this).scrollTop()==0 && loading_more_msg===false && page_number<page_end){
                loading_more_msg = true;
                var loading_html = '<li id="loading-more-msg"><img src="layouts/vlayout/modules/Rooms/resources/loading.gif" /></li>';
                thisInstance.container.find('#c-detail-container .message-box .message-list').prepend(loading_html);
                var aDeferred = jQuery.Deferred();
                var urlParams = {};
                urlParams['module'] = 'Rooms';
                urlParams['view'] = 'DetailsAjax';
                urlParams['record'] = record;
                urlParams['page_number'] = page_number;
                AppConnector.request(urlParams).then(
                    function (data) {
                        loading_more_msg = false;
                        if(data!=''){
                            thisInstance.container.find('#c-detail-container .c-detail-header input[name=message_page_number]').val(parseInt(page_number)+1);
                            thisInstance.container.find('#c-detail-container .message-box .message-list').prepend(data);
                        }
                        thisInstance.container.find('#c-detail-container .message-box .message-list').find('#loading-more-msg').remove();
                    },

                    function (error) {
                        loading_more_msg = false;
                        thisInstance.container.find('#c-detail-container .message-box .message-list').find('#loading-more-msg').remove();
                        aDeferred.reject(error);
                    }
                );

                return aDeferred.promise();
            }
        });
    },

    jumpToMessageItem: function(record, selectedItemData){
        var thisInstance = this;
        if(selectedItemData.id){
            if(thisInstance.container.find("li#msg"+selectedItemData.id).length>0){
                var msgBox = thisInstance.container.find('.message-box');
                var msgElement = msgBox.find("li#msg"+selectedItemData.id);
                msgBox.find('.message-list .message-item').removeClass('hovered');
                msgBox.animate({scrollTop: msgElement.offset().top - msgBox.offset().top + msgBox.scrollTop()},'slow');
                msgElement.toggleClass('hovered');
                thisInstance.container.find('input#search_message_internal').val('');
            }else{
                var loading_html = '<li id="loading-more-msg"><img src="layouts/vlayout/modules/Rooms/resources/loading.gif" /></li>';
                thisInstance.container.find('#c-detail-container .message-box .message-list').prepend(loading_html);
                var aDeferred = jQuery.Deferred();
                var page_number = thisInstance.container.find('#c-detail-container .c-detail-header input[name=message_page_number]').val();
                var page_end = thisInstance.container.find('#c-detail-container .c-detail-header input[name=message_page_end]').val();
                if(page_number==page_end){
                    return;
                }
                var urlParams = {};
                urlParams['module'] = 'Rooms';
                urlParams['view'] = 'DetailsAjax';
                urlParams['record'] = record;
                urlParams['page_number'] = page_number;
                AppConnector.request(urlParams).then(
                    function (data) {
                        if(data!=''){
                            thisInstance.container.find('#c-detail-container .c-detail-header input[name=message_page_number]').val(parseInt(page_number)+1);
                            thisInstance.container.find('#c-detail-container .message-box .message-list').prepend(data);
                        }
                        thisInstance.container.find('#c-detail-container .message-box .message-list').find('#loading-more-msg').remove();
                        thisInstance.jumpToMessageItem(record, selectedItemData);
                    },

                    function (error) {
                        thisInstance.container.find('#c-detail-container .message-box .message-list').find('#loading-more-msg').remove();
                        aDeferred.reject(error);
                    }
                );

                return aDeferred.promise();
            }
        }
    },

    /**
     * Function returns translated string
     */
    vtranslate : function(key) {
        if(Vtiger_Rooms_Js.languageString[key] != undefined) {
            return Vtiger_Rooms_Js.languageString[key];
        } else {
            var strings = this.container.find('#collaboration_js_strings').text();
            if(strings != '') {
                Vtiger_Rooms_Js.languageString = JSON.parse(strings);
                if(key in Vtiger_Rooms_Js.languageString){
                    return Vtiger_Rooms_Js.languageString[key];
                }
            }
        }
        return key;
    },

    registerShowMembersBtn: function(){
        var thisInstance = this;
        if(this.container.find('#member-in-room').length>0){
            this.container.find('#member-in-room').on('click', function(e){
                if(jQuery(e.target).is('button')){
                    $(this).trigger('click');
                    return;
                }
                $(this).find('.members-in-room').toggle('slide', {direction: 'up'});
            });

            thisInstance.container.find('#member-in-room button').on('click', function(event){
                event.preventDefault();
                var is_owner = thisInstance.container.find('#c-detail-container .c-detail-header h2 #member-is-owner').val();
                if(is_owner==1){
                    var parent = $(this).closest('#c-detail-container');
                    var room_id = parent.find('input#room-id').val();
                    var record = $(this).data('record');
                    $(this).attr('disabled');
                    var aDeferred = jQuery.Deferred();
                    var urlParams = {};
                    urlParams['module'] = 'RoomsUsers';
                    urlParams['action'] = 'SaveAjax';
                    urlParams['field'] = 'room_status';
                    urlParams['value'] = 'Reject';
                    urlParams['record'] = record;
                    AppConnector.request(urlParams).then(
                        function (data) {
                            thisInstance.openRoomDetail(room_id);
                        },

                        function (error) {
                            aDeferred.reject(error);
                        }
                    );
                }
            });
        }
    },

    registerAddMembersBtn: function(){
        var thisInstance = this;
        if(this.container.find('#add-new-member').length>0){
            this.container.find('#add-new-member').on('click', function(e){
                if(jQuery(e.target).is('button')){
                    $(this).trigger('click');
                    return;
                }
                $(this).find('.members-not-in-room').toggle('slide', {direction: 'up'});
            });

            thisInstance.container.find('#add-new-member button').on('click', function(event){
                event.preventDefault();
                var parent = $(this).closest('#c-detail-container');
                var room_id = parent.find('input#room-id').val();
                var user_id = $(this).data('userid');
                $(this).attr('disabled');
                var aDeferred = jQuery.Deferred();
                var urlParams = {};
                urlParams['module'] = 'RoomsUsers';
                urlParams['action'] = 'SaveAjax';
                urlParams['room_status'] = 'Joined';
                urlParams['assigned_user_id'] = user_id;
                urlParams['room_id'] = room_id;
                AppConnector.request(urlParams).then(
                    function (data) {
                        thisInstance.openRoomDetail(room_id);
                    },

                    function (error) {
                        aDeferred.reject(error);
                    }
                );
            });
        }
    },
	
	/**
	 * Function returns the record id
	 */
	getRecordId : function(){
		var view = jQuery('[name="view"]').val();
		var recordId;
		if(view == "Edit"){
			recordId = jQuery('[name="record"]').val();
		}else if(view == "Detail"){
			recordId = jQuery('#recordId').val();
		}
		return recordId;  
	},

    registerEvents : function(){
        $('head').append('<link rel="stylesheet" href="layouts/vlayout/modules/Rooms/resources/emoticons.css">');
        $('head').append('<link rel="stylesheet" href="libraries/jquery/colorpicker/css/colorpicker.css">');
        $('head').append('<link rel="stylesheet" href="layouts/vlayout/modules/Rooms/resources/Rooms.css">');

        var headerLinkBox = $('#headerLinks');
        var headerLinkContainer = headerLinkBox.find('span.headerLinksContainer');
        var collaboration = '<div class="span settingIcons">';
        collaboration +=        '<a id="c-notification-icon" href="javascript:void(0);">';
        collaboration +=            '<small title="0 New Message">0</small>';
        collaboration +=        '</a>';
        collaboration +=        '<div id="collaboration-home"></div>';
        collaboration +=    '</div>';
        headerLinkContainer.prepend(collaboration);

        this.load();
    }
}

$(document).ready(function () {
    var node = document.createElement("span");
    node.setAttribute("id", "myDecoderSpan");
    node.setAttribute("class", "hide");
    document.body.appendChild(node);
    
    if($('#headerLinks #c-notification-icon').length==0){
        Vtiger_Rooms_Js.registerEvents();
    }
});