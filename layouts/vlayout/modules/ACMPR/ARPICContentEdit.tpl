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
      <i class="icon-trash arpicdeleteRow cursorPointer" title="{vtranslate('LBL_DELETE',$MODULE)}"></i>
      &nbsp;<a><img class="draganddrop"  src="{vimage_path('drag.png')}" border="0" title="{vtranslate('LBL_DRAG',$MODULE)}"/></a>
      <input type="hidden" class="arpicrow" id="arpicrow{$arpic_no}" value="{$arpic_no}" />
   </td>
   <td>
    <div>
	 <input type="text" id="arpicname{$arpic_no}" name="arpicname{$arpic_no}" value="{$data.arpicname}" class="arpicname {if $arpic_no neq 0} autoapricComplete {/if}" placeholder="{vtranslate('LBL_TYPE_SEARCH',$MODULE)}" {if !empty($data.arpicname)} disabled="disabled" {/if}/>
	 <input type="hidden" id="arpicid{$arpic_no}" name="arpicid{$arpic_no}" value="{$data.contactid}" class="arpicid"/>
	 <img class="arpicItemPopup cursorPointer alignMiddle" data-popup="Popup" data-module-name="Contacts" title="{vtranslate('Contacts',$MODULE)}" data-field-name="arpicid{$arpic_no}" src="{vimage_path('Products.png')}"/> 
	 &nbsp;<i class="icon-remove-sign clearArpicItem cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i> 
  </div>
   </td>
   <td>
      <input name="surname{$arpic_no}" id="surname{$arpic_no}"  class="smallInputBox" readonly value="{$data.surname}"/>
   </td>
   <td>
      <input name="givenname{$arpic_no}" id="givenname{$arpic_no}" class="smallInputBox" readonly value="{$data.givenname}" />
   </td>
   <td>
      <input name="gendar{$arpic_no}" id="gendar{$arpic_no}"  class="smallInputBox" readonly  value="{$data.gendar}" />
   </td>
    <td>
      <input name="dateofbirth{$arpic_no}" id="dateofbirth{$arpic_no}"  class="smallInputBox" readonly  value="{$data.dateofbirth}" />
	  <br/>(yyyy-mm-dd)
   </td>
   <td>
      <input name="ranking{$arpic_no}" id="ranking{$arpic_no}"  class="smallInputBox" readonly  value="{$data.ranking}" />
   </td>
   <td>
      <input name="whdays{$arpic_no}" id="whdays{$arpic_no}"   class="smallInputBox" readonly value="{$data.whdays}" />
   </td>
    <td>
      <input name="othertitle{$arpic_no}" id="othertitle{$arpic_no}"  class="smallInputBox" readonly   class="smallInputBox" readonly  value="{$data.othertitle}" />
   </td>
{/strip}