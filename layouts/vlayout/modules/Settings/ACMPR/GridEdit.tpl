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
      <input type="hidden" class="rowNumber" name="rowNumber{$row_no}" value="{$row_no}" />
   </td>
   <td>
     <textarea name="accountname{$row_no}" id="accountname{$row_no}">{$data.accountname}</textarea>
   </td>
   <td>
      <textarea name="activities{$row_no}" id="activities{$row_no}">{$data.activities}</textarea>
   </td>
   <td>
      <textarea name="substance{$row_no}" id="substance{$row_no}">{$data.substance}</textarea>
   </td>
{/strip}