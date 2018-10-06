
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
{strip}
<input type="hidden" id="PersonDeails" data-value='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($Person_Details))}'/>
    <table class="table table-bordered blockContainer personItemTable" id="personTab">
        <tr>
            <th colspan="5">
			<span class="inventoryLineItemHeader">
			Persons Authorized To Place Orders For Cannabis :&nbsp;&nbsp;
			<button id="PERSONLIST"> Refresh </button>
			</span>
			</th>    <!-- Changed colspan 10 to 11 by Yogita -->
       </tr>
        <tr>
            <td><b>Tools</b></td>
			<td><b>Person</b></td>
			<td><b>Surname</b></td>
			<td><b>Given Name</b></td>
			<td><b>Gender</b></td>
        </tr>
		<tr id="row0" class="hide personCloneCopy">
            {include file="PersonContentEdit.tpl"|@vtemplate_path:'ACMPR' person_no=0 data=[]}
        </tr>		
		{foreach key=INDEX item=data from=$Person_Details}
		{assign var=person_no value=$INDEX+1}
		<tr id="row{$INDEX}" class="personItemRow" >
			{include file="PersonContentEdit.tpl"|@vtemplate_path:'ACMPR'}		
		</tr>
		{/foreach}
    </table>
{/strip}
