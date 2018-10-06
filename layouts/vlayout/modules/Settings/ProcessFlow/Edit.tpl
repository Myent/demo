{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
{strip}
   
<div class="container-fluid">
	<div class="contents">
		 <!--<iframe src="{$site_URL}modules/Settings/ProcessFlow/diagramo/editor/myDiagrams.php" style="width: 1094px;height:1200px;" id="iframeDiagram" >-->
		 <iframe src="{$site_URL}/modules/Settings/ProcessFlow/gojs/index.php" style="width:100%;height:1200px;border:none;" id="iframeDiagram" >
			<p>Your browser does not support iframes.</p>
		</iframe>
	</div>
</div>

<script>
/*
$(window).on('resize',function() {   
  $('.contents').height($(window).height()-250);
});
 $('.contents').height($(window).height()-250); */ 
</script>
{/strip}

