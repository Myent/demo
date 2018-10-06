
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
.smallInputBox{
	width:110px;
}
.arpicname {
	width : 140px;
}
</style>
{strip}
<input type="hidden" id="ArpicDeails" data-value='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($ARPIC_DETAILS))}'/>
    <table class="table table-bordered blockContainer arpicItemTable" id="arpictab" width="100%">
        <tr>
            <th colspan="9">
			<span class="arpic">
			Number of ARPIC you are submitting	: {$ARPIC_NUMBER}
			&nbsp;&nbsp;
			<button id="APRICUSERS"> Refresh </button>

			</span>
			</th>    <!-- Changed colspan 10 to 11 by Yogita -->
       </tr>
        <tr>
            <td><b>Tools</b></td>
			<td><b>ARPIC</b></td>
			<td><b>Surname</b></td>
			<td><b>Given Name</b></td>
			<td><b>Gender</b></td>
			<td><b>Date of Birth</b></td>
			<td><b>Ranking</b></td>
			<td><b>Work Hours and Days</b></td>
			<td><b>Other Title</b></td>
        </tr>
		 <tr id="arpicrow0" class="hide arpicCloneCopy">
            {include file="ARPICContentEdit.tpl"|@vtemplate_path:'ACMPR' arpic_no=0 data=[]}
        </tr>		
		{foreach key=INDEX item=data from=$ARPIC_DETAILS}
		{assign var=arpic_no value=$INDEX+1}
		<tr id="arpicrow{$INDEX}" class="arpicItemRow" >
			{include file="ARPICContentEdit.tpl"|@vtemplate_path:'ACMPR'}		
		</tr>
		{/foreach}
    </table>
{/strip}
