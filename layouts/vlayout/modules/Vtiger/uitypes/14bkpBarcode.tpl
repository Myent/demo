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
	<script src="modules/Products/JsBarcode-master/dist/JsBarcode.all.js"></script>


{assign var="FIELD_INFO" value=Vtiger_Util_Helper::toSafeHTML(Zend_Json::encode($FIELD_MODEL->getFieldInfo()))}
{assign var="SPECIAL_VALIDATOR" value=$FIELD_MODEL->getValidator()}
{if $MODULE eq 'HelpDesk' && ($FIELD_MODEL->get('name') eq 'days' || $FIELD_MODEL->get('name') eq 'hours')}
	{assign var="FIELD_VALUE" value=$FIELD_MODEL->getDisplayValue($FIELD_MODEL->get('fieldvalue'))}
{else}
	{assign var="FIELD_VALUE" value=$FIELD_MODEL->get('fieldvalue')}
{/if}
<input type="text" tabindex="{$vt_tab}" name="barcode" id ="barcode" value="{$fldvalue}" class="detailedViewTextBox" onFocus="this.className='detailedViewTextBoxOn'" onBlur="this.className='detailedViewTextBox'">
<input type="button" id="generateBC" name="generateBC" value="Generate" class="crmbutton small"  >
 <img id="barcode2" width="300" height="146"/><canvas id="myCanvasImage" width="50" height="50">re</canvas><textarea name="base64" id="base64"  style="display:none;" maxlength='90000'></textarea>
				
				<div id="img_preview"  ></div>{foreach key=ITER item=IMAGE_INFO from=$BARCODE_DETAILS}
		<div class="row-fluid">
			{if !empty($IMAGE_INFO.path) && !empty({$IMAGE_INFO.orgname})}
				<span class="span8" name="existingImages"><img src="{$IMAGE_INFO.path}_{$IMAGE_INFO.orgname}" data-image-id="{$IMAGE_INFO.id}"></span>
				<span class="span3 row-fluid">
					<span class="row-fluid">[{$IMAGE_INFO.name}]</span>
					<span class="row-fluid"><input type="button" id="file_{$ITER}" value="Delete" class="barcodeDelete"></span>
				</span>
			{/if}
		</div>
	{/foreach}<span id="vtbusy_info" style="display:none;">
						<img src="{'vtbusy.gif'|@vtiger_imageurl:$THEME}" border="0"></span>
{/strip}