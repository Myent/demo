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
{assign var="STDMOBILE" value="-"|explode:$FIELD_MODEL->get('fieldvalue')}

{if $STDMOBILE[0] eq "" || $STDMOBILE[0] eq null}
	<script>var STDCODE = '';</script>
{else}
	<script>var STDCODE = {$STDMOBILE[0]};</script>
{/if}
{if $STDMOBILE[1] eq "" || $STDMOBILE[1] eq null}
	<script>var MOBILENUM = '';</script>
{else}
	<script>var MOBILENUM = {$STDMOBILE[1]};</script>
{/if}
<input style="width: 40px" id="{$MODULE}_editView_fieldName_{$FIELD_MODEL->get('name')}_stdcode" name="{$MODULE}_editView_fieldName_{$FIELD_MODEL->get('name')}_stdcode" data-validation-engine="validate[{if $FIELD_MODEL->isMandatory() eq true} required,{/if}funcCall[Vtiger_Base_Validator_Js.invokeValidation]]"
 value="{$STDMOBILE[0]}"  maxlength="10" data-name="{$MODULE}_editView_fieldName_{$FIELD_MODEL->get('name')}" data-code="stdcode" data-validator='{Zend_Json::encode([['name'=>'mobilenumvalidation']])}' />
&nbsp;&nbsp;
{assign var="FIELD_INFO" value=Vtiger_Util_Helper::toSafeHTML(Zend_Json::encode($FIELD_MODEL->getFieldInfo()))}
{assign var="SPECIAL_VALIDATOR" value=$FIELD_MODEL->getValidator()}
<input id="{$MODULE}_editView_fieldName_{$FIELD_MODEL->get('name')}_phone" data-name="{$MODULE}_editView_fieldName_{$FIELD_MODEL->get('name')}" data-code="phone" type="text" style="width:130px" class="input-large" data-validation-engine="validate[{if $FIELD_MODEL->isMandatory() eq true} required,{/if}funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" 
 value="{$STDMOBILE[1]}"  maxlength="10" data-validator='{Zend_Json::encode([['name'=>'mobilenumvalidation']])}' />

 <input id="{$MODULE}_editView_fieldName_{$FIELD_MODEL->get('name')}" type="hidden" class="input-large" data-validation-engine="validate[{if $FIELD_MODEL->isMandatory() eq true} required,{/if}funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" name="{$FIELD_MODEL->getFieldName()}"
 value="{$FIELD_MODEL->get('fieldvalue')}" data-fieldinfo='{$FIELD_INFO}' {if !empty($SPECIAL_VALIDATOR)}data-validator={Zend_Json::encode($SPECIAL_VALIDATOR)}{/if} />

 
 {/strip}