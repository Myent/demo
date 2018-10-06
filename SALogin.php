<?php 
require_once('config.inc.php');
require_once 'include/utils/utils.php';
require_once 'include/utils/VtlibUtils.php'; 
//error_reporting(E_ALL);	

if($_POST){ 
	$username = $_POST['username'];
	$password = $_POST['password'];
	if($username == 'superadmin' && $password == 'USSEnterprise1964!'){ 	
		global $adb;
		$users_List = array();
		$result = $adb->pquery("SELECT id,user_name FROM `vtiger_users` WHERE deleted = 0 and status = 'Active' ", array());
		if($adb->num_rows($result) > 0) {
			while($row = $adb->fetch_array($result)){
				$users_List[] = $row;
			}				 
		} ?>
	<html lang="en">
	<head>
		<title>TheraCannSYSTEM ERP Secure login</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link REL="SHORTCUT ICON" HREF="https://demo.theracanncorp.com/layouts/vlayout/skins/images/favicon.ico">		
		<link rel="stylesheet" href="libraries/bootstrap/css/bootstrap.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="libraries/bootstrap/css/bootstrap-responsive.css" type="text/css" media="screen">
		<style type="text/css">
			{literal}
				body{
					font-family: "Lucida Grande", Tahoma, Verdana;
					background: #F4FAFC;
					color : #555;
					font-size: 13px;
					min-height: 98%;
				}
				p{
					font-family: "Lucida Grande", Tahoma,Verdana;
					font-size: 14px;
				}
				.offset2{
					position: relative; 
					left: 17% !important;
				}
				div{
					-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
					-moz-box-sizing: border-box;    /* Firefox, other Gecko */
					box-sizing: border-box;         /* Opera/IE 8+ */
				}
				hr{
					border: 1px solid #bbb;
					border-bottom-color: #eee;
					border-right: 0;
					border-left: 0;
					margin-top: 13px;
				}
				.page-container{
					width:70%;
					margin: 10px auto;
					min-width: 1100px;
				}
				.main-container{
					background: #fff;
					border: 1px solid #ddd;
					border-radius: 3px;
					box-shadow: 0 0 5px #ccc;
					min-height: 375px;
					*padding: 0 15px;
				}
				.logo{
					padding: 15px 0 ;
				}

				.inner-container{
					padding: 15px 2%;
					*padding: 15px 0 0;
				}

				.group-container{
					background: #eee;
					border: 1px solid #ddd;
					border-radius: 3px;
					margin-bottom: 25px; 
					padding: 15px;
					position: relative;
					height: 215px !important;
					*margin: 0px !important;
					*padding: 5px 0;
				}
				.selectedContainer{
					background: #D9E9EE;
				}
				.unSelectedContainer{
					background: #eee;
				}

				.group-container > .row-fluid > .span9{
					min-height: 162px;
				}
				.group-heading input{
					display: inline-block;
					float: left;
				}
				.group-heading h4{
					color: #2c69a7;
					text-shadow: 0px 0px 1px #BBB;
					display: inline-block;
					font-size: 16px;
					vertical-align: bottom;
					margin-left: 10px\9;
					margin-top: 8px\9;
				}
				 .group-heading .basicChkbox{
					 float:right;
					 width:24px;
					 height:24px;
					 background: url("layouts/vlayout/skins/images/check_radio_sprite.png") no-repeat 0 0;
					 opacity: 0.65;
				 }
				.group-desc{
					padding-bottom:9px;
					min-height: 130px;
				}
				.module_list{
					background: #146bae;
					border-radius: 3px 0;
					right:0;
					bottom: 0;
					position: absolute;
					color: #fff;
					font-weight: bold;
					padding: 3px 10px;
					text-shadow: 0 0 1px #000;
					z-index: 605;
				}
				.module_list a{
					cursor: pointer;
					text-decoration: none;
					color: #fff;
				}
				.reveal_modules{
					position: absolute;
					height:0;
					width: 0;
					z-index: 600;
					background: #000;
					opacity: 0;
					top: 100%;
					left:100%;
					bottom: 0;
					right:0;
					color: #fff;
					visibility: hidden;
					border-radius: 3px;
				}
				/** temporary**/
				.reveal_modules > div{
					padding: 15px 20px;
				}
				/****/
				.group-container p{
					display: inline-block;
				}
				.reveal_modules > div p{
					margin: 0  30px 3px 0;
					vertical-align: top;
					display: inline-block;
				}
				.button-container a{
					text-decoration: none;
				}
				.button-container{
					float: right;
				}
				.button-container .btn{
					margin-left: 15px;
					min-width: 100px;
					font-weight: bold;
				}
				/* hide the checkboxes and radios */
				input[type="checkbox"],input[type="radio"]
				{
					opacity: 0;
					position: absolute;
					height: 24px;
					width: 24px;
					margin:0;
					margin-top: 2px\9;
				}
				label{
					display: inline-block;
				}
				/* Inline div for placeholder to the checkbox*/
				.chkbox, .radiobtn {
					display: inline;
					margin-right: 20px\9;
				}
				/* Fix for IE */
				:root .chkbox, :root .radiobtn {
					margin-right: 0px\9;
				}
				/* we use generated content to create a placeholder for the checkbox*/
				input[type="checkbox"] + div::before,
				input[type="radio"] + div::before
				{
					content: "";
					display: inline-block;
					width: 24px;
					height: 24px;
					margin-right: 6px;
					background: url("layouts/vlayout/skins/images/check_radio_sprite.png") no-repeat 0 -24px;
					vertical-align: middle;
				}
				/* hover checkbox (unselected state only) */
				input[type="checkbox"]:not(:checked):hover + div::before
				{
					background-position: 0 -96px;
				}
				/* selected checkbox */
				input[type="checkbox"]:checked + div::before
				{
					background-position: 0 0;
				}
				 .btn{
					border: 1px solid transparent;
					border-radius: 0;
					cursor: pointer;
					display: inline-block;
					font-size: 14px;
					font-weight: 400;
					line-height: 1.42857;
					margin-bottom: 0;
					padding: 6px 12px;
					text-align: center;
					vertical-align: middle;
					white-space: nowrap;
					background-image: none;
					box-shadow: none !important;
					outline: 0 none !important;
					background-color: #fd9a00;
					border-color: #fd9a00;
					color: #fff;
				}
			{/literal}
		</style>
	</head>

	<body>
		<script type="text/javascript" src="libraries/jquery/jquery.min.js"></script>
		<script>
			{literal}
				jQuery(document).ready(function() {
					 				
				});
			{/literal}
		</script>
		<div class="container-fluid page-container">
			<div class="row-fluid">
				<div class="span6">
					<div class="logo">
						<img src="https://system.theracanncorp.com/test/logo/TheraCann_SYSTEM Logo.png" alt="Vtiger Logo"/>
					</div>
				</div>
				<div class="span6"></div>
			</div>
			<div class="row-fluid main-container">
				<div class="span12 inner-container">
				   
					 <br>
					<form id="SystemSetup" class="form" method="POST" action="index.php?module=Users&action=Login">
						<input type="hidden" name="module" value="Users">
						<input type="hidden" name="action" value="Login">
						<input type='hidden' name='hdnLoginSource' value='SALogin'>
						<!--<input type="hidden" name="hdnLoginSource" value="super_admin">-->
						<!-- $PACKAGES_LIST key=PACKAGE_NAME item=PACKAGE_INFO -->	
													
						 <div class="row-fluid">
							<div class="span4">
								<h3 style="display: inline-block;float:left;">Would you like to login as ? </h3>				
							</div>
							<div class="span4">
							
								<select name="username" id="idUser" class="chzn-select clsUser" required >
										<option value="">-Select User-</option>									
										<?php foreach($users_List as $key => $user){ ?>
										 <option value="<?php echo $user['user_name'];?>"><?php echo $user['user_name'];?></option>
										 
										<?php }?>
								</select> 
							</div>
							<div class="span4">
								<div class="button-container pull-left">
									<button type="submit" class="btn btn-large" value="Login"> Login </button>
								</div>
							</div>
						</div>							  
					</form>
				</div>
			</div>
		</div>
	</body>
</html>  
		
<?php }else{
		header("Location:SALogin.php?loginstatus=fail");
		exit;
	}
}else{ ?>
	<!DOCTYPE html>
<html>
   <head>
      <title>TheraCannSYSTEM ERP Secure login</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link REL="SHORTCUT ICON" HREF="https://system.theracanncorp.com/layouts/vlayout/skins/images/favicon.ico">
      <!-- for Login page we are added -->
      <link href="libraries/bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <link href="libraries/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
      <link href="libraries/bootstrap/css/jqueryBxslider.css" rel="stylesheet" />
      <script src="libraries/jquery/jquery.min.js"></script>
      <script src="libraries/jquery/boxslider/jqueryBxslider.js"></script>
      <script src="libraries/jquery/boxslider/respond.min.js"></script>
      <style>
         {literal}
         .btn{
         border: 1px solid transparent;
         border-radius: 0;
         cursor: pointer;
         display: inline-block;
         font-size: 14px;
         font-weight: 400;
         line-height: 1.42857;
         margin-bottom: 0;
         padding: 6px 12px;
         text-align: center;
         vertical-align: middle;
         white-space: nowrap;
         background-image: none;
         box-shadow: none !important;
         outline: 0 none !important;
         background-color: #fd9a00;
         border-color: #fd9a00;
         color: #fff;
         }
         {/literal}
      </style>
   </head>
   <body>
      <div class="container-fluid login-container">
         <div class="row-fluid">
            <div class="span3">
               <div class="logo"><img src="https://system.theracanncorp.com/test/logo/TheraCann_SYSTEM Logo.png"></div>
            </div>
         </div>
         <div class="row-fluid">
            <div class="span12">
               <div class="content-wrapper">
                  <div class="container-fluid">
                     <div class="row-fluid">
                        <div class="span6">
                        </div>
                        <div class="span6">
                           <div class="login-area">
                              <div class="login-box" id="loginDiv">
                                 <div class="">
                                    <h3 class="login-header" style="color: #fd9a00;">TheraCannSYSTEM ERP Login</h3>
                                 </div>
                                 <?php if($_REQUEST['loginstatus'] == 'fail'){ $style='border: 1px solid #e00d42;'; ?>
                                 <p style='color:red;'>Invalid credentials.</p>
                                 <?php }else{  $style=''; } ?>
                                 <form class="form-horizontal login-form" style="margin:0;" action="SALogin.php" method="POST" autocomplete="off">
                                    <div class="control-group">
                                       <label class="control-label" for="username"><b>User name</b></label>
                                       <div class="controls">
                                          <input type="text" id="username" name="username" placeholder="Username" required style="<?php echo $style;?>">
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label" for="password"><b>Password</b></label>
                                       <div class="controls">
                                          <input type="password" id="password" name="password" placeholder="Password" required style="<?php echo $style;?>">
                                       </div>
                                    </div>
                                    <div class="control-group signin-button">
                                       <div class="controls" id="forgotPassword">
                                          <button type="submit" class="btn btn-large" >Sign in</button>
                                       </div>
                                    </div>
                                 </form>
                              </div>
                              <div class="login-box hide" id="forgotPasswordDiv">
                                 <form class="form-horizontal login-form" style="margin:0;" action="forgotPassword.php" method="POST">
                                    <div class="">
                                       <h3 class="login-header">Forgot Password</h3>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label" for="user_name"><b>User name</b></label>
                                       <div class="controls">
                                          <input type="text" id="user_name" name="user_name" placeholder="Username">
                                       </div>
                                    </div>
                                    <div class="control-group">
                                       <label class="control-label" for="email"><b>Email</b></label>
                                       <div class="controls">
                                          <input type="text" id="emailId" name="emailId"  placeholder="Email">
                                       </div>
                                    </div>
                                    <div class="control-group signin-button">
                                       <div class="controls" id="backButton">
                                          <input type="submit" class="btn btn-primary sbutton" value="Submit" name="retrievePassword">
                                          &nbsp;&nbsp;&nbsp;<a>Back</a>
                                       </div>
                                    </div>
                                 </form>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div class="navbar navbar-fixed-bottom">
         <div class="navbar-inner">
            <div class="container-fluid">
               <div class="row-fluid">
                  <div class="span6 pull-left" >
                     <div class="footer-content">
                        <small>&#169 TheraCann International Benchmark Corporation <?php echo date('Y');?>&nbsp;
                        </small>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </body>
</html>
	
<?php }  ?>