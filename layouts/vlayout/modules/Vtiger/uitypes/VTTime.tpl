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
{assign var="TIME_FORMAT" value=$USER_MODEL->get('hour_format')}
<div class="input-append time" style="width:50%;float:left">
    <input style="width:67%" id="{$FIELD_MODEL->get('name')}_time" type="text" data-format="{$TIME_FORMAT}" 
	class="timepicker-default input-small vktimepicker" value="{$vtdatetime[1]}" name="{$FIELD_MODEL->get('name')}_time" data-field-name="{$FIELD_NAME}_date"
	data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" 
	 data-validator='{Zend_Json::encode([['name'=>'vttime']])}' 
	 />
    <span class="add-on cursorPointer">
        <i class="icon-time"></i>
    </span>
</div>
{/strip}