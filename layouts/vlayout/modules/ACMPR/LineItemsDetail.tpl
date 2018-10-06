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
.mergeTables tr:nth-child(even){
	background:#cfebf9;
}
.mergeTables tr:nth-child(odd) table tr:nth-child(even){
	background:#FFFFFF;
}
.mergeTables tr:nth-child(odd) table tr{
	min-height:90px;
}
</style>
<table class="table table-bordered mergeTables">
	<thead>
	<tr>
		<th colspan="3" class="blockHeader">
			<!-- Changed colspan from 5 to 10 by Yogita  --->
			Areas- Complete the following for each building:[Activities in areas where cannabis is present]
		</th>

	</tr>
	<!--tr>		
		<th colspan="3" class="blockHeader">
			
		</th>
	</tr-->
	</thead>
	<tbody>
		<tr>
			<td><b  style="color:#2E6ECB;">Room Name/Number<sup>2</sup>(per floor plan)</b>
			</td>
			<td><b  style="color:#2E6ECB;">Activities</b>
				<br/>
			</td>
			<td><b style="color:#2E6ECB;">Substance(s)</b> 
			</td>
		</tr>
		{foreach key=INDEX item=LINE_ITEM_DETAIL from=$ACCOUNT_DETAILS}
		<tr>
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
<br/>