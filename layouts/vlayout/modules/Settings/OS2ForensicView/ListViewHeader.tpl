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
<div class="container-fluid">
	<div class="widget_header row-fluid">
		<h3>{vtranslate($MODULE, $QUALIFIED_MODULE)}</h3>
	</div>
	<hr>
	<div class="row-fluid">
		<span class="span3 btn-toolbar">
				<select class="chzn-select" id="usersFilter" >
					<option value="">{vtranslate('LBL_ALL', $QUALIFIED_MODULE)}</option>
					{foreach item=USERNAME key=USER from=$USERSLIST}
						<option value="{$USER}" name="{$USERNAME}" {if $USERNAME eq $SELECTED_USER} selected {/if}>{$USERNAME}</option>
					{/foreach}
				</select>
		</span>






			
		<span class="span3 btn-toolbar">			
			<span class="btn-group" style="display:inline-table">
			
				<input id="startdate" placeholder="Start Date" type="text" class="dateField span2 listSearchContributor autoComplete ui-autocomplete-input" name="start_date" data-date-format="dd-mm-yyyy" value="{if $STARTDATE neq ""}{$STARTDATE}{/if}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]">
				<span class="add-on"><i class="icon-calendar cal1" style="width: 12px;"></i></span>
			</span>
		</span>

		<span class="span3 btn-toolbar">
				<span class="btn-group" style="display:inline-table">
				    <input id="enddate"  placeholder="End Date" type="text" class="dateField span2 listSearchContributor autoComplete ui-autocomplete-input" name="start_date" data-date-format="dd-mm-yyyy" value="{if $ENDDATE neq ""}{$ENDDATE}{/if}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]">
					 <span class="add-on"><i class="icon-calendar cal2" style="width: 12px;"></i></span>
				</span>
		</span>	

		<span class="span3 btn-toolbar">
			{include file='ListViewActions.tpl'|@vtemplate_path:$QUALIFIED_MODULE}
		</span>
	</div>
	<div class="clearfix"></div>
	<div class="listViewContentDiv" id="listViewContents">
{/strip}

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
   });
</script>