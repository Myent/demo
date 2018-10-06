{*/* ********************************************************************************
* The content of this file is subject to the Table Block ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}

<div>
    <label class="muted control-label">
        &nbsp;<strong>{vtranslate('LBL_FORMULA_FIELD',$QUALIFIED_MODULE)}</strong>
    </label>
    <div class="controls row-fluid" style="width: 433px;">
        <select class="select2 span5" id="formula_field_cb" name="formula_field_cb">
            {foreach from=$FIELDS key=FIELD_LBL item=BLOCK}
                <option value="{Vtiger_Util_Helper::toSafeHTML($FIELD_LBL)}" {if {Vtiger_Util_Helper::toSafeHTML($FIELD_LBL)} eq $BLOCK_DATA['formula_field']}selected{/if}>
                                            {vtranslate($FIELD_LBL,$SELECTED_MODULE_NAME)}</option>
            {/foreach}
        </select>
    </div>
</div>