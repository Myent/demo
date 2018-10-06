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
      <!-- <div class="row-fluid">
            <div class="pull-right">
                  <button class="btn btn-success" type="submit"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
                  <a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                </div>
		 
        </div>-->
		 
    </form>
    
    <input type="hidden" id="idIsVessels" value="{$PROCESSMASTER_JSON_DATA['is_vessels']}">
    <input type="hidden" id="idIsTools" value="{$PROCESSMASTER_JSON_DATA['is_tools']}">
    <input type="hidden" id="idIsMachinery" value="{$PROCESSMASTER_JSON_DATA['is_machinery']}">
</div>
{/strip}