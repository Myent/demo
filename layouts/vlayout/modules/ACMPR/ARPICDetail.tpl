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
		<th colspan="8" class="blockHeader">
		ARPIC Person Details
		</th>

	</tr>
	</thead>
	<tbody>
		<tr>
			<td><b>ARPIC</b></td>
			<td><b>Surname</b></td>
			<td><b>Given Name</b></td>
			<td><b>Gender</b></td>
			<td><b>Date of Birth</b></td>
			<td><b>Ranking</b></td>
			<td><b>Work Hours and Days</b></td>
			<td><b>Other Title</b></td>
		</tr>
		{foreach key=INDEX item=LINE_ITEM_DETAIL from=$ARPIC_DETAILS}
		<tr>
			<td>		
				{$LINE_ITEM_DETAIL['arpicname']}
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
			<td>
				{$LINE_ITEM_DETAIL['dateofbirth']}
			</td>
			<td>
				{$LINE_ITEM_DETAIL['ranking']}
			</td>
			<td>
				{$LINE_ITEM_DETAIL['whdays']}
			</td>
			<td>
				{$LINE_ITEM_DETAIL['othertitle']}
			</td>
		</tr>
		{/foreach}
	</tbody>
</table>
<br/>