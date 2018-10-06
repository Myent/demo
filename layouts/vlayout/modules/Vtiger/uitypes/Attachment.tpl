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
<style>
.attachment-container{
    /*width: 500px;
    border: 1px solid #333;*/
    padding: 4px;
}
.attachment-wrapper {
    background: url(modules/vtDZiner/attachment.png) no-repeat;
    background-size: cover;
    display: block;
    position: relative;
    width: 24px;
    height: 24px;
}
.attachment-icon {
    width: 24px;
    height: 24px;
    margin-right: 100px;
    opacity: 0;
    filter: alpha(opacity=0); /* IE 5-7 */
}
</style>
Current: {$FIELD_MODEL->get('fieldvalue')}
<div class="attachment-container">
  <span class="attachment-wrapper">
    <input class="attachment-icon" id="{$MODULE}_editView_fieldName_{$FIELD_NAME}" type="file" name="{$FIELD_MODEL->getFieldName()}" />
  </span>
</div>
<span id="{$MODULE}_editView_fieldName_{$FIELD_NAME}_attr"></span>
<script>
	$('#{$MODULE}_editView_fieldName_{$FIELD_NAME}').bind('change', function() {
		$('#{$MODULE}_editView_fieldName_{$FIELD_NAME}_attr').html("Selected: "+this.files[0].name +", "+this.files[0].size + " bytes");
	});
</script>
{/strip}