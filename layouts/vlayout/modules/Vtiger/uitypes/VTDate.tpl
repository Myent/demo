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
{assign var="dateFormat" value=$USER_MODEL->get('date_format')}
<div class="input-append row-fluid" style="width:50%;float:left">
	<div class="span12 row-fluid date">
		{assign var=FIELD_NAME value=$FIELD_MODEL->get('name')}
		{if $dateFormat eq 'mm-dd-yyyy'}
			 {assign var="vtdate" value=$vtdatetime[0]|date_format:'m-d-Y'}
		{else if $dateFormat eq 'dd-mm-yyyy'}
			{assign var="vtdate" value=$vtdatetime[0]|date_format:'m-d-Y'}
		{else}
			{assign var="vtdate" value=$vtdatetime[0]}
		{/if}
		 
		<input style="width:67%" id="{$FIELD_NAME}_date" type="text" class="dateField vkdateField" name="{$FIELD_NAME}_date"  data-field-name="{$FIELD_NAME}_date"
		data-date-format="{$dateFormat}" type="text" value="{$vtdate}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]"  
	 data-validator='{Zend_Json::encode([['name'=>'vtdate']])}'  />
		<span class="add-on"><i class="icon-calendar"></i></span>
	</div>
</div>
{/strip}