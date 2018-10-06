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
<div class="widget_header row-fluid">
   <div class="span6">
      <h3>Preview</h3>
   </div>
</div>
<hr/>

 
<div class="container-fluid">
	<div class="contents">
	<form action="index.php?module=LoginPage&parent=Settings&action=LoginpageAjax&mode=save&name={$PAGE}&old_record={$old_record}&record={$record}"  method="post">
	    <button type="submit" class="btn btn-success pull-right" name="generate"  id="save" ><strong>Save</strong></button>
	</form>
    <a href="index.php?module=LoginPage&parent=Settings&view=NewTheme&name={$PAGE}&record={$record}"><button class="btn btn-success pull-right" name="back" ><strong>Back</strong></button></a>
    <a target="_blank" href="{$P_URL}">
            <button class="btn btn-success pull-right" name="back" ><strong>Preview in new tab</strong></button>
        </a>
    
    <br>
    <div width="100%">
           
 

<iframe sandbox="allow-same-origin allow-scripts allow-popups allow-forms" src="{$P_URL}"    style="border: 1; width:1030px; height:520px;"></iframe>
        
        

</div>
	     	 
		
	</div> 
{/strip}
