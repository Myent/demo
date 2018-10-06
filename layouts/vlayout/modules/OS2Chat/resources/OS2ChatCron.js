/* ********************************************************************************
 * The content of this file is subject to the Table Block ("License");
 * You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is VTExperts.com
 * Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
 * All Rights Reserved.
 * ****************************************************************************** */

jQuery.Class("OS2ChatCron_Js",{
    
},{ 
    registerEvents: function() {
        var html = '<span class="span settingIcons"><a id="c-notification-icon" style="background: url(\'layouts/vlayout/modules/OS2Chat/resources/icon-notification.png\');width: 21px;height: 21px;display: block;" href="index.php?module=OS2Chat&amp;view=Dashboard"></a></span>';

        jQuery('#headerLinksBig').prepend(html);

        setInterval(function(){ 
            //OS2Chat_IndexAjax_Action
            var params = {
                'module' : 'OS2Chat',
                'action' : 'IndexAjax'
            }
            AppConnector.request(params).then(
                function(data) {
                    if(data.result > 0 ){
                    jQuery('#c-notification-icon').html('<small style="background: #FF8C00;border-radius: 50%;color: white;display: block;height: 20px;margin-left: 18px;margin-top: -8px;min-height: 15px;min-width: 15px;padding: 0;position: absolute;text-align: center;vertical-align: middle;width: 20px;" title="'+data.result+'New Messages"><span id="chatcount" value="">'+data.result+'</span></small>');
                    }else{
                        jQuery('#c-notification-icon').html('');
                    }
                },
                function(error,err){
                    aDeferred.reject();
                }
            );


        }, 5000); 
    }
});
jQuery(document).ready(function(){
    var instance = new OS2ChatCron_Js();
    instance.registerEvents();
     
});