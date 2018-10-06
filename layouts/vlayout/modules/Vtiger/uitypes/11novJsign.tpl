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

<script src="libraries/jquery/jSignature-master/libs/jquery.js"></script>
<script src="libraries/jquery/jSignature-master/src/jSignature.js"></script>
<script src="libraries/jquery/jSignature-master/src/plugins/jSignature.CompressorBase30.js"></script>

<style type="text/css">

	 
	
	#signatureparent {
		color:darkblue;
		background-color:darkgrey;
		/*max-width:600px;*/
		padding:20px;
		
	}
	
	/*This is the div within which the signature canvas is fitted*/
	#signature,.signatureclass {
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
	
	 
</style>
{if $MODULE eq 'Project'}
<div id="{$FIELD_MODEL->getFieldName()}" class="signatureclass" data-fieldid="{$FIELD_MODEL->getFieldName()}" ></div>
 <img id="sigimage{$FIELD_MODEL->getFieldName()}">
 <div style="display: inline-block;">
<p><input id="donebutton{$FIELD_MODEL->getFieldName()}" type="button" value="Done">
<input id="clearbutton{$FIELD_MODEL->getFieldName()}" type="button" value="Clear"></p>
</div>
<textarea name="{$FIELD_MODEL->getFieldName()}" id="jbase64{$FIELD_MODEL->getFieldName()}"   maxlength='90000' style="display: none;"></textarea>

				<div id="img_preview"  ></div>{foreach key=ITER item=IMAGE_INFO from=$JSIGN_DETAILS}
		<div class="row-fluid">
			{if !empty($IMAGE_INFO.path) && !empty({$IMAGE_INFO.orgname}) && $IMAGE_INFO.subject == $FIELD_MODEL->getFieldName()}
				<span class="span8" name="existingImages"><img src="{$IMAGE_INFO.path}{$IMAGE_INFO.name}" data-image-id="{$IMAGE_INFO.id}"></span>
				<span class="span3 row-fluid">
					<span class="row-fluid">[{$IMAGE_INFO.orgname}]</span>
					<span class="row-fluid"><input type="button" id="file_{$ITER}" value="Delete" class="signDelete"></span>
				</span>
			{/if}
		</div>{/foreach}
{else}
<div id="signature" ></div>

 <img id="sigimage">
 <div style="display: inline-block;">
<p><input id="donebutton" type="button" value="Done"> <input id="clearbutton" type="button" value="Clear"></p>
</div>
<textarea name="jbase64" id="jbase64"   maxlength='90000' style="display: none;"></textarea>

				<div id="img_preview"  ></div>{foreach key=ITER item=IMAGE_INFO from=$JSIGN_DETAILS}
		<div class="row-fluid">
			{if !empty($IMAGE_INFO.path) && !empty({$IMAGE_INFO.orgname})}
				<span class="span8" name="existingImages"><img src="{$IMAGE_INFO.path}_{$IMAGE_INFO.orgname}" data-image-id="{$IMAGE_INFO.id}"></span>
				<span class="span3 row-fluid">
					<span class="row-fluid">[{$IMAGE_INFO.name}]</span>
					<span class="row-fluid"><input type="button" id="file_{$ITER}" value="Delete" class="signDelete"></span>
				</span>
			{/if}
		</div>{/foreach}
{/if}
   {/strip}
 {if $MODULE neq 'Project'}
 <script type="text/javascript">
 $(document).ready(function() {

    $("#signature").jSignature();
   $('#donebutton').click(function() {
    var signatureCheck =  $('#signature').jSignature('getData', 'image');
    if (signatureCheck.length === 0) {
      alert('Signature required.');
    } else {
      $('#sigimage').attr('src', $('#signature').jSignature('getData'));

  
    $('#sigimage').show();

    }
  });
  $('#clearbutton').click(function () {
	$('#signature').jSignature('clear');
    $('#signature').show();
    $('#sigimage').hide();
	$('#Field74').hide();
    });
 
   });
   </script>
{/if}