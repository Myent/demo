jQuery.Class("OS2TimeTracker_Js", {

    formatTime : function (val) {
        if(!val) {
            val=0;
        }
        var sec_num = parseInt(val, 10); // don't forget the second param
        var hours   = Math.floor(sec_num / 3600);
        var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
        var seconds = sec_num - (hours * 3600) - (minutes * 60);

        if (hours   < 10) {hours   = "0"+hours;}
        if (minutes < 10) {minutes = "0"+minutes;}
        if (seconds < 10) {seconds = "0"+seconds;}
        var time    = hours+':'+minutes+':'+seconds;
        return time;
    },
	
},{

    timeInSecond:null,
    intervalTimer:null,
    intervalTimerSave:null,

    intervalTimerHeader:null,
    intervalTimerSaveHeader:null,
    timerRunning: null,

    registerDateTimePicker: function (container) {
        var dateFormat = jQuery('#dateFormat').val();
        var timeFormat = jQuery('#timeFormat').val();
        if(timeFormat == 12) {
            container.find('.dateTimeField:not([readonly])').datetimepicker({
                format: dateFormat + ' HH:ii P',
                autoclose: true,
                todayBtn: true,
                showMeridian: true
            });
        }else{
            container.find('.dateTimeField:not([readonly])').datetimepicker({
                format: dateFormat + ' hh:ii',
                autoclose: true,
                todayBtn: true
            });
        }

        container.find('.dateTimeField:not([readonly])').datetimepicker('update');

    },

    timeTrackerTimer: function () {
        var val = parseInt(jQuery('#timeTrackerTotal').val());
        if(!val){
            val=0;
        }
        val = val + 1;
        jQuery('#timeTrackerTotal').val(val);
        jQuery('.timeTrackerTotal').html(OS2TimeTracker_Js.formatTime(val));
    },
	
	deleteTimer: function () {
        var instance = this;
        var form = jQuery('form[name="TrackerForm"]');
        //var record=form.find('[name="parentId"]').val();
        var params = {};
        params.action = 'SaveAjax';
        params.parent = 'Settings';
        params.module = 'OS2TimeTracker';
        params.mode = 'deleteTimer';
       // params.record = record;
        AppConnector.request(params).then(
            function(data) {                
				console.log(data);
                //var response = data['result'];
                //var result = response['success'];
                //if(result == true){
                    //instance.timerRunning = response['data'];
                    //return true;
                //}
                //return false;
            }
        );
    },

    stopTimer: function (func) {
        clearInterval(func);
    },

    registerEventForTimeTrackerButton: function(){
		var thisInstance=this;
        jQuery('#timeTrackerPopup').hide();
        jQuery('#timetrackerBtn').on('click', function () {
			thisInstance.deleteTimer();
            var visible= jQuery(this).data('popup-visible');
                if(visible == 'true') {
                    jQuery(this).data('popup-visible','false');
                    jQuery('#timeTrackerPopup').show();
                }else{
                    jQuery(this).data('popup-visible','true');
                    jQuery('#timeTrackerPopup').hide();
                }

        });
    },
	
	

    registerEventForControlButton: function () {
        var thisInstance=this;
        jQuery('#controlButton').on('click', function () {
            var status=jQuery(this).data('status');

            if(status == 'running') {
                jQuery(this).data('status','');
                jQuery('#trackerStatus').val('');
                var buttonLbl=jQuery(this).data('start-label');
                jQuery(this).html(buttonLbl);
                thisInstance.stopTimer(thisInstance.intervalTimer);
                thisInstance.stopTimer(thisInstance.intervalTimerSave);

                var endDateTime = jQuery('#endDateTime');
                if(endDateTime.val() == '') {
                    /*var dateFormat = jQuery('#dateFormat').val();
					var dateObj = new Date();
					var month = ('0' + (dateObj.getUTCMonth() + 1)).slice(-2); //months from 1-12
					var day = ('0' + dateObj.getUTCDate()).slice(-2);
					var year = dateObj.getUTCFullYear();
					var hours = ('0' + dateObj.getUTCHours()).slice(-2);
					var minutes = ('0' + dateObj.getUTCMinutes()).slice(-2);
					var seconds = dateObj.getUTCSeconds();

					var selectedDate = day + "-" + month + "-" + year;
                    var currentTime = hours + ":" + minutes ;
                    //var selectedDate = app.getDateInVtigerFormat(dateFormat, currentTime);

                    var timeFormat = jQuery('#timeFormat').val();
                    if(timeFormat == 12) {
                        //endDateTime.val(selectedDate + ' ' + currentTime.toString('hh:mm tt'));
                        endDateTime.val(selectedDate + ' ' + currentTime);
                    }else{
                        //endDateTime.val(selectedDate + ' ' + currentTime.toString('HH:mm'));
                        endDateTime.val(selectedDate + ' ' + currentTime);
                    }

                    //endDateTime.val(selectedDate + ' ' + hours + ':' + minutes + ':' + seconds);
                    if (endDateTime.attr('readonly') == undefined) {
                        endDateTime.datetimepicker('update');
                    }*/
					var dateFormat = jQuery('#dateFormat').val();
                    var currentTime = new Date();
                    var selectedDate = app.getDateInVtigerFormat(dateFormat, currentTime);

                    var timeFormat = jQuery('#timeFormat').val();
                    if(timeFormat == 12) {
                        endDateTime.val(selectedDate + ' ' + currentTime.toString('hh:mm tt'));
                    }else{
                        endDateTime.val(selectedDate + ' ' + currentTime.toString('HH:mm'));
                    }

                    //endDateTime.val(selectedDate + ' ' + hours + ':' + minutes + ':' + seconds);
                    if (endDateTime.attr('readonly') == undefined) {
                        endDateTime.datetimepicker('update');
                    }
                }else{
                    jQuery('#timeTrackerTotal').val(0);
                }

                thisInstance.createEvents();
                
            }else{
                var controlBtn=jQuery('#controlButton');
                var listActiveTimerTable = jQuery('#listActiveTimers');
                var recordId = jQuery('form.timeTrackerForm').find('input[name="parentId"]').val();

                if(jQuery('#timeTrackerTotalRunning').val() != undefined){
                    thisInstance.stopTimer(thisInstance.intervalTimerHeader);
                
                    jQuery(".quickActions .timeTrackerTotalRunning").removeClass("timeTrackerTotalRunning").addClass("timeTrackerTotal");
                    jQuery('#timeTrackerTotalRunning').remove();
                    jQuery('#record_running').remove();
                    jQuery('#header_popup').html(jQuery("input[name='record_name']").val());
                }
                if(status == '') {
                   /* var startDateTime = jQuery('#startDateTime');
                    var dateFormat = jQuery('#dateFormat').val();
                    //var currentTime = new Date();
                    //var selectedDate = app.getDateInVtigerFormat(dateFormat, currentTime);
					
					var dateObj = new Date();
					var month = ('0' + (dateObj.getUTCMonth() + 1)).slice(-2); //months from 1-12
					var day = ('0' + dateObj.getUTCDate()).slice(-2);
					var year = dateObj.getUTCFullYear();
					var hours = ('0' + dateObj.getUTCHours()).slice(-2);
					var minutes = ('0' + dateObj.getUTCMinutes()).slice(-2);
					var seconds = dateObj.getUTCSeconds();

					var selectedDate = day + "-" + month + "-" + year;
                    var currentTime = hours + ":" + minutes ;

                    var timeFormat = jQuery('#timeFormat').val();
                    if(timeFormat == 12) {
                        startDateTime.val(selectedDate + ' ' + currentTime);
                    }else{
                        startDateTime.val(selectedDate + ' ' + currentTime);
                    }

                    if (startDateTime.attr('readonly') == undefined) {
                        startDateTime.datetimepicker('update');
                    }*/
					var startDateTime = jQuery('#startDateTime');
                    var dateFormat = jQuery('#dateFormat').val();
                    var currentTime = new Date();
					console.log(currentTime);
                    var selectedDate = app.getDateInVtigerFormat(dateFormat, currentTime);

                    var timeFormat = jQuery('#timeFormat').val();
                    if(timeFormat == 12) {
                        startDateTime.val(selectedDate + ' ' + currentTime.toString('hh:mm tt'));
                    }else{
                        startDateTime.val(selectedDate + ' ' + currentTime.toString('HH:mm'));
                    }

                    if (startDateTime.attr('readonly') == undefined) {
                        startDateTime.datetimepicker('update');
                    }
                    
                    var newEle = listActiveTimerTable.find('.row_base').clone();
                    var link = jQuery('#header_popup').attr('href');
                    newEle.removeClass('hide');
                    newEle.attr('id','record_'+recordId);
                    newEle.find('.record_name').html(jQuery('#header_popup').text());
                    newEle.find('.record_name, .play_icon').attr('href',link +'&go_back=1');
                    listActiveTimerTable.find('.timeValue').removeClass('timeTrackerTotal');
                    newEle.find('.timeTrackerTotal').html(OS2TimeTracker_Js.formatTime(parseInt(jQuery('#timeTrackerTotal').val())));
                    listActiveTimerTable.prepend(newEle);
                    
                    jQuery('#endDateTime').css('cursor','auto');
                    jQuery('#endDateTime').prop('disabled', false);
                    jQuery('#startDateTime').css('cursor','auto');
                    jQuery('#startDateTime').prop('disabled', false);
                    jQuery('.propFieldInput').prop('disabled', false);
                    
                    jQuery('.propSelectFieldInput').removeAttr('disabled').trigger('liszt:updated');
                    jQuery('#subject').val('');
                    jQuery('#description').val('');
                    jQuery('#activitytype').val(jQuery('#activitytype').data('default-value'));
                    jQuery('#activitytype').trigger("liszt:updated");
                    jQuery('#endDateTime').val('');

                }else if(status == 'pause'){
                    jQuery('.propSelectFieldInput').removeAttr('disabled').trigger('liszt:updated');
                    listActiveTimerTable.find('.timeValue').removeClass('timeTrackerTotal');
                    listActiveTimerTable.find('#record_'+recordId+' .timeValue').addClass('timeTrackerTotal');
                    jQuery('#endDateTime').css('cursor','auto');
                    jQuery('#endDateTime').prop('disabled', false);
                    jQuery('#startDateTime').css('cursor','auto');
                    jQuery('#startDateTime').prop('disabled', false);
                    jQuery('.propFieldInput').prop('disabled', false);

                }
                thisInstance.intervalTimer =  setInterval(function () {
                    thisInstance.timeTrackerTimer();
                }, 1000);
                thisInstance.saveTimeTrackerData();
                thisInstance.intervalTimerSave =  setInterval(function () {
                    thisInstance.saveTimeTrackerData();
                }, 5000);
                
                controlBtn.data('status','running');
                jQuery('#trackerStatus').val('running');
                var buttonLbl=controlBtn.data('complete-label');
                controlBtn.html(buttonLbl);
            }
        });
    },

    registerEventForPauseButton: function () {
        var thisInstance=this;

        jQuery('#btnPause').on('click', function () {
            var status = jQuery('#controlButton').data('status');
            var timeRunning = jQuery('#timeTrackerTotalRunning').val();

            if(status == ''){
                return;
            }
            var controlBtn=jQuery('#controlButton');
            var status=jQuery('#trackerStatus').val();

            if(status == 'running') {
                controlBtn.data('status','pause');
                jQuery('#trackerStatus').val('pause');
                controlBtn.data('status','pause');
                var buttonLbl=controlBtn.data('resume-label');
                controlBtn.html(buttonLbl);
                thisInstance.stopTimer(thisInstance.intervalTimer);
                thisInstance.stopTimer(thisInstance.intervalTimerSave);
                thisInstance.saveTimeTrackerData();
                jQuery('#controlButton').css('cursor','auto');
                jQuery('#startDateTime').css('cursor', 'not-allowed');
                jQuery('#startDateTime').prop('disabled', true);
                jQuery('#endDateTime').css('cursor', 'not-allowed');
                jQuery('#endDateTime').prop('disabled', true);
                jQuery('.propFieldInput').prop('disabled', true);
                jQuery('.propSelectFieldInput').prop('disabled', true).trigger('liszt:updated');

                var saveUrl = window.location.href;
                saveUrl = saveUrl.replace('&go_back=1', '');
                window.history.pushState('', '', saveUrl);

            }else{
                return false;
            }
        });
    },


    saveTimeTrackerData: function () {
        var thisInstance=this;
        var form = jQuery('form[name="TrackerForm"]');
        var params={};
        params = form.serializeFormData();
        params.parent = 'Settings';
        params.module = 'OS2TimeTracker';
        params.action = 'SaveAjax';
        params.mode = 'saveTrackerData';
        params.currentModule = jQuery('#module').val();
        params.trackerStatus = jQuery('#trackerStatus').val();
        params.record_name = jQuery('#record_name').val(); 
        AppConnector.request(params).then(
            function(data) {
                if(data.error) {
                    if(typeof thisInstance.intervalTimer != 'undefined') {
                        thisInstance.stopTimer(thisInstance.intervalTimer);
                        thisInstance.stopTimer(thisInstance.intervalTimerSave);
                    }
                    if(typeof thisInstance.intervalTimerHeader != 'undefined') {
                        thisInstance.stopTimer(thisInstance.intervalTimerHeader);
                        thisInstance.stopTimer(thisInstance.intervalTimerSaveHeader);
                    }
                    //document.location.reload();
                    window.location.href = window.location.href;
                }
            },
            function(error,err){

            }
        );
    },

    createEvents: function () {
        var thisInstance=this;
        thisInstance.stopTimer(thisInstance.intervalTimer);
        thisInstance.stopTimer(thisInstance.intervalTimerSave);

        var progressIndicatorElement = jQuery.progressIndicator();
        var form = jQuery('form[name="TrackerForm"]');
        var params={};
        params = form.serializeFormData();
        params.parent = 'Settings';
        params.module = 'OS2TimeTracker';
        params.action = 'SaveAjax';
        params.mode = 'createEvents';
        AppConnector.request(params).then(
            function(data) {
                progressIndicatorElement.progressIndicator({'mode':'hide'});
                if(data.success == true){
                    var params = {};
                    params['text'] = 'Record has been created';
                    Vtiger_Helper_Js.showMessage(params);
                    var saveUrl = window.location.href;
                    if(saveUrl.search('view=List')<0){
                        thisInstance.reloadPopupContent();
                        saveUrl = saveUrl.replace('&go_back=1', '');
                        window.history.pushState('', '', saveUrl);
                    }else{
                        location.reload();
                    }

                }
            },
            function(error,err){
            }
        );
    },

    reloadPopupContent: function () {
        var form = jQuery('form[name="TrackerForm"]');
        var record=form.find('[name="parentId"]').val();
        var params = {};
        params.view   = 'MassActionAjax';
        params.parent = 'Settings';
        params.module = 'OS2TimeTracker';
        params.mode   = 'getTimeTrackerPopup';
        params.record = record;
        AppConnector.request(params).then(
            function(data) {
                var parse = jQuery.parseJSON(data);
                jQuery('#timeTrackerPopup').html(parse.result);
                app.changeSelectElementView(jQuery('#timeTrackerPopup'));
                var instance = new OS2TimeTracker_Js();
                instance.registerEvents();
            }
        );
    },

    registerEventForCancelButton: function () {
        var thisInstance=this;
        jQuery('#btnCancel').on('click', function () {

            var status = jQuery('#controlButton').data('status');
            if(status == ''){
                return;
            }
            thisInstance.stopTimer(thisInstance.intervalTimer);
            thisInstance.stopTimer(thisInstance.intervalTimerSave);
            var form = jQuery('form[name="TrackerForm"]');
            var record=form.find('[name="parentId"]').val();
            var params = {};
            params = form.serializeFormData();
            params.action = 'SaveAjax';
            params.parent = 'Settings';
            params.module = 'OS2TimeTracker';
            params.mode = 'cancelTimer';
            params.record = record;
            AppConnector.request(params).then(
                function(data) {
                    thisInstance.reloadPopupContent();
                }
            ); 
        });
    },

   

    registerEventsForAll:function(){
        var thisInstance = this;
        var container = jQuery('form.timeTrackerForm');
        this.registerEventForControlButton();
        this.registerEventForPauseButton();

        jQuery('#commentIcon').css('cursor','not-allowed');
        jQuery('#btnCancel').css('cursor','not-allowed');

        if(jQuery('#timeTrackerTotalRunning').val() != undefined){
            thisInstance.intervalTimerHeader =  setInterval(function () {
                thisInstance.setTimerHeader();
            }, 1000);
            
            jQuery('.timeTrackerTotalRunning').html(OS2TimeTracker_Js.formatTime(parseInt(jQuery('#timeTrackerTotalRunning').val())));
        }else{
            jQuery(".timeTrackerTotalRunning").removeClass("timeTrackerTotalRunning").addClass("timeTrackerTotal");
        }
        
        if(jQuery('#trackerStatus').val() == 'running') {
            jQuery(".timeTrackerTotalRunning").removeClass("timeTrackerTotalRunning").addClass("timeTrackerTotal");
            //jQuery('#controlButton').css('cursor','not-allowed');
            thisInstance.intervalTimer =  setInterval(function () {
                thisInstance.timeTrackerTimer();
            }, 1000);
            thisInstance.intervalTimerSave =  setInterval(function () {
                thisInstance.saveTimeTrackerData();
            }, 5000);
            jQuery('.timeTrackerTotal').html(OS2TimeTracker_Js.formatTime(parseInt(jQuery('#timeTrackerTotal').val())));
        }else{
            jQuery('.timeTrackerTotal').html(OS2TimeTracker_Js.formatTime(parseInt(jQuery('#timeTrackerTotal').val())));
        }
       
    },
    
    registerEvents: function(){
        var thisInstance = this;
        
        var container = jQuery('form.timeTrackerForm');
        this.registerDateTimePicker(container);
        this.registerEventForControlButton();
        this.registerEventForPauseButton();
        this.registerEventForCancelButton();

        if(jQuery('#timeTrackerTotalRunning').val() != undefined){
            thisInstance.intervalTimerHeader =  setInterval(function () {
                thisInstance.setTimerHeader();
            }, 1000);
            thisInstance.intervalTimerSaveHeader =  setInterval(function () {
                thisInstance.updateTimeTrackerTotal();
            }, 5000);
            jQuery('.timeTrackerTotalRunning').html(OS2TimeTracker_Js.formatTime(parseInt(jQuery('#timeTrackerTotalRunning').val())));
        }else{
            jQuery(".timeTrackerTotalRunning").removeClass("timeTrackerTotalRunning").addClass("timeTrackerTotal");
        }

        if(jQuery('#trackerStatus').val() == 'running') {
            jQuery('#startDateTime').css('cursor', 'auto');
            jQuery('#endDateTime').css('cursor', 'auto');
            thisInstance.intervalTimer =  setInterval(function () {
                thisInstance.timeTrackerTimer();
            }, 1000);
            thisInstance.intervalTimerSave =  setInterval(function () {
                thisInstance.saveTimeTrackerData();
            }, 5000);
            jQuery('.timeTrackerTotal').html(OS2TimeTracker_Js.formatTime(parseInt(jQuery('#timeTrackerTotal').val())));
        }else{
            jQuery('#startDateTime').css('cursor', 'not-allowed');
            jQuery('#startDateTime').prop('disabled', true);
            jQuery('#endDateTime').css('cursor', 'not-allowed');
            jQuery('#endDateTime').prop('disabled', true);
            jQuery('.propFieldInput').prop('disabled', true);
            jQuery('.propSelectFieldInput').prop('disabled', true).trigger('liszt:updated');

            jQuery('.timeTrackerTotal').html(OS2TimeTracker_Js.formatTime(parseInt(jQuery('#timeTrackerTotal').val())));
        }

    },


});

jQuery(document).ready(function () {
   var sURL = window.location.search.substring(1);
   var sURLVar = sURL.split('&');
   var targetModule = '';
   var targetView   = '';
   var targetRecord = '';
   for(var i=0; i < sURLVar.length; i++){
        var sParamName = sURLVar[i].split('=');
        if (sParamName[0] == 'module') {
            targetModule = sParamName[1];
        }
        else if (sParamName[0] == 'view') {
            targetView = sParamName[1];
        }
        else if (sParamName[0] == 'record') {
            targetRecord = sParamName[1];
        }
   }

   var params = {};
   params.action = 'SaveAjax';
   params.module = 'OS2TimeTracker';
   params.mode   = 'getSelectedModules';
   params.parent = 'Settings';

   AppConnector.request(params).then(
       function(data){
            var selectedModules=data.result;
            console.log(jQuery.inArray(targetModule,selectedModules));
            if(jQuery.inArray(targetModule,selectedModules) != -1 && (targetView == 'Detail' || targetView == 'Edit') ) {

                var timeTrackerButton=jQuery('<div class="pull-right">&nbsp;<a href="javascript:void(0);" data-popup-visible="false" id="timetrackerBtn"><img src="layouts/vlayout/modules/Settings/OS2TimeTracker/images/timer.png" width="30px" height="30px" /></a></div><div class="detailViewTitle pull-right"><span class="recordLabel font-x-x-large pushDown timeTrackerTotalRunning" style="color: #2787e0;" ></span></div>');
                jQuery('.quickActions').removeClass('span2')
                jQuery('.quickActions').addClass('span3')
                jQuery('.quickActions').find('.commonActionsButtonContainer').after(timeTrackerButton);

                var params = {};
                params.view   = 'MassActionAjax';
                params.parent = 'Settings';
                params.module = 'OS2TimeTracker';
                params.mode   = 'getTimeTrackerPopup';
                params.record = targetRecord;
                params.targetModule = targetModule;
				if(typeof isGoBack != 'undefined'){
                    params.isGoBack = isGoBack;
                }
                AppConnector.request(params).then(
                    function(data){
                        var parseData = jQuery.parseJSON(data);
                        var navHeight=jQuery('.navbar-inverse').height();
                        jQuery('body').append('<div id="timeTrackerPopup" style="border:2px solid #2787e0; display: none; position: fixed; right: 0px;  background: rgb(255, 255, 255) none repeat scroll 0% 0%; z-index: 1000; bottom: 0; top: '+navHeight+'px; overflow-y : scroll; ">'+parseData.result+'</div>');
                        app.changeSelectElementView(jQuery('#timeTrackerPopup'));
						if( typeof isGoBack != 'undefined' && isGoBack == 1) {
                            var timeTrackerButon = jQuery('#timeTrackerButton');
                            timeTrackerButon.data('popup-visible', 'true');
                            jQuery('#timeTrackerPopup').show();
                            var listActiveTimerTable = jQuery('#listActiveTimers');
                            listActiveTimerTable.find('.timeValue').first().addClass('timeTrackerTotal');
						}
                        var instance = new OS2TimeTracker_Js();
                        instance.registerEventForTimeTrackerButton();
                        instance.registerEvents();
                    }
                    
                );
            }else{
                if(jQuery.inArray(targetModule,selectedModules) != -1){
                    var timeTrackerButton=jQuery('<div class="pull-right">&nbsp;<a href="javascript:void(0);" popup-visible="false" id="timetrackerBtn"><img src="layouts/vlayout/modules/Settings/OS2TimeTracker/images/timer.png" width="30px" height="30px" /></a></div><div class="detailViewTitle pull-right"><span class="recordLabel font-x-x-large pushDown timeTrackerTotalRunning" style="color: #2787e0;" ></span></div>');
                    jQuery('.quickActions').removeClass('span2')
                    jQuery('.quickActions').addClass('span3')
                    jQuery('.quickActions').find('.commonActionsButtonContainer').after(timeTrackerButton);
    
                   
                }
                
                // Get Time Tracker form
                var params = {};
                params.view = 'MassActionAjax';
                params.parent = 'Settings';
                params.module = 'OS2TimeTracker';
                params.mode = 'getTimeTrackerPopupForAll';

                AppConnector.request(params).then(
                    function(data) {
                        var parseData = jQuery.parseJSON(data);
                        var navHeight=jQuery('.navbar-inverse').height();
                        jQuery('body').append('<div id="timeTrackerPopup" style="border:2px solid #2787e0; display: none; position: fixed; right: 0px;  background: rgb(255, 255, 255) none repeat scroll 0% 0%; z-index: 1000; bottom: 0; top: '+navHeight+'px; overflow-y : scroll; ">'+parseData.result+'</div>');
                        app.changeSelectElementView(jQuery('#timeTrackerPopup'));
                        var instance = new OS2TimeTracker_Js();
                        instance.registerEventForTimeTrackerButton();
                        instance.registerEventsForAll();
                    }
                );
            }  
       }
    );
});

$(window).on('beforeunload', function() {
    var status=jQuery('#trackerStatus').val();
    if(status == 'running'){
        var instance = new OS2TimeTracker_Js();
        instance.saveTimeTrackerData();
    }
});