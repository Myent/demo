	<link rel="stylesheet" type="text/css" href="libraries/jquery.dataTables.css">
	
	<script type="text/javascript" language="javascript" src="libraries/jquery.dataTables.js">
	</script>
	</script>
	<script type="text/javascript" language="javascript" class="init">
	
$(document).ready(function() {
	$('#products').DataTable( {
		"pagingType": "full_numbers"
	});
	//Allocate Qty Edit Purpose
	$("#products").on('click','.quantity',function(e){
		var target =$(e.currentTarget).closest('td');
		target.find('.quantityval').addClass('hide');
		target.find('.quantity').addClass('hide');
		target.find('.quantityedit').removeClass('hide');
	});
	$("#products").on('click','.qtysave',function(e){
		var projectid=$("input[name='projectid']").val();
		var target =$(e.currentTarget).closest('tr');
		var productid = target.find("input[name='productid']").val();
		var productqty = target.find("input[name='productqty']").val();
		var qty = target.find("input[name='allocatedtqty']").val();
		var price = target.find("input[name='totalprice']").val();
		if(parseInt(productqty) < parseInt(qty)){
			bootbox.alert("Products Quantity in Stock is "+productqty+".So,Please give proper qty.");
			return false;
		}
		var params = {};
		params['projectid'] = projectid;
		params['productid'] = productid;
		params['qty'] = qty;
		params['module'] = "Project";
		params['action'] = "ProductQtyUpdate";
		
		AppConnector.request(params).then(
			function(data) {
				if(data.success == true) {
					target.find('.quantityval').html(qty);
					var totalprice = (qty*price).toFixed(2);
					target.find('.remainingqty').html(qty);
					target.find('.totalpricedisplay').html(totalprice);
					target.find('.quantityval').removeClass('hide');
					target.find('.quantityedit').addClass('hide');
				}
			}
		);
		
	});
	$("#products").on('click','.qtycancel',function(e){
		var target =$(e.currentTarget).closest('tr');
		target.find('.quantityval').removeClass('hide');
		target.find('.quantityedit').addClass('hide');
		target.find('.quantity').removeClass('hide');
	});
	//Used Qty Purpose
	$("#products").on('click','.usedqty',function(e){
		var target =$(e.currentTarget).closest('td');
		target.find('.usedqtyval').addClass('hide');
		target.find('.usedqty').addClass('hide');
		target.find('.usedqtyedit').removeClass('hide');
	});
	$("#products").on('click','.dtsave',function(e){
		var projectid=$("input[name='projectid']").val();
		var target =$(e.currentTarget).closest('tr');
		var productid = target.find("input[name='productid']").val();
		var productqty = target.find(".quantityval").text();
		var qty = target.find("input[name='usedqtyallow']").val();
		if(!productqty.length){
			bootbox.alert("Please allocate some products qty first.");
			return false;
		}

		var remainingqty = productqty-qty;
		if(parseInt(productqty) < parseInt(qty)){
			bootbox.alert("Products Quantity allocated for this project is "+productqty+".So,Please give proper qty.");
			return false;
		}
		var params = {};
		params['projectid'] = projectid;
		params['productid'] = productid;
		params['qty'] = qty;
		params['module'] = "Project";
		params['action'] = "ProductUsedQtyUpdate";
		
		AppConnector.request(params).then(
			function(data) {
				if(data.success == true) {
					target.find('.usedqtyval').html(qty);
					target.find('.remainingqty').html(remainingqty);
					target.find('.usedqtyval').removeClass('hide');
					target.find('.usedqtyedit').addClass('hide');
					target.find('.usedqty').removeClass('hide');
				}
			}
		);
		
	});
	$("#products").on('click','.dtcancel',function(e){
		var target =$(e.currentTarget).closest('tr');
		target.find('.usedqtyval').removeClass('hide');
		target.find('.usedqtyedit').addClass('hide');
		target.find('.usedqty').removeClass('hide');
	});
	//Add Stock to Products module again
	$("#products").on('click','.addstock',function(e){
		var stockstatus = $(this).is( ":checked" );
		var projectid=$("input[name='projectid']").val();
		var target =$(e.currentTarget).closest('tr');
		var productid = target.find("input[name='productid']").val();
		var params = {};
		params['projectid'] = projectid;
		params['productid'] = productid;
		params['module'] = "Project";
		params['action'] = "ProductRemaingStockUpdate";
		if(stockstatus == true){
			bootbox.confirm("Product will lock once you checked. You can't edit this product quantity again.", function(result){ 
				if(result == false){
					target.find("input[name='addstock']").prop('checked',false);
					
				}else{
					AppConnector.request(params).then(
						function(data) {
							if(data.success == true) {
								target.find("input[name='addstock']").prop('disabled',true);
								target.find('.usedqty').addClass('hide');
								target.find('.quantity').addClass('hide');
							}
						}
					);
				}
			});
		}
	});
});
	</script>

	<div class="contents">
		<section>
			<table id="products" class="display" cellspacing="0" width="90%">
				<thead>
					<tr>
						<th>Product Number</th>
						<th>Product Name</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Total Price</th>
						<th>Used Quantity</th>
						<th>Remaining Quantity</th>
						<th>Stock add to Products</th>
					</tr>
				</thead>
				
				<tbody>
				
				{foreach key=k item=i from=$PRODUCTDETAILS}
					<tr>
						<td align="center">{$i['productnumber']}
						<input type="hidden" name="productid" value="{$i['productid']}" />
						<input type="hidden" name="projectid" value="{$smarty.request.record}" />
						<input type="hidden" name="productqty" class="productqty" value="{$i['productqty']}" />
						<input type="hidden" name="totalprice"  value="{$i['price']}" />
						</td>
						<td align="center">{$i['productname']}</td>
						<td align="center">{$i['price']}</td>
						<td align="center" class="qtyclick">
							<span class="quantityval">{$i['allocatedtqty']}</span>&nbsp;&nbsp;
								{if $i['is_edit'] neq 1 &&  $i['is_checked'] neq 1}
								<i class="icon-edit quantity"></i>
									<span class="hide quantityedit">
										<input  type="text" name="allocatedtqty" value="{$i['allocatedtqty']}" class="input-small"/>
										<br/>
										<i class="icon-ok-sign qtysave"></i>
										<i class="icon-remove-sign qtycancel"></i>
									</span>
								{/if}
						</td>
						<td align="center" class='totalpricedisplay'>
							{$i['totalprice']}
						</td>
						<td align="center" class="usedqtyclick">
							<span class="usedqtyval" style='color:blue;font-weight:bold;'>{$i['usedqty']}						
							</span>
							{if $i['is_checked'] neq 1}
							&nbsp;<i class="icon-edit usedqty"></i>
							<span class="hide usedqtyedit">
								<input  type="text" name="usedqtyallow" value="{$i['usedqty']}" class="input-small"/>
								<br/>
								<i class="icon-ok-sign dtsave"></i>
								<i class="icon-remove-sign dtcancel"></i>
							</span>
							{/if}
						</td>
						<td align="center">
							<span class="remainingqty">
							{$i['remainingqty']}
							</span>
						</td>
						<td align="center">
							<input type="checkbox" name="addstock" class="addstock" value="{if $i['is_checked'] eq 1}1{else}0{/if}" {if $i['is_checked'] eq 1}checked disabled{/if}/>
						</td>
					</tr>
					{/foreach}
				</tbody>
			</table>
	</div>
	</section>
