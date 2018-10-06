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

{include file="EditViewBlocksVtiger.tpl"|@vtemplate_path:'ProcessFlow'}
{*Manasa added APR 13 2018 Grids Purpose following 4 includes*}
{include file="LineItemsEdit.tpl"|@vtemplate_path:'ProcessFlow'}

<div id="idProceessData"></div>
 
{/strip}