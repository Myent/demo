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
{assign var="FIELD_INFO" value=Zend_Json::encode($FIELD_MODEL->getFieldInfo())}
{assign var="SPECIAL_VALIDATOR" value=$FIELD_MODEL->getValidator()}
{assign var="FIELD_NAME" value=$FIELD_MODEL->get('name')}
<div class="alignTop">
	Current: {$FIELD_MODEL->get('fieldvalue')}
	<small>
		Paste the Embed code from Youtube
	</small>
	<i class="icon-remove"></i>&nbsp;<input id="{$MODULE}_editView_fieldName_{$FIELD_NAME}" type="text" data-validation-engine="validate[{if $FIELD_MODEL->isMandatory() eq true} required,{/if}funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" name="{$FIELD_NAME}" onblur="getYoutTubeSRC(this);return false;"
	value="{$FIELD_MODEL->get('fieldvalue')}" data-fieldinfo='{$FIELD_INFO}' {if !empty($SPECIAL_VALIDATOR)}data-validator={Zend_Json::encode($SPECIAL_VALIDATOR)}{/if} />
	<h5 id="ytUrl" class="small">Click here to resolve URL</h5>
</div>
<script>
function getYoutTubeSRC(obj){
	ytcode = obj.value;
	ytcode = obj.value.replace(/^.*src="/g,'').replace(/" frameborder=.*$/g,'');
	ytcode = ytcode.replace(/" frameborder=.*$/g,'');
	jQuery(obj).val(ytcode);
	jQuery("#ytUrl").html(ytcode);
}
</script>
{/strip}
