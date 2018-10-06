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
    {assign var=CURRENCY_MODEL_EXISTS value=true}
    {assign var=CURRENCY_ID value=$RECORD_MODEL->getId()}
    {if empty($CURRENCY_ID)}
        {assign var=CURRENCY_MODEL_EXISTS value=false}
    {/if}
    <div class="currencyModalContainer">
	{if $EDIT_MODE}
	<input id="edit-mode" type="hidden" value="{$EDIT_MODE}"/>
	<div class="widget_header row-fluid">
		<h3>{vtranslate('Edit FIELD FORMULA', $QUALIFIED_MODULE)}</h3>
	</div>
	<hr/>
	{else}
  <div class="modal-header contentsBackground">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3>{vtranslate('ADD NEW FIELD FORMULA', $QUALIFIED_MODULE)}</h3>
  </div>
	{/if}
		<form id="editFieldFormula" class="form-horizontal" method="POST">
            <input type="hidden" name="record" value="{$CURRENCY_ID}" />
			{assign var=recordid value=$CURRENCY_ID}
			{assign var=expressionval value=$RECORD_MODEL->get('expression')}
			<input type='hidden' name="expressionval" value="{$expressionval}"/>
			<input type='hidden' name="finalfield" value="{$RECORD_MODEL->get('resultfield')}"/>
			<input type="hidden" name="FIELD_EXPRESSIONS" value='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($FIELD_EXPRESSIONS))}'/>
            <div class="modal-body">
                <div class="row-fluid">
									<table class="massEditTable table table-bordered">
									<tbody>
									<tr>
									<td class="fieldLabel">
									<label class="muted pull-right"><span class="redColor">*</span>&nbsp;{vtranslate('Module Name', $QUALIFIED_MODULE)}</label>
									</td>
									<td>
										<select class="select2 span5" name="module_name" data-validation-engine='validate[required]]'>
											 {foreach key=CURRENCY_ID item=CURRENCY_MODEL from=$ALL_CURRENCIES name=currencyIterator}
												 {if !$CURRENCY_MODEL_EXISTS && $smarty.foreach.currencyIterator.first}
																							{assign var=RECORD_MODEL value=$CURRENCY_MODEL}
																					{/if}
													<option value="{$CURRENCY_MODEL->get('name')}" data-code="{$CURRENCY_MODEL->get('tabid')}"
													 {if $RECORD_MODEL->get('module') == $CURRENCY_MODEL->get('name')} selected {/if}>
													 {vtranslate($CURRENCY_MODEL->get('name'), $QUALIFIED_MODULE)}</option>
											 {/foreach}
										 </select>
									</td>
								</tr>
								<tr>
									<td class="fieldLabel">
										<label class="muted pull-right">
												<span class="redColor">*</span>&nbsp;{vtranslate('FieldFormula Name', $QUALIFIED_MODULE)}
										</label>
									</td>
									<td>
										<input type="text" name="fieldformula_name" value="{$RECORD_MODEL->get('fieldformula_name')}"  data-validation-engine='validate[required]]' />

									</td>
								</tr>
				<tr>
					<td class="fieldLabel">
						<label class="muted pull-right">
							<span class="redColor">*</span>&nbsp;{vtranslate('Field Type', $QUALIFIED_MODULE)}
						 </label>
					</td>
					<td>
						<select class="select2 span5" name="fieldtype" id="fieldtype" onchange="clearfun()">
								<option value="String" data-code="'V~O','V~M'" {if $EXP_TYPE == 'String'} selected {/if}>{'String Fields'}</option>
								<option value="Date" data-code="'D~O','D~M'" {if $EXP_TYPE == 'Date'} selected {/if}>{'Date Fields'}</option>
								<option value="Time" data-code="'T~O','T~M'" {if $EXP_TYPE == 'Time'} selected {/if}>{'Time Fields'}</option>
								<option value="Number" data-code="'N~O','I~O','NN~O','I~M','N~M'" {if $EXP_TYPE == 'Number'} selected {/if}>{'Number Fields'}</option>
						 </select>
					</td>
				</tr>
<tr>
	<td class="fieldLabel">
		<label class="muted pull-right"><span class="redColor">*</span>&nbsp;{vtranslate('Expression', $QUALIFIED_MODULE)}</label>
	</td>
	<td>
		<select class="select2 span5 expression" name="expression" id="expression" onchange="chngeexpression()">
			<option value=''>{'SELECT'}</option>
				{foreach item=item key=k from=$FIELD_EXPRESSIONS[{$EXP_TYPE}]}
				<option value="{$item}" {if $expressionval  == $item} selected {/if}>
				{$k}
				</option>
				{/foreach}
		 </select>
	</td>
</tr>
<tr>
	<td class="fieldLabel">
			<input type="hidden" id="calculatedfield" value="{$RECORD_MODEL->get('resultfield')}" />
		<label class="muted pull-right">
	 	 <span class="redColor" >*</span>&nbsp;{vtranslate('Field Name', $QUALIFIED_MODULE)}
	 	</label>
	</td>
	<td>
		<select class="select2 span5 fieldname" name="fieldname" id="fieldname" >
			<option value="{$RECORD_MODEL->get('resultfield')}" selected> {$calculated_field}</option>
		 </select>
	</td>
</tr>
<tr>
	<td class="fieldLabel">
		<label class="muted pull-right">
	 	 <span class="redColor">*</span>&nbsp;{vtranslate('Calculation Field', $QUALIFIED_MODULE)}
	 	</label>
	</td>
	<td>
		<select class="select2 span5" name="fieldname2" id="fieldname2" >
				<option value="{$RECORD_MODEL->get('resultfield')}" selected> {$calculated_field}</option>
		 </select>
	</td>
</tr>
<tr>
	<td>
	<textarea class="expValue" readonly name="expValue" style="width:190px;" value="">
		{$RECORD_MODEL->get('expression')}</textarea>
	</td>
	<td>
	<textarea class="fieldValue" name="fieldValue" style="width:200px;" value="">
		{$RECORD_MODEL->get('fieldname')}</textarea>
	</td>
</tr>
<tr>
	<td class="fieldLabel">
<label class="muted pull-right">{vtranslate('LBL_STATUS', $QUALIFIED_MODULE)}</label>
	</td>
	<td>
		<label class="checkbox">
{$RECORD_MODEL->get('fieldformula_status')}
				<input type="hidden" name="fieldformula_status" value="Inactive" />
				<input type="checkbox" name="fieldformula_status" value="Active" class="fieldformulaStatus alignBottom"
{if $RECORD_MODEL->get('fieldformula_status') == 'Active'} checked {else if $recordid eq ''}checked {/if} />
</label>
	</td>
</tr>
</tbody>
</table>

<div id="rawtext_help" class="alert alert-info helpmessagebox" style="margin-top:1px;margin-bottom:-5px;">
	<p>Expression</p>
	<p>If you select addtime(), subtime(), add_days(), sub_days() any of these, select FieldName first and then put comma(,) and add the number of days or number of minutes.</p>
	<p>Example: Potentialname,10</p>
	<p>Basic Formula:field1+field2+(field3*3)+field4*10</p>
	<p></p>
</div>
</div>
</div>
{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
</form>
	</div>
{/strip}
<style media="screen">
	p{
		line-height: 11px;
	}
	.table th, .table td {
padding: 6px;
	}
</style>
