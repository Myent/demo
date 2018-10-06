{strip}

<meta name="viewport" content="width=device-width, initial-scale=1">
 <style>
 .listViewPageDiv{
	   margin: 0px;
 }
 .contentsDiv{
	 min-height:0px !important;
 }
 .container-bg {
    height: 513px;
    overflow: hidden;
}
.bodyContents{
min-height:0px!important;
}
.mainContainer {
min-height:0px!important;
}

 /*iframe{
	overflow-x: hidden;
    height: 564px;
    width: 100%;
 }*/
 </style> 
<iframe id="iframeSize" style="width:100%;overflow-x:hidden;" src="{$SITE_URL}modules/OS2Chat/webrtc/" class="embed-responsive embed-responsive-16by9 listViewPageDiv container" style='overflow-x: hidden;'  frameborder="0">
	  <p>Your browser does not support iframes.</p>
</iframe>
 
 <script type="text/javascript">
 	jQuery(document).ready(function(){
		var width = jQuery( document ).width() - 15;
		var height = jQuery( document ).height() - 120;

		jQuery("#iframeSize").css("height",height);
		/*jQuery("#iframeSize").css("width",width);*/

 	});
 </script>
{/strip}
 