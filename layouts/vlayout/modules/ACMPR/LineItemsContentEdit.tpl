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

   <td>
      <i class="icon-trash deleteRow cursorPointer" title="{vtranslate('LBL_DELETE',$MODULE)}"></i>
      &nbsp;<a><img class="draganddrop"  src="{vimage_path('drag.png')}" border="0" title="{vtranslate('LBL_DRAG',$MODULE)}"/></a>
      <input type="hidden" class="rowNumber" value="{$row_no}" />
   </td>
   <td>
     <textarea name="accountname{$row_no}" id="accountname{$row_no}">{$data.accountname}</textarea>
     <!-- <div>
	  <!-- data-validation-engine="validate[required]"
         <input type="text" id="accountname{$row_no}" name="accountname{$row_no}" value="{$data.displayname}" data-validation-engine="validate[required]" class="accountname {if $row_no neq 0} autoComplete {/if}" placeholder="{vtranslate('LBL_TYPE_SEARCH',$MODULE)}" {if !empty($data.displayname)} disabled="disabled" {/if}/>
         <input type="hidden" id="accountid{$row_no}" name="accountid{$row_no}" value="{$data.accountid}" class="selectedModuleId"/>

         <img class="lineItemPopup cursorPointer alignMiddle" data-popup="Popup" data-module-name="Accounts" title="{vtranslate('Accounts',$MODULE)}" data-field-name="accountid{$row_no}" src="{vimage_path('Products.png')}"/> 
         &nbsp;<i class="icon-remove-sign clearLineItem cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i> 
      </div-->
   </td>
   <td>
      <textarea name="activities{$row_no}" id="activities{$row_no}">{$data.activities}</textarea>
   </td>
   <td>
      <textarea name="substance{$row_no}" id="substance{$row_no}">{$data.substance}</textarea>
   </td>
{/strip}