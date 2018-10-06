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
{assign var="FIELD_INFO" value=Vtiger_Util_Helper::toSafeHTML(Zend_Json::encode($FIELD_MODEL->getFieldInfo()))}
{assign var="SPECIAL_VALIDATOR" value=$FIELD_MODEL->getValidator()}
{assign var="FIELD_NAME" value=$FIELD_MODEL->get('name')}
{* VIVEK ADDED *}
{assign var="CURRENT_USER_MODEL" value=Users_Record_Model::getCurrentUserModel()}
{* VIVEK ADDED *}

<input class="{$MODULE}_editView_fieldName_{$FIELD_NAME}" style="vertical-align: top" type="radio" value="1" name="{$FIELD_MODEL->getFieldName()}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]"
{if $FIELD_MODEL->get('fieldvalue') eq 1 && $FIELD_MODEL->get('fieldvalue') neq ''} checked {/if} data-fieldinfo='{$FIELD_INFO}' {if !empty($SPECIAL_VALIDATOR)}data-validator={Zend_Json::encode($SPECIAL_VALIDATOR)}{/if}  />
&nbsp;Yes&nbsp;&nbsp;
<input class="{$MODULE}_editView_fieldName_{$FIELD_NAME}" style="vertical-align: top" type="radio" value="0" name="{$FIELD_MODEL->getFieldName()}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]"
{if $FIELD_MODEL->get('fieldvalue') eq 0 && $FIELD_MODEL->get('fieldvalue') neq ''} checked
{/if} data-fieldinfo='{$FIELD_INFO}' {if !empty($SPECIAL_VALIDATOR)}data-validator={Zend_Json::encode($SPECIAL_VALIDATOR)}{/if} value="0" />
&nbsp;No

{/strip}