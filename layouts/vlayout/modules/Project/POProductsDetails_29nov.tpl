	<link rel="stylesheet" type="text/css" href="libraries/jquery.dataTables.css">
	
	<script type="text/javascript" language="javascript" src="libraries/jquery.dataTables.js">
	</script>
	</script>
	<script type="text/javascript" language="javascript" class="init">
	
$(document).ready(function() {
	$('#products').DataTable( {
		"pagingType": "full_numbers"
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
						<th>Quantity</th>
						<th>Used Quantity</th>
						<th>Remaining Quantity</th>
					</tr>
				</thead>
				
				<tbody>
				
				{foreach key=k item=i from=$PRODUCTDETAILS}
					<tr>
						<td align="center">{$i['productnumber']}</td>
						<td align="center">{$i['productname']}</td>
						<td align="center">{$i['quantity']}
						</td>
						<td align="center">
						<span class="value">{$i['usedqty']}</span>
						</td>
						<td align="center">{$i['remainingqty']}</td>
						
					</tr>
					{/foreach}
				</tbody>
			</table>
	</div>
	</section>
