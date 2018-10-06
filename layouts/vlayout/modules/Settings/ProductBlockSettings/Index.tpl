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
<div class="container-fluid" id="acmprhead">
	<div class="widget_header row-fluid">
		<div class="row-fluid span8"><h3>{vtranslate('Categories Blocks Map for Modules', $QUALIFIED_MODULE)}</h3></div>
	</div>
	<hr>
    <div class="contents row-fluid">
	<div class="span8">
	<table class="table table-bordered inventoryTaxTable themeTableColor">
	<thead>
	<tr>
		<td><b  style="color:#2E6ECB;"> S.No</b> </td>
		<td><b  style="color:#2E6ECB;">Module Name</b>
			</td>
			<td><b  style="color:#2E6ECB;">Category</b>
			</td>
			<td><b  style="color:#2E6ECB;">Action</b>
			</td>
	</tr>
	</thead>
	<tbody>
	{assign var=i value=1}
		{foreach key=name item=Category from=$MODULES_INFO}
		<tr>
			<td width="10px;">	
				{assign var=currentrow value=$i}
				{$i++}
			</td>
			<td  width="150px;">{vtranslate($name,$name)}</td>
			<td  width="200px;">
			{vtranslate($Category,$name)}
			</td>
			<td width="15px;">
			<a href="index.php?module=ProductBlockSettings&parent=Settings&view=ListDisplay&settingsmodule={$name}" title="{vtranslate($name,$name)}">
				<center><i title="Edit" class="icon-pencil edit alignMiddle "></i></center>
			</a>
			</td>			
		</tr>
		{/foreach}
		</tbody>
	</table>
     </div><!-- span6 ended here-->
	
	 </div>
</div>
{/strip}