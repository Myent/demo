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
{if $FIELD_MODEL->get('fieldvalue') neq ''}
<script src="./libraries/barcode/JsBarcode.code39.min.js"></script>
<img id="{$FIELD_NAME}_display">
{/if}
<script>
/*Modified by Manasa :: 06th DEC 2017 if we went related list again back to detail view. If value is empty. Throwing error*/
var barcodenum = "{$FIELD_MODEL->get('fieldvalue')}";
if(barcodenum){
	JsBarcode("#{$FIELD_NAME}_display", "{$FIELD_MODEL->get('fieldvalue')}");
}
</script>
