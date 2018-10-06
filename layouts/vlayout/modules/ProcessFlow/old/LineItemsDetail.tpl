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
    <th colspan="6" class="detailViewBlockHeader">
		Materials
    </th>
	</thead>
	<tbody>
    <tr>
		<td><b>{vtranslate('Product Name',$MODULE)}</b></td>
		<td><b>{vtranslate('Batch Name',$MODULE)}</b></td>
		<td  width="100px"><b>{vtranslate('Present Stock',$MODULE)}</b></td>
		<td width="100px"><b>{vtranslate('Issued Qty',$MODULE)}</b></td>
		<td><b>{vtranslate('Issued By',$MODULE)}</b></td>
		<td><b>{vtranslate('Remarks',$MODULE)}</b></td>
    </tr>
    {foreach key=row_no item=data from=$GRID1}
	{assign var=row_no value=$row_no+1}
			{assign var="productid" value="grid1productid"|cat:$row_no}
			{assign var="productName" value="grid1productName"|cat:$row_no}
			{assign var="batchname" value="grid1batchname"|cat:$row_no}
			{assign var="batchid" value="grid1batchid"|cat:$row_no}
			{assign var="issuedqty" value="grid1issuedqty"|cat:$row_no}
			{assign var="prasentqty" value="grid1prasentqty"|cat:$row_no}
			{assign var="issuedby" value="grid1issuedby"|cat:$row_no}
			{assign var="remarks" value="grid1remarks"|cat:$row_no}
	<tr>
	    <td>{$data.$productName}</td>
		<td>{$data.$batchname}</td>
		<td>{$data.$prasentqty}</td>
		<td>{$data.$issuedqty}</td>
		<td>{$data.$issuedby}</td>
		<td>{$data.$remarks}</td>
    </tr>
	{/foreach}
	</tbody>
</table>
<!-- Vessels -->
<table class="table table-bordered mergeTables">
    <thead>
    <th colspan="6" class="detailViewBlockHeader">
		Vessels
    </th>
	</thead>
	<tbody>
    <tr>
		<td><b>{vtranslate('Product Name',$MODULE)}</b></td>
		<td><b>{vtranslate('Batch Name',$MODULE)}</b></td>
		<td  width="100px"><b>{vtranslate('Present Stock',$MODULE)}</b></td>
		<td width="100px"><b>{vtranslate('Issued Qty',$MODULE)}</b></td>
		<td><b>{vtranslate('Issued By',$MODULE)}</b></td>
		<td><b>{vtranslate('Remarks',$MODULE)}</b></td>
    </tr>
    {foreach key=row_no item=data from=$GRID2}
		{assign var=row_no value=$row_no+1}
			{assign var="productid" value="grid2productid"|cat:$row_no}
			{assign var="productName" value="grid2productName"|cat:$row_no}
			{assign var="batchname" value="grid2batchname"|cat:$row_no}
			{assign var="batchid" value="grid2batchid"|cat:$row_no}
			{assign var="issuedqty" value="grid2issuedqty"|cat:$row_no}
			{assign var="prasentqty" value="grid2prasentqty"|cat:$row_no}
			{assign var="issuedby" value="grid2issuedby"|cat:$row_no}
			{assign var="remarks" value="grid2remarks"|cat:$row_no}
	<tr>
	    <td>{$data.$productName}</td>
		<td>{$data.$batchname}</td>
		<td>{$data.$prasentqty}</td>
		<td>{$data.$issuedqty}</td>
		<td>{$data.$issuedby}</td>
		<td>{$data.$remarks}</td>
    </tr>
	{/foreach}
	</tbody>
</table>
<!-- Tools -->
<table class="table table-bordered mergeTables">
    <thead>
    <th colspan="6" class="detailViewBlockHeader">
		Tools
    </th>
	</thead>
	<tbody>
    <tr>
		<td><b>{vtranslate('Product Name',$MODULE)}</b></td>
		<td><b>{vtranslate('Batch Name',$MODULE)}</b></td>
		<td  width="100px"><b>{vtranslate('Present Stock',$MODULE)}</b></td>
		<td width="100px"><b>{vtranslate('Issued Qty',$MODULE)}</b></td>
		<td><b>{vtranslate('Issued By',$MODULE)}</b></td>
		<td><b>{vtranslate('Remarks',$MODULE)}</b></td>
    </tr>
    {foreach key=row_no item=data from=$GRID3}
		{assign var=row_no value=$row_no+1}
		{assign var="productid" value="grid3productid"|cat:$row_no}
		{assign var="productName" value="grid3productName"|cat:$row_no}
		{assign var="batchname" value="grid3batchname"|cat:$row_no}
		{assign var="batchid" value="grid3batchid"|cat:$row_no}
		{assign var="issuedqty" value="grid3issuedqty"|cat:$row_no}
		{assign var="prasentqty" value="grid3prasentqty"|cat:$row_no}
		{assign var="issuedby" value="grid3issuedby"|cat:$row_no}
		{assign var="remarks" value="grid3remarks"|cat:$row_no}

		<tr>
			<td>{$data.$productName}</td>
			<td>{$data.$batchname}</td>
			<td>{$data.$prasentqty}</td>
			<td>{$data.$issuedqty}</td>
			<td>{$data.$issuedby}</td>
			<td>{$data.$remarks}</td>
		</tr>
	{/foreach}
	</tbody>
</table>
<!-- Machinery -->
<table class="table table-bordered mergeTables">
    <thead>
    <th colspan="6" class="detailViewBlockHeader">
		Machinery
    </th>
	</thead>
	<tbody>
    <tr>
		<td><b>{vtranslate('Product Name',$MODULE)}</b></td>
		<td><b>{vtranslate('Batch Name',$MODULE)}</b></td>
		<td  width="100px"><b>{vtranslate('Present Stock',$MODULE)}</b></td>
		<td width="100px"><b>{vtranslate('Issued Qty',$MODULE)}</b></td>
		<td><b>{vtranslate('Issued By',$MODULE)}</b></td>
		<td><b>{vtranslate('Remarks',$MODULE)}</b></td>
    </tr>
    {foreach key=row_no item=data from=$GRID4}
		{assign var=row_no value=$row_no+1}
			{assign var="productid" value="grid4productid"|cat:$row_no}
			{assign var="productName" value="grid4productName"|cat:$row_no}
			{assign var="batchname" value="grid4batchname"|cat:$row_no}
			{assign var="batchid" value="grid4batchid"|cat:$row_no}
			{assign var="issuedqty" value="grid4issuedqty"|cat:$row_no}
			{assign var="prasentqty" value="grid4prasentqty"|cat:$row_no}
			{assign var="issuedby" value="grid4issuedby"|cat:$row_no}
			{assign var="remarks" value="grid4remarks"|cat:$row_no}
	
	<tr>
	    <td>{$data.$productName}</td>
		<td>{$data.$batchname}</td>
		<td>{$data.$prasentqty}</td>
		<td>{$data.$issuedqty}</td>
		<td>{$data.$issuedby}</td>
		<td>{$data.$remarks}</td>
    </tr>
	{/foreach}
	</tbody>
</table>