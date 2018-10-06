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
.mergeTables tr:nth-child(even){
	
}
.mergeTables tr:nth-child(odd) {
	background:#d6d6d6;
}
</style>
{include file='ActivitiesList.tpl'|@vtemplate_path:'Settings::ACMPR'}
<br/><br/>
<div class="container-fluid" id="acmprhead">
	<div class="widget_header row-fluid">
		<div class="row-fluid span8"><h3>{vtranslate('ACMPR Grid Details', $QUALIFIED_MODULE)}</h3></div>
		<div class="span4">
			<div class="pull-right">
				<button class="btn editButton" data-url="?module=ACMPR&parent=Settings&view=Edit" type="button" title="Edit"><strong><a href="?module=ACMPR&parent=Settings&view=Edit">Edit</a></strong></button>
			</div>
		</div>
	</div>
	<hr>

    <div class="contents row-fluid">
	<table class="table table-bordered mergeTables">
	<thead>
	<tr>
		<th colspan="4" class="blockHeader">
			Activities in areas where cannabis is present - ACMPR Module
		</th>

	</tr>
	</thead>
	<tbody>
		<tr>
			<td><b  style="color:#2E6ECB;">S.No</b></td>
			<td><b  style="color:#2E6ECB;">Room Name/Number<sup>2</sup>(per floor plan)</b>
			</td>
			<td><b  style="color:#2E6ECB;">Activities</b>
				<br/>
			</td>
			<td><b style="color:#2E6ECB;">Substance(s)</b> 
			</td>
		</tr>
		{foreach key=INDEX item=LINE_ITEM_DETAIL from=$GRID_INFO}
		<tr>
			<td>{$LINE_ITEM_DETAIL['sequence']}</td>
			<td>		
				{$LINE_ITEM_DETAIL['accountname']}
			</td>
			<td>
				{$LINE_ITEM_DETAIL['activities']}
			</td>
			<td>
				{$LINE_ITEM_DETAIL['substance']}
			</td>
		</tr>
		{/foreach}
		</tbody>
	</table>
     </div>
</div>
{/strip}