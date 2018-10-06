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
<div class="container-fluid" style="padding-left:0;padding-right:0">
	<div class="widget_header row-fluid">
		<h3>{vtranslate(LBL_VTLOGIN_HISTORY_DETAILS, $QUALIFIED_MODULE)}</h3>
		<!-- {$ISSUES_LIST|@print_r} -->
	</div>
	<hr>
	<div class="row-fluid">
		<span class="span8 btn-toolbar">
				<!-- <select class="chzn-select chzn-done" id="basicSearchModulesList" > -->

				<select class="chzn-select picklistFilter" id="picklistFilter" name="picklistFilter">
				<optgroup>
                 <option value="">{vtranslate('LBL_ALL', $QUALIFIED_MODULE)}</option>
                    {foreach item=PICKLIST_MODULE key=LIST from=$PICKLIST_MODULES_LIST}

                    <option  {if $SELECTED_MODULE_NAME eq $PICKLIST_MODULE->get('name')} selected="" {/if} value="{$PICKLIST_MODULE->get('name')}">{vtranslate($PICKLIST_MODULE->get('label'),$QUALIFIED_MODULE)}</option>

				    {/foreach}
				</optgroup>

				</select>

		</span>
		<input type="hidden" value="{$ISSUES_LIST|json_encode}" id="tabledata">
		<span class="span4 btn-toolbar">
			{include file='DetailViewActions.tpl'|@vtemplate_path:$QUALIFIED_MODULE}
		</span>
	</div>
	<div class="clearfix"></div>
	<div class="detailViewContentDiv" id="detailViewContents">
{/strip}
