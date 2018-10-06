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
{assign var="LATLONGADD" value=":||:"|explode:$FIELD_MODEL->get('fieldvalue')}
{assign var="LATLONG" value=", "|explode:$LATLONGADD[0]}

{if $LATLONG[0] eq "" || $LATLONG[0] eq null}
	<script>var vtLatitude = 0;</script>
{else}
	<script>var vtLatitude = {$LATLONG[0]};</script>
{/if}
{if $LATLONG[1] eq "" || $LATLONG[1] eq null}
	<script>var vtLongitude = 0;</script>
{else}
	<script>var vtLongitude = {$LATLONG[1]};</script>
{/if}
{if $LATLONGADD[1] eq "" || $LATLONG[1] eq null}
	<script>jQuery("{$MODULE}_editView_fieldName_{$FIELD_NAME}-address").val('')</script>
{else}
	<script>jQuery("{$MODULE}_editView_fieldName_{$FIELD_NAME}-address").val('{$LATLONGADD[1]}')</script>
{/if}
<script>
	var inputfield = "{$MODULE}_editView_fieldName_{$FIELD_NAME}";
</script>
<textarea id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-address" style="width: 100%"/></textarea><br/>
<input id="{$MODULE}_editView_fieldName_{$FIELD_NAME}" type="hidden" class="input-large hide" data-validation-engine="validate[{if $FIELD_MODEL->isMandatory() eq true} required,{/if}funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" name="{$FIELD_NAME}"
value="{$FIELD_MODEL->get('fieldvalue')}" data-fieldinfo='{$FIELD_INFO}' {if !empty($SPECIAL_VALIDATOR)}data-validator={Zend_Json::encode($SPECIAL_VALIDATOR)}{/if} />
{/strip}
<div id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-vtdzmap" class="geography" style="height: 200px;"></div>
<div class="span5">
	Lat: <input type="text" id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-lat" style="width: 90px"/>&nbsp;
	Lon: <input type="text" id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-lon" style="width: 90px"/>
		<span class="pull-right" >
			Rad: <input type="text" id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-radius" style="width: 40px"/>
		</span>
</div>
<span><input type=text disabled id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-street1" class="span5"/></span>
<span><input type=text disabled id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-city" class="span5"></span>
<span>
	<input type=text disabled id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-state" class="span2">&nbsp;
	<input type=text disabled id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-zip" class="span1">&nbsp;
	<input type=text disabled id="{$MODULE}_editView_fieldName_{$FIELD_NAME}-country" class="span2">
</span>