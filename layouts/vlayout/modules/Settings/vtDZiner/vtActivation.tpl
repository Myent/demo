{if $smarty.get.debug == yes}
	{debug}
	{$ACTIVATIONACTION}<br>
	{$ACTIVATIONRESULT}
{/if}
<div class="container-fluid">
	<hr>
	<h3>Theracann License Activation/Authentication Required</h3><hr/>
	<h4>Please submit your ACTIVATION KEY and click on the Activate button<br> For activation to work, please ensure that outbound posts are allowed from your web hosting environment to the url given below<br><br> <font color="red">http://support.vtigress.com/vtdziner</font>&nbsp;<sup><a href="javascript:testPosts();">Click to test</a></sup>
	<br><br> Without the outbound posts allowed, Theracann will fail to be activated
	<br> Contact <a href="mailto:support@theracann.com">support@theracann.com</a> if you have any problems </h4>
	<br>
	<h4>If activation fails, click on the RESET button to show the Reset Installation form</h4>
	<hr>
</div>

<div class="control-group">
	<span class="control-label">
		<strong>
			Activation Key
		</strong>
	</span>
	<div class="controls">
		<span class="row-fluid">
			<input type="text" id="registrationkey" name="registrationkey" size="80" class="span4" />
		</span>
	</div>
</div>
<!-- Next -->
<div class="control-group" id="resetblock" style="display:none">
	<span class="control-label">
		<strong>
			Reset Key
		</strong>
	</span>
	<div class="controls">
		<span class="row-fluid">
			<input type="text" id="secondarykey" name="secondarykey" size="80" class="span4" />
		</span>
	</div>
</div>
<div>
	<input type="hidden" id="regmode" name="regmode" value=".$activationAction." />
	<input id="activatebutton" type="button" class="addButton" value='Activate' onclick='activateTheracann("activate");' title="Enter the Activation Key and click to Activate"/>
	<input id="resetbutton" type="button" value='Reset' onclick='showResetBlock();' title="Click to display RESET form"/>
	<input style="display:none" id="reactivatebutton" type="button" value='Reset & Activate' onclick='activateTheracann("register");'/>
</div>
<hr>
<div>
<h3 class="validationResult redColor"></h3>
</div>
<div class="echobackResult redColor">
</div>
<script type="text/javascript" src="resources/Connector.js"></script>
<script>
function showResetBlock(){
jQuery('[id="resetblock"]').show();
jQuery('[id="activatebutton"]').hide();
jQuery('[id="reactivatebutton"]').show();
jQuery('[id="resetbutton"]').hide();
}

function testPosts(){
	jQuery(".echobackResult").html("Testing for HTTP POST from Server&nbsp;<img src='./layouts/vlayout/skins/images/vtbusy.gif'>");
	var params = {};
	params['module'] = 'vtDZiner';
	params['parent'] = 'Settings';
	params['view'] = 'Index';
	params['mode'] = 'echoback';
	AppConnector.request(params).then(function(data) {
		jQuery(".echobackResult").html(data);
	});
}

function activateTheracann(regmode){
	jQuery(".echobackResult").html('');
	jQuery(".validationResult").html('');
	var params = {};
	params['module'] = 'vtDZiner';
	params['parent'] = 'Settings';
	params['view'] = 'Index';
	params['mode'] = 'validatevtDZinerLicense';
	params['regmode'] = regmode;
	params['secondarykey'] = jQuery("#secondarykey").val();
	params['registrationkey'] = jQuery("#registrationkey").val();
	AppConnector.request(params).then(function(data) 
		{
			if (data=="") {
				window.location.reload();
			} else {
				resultInfo = data.split(":||:");
				jQuery(".validationResult").html(resultInfo[0]);
			}
		}
	);
}
</script>