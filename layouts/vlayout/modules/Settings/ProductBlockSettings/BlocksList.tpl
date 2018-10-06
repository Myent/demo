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
		<div class="row-fluid span8"><h3>{vtranslate($Prasent_MODULE,$Prasent_MODULE)}&nbsp;{vtranslate('Categories Blocks Map', $QUALIFIED_MODULE)}</h3></div>
		<div class="pull-right">
		<a href="index.php?module=ProductBlockSettings&parent=Settings&view=List" title="Back to List">
			<button class="btn btn-success saveButton"  ><strong>Back</strong></button>
		</a>
		</div>
	</div>
	<hr>
    <div class="contents row-fluid">
	<div class="span8">
	<table class="table table-bordered inventoryTaxTable themeTableColor">
	<thead>
	<tr>
		<td><b  style="color:#2E6ECB;"> S.No</b> </td>
		<td><b  style="color:#2E6ECB;">Category</b>
			</td>
			<td><b  style="color:#2E6ECB;">Related Blocks</b>
			</td>
	</tr>
	</thead>
	<tbody>
	{assign var=i value=1}
		{foreach key=ID item=NAME from=$PRODUCT_CATEGORIES}
		<tr>
			<td width="10px;">	
				{assign var=currentrow value=$i}
				{$i++}
			</td>
			<td  width="150px;">{vtranslate($NAME,$Prasent_MODULE)}</td>
			<td  width="200px;">
				<span class='display'>
				{assign var="BlockIDS" value=explode(',',$MULTI_BLOCKS[$NAME])}
				 {foreach item=item key=key  from=$BlockIDS}     
					 {vtranslate($PRODUCT_BLOCKS_INFO[$item],$Prasent_MODULE)}<br/>
				{/foreach}				
				</span>
				<input type='hidden' name='productcategory' value='{$NAME}'/>
				<span class="weightfield hide">
					<input  type="hidden" name="productfield"  value="{$column}" />
					<input  type="hidden" name="prasentmodule"  value="{$Prasent_MODULE}" />
								&nbsp; <select class="select2" multiple name="blockids[]" data="{$currentrow}" id="blockids{$currentrow}"  style="width:200px;" >
					{foreach item=PICKLIST_VALUE key=PICKLIST_NAME from=$PRODUCT_BLOCKS_INFO}
					<option value="{Vtiger_Util_Helper::toSafeHTML($PICKLIST_NAME)}" {if in_array($PICKLIST_NAME,$BlockIDS)} selected {/if}>
					{vtranslate($PICKLIST_VALUE,$Prasent_MODULE)}</option>
					{/foreach}
				 </select>			
				 <i title="Save" class="icon-ok-sign dtsave"></i>&nbsp;&nbsp;
					<i title="Cancel" class="icon-remove-sign dtcancel"></i>
				</span>
				<i title="Edit" class="icon-pencil edit alignMiddle pull-right"></i>
			</td>
			
		</tr>
		{/foreach}
		</tbody>
	</table>
     </div><!-- span6 ended here-->
	
	 </div>
</div>
{/strip}