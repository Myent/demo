{strip} 
<script>
	var core_productcategory = {};
</script>

{foreach key=categoryid item=categoryname from=$PRODUCT_CATEGORIES}
	<script> 
		var pname = "{$categoryname}";		 
		var pcid = {$categoryid};	 
		core_productcategory[pname] = pcid;
	</script>	 
{/foreach}
 

{if !empty($RECORD_ID)}
	{*include file='/var/www/html/VTFormula/layouts/vlayout/modules/ProcessFlow/EditViewBlocksProcessFlowEdit.tpl'*}
	{include file="EditViewBlocksProcessFlowEdit.tpl"|@vtemplate_path:'ProcessFlow'}
{else}
	{*include file='/var/www/html/VTFormula/layouts/vlayout/modules/ProcessFlow/EditViewBlocksVtiger.tpl'*}
	{*Manasa added APR 13 2018 Grids Purpose following 4 includes*}
	{include file="EditViewBlocksVtiger.tpl"|@vtemplate_path:'ProcessFlow'}
	{include file="LineItemsEdit.tpl"|@vtemplate_path:'ProcessFlow'} 
{/if}
 
{/strip}