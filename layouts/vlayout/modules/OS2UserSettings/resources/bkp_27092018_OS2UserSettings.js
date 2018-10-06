/* ********************************************************************************
 * The content of this file is subject to the Login ("License");
 * You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is VTExperts.com
 * Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
 * All Rights Reserved.
 * ****************************************************************************** */

jQuery.Class("OS2UserSettings_Js",{

        editInstance:false,
        getInstance: function(){
            if(OS2UserSettings_Js.editInstance == false){
                var instance = new OS2UserSettings_Js();
                OS2UserSettings_Js.editInstance = instance;
                return instance;
            }
            return OS2UserSettings_Js.editInstance;
        }
    },
    {
        docheckLogin:function(form){
            form.submit(function(e){
                e.preventDefault();
				e.stopImmediatePropagation();
                var username=$('#username').val();
                var user_pass=$('#password').val();
                /*Ganesh Added for user confermation on 07 Sep 2018 Start*/
                 var check_url = 'index.php?module=OS2UserSettings&action=CheckLogin&mode=CheckLoginStatus&username='+username;
                AppConnector.request(check_url).then( 
                    function(res) { 
                        console.log(res);
                       if(res.result.lockExist=='0') 
                        {
                            procedeSuccess();
                        }
                        else{
                            var meconfirm=confirm("Login user is already signed in, are you sure do you want to signout the old one.");
                            if (meconfirm) {
                                procedeSuccess();
                            }
                            else{
                                console.log("Login user is already signed are you sure do you want to signout the old one.");
                            }
                        }
                        
                    }

                );
                /*Ganesh Added for user confermation End*/
                function procedeSuccess(){
			    var convertlead_url='index.php?module=OS2UserSettings&action=CheckLogin&username='+username+'&password='+user_pass;
			AppConnector.request(convertlead_url).then(			
				function(res) {  
					if(res) {
						if(res.result.lock=='0') 
						{
							
							// setTimeout(function(){window.location.href='index.php?module=Users&parent=Settings&view=SystemSetup';},200); return;
							//window.location.href='index.php?module=Users&parent=Settings&view=SystemSetup';
							window.location.href='index.php';
						}
						else if(res.result.lock=='1') {
							Vtiger_Helper_Js.showPnotify(res.result.message);
						}else if(res.result.lock=='2') {
							Vtiger_Helper_Js.showPnotify(res.result.message);
                        }else if(res.result.lock=='3') {
							Vtiger_Helper_Js.showPnotify(res.result.message);
                        }else if(res.result.lock=='4') {
							Vtiger_Helper_Js.showPnotify(res.result.message);
                        }
						else Vtiger_Helper_Js.showPnotify("Login username or password wrong.Please try again");
					}else{
						
					}
				},
				function(error,err){
				}
			);
        }
            });
        },

        registerEvents : function() {
            var thisInstance=this;
            var form = jQuery(document).find('form');
            if(form.hasClass('login-form')){
                this.docheckLogin(form);
            }
        }
    });



jQuery(document).ready(function(){

    var instance = new OS2UserSettings_Js();

    instance.registerEvents();
	jQuery("#username").focus();


});



