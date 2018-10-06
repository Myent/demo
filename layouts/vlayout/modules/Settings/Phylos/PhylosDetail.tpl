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
		<div class="span8"><h3>{vtranslate('LBL_Phylos_EDITOR', $QUALIFIED_MODULE)}</h3>
		<!--a href="?module=Phylos&parent=Settings&view=PhylosSessionAjax"  title="Test"><strong>Test Phylos Connection</strong></a-->
		</div>
		<div class="span4">
			<div class="pull-right">
				<button class="btn kitlistButton" data-url='?module=Phylos&parent=Settings&view=PhylosKitList' type="button" title="{vtranslate('LBL_EDIT', $QUALIFIED_MODULE)}"><strong>{vtranslate('LBL_KIT_LIST', $QUALIFIED_MODULE)}</strong></button>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button class="btn editButton" data-url='?module=Phylos&parent=Settings&view=PhylosEdit' type="button" title="{vtranslate('LBL_EDIT', $QUALIFIED_MODULE)}"><strong>{vtranslate('LBL_EDIT', $QUALIFIED_MODULE)}</strong></button>
			</div>
		</div>
	</div>
	<hr>
	<div class="contents">
		<table class="table table-bordered equalSplit detailview-table">
			<thead>
				<tr class="blockHeader">
					<th colspan="2" class="">
						<span class="alignMiddle">{vtranslate('LBL_LOGIN_FILE', $QUALIFIED_MODULE)}</span>
					</th>
					
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<label class="muted pull-right marginRight10px">{vtranslate('LBL_Phylos_EMAIL', $QUALIFIED_MODULE)}</label>
					</td>
					<td>
						{$MODEL['email']}
					</td>
				</tr>
				<tr>
					<td>
						<label class="muted pull-right marginRight10px">{vtranslate('LBL_Phylos_PASSWORD', $QUALIFIED_MODULE)}</label>
					</td>
					<td>
						{$MODEL['api_key']}
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
{/strip}