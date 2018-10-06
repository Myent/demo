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
<!--div>
	<i class="icon-upload"></i>&nbsp;
	{if $FIELD_MODEL->get('fieldvalue') ne ""}
		{$FIELD_MODEL->get('fieldvalue')}&nbsp;<i class="icon-download"></i>&nbsp;<i class="icon-remove"></i>
		<audio controls>
			<source src="{$FIELD_MODEL->get('fieldvalue')}">
				Your browser does not support the audio tag.
		</audio>
	{/if}
</div-->
<style>
.audio-container{
    /*width: 500px;
    border: 1px solid #333;*/
    padding: 4px;
}
.audio-wrapper {
    background: url(modules/vtDZiner/audio.png) no-repeat;
    background-size: cover;
    display: inline;
    position: absolute;
    width: 24px;
    height: 24px;
}
.audio-icon {
    width: 24px;
    height: 24px;
    /*margin-right: 100px;*/
    opacity: 0;
    filter: alpha(opacity=0); /* IE 5-7 */
}
</style>
<div>
	Click on icon to select a new file
	<div style=" width:312px;float:left;">
		<div style=" width:32px;float:left;">
			<!-- Audio -->
			<span class="audio-container" style=" width:50px;">
				<span class="audio-wrapper" >
					<input style="width:50px;" accept="audio/*" class="audio-icon" id="{$MODULE}_editView_fieldName_{$FIELD_NAME}" type="file" name="{$FIELD_MODEL->getFieldName()}" />
				</span>
			</span>
			<!-- Audio -->
		</div>
		<div style=" width:204px;float:left;" class="alert alert-info">
			{if $FIELD_MODEL->get('fieldvalue') ne ""}
				{assign var="testsplit" value="/"|explode:$FIELD_MODEL->get('fieldvalue')}
				{assign var="storagename" value=$testsplit|end}
				{assign var="finalname" value="_"|explode:$storagename}
				{$finalname[1]}&nbsp;<sup>Saved</sup>
			{else}
				No file uploaded
			{/if}
			<span class="pull-left" id="{$MODULE}_editView_fieldName_{$FIELD_NAME}_attr"></span>
		</div>
	</div>
</div>
<script>
	$('#{$MODULE}_editView_fieldName_{$FIELD_NAME}').bind('change', function() {
		$('#{$MODULE}_editView_fieldName_{$FIELD_NAME}_attr').html(this.files[0].name +"&nbsp;<sup>New</sup><br>"+this.files[0].size + " bytes");
	});
</script>
{/strip}