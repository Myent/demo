
<div class="QbSettngsList">

	<table class="table table-bordered">
		<thead>
			<tr>
				<th colspan='3'>Sync Modules Manually</th>				 				 		 				 
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Get Contacts From Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_get_cron_contacts.php' data-type="get" data-module="Contacts" >Sync</button></td>
				<td><input type='checkbox' class='clsChkCron' value='' name='get_Contacts' data-module='Contacts' data-type='get' {if $CRONDATA['Get Quickbooks Contacts'] eq '1' } checked  {/if} >&nbsp;Cron</td>
			</tr>
			<tr>
				<td>Send Contacts To Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_set_cron_contacts.php' data-type="post" data-module="Contacts" >Sync</button></td>
				<td><input type='checkbox' class='clsChkCron' value='' name='set_Contacts' data-module='Contacts' data-type='set' {if $CRONDATA['Set Quickbooks Contacts'] eq '1' } checked  {/if}>&nbsp;Cron</td>
			</tr>
			<tr>
				<td>Get Products/Services From Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_get_cron_products.php' data-type="get" data-module="Products-Services" >Sync</button></td>
				<td><input type='checkbox' class='clsChkCron' value='' name='get_products_service' data-module='items' data-type='get' {if $CRONDATA['Get Quickbooks products / Services'] eq '1' } checked  {/if}>&nbsp;Cron</td>
			</tr>
			<tr>
				<td>Send Products To Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_set_cron_products.php' data-type="post" data-module="Products" >Sync</button></td>				 
				<td><input type='checkbox' class='clsChkCron' value='' name='set_products' data-module='products' data-type='set' {if $CRONDATA['Set Quickbooks Products'] eq '1' } checked  {/if}>&nbsp;Cron</td>
			</tr>
			<tr>
				<td>Send Services To Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_set_cron_services.php' data-type="post" data-module="Services" >Sync</button></td>
				<td><input type='checkbox' class='clsChkCron' value='' name='set_services' data-module='services' data-type='set' {if $CRONDATA['Set Quickbooks Services'] eq '1' } checked  {/if}>&nbsp;Cron</td>
			</tr>
			<tr>
				<td>Get Vendors From Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_get_cron_Vendors.php' data-type="get" data-module="Vendors" >Sync</button></td>
				<td><input type='checkbox' class='clsChkCron' value='' name='get_vendors' data-module='Vendors' data-type='get' {if $CRONDATA['Get Quickbooks Vendors'] eq '1' } checked  {/if}>&nbsp;Cron</td>
			</tr>
			<tr>
				<td>Send Vendors To Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_set_cron_Vendors.php' data-type="post" data-module="Vendors" >Sync</button></td>
				<td><input type='checkbox' class='clsChkCron' value='' name='set_vendors' data-module='Vendors' data-type='set' {if $CRONDATA['Set Quickbooks Contacts'] eq '1' } checked  {/if}>&nbsp;Cron</td>
			</tr>
			<tr>
				<td>Get Invoice From Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_get_cron_Invoice.php' data-type="get" data-module="Invoice" >Sync</button></td>
				<td><input type='checkbox' class='clsChkCron' value='' name='get_invoice' id='get_invoice' data-module='Invoice' data-type='get' {if $CRONDATA['Get Quickbooks Invoice'] eq '1' } checked  {/if}>&nbsp;Cron</td>
			</tr>
			<tr>
				<td>Send Invoice To Quickbooks</td>
				<td><button class="btn clsBtnSync" data-page='qb_set_cron_Invoice.php' data-type="post" data-module="Invoice" >Sync</button></td>
				<td><input type='checkbox' class='clsChkCron'  value='' name='set_invoice' id='set_invoice' data-module='Invoice'  data-type='set' {if $CRONDATA['Set Quickbooks Invoice'] eq '1' } checked  {/if} >&nbsp;Cron</td>
			</tr>
			 
		</tbody>
	</table>
</div>
 

