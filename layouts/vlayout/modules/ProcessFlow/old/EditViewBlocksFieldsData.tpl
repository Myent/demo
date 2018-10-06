{foreach key=BLOCK_LABEL item=BLOCK_FIELDS from=$RECORD_STRUCTURE name="EditViewBlockLevelLoop"}            
{if $BLOCK_FIELDS|@count lte 0}{continue}{/if} 
<table class="table table-bordered blockContainer showInlineTable equalSplit">
<thead>
<tr>
    <th class="blockHeader" colspan="4">{vtranslate($BLOCK_LABEL, $MODULE)}</th>
</tr>
</thead>
<tbody>  
    <tr>
        {assign var=COUNTER value=0}         
        {foreach key=FIELD_NAME item=FIELD_MODEL from=$BLOCK_FIELDS name=blockfields}
             {assign var="isReferenceField" value=$FIELD_MODEL->getFieldDataType()}
                {if $FIELD_MODEL->get('uitype') eq "20" or $FIELD_MODEL->get('uitype') eq "19"}
                    {if $COUNTER eq '1'}
                        <td class="{$WIDTHTYPE}"></td><td class="{$WIDTHTYPE}"></td>
                    </tr>
                    <tr>
                        {assign var=COUNTER value=0}
                    {/if}
                {/if}
                {if $COUNTER eq 2}
                </tr>
                <tr>
                    {assign var=COUNTER value=1}
                {else}
                    {assign var=COUNTER value=$COUNTER+1}
                {/if}

            {if $FIELD_NAME == 'operating_mode'  }
            <input type='hidden' name='{$FIELD_NAME}' id="{$FIELD_NAME}" value="Relaxed"> 
            {elseif $FIELD_NAME == 'processmasterid'  }
                    <input type='hidden' name='{$FIELD_NAME}' id="{$FIELD_NAME}" value="{$FIELD_MODEL->get('fieldvalue')}"> 
                    {* Start Product Details, Date : feb 6th 2018, Dev:Anjaneya *} 				 
                
                    <td class="fieldLabel medium"><label class="muted pull-right marginRight10px"><span class="redColor">*</span> Process Master</label></td>
                    <td class="fieldValue medium">
                        {* data-validation-engine="" data-fieldinfo='' *}
                        <select class="chzn-select"  id="idProcessmasterid" >
                            <option value="">{vtranslate('LBL_SELECT_OPTION','Vtiger')}</option>
                        {foreach item=PMNAME key=PMID from=$PROCESS_MASTER_LIST}
                            <option value="{$PMID}" {if $PMID eq $REFERENCED_MODULE_NAME} selected {/if} >{$PMNAME}</option>
                        {/foreach}
                        </select>
                    </td>
                    
                 							
                {* End Product Details *} 
            
            {elseif $FIELD_NAME == 'end_product_category'}
                <input type='hidden' name='{$FIELD_NAME}' id="{$FIELD_NAME}" value="{$FIELD_MODEL->get('fieldvalue')}"> 
                {* Start raw_materials, Date : Apr 16th 2018, Dev:Anjaneya *} 				 
               
                    <td class="fieldLabel medium"><label class="muted pull-right marginRight10px">{vtranslate($FIELD_MODEL->get('label'), $MODULE)}</label></td>
                    <td class="fieldValue medium">
                        {* data-validation-engine="" data-fieldinfo='' *}
                        
                        {assign var=parray value=","|explode:$FIELD_MODEL->get('fieldvalue')}
                        <select class="chzn-select"  id="id_end_product_category"  >
                            <option value="">{vtranslate('LBL_SELECT_OPTION','Vtiger')}</option>
                        {foreach item=PNAME key=PID from=$PRODUCTS_CATEGORY_LIST}
                            <option value="{$PID}" {if $PID|in_array:$parray} selected {/if} >{$PNAME}</option>
                        {/foreach}
                        </select>
                    </td>
                     							
                {* End raw_materials *} 
            {else} 
               
                <td class="fieldLabel {$WIDTHTYPE}">
                    {if $isReferenceField neq "reference"}<label class="muted pull-right marginRight10px">{/if}
                    {if $FIELD_MODEL->isMandatory() eq true && $isReferenceField neq "reference"} <span class="redColor">*</span> {/if}
                    {if $isReferenceField eq "reference"}
                        {assign var="REFERENCE_LIST" value=$FIELD_MODEL->getReferenceList()}
                        {assign var="REFERENCE_LIST_COUNT" value=count($REFERENCE_LIST)}
                        {if $REFERENCE_LIST_COUNT > 1}
                            {assign var="DISPLAYID" value=$FIELD_MODEL->get('fieldvalue')}
                            {assign var="REFERENCED_MODULE_STRUCT" value=$FIELD_MODEL->getUITypeModel()->getReferenceModule($DISPLAYID)}
                            {if !empty($REFERENCED_MODULE_STRUCT)}
                                {assign var="REFERENCED_MODULE_NAME" value=$REFERENCED_MODULE_STRUCT->get('name')}
                            {/if}
                            <span class="pull-right">
                            {if $FIELD_MODEL->isMandatory() eq true} <span class="redColor">*</span> {/if}
                           
                            <select id="{$MODULE}_editView_fieldName_{$FIELD_MODEL->getName()}_dropDown" class="chzn-select referenceModulesList streched" style="width:160px;">
                                <optgroup>
                                    {foreach key=index item=value from=$REFERENCE_LIST}
                                        <option value="{$value}" {if $value eq $REFERENCED_MODULE_NAME} selected {/if}>{vtranslate($value, $MODULE)}</option>
                                    {/foreach}
                                </optgroup>
                            </select>
                        </span>
                    {else}
                        <label class="muted pull-right marginRight10px">{if $FIELD_MODEL->isMandatory() eq true} <span class="redColor">*</span> {/if}{vtranslate($FIELD_MODEL->get('label'), $MODULE)}</label>
                    {/if}
                {else if $FIELD_MODEL->get('uitype') eq "83"}
                    {include file=vtemplate_path($FIELD_MODEL->getUITypeModel()->getTemplateName(),$MODULE) COUNTER=$COUNTER MODULE=$MODULE}
                {else}
                    {vtranslate($FIELD_MODEL->get('label'), $MODULE)}
                {/if}
            {if $isReferenceField neq "reference"}</label>{/if}
        </td>
        {if $FIELD_MODEL->get('uitype') neq "83"}
        <td class="fieldValue {$WIDTHTYPE}" {if $FIELD_MODEL->get('uitype') eq '19' or $FIELD_MODEL->get('uitype') eq '20'} colspan="3" {assign var=COUNTER value=$COUNTER+1} {/if}>
            <div class="row-fluid">
                <span class="span10">
                    {include file=vtemplate_path($FIELD_MODEL->getUITypeModel()->getTemplateName(),$MODULE) BLOCK_FIELDS=$BLOCK_FIELDS}
                </span>
            </div>
        </td>
        {/if}
        {if $BLOCK_FIELDS|@count eq 1 and $FIELD_MODEL->get('uitype') neq "19" and $FIELD_MODEL->get('uitype') neq "20" and $FIELD_MODEL->get('uitype') neq "30" and $FIELD_MODEL->get('name') neq "recurringtype"}
        <td class="{$WIDTHTYPE}"></td><td class="{$WIDTHTYPE}"></td>
        {/if}
        {if $MODULE eq 'Events' && $BLOCK_LABEL eq 'LBL_EVENT_INFORMATION' && $smarty.foreach.blockfields.last }
            {include file=vtemplate_path('uitypes/FollowUp.tpl',$MODULE) COUNTER=$COUNTER}
        {/if}
            {/if}
        {/foreach}
            {* adding additional column for odd number of fields in a block *}
            {if $BLOCK_FIELDS|@end eq true and $BLOCK_FIELDS|@count neq 1 and $COUNTER eq 1}
                <td class="fieldLabel {$WIDTHTYPE}"></td><td class="{$WIDTHTYPE}"></td>
            {/if} 
        </tr>
        </tbody>
    </table> 
{/foreach} 