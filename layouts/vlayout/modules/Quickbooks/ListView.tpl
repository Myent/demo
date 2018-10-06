{strip}
 

<!-- Every page of your app should have this snippet of Javascript in it, so that it can show the Blue Dot menu -->
		<script type="text/javascript" src="https://appcenter.intuit.com/Content/IA/intuit.ipp.anywhere.js"></script>
		<script type="text/javascript">
		intuit.ipp.anywhere.setup({
			menuProxy: "{$quickbooks_menu_url}",
			grantUrl: "{$quickbooks_oauth_url}"
		});
		</script> 
		
		 
		 {if $quickbooks_is_connected}
			<ipp:blueDot></ipp:blueDot>
		{/if}
		<style>
		.table tbody tr:hover td{
		  background-color: white;
		}
		</style>
		
<div class='editViewContainer'>
<div class="padding-left1per">
		<div class="row-fluid widget_header">
			<div class="span8">
				<h3>{vtranslate('QB Authentication', $QUALIFIED_MODULE)}</h3>
				{if $DESCRIPTION}<span style="font-size:12px;color: black;"> - &nbsp;{vtranslate({$DESCRIPTION}, $QUALIFIED_MODULE)}</span>{/if}
			</div>
			<div class="span4">
			<!--button id="updateCompanyDetails" class="btn pull-right">{vtranslate('LBL_EDIT',$QUALIFIED_MODULE)}</button-->
			</div>
		</div>
	<div>
		<table class="table equalSplit">
			<tr>
				<td width="100%" >
					{assign var=WIDTHTYPE value=$CURRENT_USER_MODEL->get('rowheight')}
					{include file="modules/Quickbooks/Index.tpl"}
				</td>
			</tr>
		</table>
	</div>
</div>

 
{include file='quickbooks/views/footer.tpl.php'}

 
	
</div>
{/strip}