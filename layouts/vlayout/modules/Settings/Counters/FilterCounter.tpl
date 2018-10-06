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
.floatleft {
    float:left;
    widht:80%;
}
.floatright {
    float:right;
    widht:20%;
}
</style>
{strip}
<div class="recordNamesList">
	<div class="row-fluid">
		<div class="">
		<table>
			<tr class="nav nav-list">
				<div class="floatleft">
					<td style="padding-left:8px;"><b>FiterName</b></td>
				</div>
				<div class="floatright">
					<td style="padding-left:12px;"><b>Count</b></td>
				</div>
				<td><br/></td>
			</tr>
			{foreach item=i key=k from=$FILTER_COUNT}
			<tr>
				<div class="floatleft">
					<td style="padding-left:8px;">
					{$i[0]}
					</td>
				</div>
				<div class="floatright">
					<td style="padding-left:12px;">
					{$i[1]}
					</td>
				</div>
				<td><br/></td>
			</tr>
			{/foreach}
		</table>
		</div>
	</div>
</div>
{/strip}