
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
<style type="text/css">
.lineItemTable tr:nth-child(even){
	background:#8FC5CF;
}
.lineItemTable tr:nth-child(odd) .subtable tr:nth-child(even){
	background:#FFFFFF;
}
</style>
{strip}
    <table class="table table-bordered blockContainer lineItemTable" id="lineItemTab">
        <tr>
            <th colspan="4">
			<span class="inventoryLineItemHeader">
			Areas- Complete the following for each building:
			</span>
			</th>    <!-- Changed colspan 10 to 11 by Yogita -->
       </tr>
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
            {include file="LineItemsContentEdit.tpl"|@vtemplate_path:'ACMPR' row_no=0 data=[]}
        </tr>		
		{foreach key=INDEX item=data from=$ACCOUNT_DETAILS}
		{assign var=row_no value=$INDEX+1}
		<tr id="row{$INDEX}" class="lineItemRow" >
			{include file="LineItemsContentEdit.tpl"|@vtemplate_path:'ACMPR'}		
		</tr>
		{/foreach}
		{if count($ACCOUNT_DETAILS) eq 0}
            <tr id="row1" class="lineItemRow">
                {include file="LineItemsContentEdit.tpl"|@vtemplate_path:'ACMPR' row_no=1 data=[]}
            </tr>
        {/if}
    </table>
    <div class="row-fluid verticalBottomSpacing">
        <div>
		<br/>
          <div class="btn-group">
                    <button type="button" class="btn addButton" id="addDepartment">
                        <i class="icon-plus"></i><strong>Add Room(Organization)</strong>
                    </button>
          </div>
        </div>
    </div>
{/strip}
