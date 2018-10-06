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
<meta charset="utf-8">
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
   Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="initial-scale=1.0, target-densitydpi=device-dpi" /><!-- this is for mobile (Android) Chrome -->
<meta name="viewport" content="initial-scale=.5, width=device-height"><!--  mobile Safari, FireFox, Opera Mobile  -->


<script src="./libraries/jSignature-master/src/jSignature.js"></script>
<script src="./libraries/jSignature-master/src/plugins/jSignature.CompressorBase30.js"></script>

<style type="text/css">

	 
	
	#signatureparent {
		color:darkblue;
		background-color:darkgrey;
		/*max-width:600px;*/
		padding:20px;
		
	}
	
	/*This is the div within which the signature canvas is fitted*/
	.signature {
		border: 2px dotted black;
		background-color:lightgrey;
		 width:300px;height:80px;
		 position:left;
		 left:e.pageX;
		 top:e.pageY;

	}

	/* Drawing the 'gripper' for touch-enabled devices */ 
	html.touch #content {
		float:left;
		width:52%;
	}
	html.touch #scrollgrabber {
		
		width:4%;
		margin-right:2%;
		background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAFCAAAAACh79lDAAAAAXNSR0IArs4c6QAAABJJREFUCB1jmMmQxjCT4T/DfwAPLgOXlrt3IwAAAABJRU5ErkJggg==)
	}
	span[name=existingImages] img { 
	  height:100px;  
	  width:300px; 
	}
	 
</style>

	<div id="signature{$FIELD_MODEL->getFieldName()}" class='signature'></div>
	<img id="sigimage{$FIELD_MODEL->getFieldName()}">
	<div style="display: inline-block;">
		<p>
			<input id="donebutton{$FIELD_MODEL->getFieldName()}" type="button" value="Done">
			<input id="clearbutton{$FIELD_MODEL->getFieldName()}" type="button" value="Clear">
		</p>
		<input name="imagedata[{$FIELD_MODEL->getFieldName()}]" value="" id ="idimagedata{$FIELD_MODEL->getFieldName()}" type="hidden" />
	</div>
	<textarea name="jbase64" id="jbase64{$FIELD_MODEL->getFieldName()}"   maxlength='90000' style="display: none;"></textarea>
	<div id="img_preview"  ></div> 	 

	{foreach key=ITER item=IMAGE_INFO from=$JSIGN_DETAILS}		
		{assign var='imgpath' value="`$IMAGE_INFO.path`_`$IMAGE_INFO.name`"}
					{* $RECORD->get($FIELD_MODEL->getFieldName()) *}
		{if $IMAGE_INFO['path'] != '' &&  {$IMAGE_INFO['orgname']} != ''  && $imgpath == $FIELD_MODEL->get('fieldvalue')}
		<div class="row-fluid">
			<span class="span8" name="existingImages">
			<img src="{$IMAGE_INFO.path}_{$IMAGE_INFO.orgname}" data-image-id="{$IMAGE_INFO.id}"></span>
			<span class="span3 row-fluid">
				<span class="row-fluid">[{$IMAGE_INFO['name']}]</span>
				<span class="row-fluid">
				<input type="button" id="file_{$ITER}" value="Delete" class="signDelete"></span>
			</span>
		</div>
		{/if}
	{/foreach} 
{/strip}

 
 <script type="text/javascript">
 jQuery(document).ready(function() {
	var field_name = "{$FIELD_MODEL->getFieldName()}"; 
	jQuery("#signature"+field_name).jSignature();
	jQuery('#donebutton'+field_name).click(function() {
	var signatureCheck =  jQuery('#signature'+field_name).jSignature('getData', 'image');
    if (signatureCheck.length === 0) {		
		alert('Signature required.');
    } else {
		jQuery('#sigimage'+field_name).attr('src', jQuery('#signature'+field_name).jSignature('getData')); 
		jQuery('#sigimage'+field_name).show();
		var imagedata = jQuery('#signature'+field_name).jSignature('getData');
		jQuery('#idimagedata'+field_name).val(imagedata);
    }
  });
  jQuery('#clearbutton'+field_name).click(function () {
		jQuery('#signature'+field_name).jSignature('clear');
		jQuery('#signature'+field_name).show();
		jQuery('#sigimage'+field_name).hide();
    });	
	jQuery('.signDelete').click(function(element){
		var file_id = jQuery(this).id;
		var formElement = jQuery('#EditView');
		var recordId = formElement.find('input[name="record"]').val();		 
		var element = jQuery(this);	 
		var imageId = element.closest('div').find('img').data().imageId;
		console.log(element);
		element.closest('div').remove();
		//var exisitingImages = parentTd.find('[name="existingImages"]');		
		if(formElement.find('[name=imageid]').length != 0) {
			var imageIdValue = JSON.parse(formElement.find('[name=imageid]').val());
			imageIdValue.push(imageId);
			formElement.find('[name=imageid]').val(JSON.stringify(imageIdValue));
		} else {
			var imageIdJson = [];
			imageIdJson.push(imageId);
			formElement.append('<input type="hidden" name="signDeleted" value="true" />');
			formElement.append('<input type="hidden" name="imageid" value="'+JSON.stringify(imageIdJson)+'" />');
		} 
	});
   });
   </script>
 