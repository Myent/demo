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
<div class="container-fluid">
	<div class="contents">
		<form id="PhylosForm" class="form-horizontal" data-detail-url="?module=Phylos&parent=Settings&view=PhylosDetail" method="POST">
			<div class="widget_header row-fluid">
				<div class="span8"><h3>{vtranslate('LBL_Phylos_EDITOR', $QUALIFIED_MODULE)}</h3>&nbsp;{vtranslate('LBL_Phylos_DESCRIPTION', $QUALIFIED_MODULE)}</div>
				<div class="span4 btn-toolbar">
					<div class="pull-right">
						<button class="btn btn-success saveButton" type="submit" title="{vtranslate('LBL_SAVE', $QUALIFIED_MODULE)}"><strong>{vtranslate('LBL_SAVE', $QUALIFIED_MODULE)}</strong></button>
						<a type="reset" class="cancelLink" title="{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}">{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}</a>
					</div>
				</div>
			</div>
			<hr>
			<div class="row-fluid hide errorMessage">
				<div class="alert alert-error">
				  {vtranslate('Error', $QUALIFIED_MODULE)}:&nbsp;
				  <strong class="errormessagedisplay"></strong>  
				</div>
			</div>
			<input type="hidden" name="phylosid" value="{$MODEL['id']}"/>
			<table class="table table-bordered table-condensed themeTableColor">
				<thead>
					<tr class="blockHeader"><th colspan="2" class="{$WIDTHTYPE}">{vtranslate('LBL_LOGIN_FILE', $QUALIFIED_MODULE)}</th></tr>
				</thead>
				<tbody>
					<tr>
					<td>
						<label class="muted pull-right marginRight10px">
						<!--span class="redColor">*</span>data-validation-engine="validate[required]"-->{vtranslate('LBL_Phylos_EMAIL', $QUALIFIED_MODULE)}</label>
					</td>
					<td>
						<input type="email" name="email"  value="{$MODEL['email']}"/>
					</td>
				</tr>
				<tr>
					<td>
						<label class="muted pull-right marginRight10px">
						<span class="redColor">*</span>{vtranslate('LBL_Phylos_PASSWORD', $QUALIFIED_MODULE)}</label>
					</td>
					<td>
						<input type="text" name="api_key" data-validation-engine="validate[required]" value="{$MODEL['api_key']}"/>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>
{/strip}