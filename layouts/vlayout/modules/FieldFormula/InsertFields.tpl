{*/* ********************************************************************************
* The content of this file is subject to the Table Block ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}
<table>
    <tr>
        <td>
            <div id="formula_field_cb">
                    <label class="muted control-label">
                        &nbsp;<strong>{vtranslate('LBL_FORMULA_FIELD',$QUALIFIED_MODULE)}</strong>
                    </label>
                    <div class="controls row-fluid">
                        <select class="select2" id="formula_field_cb" name="formula_field"  style="width: 225px;">
                            {foreach from=$FIELDS key=FIELD_LBL item=BLOCK}                                
                                <option value="{Vtiger_Util_Helper::toSafeHTML($FIELD_LBL)}" {if {Vtiger_Util_Helper::toSafeHTML($FIELD_LBL)} eq $BLOCK_DATA['formula_field']}selected{/if}>
                                                            {vtranslate($BLOCK ->get("label"),$SELECTED_MODULE_NAME)}</option>
                            {/foreach}
                        </select>
                    </div>
            </div>  
        </td>
        <td>
            <div id="fields" style="margin-left: -50px;">
                    <label class="muted control-label">
                        &nbsp;<strong>{vtranslate('LBL_INSERT_FIELD',$QUALIFIED_MODULE)}</strong>
                    </label>
                    <div class="controls row-fluid">
                        <select class="select2" id="field" name="field" style="width: 205px;">
                            {foreach from=$FIELDS key=FIELD_LBL item=BLOCK}
								 {assign var=FIELD_ACTIVE value=$BLOCK -> get('presence')}	
								 {if $FIELD_ACTIVE != 1}
                                       <option value="{Vtiger_Util_Helper::toSafeHTML($FIELD_LBL)}">{vtranslate($BLOCK ->get("label"),$SELECTED_MODULE_NAME)}</option>             
                                 {/if}                                
                            {/foreach}
                        </select>
                    </div>   
            </div>                                        
        </td>
    </tr>
</table>        