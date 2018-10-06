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
	<div class="container-fluid" id="counterContainer">
		<div class="widget_header row-fluid">
			<div class="span8"><h3>Counters</h3></div>
		</div>
		<hr>
		<button id="counterslistview" class="btn addButton" onclick='window.location.href="index.php?module=Counters&parent=Settings&view=Edit"'><i class="icon-plus"></i>&nbsp;<strong>Add Counter</strong></button>
		<br><br>
		<div class="contents">
			<form name="counters" action="" method="post" class="form-horizontal" id="counters">
				<input type="hidden" id="filterDetails" name="filters" value="{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($FILTER_NAME))}">
				<table class="table table-bordered listViewEntriesTable">
					<thead>
					<th>Module</th>
					<th>View</th>
					<th>Filter Name</th>
					<th>Widget Name</th>
					<th>Actions</th>
					</thead>
					
        {foreach item=COUNTER_DETAILS from=$COUNTERS_DATA}
        <tr>
			{assign var=VIEWDATA value=$COUNTER_DETAILS.view|json_decode:true}
				
            <td>{vtranslate($COUNTER_DETAILS.module,$COUNTER_DETAILS.module)}</td>
            <td>{$COUNTER_DETAILS.view}</td>
            <td>{$COUNTER_DETAILS.filtername}</td>
            <td>{$COUNTER_DETAILS.countername}</td>
             {assign var=itemArray value=$jsonString|json_decode:true}
            <td>
				<div class="actions">
					<span class="actionImages">
							<a href='index.php?module=Counters&parent=Settings&view=Edit&record={$COUNTER_DETAILS.counterid}'><i title="{vtranslate('LBL_EDIT', $MODULE)}" class="icon-pencil alignMiddle"></i></a>&nbsp;
							<a class="deleteRecordButton" data-id="{$COUNTER_DETAILS.counterid}"><i title="" class="icon-trash alignMiddle"></i></a>
					</span>
				</div>
			</td>
        </tr>
        {/foreach}
	</table>
			</form>
		</div>	
	</div>
{/strip}
