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

/*********************************************************************************
 ** The contents of this file are originally from vTiger distribution. 
  *  These are distributed with certain enhancements keeping in view the 
  *  vtiger CRM Public License Version 1.0
  *  Certain 3rd party components may have been deployed here keeping in mind their
  *  rights and licences
  *  Where used, these are acknoweledged inline with suitable comments
 *
 ********************************************************************************/

-->*}
{strip}
{assign var="FIELD_INFO" value=Vtiger_Util_Helper::toSafeHTML(Zend_Json::encode($FIELD_MODEL->getFieldInfo()))}
{assign var="SPECIAL_VALIDATOR" value=$FIELD_MODEL->getValidator()}
{assign var="FIELD_NAME" value=$FIELD_MODEL->get('name')}
<textarea id="{$MODULE}_editView_fieldName_{$FIELD_NAME}" class="richtext span11 {if $FIELD_MODEL->isNameField()}nameField{/if}" name="{$FIELD_MODEL->getFieldName()}" {if $FIELD_NAME eq "notecontent"}id="{$FIELD_NAME}"{/if} data-validation-engine="validate[{if $FIELD_MODEL->isMandatory() eq true}required,{/if}funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" data-fieldinfo='{$FIELD_INFO}' {if !empty($SPECIAL_VALIDATOR)}data-validator={Zend_Json::encode($SPECIAL_VALIDATOR)}{/if}>
{$FIELD_MODEL->get('fieldvalue')}</textarea>
{/strip}
{if $COUNTER==1}
<script>
jQuery(document).ready(function(){
	if (jQuery("#{$MODULE}_editView_fieldName_{$FIELD_NAME}").closest('td').next().html()=="") {
		jQuery("#{$MODULE}_editView_fieldName_{$FIELD_NAME}").closest('td').siblings().addClass('hide');
		jQuery("#{$MODULE}_editView_fieldName_{$FIELD_NAME}").closest('td').prepend('<label class="muted marginRight10px">'+jQuery("#{$MODULE}_editView_fieldName_{$FIELD_NAME}").closest('td').prev().text()+'</label><hr/>');
		jQuery("#{$MODULE}_editView_fieldName_{$FIELD_NAME}").closest('td').find('span:first').removeClass('span10').addClass('span12');
		jQuery("#{$MODULE}_editView_fieldName_{$FIELD_NAME}").closest('td').attr('colspan',4);
	}
});
</script>
{/if}