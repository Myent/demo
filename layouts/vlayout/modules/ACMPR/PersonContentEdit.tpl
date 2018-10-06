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
      <i class="icon-trash persondeleteRow cursorPointer" title="{vtranslate('LBL_DELETE',$MODULE)}"></i>
      &nbsp;<a><img class="draganddrop"  src="{vimage_path('drag.png')}" border="0" title="{vtranslate('LBL_DRAG',$MODULE)}"/></a>
      <input type="hidden" class="personrow" id="personrow{$person_no}" value="{$person_no}" />
   </td>
   <td>
    <div>
	 <input type="text" id="personname{$person_no}" name="personname{$person_no}" value="{$data.personname}" class="personname {if $person_no neq 0} autopersonComplete {/if}" placeholder="{vtranslate('LBL_TYPE_SEARCH',$MODULE)}" {if !empty($data.personname)} disabled="disabled" {/if}/>
	 <input type="hidden" id="personid{$person_no}" name="personid{$person_no}" value="{$data.contactid}" class="personid"/>
	 <img class="personItemPopup cursorPointer alignMiddle" data-popup="Popup" data-module-name="Contacts" title="{vtranslate('Contacts',$MODULE)}" data-field-name="personid{$person_no}" src="{vimage_path('Products.png')}"/> 
	 &nbsp;<i class="icon-remove-sign clearpersonItem cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i> 
  </div>
   </td>
   <td>
      <input name="surname{$person_no}" id="surname{$person_no}"  class="smallInputBox" readonly value="{$data.surname}"/>
   </td>
   <td>
      <input name="givenname{$person_no}" id="givenname{$person_no}" class="smallInputBox" readonly value="{$data.givenname}" />
   </td>
   <td>
      <input name="gendar{$person_no}" id="gendar{$person_no}"  class="smallInputBox" readonly  value="{$data.gendar}" />
   </td>
{/strip}