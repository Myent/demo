
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
<input type="hidden" class="numberOfCurrencyDecimal" value="{$USER_MODEL->get('no_of_currency_decimals')}" />
{assign var=ALL_ACTIVEUSER_LIST value=$USER_MODEL->getAccessibleUsers()}
 
    <table class="table table-bordered blockContainer grid1" id="grid1">
        <thead>
		<tr>
            <th colspan="7"><span class="inventoryLineItemHeader">{vtranslate('Materials', $MODULE)}</span></th>
        </tr>
        <tr>
			<td><b>{vtranslate('Tools',$MODULE)}</b></td>
			<td><b>{vtranslate('Product Category',$MODULE)}</b></td>
            <td><b>{vtranslate('Product Name',$MODULE)}</b></td>
            <!--td><b>{vtranslate('Batch Name',$MODULE)}</b></td-->
			<td  width="100px"><b>{vtranslate('Present Stock',$MODULE)}</b></td>
            <td width="100px"><b>{vtranslate('Issued Qty',$MODULE)}</b></td>
            <td><b>{vtranslate('Issued By',$MODULE)}</b></td>
            <td><b>{vtranslate('Remarks',$MODULE)}</b></td>
        </tr>
		</thead>
		<tbody id="idtbodyGrid1">
        <tr id="row0" class="hide grid1CloneCopy">
			{assign var=row_no value=0}
			{assign var="userid" value=$CURRENT_USER_MODEL->get('id')} 	
			{assign var="productid" value="grid1productid"|cat:$row_no}
			{assign var="productName" value="grid1productName"|cat:$row_no}
			{assign var="productcategory" value="grid1productcategory"|cat:$row_no}
			{assign var="batchid" value="grid1batchid"|cat:$row_no}
			{assign var="issuedqty" value="grid1issuedqty"|cat:$row_no}
			{assign var="prasentqty" value="grid1prasentqty"|cat:$row_no}
			{assign var="issuedby" value="grid1issuedby"|cat:$row_no}
			{assign var="remarks" value="grid1remarks"|cat:$row_no}
            
            {include file="LineItemsContent.tpl"|@vtemplate_path:'ProcessFlow'}
        </tr>
		
        {foreach key=row_no item=data from=$GRID1}
			{assign var=row_no value=$row_no+1}
			{assign var="productid" value="grid1productid"|cat:$row_no}
			{assign var="productName" value="grid1productName"|cat:$row_no}
			{assign var="productcategory" value="grid1productcategory"|cat:$row_no}
			{assign var="batchid" value="grid1batchid"|cat:$row_no}
			{assign var="issuedqty" value="grid1issuedqty"|cat:$row_no}
			{assign var="prasentqty" value="grid1prasentqty"|cat:$row_no}
			{assign var="issuedby" value="grid1issuedby"|cat:$row_no}
			{assign var="remarks" value="grid1remarks"|cat:$row_no}
            <tr id="row{$row_no}" class="grid1ItemRow">
                {include file="LineItemsContent.tpl"|@vtemplate_path:'ProcessFlow'}
            </tr>
        {/foreach}
        {if count($GRID1) eq 0}
			{assign var=row_no value=1}
			{assign var="productid" value="grid1productid"|cat:$row_no}
			{assign var="productName" value="grid1productName"|cat:$row_no}
			{assign var="productcategory" value="grid1productcategory"|cat:$row_no}
			{assign var="batchid" value="grid1batchid"|cat:$row_no}
			{assign var="issuedqty" value="grid1issuedqty"|cat:$row_no}
			{assign var="prasentqty" value="grid1prasentqty"|cat:$row_no}
			{assign var="issuedby" value="grid1issuedby"|cat:$row_no}
			{assign var="remarks" value="grid1remarks"|cat:$row_no}
            <tr id="row1" class="grid1ItemRow">
                {include file="LineItemsContent.tpl"|@vtemplate_path:'ProcessFlow'}
            </tr>
        {/if}
		</tbody>
    </table>
    <div class="row-fluid verticalBottomSpacing">
        <div>
			<div class="btn-group">
				<button type="button" class="btn addButton" id="addGrid1">
					<i class="icon-plus"></i><strong> {vtranslate('Add Materials',$MODULE)}</strong>
				</button>
			</div>
        </div>
	</div>

	<!-- Vessels Grid2 Started here -->
	<table class="table table-bordered blockContainer grid2" id="grid2">
        <thead>
		<tr>
            <th colspan="7"><span class="inventoryLineItemHeader">{vtranslate('Vessels', $MODULE)}</span></th>
        </tr>
        <tr>
			<td><b>{vtranslate('Tools',$MODULE)}</b></td>
            <td><b>{vtranslate('Assets Category',$MODULE)}</b></td>
            <td><b>{vtranslate('Assets Name',$MODULE)}</b></td>
            <!--td><b>{vtranslate('Batch Name',$MODULE)}</b></td-->
			<!--<td  width="100px"><b>{vtranslate('Present Stock',$MODULE)}</b></td>-->
            <td width="100px"><b>{vtranslate('Issued Qty',$MODULE)}</b></td>
            <td><b>{vtranslate('Issued By',$MODULE)}</b></td>
            <td><b>{vtranslate('Remarks',$MODULE)}</b></td>
        </tr>
		</thead>
		<tbody id="idtbodyGrid2">
        <tr id="row0" class="hide grid2CloneCopy">
		{assign var=row_no value=0}
			{assign var="assetsid" value="grid2assetsid"|cat:$row_no}
			{assign var="assetName" value="grid2assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid2assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid2batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid2issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid2prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid2issuedby"|cat:$row_no}
			{assign var="remarks" value="grid2remarks"|cat:$row_no}
            {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
        </tr>
        {foreach key=row_no item=data from=$GRID2}
			{assign var=row_no value=$row_no+1}
			{assign var="assetsid" value="grid2assetsid"|cat:$row_no}
			{assign var="assetName" value="grid2assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid2assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid2batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid2issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid2prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid2issuedby"|cat:$row_no}
			{assign var="remarks" value="grid2remarks"|cat:$row_no}
            <tr id="row{$row_no}" class="grid2ItemRow" >
                {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
            </tr>
        {/foreach}
        {if count($GRID2) eq 0}
		{assign var=row_no value=1}
			{assign var="assetsid" value="grid2assetsid"|cat:$row_no}
			{assign var="assetName" value="grid2assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid2assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid2batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid2issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid2prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid2issuedby"|cat:$row_no}
			{assign var="remarks" value="grid2remarks"|cat:$row_no}
            <tr id="row1" class="grid2ItemRow">
                {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
            </tr>
        {/if}
		</tbody>
    </table>
    <div class="row-fluid verticalBottomSpacing">
        <div>
			<div class="btn-group">
				<button type="button" class="btn addButton" id="addGrid2">
					<i class="icon-plus"></i><strong> {vtranslate('Add Vessels',$MODULE)}</strong>
				</button>
			</div>
        </div>
	</div>
	<!-- Ended here -->
	<!-- Tools Grid 3 -->
	<table class="table table-bordered blockContainer grid3" id="grid3">
        <thead>
		<tr>
            <th colspan="7"><span class="inventoryLineItemHeader">{vtranslate('Tools', $MODULE)}</span></th>
        </tr>
        <tr>
			<td><b>{vtranslate('Tools',$MODULE)}</b></td>
            <td><b>{vtranslate('Asset Category',$MODULE)}</b></td>
            <td><b>{vtranslate('Asset Name',$MODULE)}</b></td>
            <!--td><b>{vtranslate('Batch Name',$MODULE)}</b></td-->
			<!--<td  width="100px"><b>{vtranslate('Present Stock',$MODULE)}</b></td>-->
            <td width="100px"><b>{vtranslate('Issued Qty',$MODULE)}</b></td>
            <td><b>{vtranslate('Issued By',$MODULE)}</b></td>
            <td><b>{vtranslate('Remarks',$MODULE)}</b></td>
        </tr>
		</thead>
		<tbody id="idtbodyGrid3">
        <tr id="row0" class="hide grid3CloneCopy">
		{assign var=row_no value=0}
			{assign var="assetsid" value="grid3assetsid"|cat:$row_no}
			{assign var="assetName" value="grid3assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid3assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid3batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid3issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid3prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid3issuedby"|cat:$row_no}
			{assign var="remarks" value="grid3remarks"|cat:$row_no}

            {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
        </tr>
        {foreach key=row_no item=data from=$GRID3}
		{assign var=row_no value=$row_no+1}
			{assign var="assetsid" value="grid3assetsid"|cat:$row_no}
			{assign var="assetName" value="grid3assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid3assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid3batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid3issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid3prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid3issuedby"|cat:$row_no}
			{assign var="remarks" value="grid3remarks"|cat:$row_no}

            <tr id="row{$row_no}" class="grid3ItemRow" >
                {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
            </tr>
        {/foreach}
        {if count($GRID3) eq 0}
		{assign var=row_no value=1}
			{assign var="assetsid" value="grid3assetsid"|cat:$row_no}
			{assign var="assetName" value="grid3assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid3assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid3batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid3issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid3prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid3issuedby"|cat:$row_no}
			{assign var="remarks" value="grid3remarks"|cat:$row_no}

            <tr id="row1" class="grid3ItemRow">
                {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
            </tr>
        {/if}
		</tbody>
    </table>
    <div class="row-fluid verticalBottomSpacing">
        <div>
			<div class="btn-group">
				<button type="button" class="btn addButton" id="addGrid3">
					<i class="icon-plus"></i><strong> {vtranslate('Add Tools',$MODULE)}</strong>
				</button>
			</div>
        </div>
	</div>
	<!-- Grid3 ended here -->
	<!-- Grid 4 Machinery Started here -->
	 <table class="table table-bordered blockContainer grid4" id="grid4">
        <thead>
		<tr>
            <th colspan="7"><span class="inventoryLineItemHeader">{vtranslate('Machinery', $MODULE)}</span></th>
        </tr>
        <tr>
			<td><b>{vtranslate('Tools',$MODULE)}</b></td>
           <td><b>{vtranslate('Asset Category',$MODULE)}</b></td>
            <td><b>{vtranslate('Asset Name',$MODULE)}</b></td>
            <!--td><b>{vtranslate('Batch Name',$MODULE)}</b></td-->
			<!--<td  width="100px"><b>{vtranslate('Present Stock',$MODULE)}</b></td>-->
            <td width="100px"><b>{vtranslate('Issued Qty',$MODULE)}</b></td>
            <td><b>{vtranslate('Issued By',$MODULE)}</b></td>
            <td><b>{vtranslate('Remarks',$MODULE)}</b></td>
        </tr>
		</thead>
		<tbody id="idtbodyGrid4">
        <tr id="row0" class="hide grid4CloneCopy">
		{assign var=row_no value=0}
			{assign var="assetsid" value="grid4assetsid"|cat:$row_no}
			{assign var="assetName" value="grid4assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid4assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid4batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid4issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid4prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid4issuedby"|cat:$row_no}
			{assign var="remarks" value="grid4remarks"|cat:$row_no}

            {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
        </tr>
        {foreach key=row_no item=data from=$GRID4}
		{assign var=row_no value=$row_no+1}
			{assign var="assetsid" value="grid4assetsid"|cat:$row_no}
			{assign var="assetName" value="grid4assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid4assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid4batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid4issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid4prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid4issuedby"|cat:$row_no}
			{assign var="remarks" value="grid4remarks"|cat:$row_no}

            <tr id="row{$row_no}" class="grid4ItemRow">
                {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
            </tr>
        {/foreach}
        {if count($GRID4) eq 0}
		{assign var=row_no value=1}
			{assign var="assetsid" value="grid4assetsid"|cat:$row_no}
			{assign var="assetName" value="grid4assetName"|cat:$row_no}
			{assign var="assetcategory" value="grid4assetcategory"|cat:$row_no}
			{*assign var="batchid" value="grid4batchid"|cat:$row_no*}
			{assign var="issuedqty" value="grid4issuedqty"|cat:$row_no}
			{*assign var="prasentqty" value="grid4prasentqty"|cat:$row_no*}
			{assign var="issuedby" value="grid4issuedby"|cat:$row_no}
			{assign var="remarks" value="grid4remarks"|cat:$row_no}

            <tr id="row1" class="grid4ItemRow">
                {include file="LineItemsContentAsset.tpl"|@vtemplate_path:'ProcessFlow'}
            </tr>
        {/if}
		</tbody>
    </table>
    <div class="row-fluid verticalBottomSpacing">
        <div>
			<div class="btn-group">
				<button type="button" class="btn addButton" id="addGrid4">
					<i class="icon-plus"></i><strong> {vtranslate('Add Machinery',$MODULE)}</strong>
				</button>
			</div>
        </div>
	</div>
	<!-- Grid 4 Machinery Ended here -->
{/strip}