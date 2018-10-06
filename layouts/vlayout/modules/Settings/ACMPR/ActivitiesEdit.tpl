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
		<div class="row-fluid span8"><h3>{vtranslate('Section 5a Activities and Substances Details', $QUALIFIED_MODULE)} - Edit</h3></div>
	</div>
	<hr>

    <div class="contents row-fluid">
	<form id="acrmprgrid" data-detail-url="index.php?module=ACMPR&view=Index&parent=Settings" method="POST">
	<input type="hidden" name="module" value="ACMPR">
	<input type="hidden" name="parent" value="Settings">
	<input type="hidden" name="action" value="ActivitiesSave">
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
			<td>{$DETAIL['name']}
				<input type="hidden" name="nameid{$DETAIL['id']}" value="{$DETAIL['id']}"/>
			</td>
			<td>		
				<select name='substances{$DETAIL["id"]}[]' style="width:180px;" class='select2' multiple>
					<option name="Dried Marihuana" {if in_array("Dried Marihuana",$DETAIL['substances'])}selected{/if}>Dried Marihuana</option>
					<option name="Marihuana Plants" {if in_array("Marihuana Plants",$DETAIL['substances'])}selected{/if}>Marihuana Plants</option>
					<option name="Marihuana Seeds" {if in_array("Marihuana Seeds",$DETAIL['substances'])}selected{/if}>Marihuana Seeds</option>
					<option name="Cannabis Oil" {if in_array("Cannabis Oil",$DETAIL['substances'])}selected{/if}>Cannabis Oil</option>
					<option name="Fresh Marihuana" {if in_array("Fresh Marihuana",$DETAIL['substances'])}selected{/if}>Fresh Marihuana</option>
				</select>
			</td>
			<td>
				<textarea name='cannabis{$DETAIL["id"]}' >{$DETAIL['cannabis']}</textarea>
			</td>
			<td>
				<textarea name='purpose{$DETAIL["id"]}' >{$DETAIL['purpose']}</textarea>
			</td>
		</tr>
		{/foreach}
		</tbody>
	</table>
	<div class="row-fluid verticalBottomSpacing">
        <div>
		<br/>
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