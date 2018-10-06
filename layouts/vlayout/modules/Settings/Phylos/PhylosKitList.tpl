{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
{strip}
<div class="container-fluid" id="PhylosDetails">
	
	<div class="widget_header row-fluid">
		<div class="span8"><h3>{vtranslate('LBL_Phylos_KITLIST', $QUALIFIED_MODULE)}</h3>
		<!--a href="?module=Phylos&parent=Settings&view=PhylosSessionAjax"  title="Test"><strong>Test Phylos Connection</strong></a-->
		</div>
		<div class="span4">
			<div class="pull-right"> 
				&nbsp;&nbsp;&nbsp;&nbsp; 
				<button class="btn editButton" data-url='?module=Phylos&parent=Settings&view=PhylosEdit' type="button" title="{vtranslate('LBL_EDIT', $QUALIFIED_MODULE)}"><strong>{vtranslate('LBL_EDIT_SETTINGS', $QUALIFIED_MODULE)}</strong></button>
			</div>
		</div>
	</div>
	<hr>
	<div class="contents">
	
		<table class="table table-bordered equalSplit detailview-table">
			<thead>
				<tr class="blockHeader">
					<th   class="">
						#
					</th>
					<th class="">
						<span class="alignMiddle">{vtranslate('LBL_KITNAME', $QUALIFIED_MODULE)}</span>
					</th> 
				</tr>
			</thead>
			<tbody> 				
				{assign var=i value=1}
				{foreach from=$MODEL key=keyv item=vdata}
					<tr>
						<td>
						{$i}
						</td>
						<td>
						{$vdata['kitid']}
							 
						</td>
					</tr>
					{assign var=i value=$i+1}
				{/foreach}
				
			</tbody>
		</table>
	</div>
</div>
{/strip}