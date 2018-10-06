/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

var Vtiger_DesktopNotifiation_Js = {
	 desktopbody : '',
	 desktopmodule :'Calendar',
	 desktoptitle : '',
	showDesktopNotification : function() {
		var thisInstance = this;
		if (Notification.permission === "granted") {
			var url = 'index.php?module=Calendar&action=ActivityReminder&mode=getReminders';
			AppConnector.request(url).then(function(data){
				if(data.success && data.result) {
					for(i=0; i< data.result.length; i++) {
						var record  = data.result[i];
						var subject =record.subject;//+' - '+record.ActivityType;	
						var bodyno = 'Activity Type: '+record.ActivityType+'\n'+app.vtranslate('JS_START_DATE_TIME')+' : '+record.startdate+'     '+app.vtranslate('JS_END_DATE_TIME')+' : '+record.enddate;
						var options = {
							body: bodyno,
							icon: "layouts/vlayout/skins/images/btnCalendar.png",
							dir : "ltr"
						};	
						var notification = new Notification(subject,options);
						notification.onclick = function() { 
							window.location.href = 'index.php?module=Calendar&view=Detail&record='+record.id;
							
						};
				  }
				}
			});
		  }
		//Ended here
	},
	
	requestCalendarEvents : function() {
        var url = 'index.php?module=Calendar&action=ListNotification';
        AppConnector.request(url).then(function(data){
			 if(data.success && data.result) {
                for(i=0; i< data.result.length; i++) {
                    var record  = data.result[i];
					var subject =record.subject;//+' - '+record.ActivityType;				
					var bodyno = 'Activity Type: '+record.ActivityType+'\n'+app.vtranslate('JS_START_DATE_TIME')+' : '+record.startdate+'    '+app.vtranslate('JS_END_DATE_TIME')+' : '+record.enddate;
					var options = {
						body: bodyno,
						icon: "layouts/vlayout/skins/images/btnCalendar.png",
						dir : "ltr"
					};
					var notification = new Notification(subject,options);
					notification.onclick = function() { 
						window.location.href = 'index.php?module=Calendar&view=Detail&record='+record.id;
					};
				}
			 }
        });
    },
	
	
	registerEvents : function(){
		var html = '<span class="span settingIcons"><img src="layouts/vlayout/skins/images/bell.png" alt="Desktop Notifications" title="Desktop Notifications" class="desktopnotification" height="20px;"></span>';
		jQuery('#headerLinksBig').prepend(html);
		Vtiger_DesktopNotifiation_Js.requestCalendarEvents();
        setInterval("Vtiger_DesktopNotifiation_Js.requestCalendarEvents()",120000);//
		Vtiger_DesktopNotifiation_Js.desktopAlertNotification();
		Vtiger_DesktopNotifiation_Js.showDesktopNotification();
		setInterval("Vtiger_DesktopNotifiation_Js.showDesktopNotification()",120000);//
	},
	
registerPostAjaxEvents: function() {
		Vtiger_Index_Js.registerTooltipEvents();
	},
	desktopAlertNotification : function(){
		var thisInstance = this;
		jQuery(".desktopnotification").on('click',function(){
			
				 if (!("Notification" in window)) {
					bootbox.alert("This browser does not support desktop notification");
				  }// Let's check if the user is okay to get some notification
				  else if (Notification.permission === "granted") {
					// If it's okay let's create a notification
			
				  }
				  else if (Notification.permission !== 'denied') {
					Notification.requestPermission(function (permission) {
					  // Whatever the user answers, we make sure we store the information
					  if (!('permission' in Notification)) {
						Notification.permission = permission;
					  }
					});
				  }
			});
		}
}
//On Page Load
jQuery(document).ready(function() {
	Vtiger_DesktopNotifiation_Js.registerEvents();
	
});
