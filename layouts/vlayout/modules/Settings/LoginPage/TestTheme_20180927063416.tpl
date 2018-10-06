<!DOCTYPE html>
<html>
   <head>
      <title></title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <!-- for Login page we are added -->
      <link href="libraries/bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <link href="libraries/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
      <link href="libraries/bootstrap/css/jqueryBxslider.css" rel="stylesheet" />
      <link href="layouts/vlayout/modules/Settings/LoginPage/resources/LoginPage.css" rel="stylesheet" />
      <link href="layouts/vlayout/modules/Settings/LoginPage/resources/LoginPagemain.css" rel="stylesheet" />	  
      <script src="libraries/jquery/jquery.min.js"></script><script src="libraries/jquery/boxslider/jqueryBxslider.js"></script>
	  <script src="libraries/jquery/boxslider/respond.min.js"></script>

	   <script>
		jQuery(document).ready(function () {
			  scrollx = jQuery(window).outerWidth();
			  window.scrollTo(scrollx, 0);
			  slider = jQuery('.bxslider').bxSlider({
				  mode: 'horizontal',
				  auto: true,
				  randomStart: false,
				  autoHover: false,
				  controls: false,
				  pager: false,
				  speed: 10000,
				  easing: 'linear',
				  onSliderLoad: function () {}
			  });
		  });
		</script></head><body><div class="vte-login-container"><div class="logo"><img src="loginimages/TheraCann_SYSTEM Logo_1517844048_1538030057.png" /></div><div class="row-fluid"><div class="span6 slideshow" style="margin-left:0;">
						<div class="carousal-container">
							<ul class="bxslider"><li> <div id="slide0" class="slide"><img class="pull-left" src="loginimages/267f709e4c8b696957ebf9f187c0d344--iphone-backgrounds-phone-wallpapers_1538030057.jpg"></div></li><li> <div id="slide1" class="slide"><img class="pull-left" src="loginimages/648773_1538030057.jpg"></div></li><li> <div id="slide2" class="slide"><img class="pull-left" src="loginimages/d7150a50365035e908fc375b9a65e07f_1538030057.jpg"></div></li></ul>
				</div>
			</div><style> .login-header, .subtitle { color:#5c39c4; } .signin-button .btn { border-color:#5c39c4; background-color:#5c39c4; } .login-more-info .copy-right small{  color: #5c39c4 } h3.forgot-password {  color: #5c39c4  !important;  }</style>
				<div class="span6 login-area">
				<div class="span12 site-info">
				<h1 class="login-header">Test Theme</h1>
				<p class="subtitle">Test Theme</p>
				</div>
				<div class="span12 login-box" id="loginDiv">
				<form class="form-horizontal login-form" action="index.php?module=Users&action=Login" method="POST">
					{if isset($smarty.request.error)}
						<div class="alert alert-error">
							<p>Invalid username or password.</p>
						</div>
					{/if}
					{if isset($smarty.request.fpError)}
						<div class="alert alert-error">
							<p>Invalid Username or Email address.</p>
						</div>
					{/if}
					{if isset($smarty.request.status)}
						<div class="alert alert-success">
							<p>Mail was send to your inbox, please check your e-mail.</p>
						</div>
					{/if}
					{if isset($smarty.request.statusError)}
						<div class="alert alert-error">
							<p>Outgoing mail server was not configured.</p>
						</div>
					{/if}
					<div class="row">
						<div class="span6 username"><input type="text" id="username" name="username" placeholder="Username" value=""></div>
						<div class="span6 password"><input type="password" id="password" name="password" placeholder="Password" value=""></div>
					</div>
					<div class="row control-group signin-button pull-right">
						<div class="span12" id="forgotPassword"><a>Forgot Password ?</a>&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-primary sbutton">Sign in</button></div>
					</div>
				</form>
				</div>
				<div class="span12 login-box hide" id="forgotPasswordDiv">
				<form class="form-horizontal login-form" action="forgotPassword.php" method="POST">
					 
					<div class="row">
						<h3 class="forgot-password">Forgot Password</h3>
					</div>
					<div class="row">
						<div class="span6 username"><input type="text" id="user_name" name="user_name" placeholder="Username"></div>
						<div class="span6 password"><input type="text" id="emailId" name="emailId"  placeholder="Email"></div>
					</div>
					<div class="row control-group signin-button">
						<div class="" id="backButton"><input type="button" class="btn btn-back sbutton pull-left" value="Back" style="color:white;"><input type="submit" class="btn btn-primary sbutton pull-right" value="Submit" name="retrievePassword"></div>
					</div>
				</form>
				</div>
				<div class="span12 login-more-info vte-user-login">
				<div class="row"><div class="span6 " ><small>Testing login page</small></div></div>
				</div>
			</div></div>
      </div>
      
   </body>
   <script type="text/javascript">CsrfMagic.end();</script>
   <script>jQuery(document).ready(function () {
	jQuery("#forgotPassword a").click(function () {
		jQuery("#loginDiv").hide();
		jQuery("#forgotPasswordDiv").show();
	});
	jQuery("#backButton .btn-back").click(function () {
		jQuery("#loginDiv").show();
		jQuery("#forgotPasswordDiv").hide();
	});
	jQuery("input[name='retrievePassword']").click(function () {
		var username = jQuery('#user_name').val();
		var email = jQuery('#emailId').val();
		var email1 = email.replace(/^\s+/, '').replace(/\s+$/, '');
		var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/;
		var illegalChars = /[\(\)\<\>\,\;\:\\\"\[\]]/;
		if (username == '') {
			alert('Please enter valid username');
			return false;
		} else if (!emailFilter.test(email1) || email == '') {
			alert('Please enater valid email address');
			return false;
		} else if (email.match(illegalChars)) {
			alert("The email address contains illegal characters.");
			return false;
		} else {
			return true;
		}
	});
});
</script>
</html>