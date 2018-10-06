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
{assign var="FIELD_INFO" value=Zend_Json::encode($FIELD_MODEL->getFieldInfo())}
{assign var="SPECIAL_VALIDATOR" value=$FIELD_MODEL->getValidator()}
{assign var="FIELD_NAME" value=$FIELD_MODEL->get('name')}
{assign var="FIELD_VALUE" value=$FIELD_MODEL->get('fieldvalue')}
{assign var="SRC" value="?v="|explode:$FIELD_VALUE} 
{$FIELD_VALUE}
{if $FIELD_VALUE}
<iframe  width="360" height="150" src="https://www.youtube.com/embed/{$SRC[1]}" ></iframe>
{/if}
<script>
$("#{$FIELD_MODEL->get('name')}").closest("td").css('vertical-align','top');
</script>