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
<div class="container-fluid" id="acmprhead">
	<div class="widget_header row-fluid">
		<div class="row-fluid span8"><h3>{vtranslate('Section 5a Activities and Substances Details', $QUALIFIED_MODULE)}</h3></div>
		<div class="span4">
			<div class="pull-right">
				<button class="btn editButton" data-url="?module=ACMPR&parent=Settings&view=ActivitiesEdit" type="button" title="Edit"><strong><a href="?module=ACMPR&parent=Settings&view=ActivitiesEdit">Edit</a></strong></button>
			</div>
		</div>
	</div>
	<hr>

    <div class="contents row-fluid">

	<table class="table table-bordered mergeTables">
	<tbody>
		<tr>
			<td>
				<b  style="color:#2E6ECB;">Activity Requested</b>
			</td>
			<td>
				<b  style="color:#2E6ECB;">Substances Requested</b>
			</td>
			<td>
				<b  style="color:#2E6ECB;">Cannabis Other</b>
			</td>
			<td>
				<b style="color:#2E6ECB;">Purpose</b> 
			</td>
		</tr>
		{foreach key=INDEX item=DETAIL from=$ACTIVIES_INFO}
		<tr>
			<td>{$DETAIL['name']}</td>
			<td>		
				{$DETAIL['substancesdisplay']}
			</td>
			<td>
				{$DETAIL['cannabis']}
			</td>
			<td>
				{$DETAIL['purpose']}
			</td>
		</tr>
		{/foreach}
		</tbody>
	</table>
     </div>
</div>
{/strip}