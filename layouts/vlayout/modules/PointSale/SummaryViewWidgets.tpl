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
{if !empty($MODULE_SUMMARY)}
	<div class="row-fluid">
		<div class="span7">
			<div class="summaryView row-fluid">
			{$MODULE_SUMMARY}
			</div>
{/if}
			{foreach item=DETAIL_VIEW_WIDGET from=$DETAILVIEW_LINKS['DETAILVIEWWIDGET'] name=count}
				{if $smarty.foreach.count.index % 2 == 0}
					<div class="summaryWidgetContainer">
						<div class="widgetContainer_{$smarty.foreach.count.index}" data-url="{$DETAIL_VIEW_WIDGET->getUrl()}" data-name="{$DETAIL_VIEW_WIDGET->getLabel()}">
							<div class="widget_header row-fluid">
								<span class="span8 margin0px"><h4>{vtranslate($DETAIL_VIEW_WIDGET->getLabel(),$MODULE_NAME)}</h4></span>
							</div>
							<div class="widget_contents">
							</div>
						</div>
					</div>
				{/if}
			{/foreach}

			<div class="summaryWidgetContainer">
				<div >
					<b>{'BILL OF SALE'}</b>
				</div>
				<hr>
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>Product</th>
							<th>Qty</th>
							<th>Price</th>
							<th>Total</th>
							{if $TAX eq 1}<th>TotalWithTax</th>{/if}
						</tr>
					</thead>
					<tbody>
					{foreach from=$POS_DETAIL key=k item=data}
						<tr>
							<td>{$data['productname']}</td>
							<td>{$data['selected_qty']|string_format:"%.2f"}</td>
							<td>{$data['price']|string_format:"%.2f"}</td>
							<td>{$data['selected_qty']*$data['price']|string_format:"%.2f"}</td>
							{if $TAX eq 1}<td>{(($data['selected_qty']*$data['price']) + (($data['selected_qty']*$data['price']) * ($data['taxpercent']/100)))|string_format:"%.2f"}</td>{/if}
						</tr>
					{/foreach}
					</tbody>
				</table>
				<hr>
				<table class="table table-striped table-bordered">
					<tbody>
						<tr>
							<td>Total Items</td>
							<td colspan=3>{$total_qty|string_format:"%.2f"}</td>
						</tr>
						{if $TAX eq 1}
						<tr>
							<td>Total</td>
							<td colspan=3>{$pos_amount['total_amount']|string_format:"%.2f"}</td>
						</tr>
						{else}
						<tr>
							<td>Total Amount</td>
							<td colspan=3>{$totalwithouttax|string_format:"%.2f"}</td>
						</tr>
						<tr>
							<td>Total With Tax</td>
							<td colspan=3>{$pos_amount['total_amount']|string_format:"%.2f"}</td>
						</tr>
						{/if}
						<tr>
							<td>Cash Tendered</td>
							<td colspan=3>{$pos_amount['paid_amount']|string_format:"%.2f"}</td>
						</tr>
						<tr>
							<td>Change Return</td>
							<td colspan=3>{$pos_amount['return_amount']|string_format:"%.2f"}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
{/strip}