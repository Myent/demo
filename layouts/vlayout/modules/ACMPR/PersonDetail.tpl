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
<table class="table table-bordered mergeTables">
	<thead>
	<tr>
		<th colspan="4" class="blockHeader">
		Persons Authorized To Place Orders For Cannabis 
		</th>

	</tr>
	</thead>
	<tbody>
		<tr>
			<td><b >Person </b>
			</td>
			<td><b>Surname</b>
				<br/>
			</td>
			<td><b>GivenName</b> 
			</td>
			<td><b>Gender</b></td>
		</tr>
		{foreach key=INDEX item=LINE_ITEM_DETAIL from=$Person_Details}
		<tr>
			<td>		
				{$LINE_ITEM_DETAIL['personname']}
			</td>
			<td>
				{$LINE_ITEM_DETAIL['surname']}
			</td>
			<td>
				{$LINE_ITEM_DETAIL['givenname']}
			</td>
			<td>
				{$LINE_ITEM_DETAIL['gendar']}
			</td>
		</tr>
		{/foreach}
	</tbody>
</table>
<br/>