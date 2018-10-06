{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
*
 ********************************************************************************/
-->*}
{strip}
<div class="listViewPageDiv">
		<div class="listViewTopMenuDiv noprint">
<div class="container-fluid">
	<div class="widget_header row-fluid">
		<div class="span6"><h3>{vtranslate($MODULE, $QUALIFIED_MODULE)}</h3></div>
		<div class="span6 pull-right" style="text-align:right; margin-top:10px;"><b id="openlogin" style="cursor: pointer;">{vtranslate("Total Logged in Users", $QUALIFIED_MODULE)} : {$TOTAL_LOGIN}</b></div>
	</div>
	<hr>
	<div class="row-fluid input-append">
		<span class="span2 btn-toolbar">
				<input id="startdate" type="text" class="dateField span2 listSearchContributor autoComplete ui-autocomplete-input" name="start_date" data-date-format="dd-mm-yyyy" value="{$SIGNIN_TIME}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" placeholder="From Date">
				<span class="add-on" style="margin-left:-15px;"><i class="icon-calendar cal1" style="width: 12px;"></i></span>
			</span>

				<span class="span2 btn-toolbar" >
					<div class="input-append">
						<input id="enddate" type="text" class="dateField span2 listSearchContributor autoComplete ui-autocomplete-input" name="start_date" data-date-format="dd-mm-yyyy" value="{$SIGNOUT_TIME}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" placeholder="To Date">
					  <span class="add-on" style="margin-left:-15px;"><i class="icon-calendar cal2" style="width: 12px;"></i></span>
					</div>
		</span>
		<div>
			<div class="span3 btn-toolbar">
				<select class="chzn-select" id="usersFilter">
							<option value="">{vtranslate('LBL_ALL', $QUALIFIED_MODULE)}</option>
							{foreach item=USERNAME key=USER from=$USERSLIST}
								<option value="{$USER}" name="{$USERNAME}" {if $USERNAME eq $SELECTED_USER} selected {/if}>{$USERNAME}</option>
							{/foreach}
				</select>
			</div>
			<div class="span2 btn-toolbar">
				<select class="chzn-select" id="user_status">
							<option value="">{vtranslate('LBL_ALL', $QUALIFIED_MODULE)}</option>
							<option value="Signed in">Signed in</option>
							<option value="Signed off">Signed off</option>
				</select>
			</div>
		</div>
		<span class="span3 btn-toolbar">
			{include file='ListViewActions.tpl'|@vtemplate_path:$QUALIFIED_MODULE}
		</span>
		 <span class="btn-group listViewMassActions" style="position: absolute;right: 35px;top: 85px;">
		           <button class="btn dropdown-toggle" data-toggle="dropdown">
					<span class="icon-wrench"></span><i class="caret">&nbsp;&nbsp;</i></button>
					<ul class="dropdown-menu">
					  <li id="">
					   <a href="javascript:void(0);" id="exportForm">Export</a>
					  </li>
					</ul>
				</span>
	</div>
	</div>
		</div>
	<div class="clearfix"></div>
	<div class="listViewContentDiv" id="listViewContents">
{/strip}

<!-- added by jyothi for login++ -->
<script>
   $(document).ready(function(){
		
   	   app.registerEventForDatePickerFields('#startdate');
		jQuery('.cal1').on('click',function(){
		  jQuery("#startdate").trigger("focus");
		 });

		app.registerEventForDatePickerFields('#enddate');
		jQuery('.cal2').on('click',function(){
		  jQuery("#enddate").trigger("focus");
		 });

       jQuery('#exportForm').bind("click", function() {
             var user = $('#usersFilter option:selected').text();
             var startdate = $('#startdate').val();
             // alert(startdate);
             var enddate = $('#enddate').val();
             // alert(enddate);
            window.location.href='index.php?module=OS2LoginHistory&parent=Settings&action=ListAjaxData&user='+$.trim(user)+'&startdate='+startdate+'&enddate='+enddate;
       });
	   
	   jQuery("#openlogin").on("click", function(){
		  var currentLocation = 'index.php?module=OS2LoginHistory&parent=Settings&view=List&ckstatus=Signedin';
		 // window.location.href=currentLocation;
		   jQuery.ajax({
			   url:currentLocation,
			   success: function(result){
							$("#userlogdetails").html(result);
				   			$('#userlogdetails table tr:eq(1)').remove()
						}
		   });
		   jQuery("#usersignbtn").click();
	   });
   });
</script>
<!-- ended here -->
<style>
.dropdown-menu {
right:0!important;
float:left;
left:unset;
margin-top:5px !important;
}
.chzn-container-single .chzn-drop{
	display: inline-grid;
} 
</style>
