{if $smarty.request.content eq ''}
<div class="dashboardWidgetHeader">
	<table width="100%" cellspacing="0" cellpadding="0">
		<tbody>
			<tr>
				<td class="span5">
					<div class="dashboardTitle textOverflowEllipsis" title="{$LINKS_INFO['linklabel']}" style="width: 15em;"><b>{$LINKS_INFO['linklabel']}</b></div>
				</td>
				<td class="refresh span2" align="right">
					<span style="position:relative;">&nbsp;</span>
				</td>
				<td class="widgeticons span5" align="right">
					<div class="box pull-right">
						<a href="javascript:void(0);" name="drefresh" data-url="{$EDIT_URL}">
							<i class="icon-refresh" hspace="2" border="0" align="absmiddle" title="{vtranslate('LBL_REFRESH')}" alt="{vtranslate('LBL_REFRESH')}"></i>
						</a>
				
						<a name="dclose" class="widget" data-url="{$DELETE_URL}">
							<i class="icon-remove" hspace="2" border="0" align="absmiddle" title="{vtranslate('LBL_REMOVE')}" alt="{vtranslate('LBL_REMOVE')}"></i>
						</a>
							
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
{/if}
<div class="dashboardWidgetContent">
	<div style="padding:5px">
		<div style="padding:5px">
			<span class="pull-right"><b>Count</b></span>
			<b>FiterName</b>
		</div>
		{foreach item=i key=k from=$FILTER_COUNT}
			<div style="padding:5px">
				<span class="pull-right"><b>{$i[1]}</b></span>
				{$i[0]}
			</div>
		{/foreach}
	</div>
</div>
