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
<div class="vk_dt_container">
<input class="VKActualDateTime {$FIELD_NAME}" type="hidden" name="VKActualDateTime" value="{$FIELD_MODEL->get('fieldvalue')}"
 data-fieldinfo='{$FIELD_INFO}'/>
<input id="{$MODULE}_editView_fieldName_{$FIELD_NAME}" type="hidden" name="{$FIELD_MODEL->getFieldName()}" value="{$FIELD_MODEL->get('fieldvalue')}"
 data-fieldinfo='{$FIELD_INFO}'/>
	 
 {assign var="vtdatetime" value=" "|explode:$FIELD_MODEL->get('fieldvalue')}

<div>

	{include file=vtemplate_path('uitypes/VTDate.tpl',$MODULE) BLOCK_FIELDS=$BLOCK_FIELDS}
</div>
<div class="clear-both"></div>
<div>
	{include file=vtemplate_path('uitypes/VTTime.tpl',$MODULE) BLOCK_FIELDS=$BLOCK_FIELDS}
</div>
</div>
