{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
{strip}
<style type="text/css">
.lineItemTable tr:nth-child(odd){
	background:#d6d6d6;
}
</style>
<div class="container-fluid" id="acmprhead">
	<div class="widget_header row-fluid">
		<div class="row-fluid"><h3>{vtranslate('ACMPR Grid Details Edit', $QUALIFIED_MODULE)}</h3></div>
	</div>
	<hr>

    <div class="contents row-fluid">
	<form id="acrmprgrid" data-detail-url="index.php?module=ACMPR&view=Index&parent=Settings" method="POST">
	<input type="hidden" name="module" value="ACMPR">
	<input type="hidden" name="parent" value="Settings">
	<input type="hidden" name="action" value="Save">
      <table class="table table-bordered blockContainer lineItemTable" id="lineItemTab">
        <tr>
            <td><b>Tools</b></td>
			<td><b>Room Name/Number<sup>2</sup>(per floor plan)</b>		
			</td>
			<td><b>Activities</b>
			</td>
			<td><b>Substance(s)</b> 
			</td>
        </tr>
		 <tr id="row0" class="hide lineItemCloneCopy">
            {include file="GridEdit.tpl"|@vtemplate_path:'Settings::ACMPR' row_no=0 data=[]}
        </tr>		
		{foreach key=INDEX item=data from=$GRID_INFO}
		{assign var=row_no value=$INDEX+1}
		<tr id="row{$INDEX}" class="lineItemRow" >
			{include file="GridEdit.tpl"|@vtemplate_path:'Settings::ACMPR'}		
		</tr>
		{/foreach}
		{if count($GRID_INFO) eq 0}
            <tr id="row1" class="lineItemRow">
                {include file="GridEdit.tpl"|@vtemplate_path:'Settings::ACMPR' row_no=1 data=[]}
            </tr>
        {/if}
    </table>
	
    <div class="row-fluid verticalBottomSpacing">
        <div>
		<br/>
          <div class="btn-group span8">
                    <button type="button" class="btn addButton" id="addDepartment">
                        <i class="icon-plus"></i><strong>Add Room(Organization)</strong>
                    </button>
          </div>
		  <div class="pull-right span4">
		  <button class="btn btn-success" type="submit">
			<strong>Save</strong>
		  </button>
		  <a class="cancelLink" type="reset" onclick="javascript:window.history.back();">Cancel</a>
		  </div>
        </div>
		
    </div>
	</form>
    </div>
</div>
{/strip}