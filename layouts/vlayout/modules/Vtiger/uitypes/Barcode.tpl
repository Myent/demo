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
<script src="./libraries/barcode/JsBarcode.code39.min.js"></script>
{assign var="FIELD_INFO" value=Vtiger_Util_Helper::toSafeHTML(Zend_Json::encode($FIELD_MODEL->getFieldInfo()))}
{assign var="SPECIAL_VALIDATOR" value=$FIELD_MODEL->getValidator()}
{assign var="FIELD_VALUE" value=$FIELD_MODEL->get('fieldvalue')}
<script>
function displayBarCode(obj){
	JsBarcode("#"+obj.name+"_display", obj.value);
}
</script>

<input type="text" tabindex="{$vt_tab}" id="{$MODULE}_editView_fieldName_{$FIELD_MODEL->get('name')}" name="{$FIELD_NAME}" value="{$FIELD_MODEL->get('fieldvalue')}" class="detailedViewTextBox" onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox';displayBarCode(this);" onChange="displayBarCode(this);" onKeyup="displayBarCode(this);"/>
<br/>
<img id="{$FIELD_NAME}_display"/>

<script>
	JsBarcode("#{$FIELD_MODEL->get('name')}"+"_display", "{$FIELD_MODEL->get('fieldvalue')}");
</script>
{/strip}