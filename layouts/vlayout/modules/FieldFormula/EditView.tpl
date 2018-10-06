{*/* ********************************************************************************
* The content of this file is subject to the Table Block ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}

{strip}
    <div id="massEditContainer">
        <div id="massEdit">
            <div class="modal-header contentsBackground">
                <button type="button" class="close " data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 id="massEditHeader">{if $RECORD}{vtranslate('LBL_EDIT')}{else}{vtranslate('LBL_ADD')}{/if} {vtranslate('FieldFormula', 'FieldFormula')}</h3>
            </div>
            <form class="form-horizontal" action="index.php" id="tableblocks_form">
                <input type="hidden" name="record" value="{$RECORD}" />

                <div name='massEditContent' class="row-fluid">
                    <div class="modal-body" style="margin-left: -38px;">
                        <div class="control-group">
                            <label class="muted control-label">
                                &nbsp;<strong>{vtranslate('LBL_MODULE', 'FieldFormula')}</strong>
                            </label>
                            <div class="controls row-fluid">
                                <select class="select2 span4" name="select_module" id="select_module" data-validation-engine='validate[required]]'>
                                    {foreach item=MODULE from=$SUPPORTED_MODULES name=moduleIterator}
                                        <option value="{$MODULE}" {if $MODULE eq $BLOCK_DATA['module']}selected{/if}>
                                            {vtranslate($MODULE, $MODULE)}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="muted control-label">
                                &nbsp;<strong>{vtranslate('LBL_NAME', 'FieldFormula')}</strong>
                            </label>
                            <div class="controls row-fluid">
                                  <input type="text" name="name" value="{$BLOCK_DATA['name']}" class="span3"   style="width: 216px;" />
                            </div>
                        </div>        
                        <div class="control-group">
                            <label class="muted control-label">
                                &nbsp;<strong>{vtranslate('LBL_ACTIVE', 'FieldFormula')}</strong>
                            </label>
                            <div class="controls row-fluid">
                                <select class="select2 span4" name="status">
                                    <option value="1" {if $BLOCK_DATA['status'] eq '1'}selected{/if}>{vtranslate('LBL_YES')}</option>
                                    <option value="0" {if $BLOCK_DATA['status'] eq '0'}selected{/if}>{vtranslate('LBL_NO')}</option>
                                </select>
                            </div>
                        </div>  
                        <div class="control-group" id="div_field">
                            {include file='InsertFields.tpl'|@vtemplate_path:$QUALIFIED_MODULE} 
                        </div>        
                        
                        <div class="control-group">
                            <label class="muted control-label">
                                <span class="redColor">*</span><strong>{vtranslate('LBL_FORMULA', 'FieldFormula')}</strong>
                            </label>
                            <div class="controls row-fluid">
                                <textarea name="formula" id="formula" data-validation-engine='validate[required]' style ="width:77%;">{vtranslate($BLOCK_DATA['formula'], $SELECTED_MODULE_NAME)}</textarea>
                            </div>    
                            
                        </div>
                        <div class="control-group">
                             <div class="controls row-fluid">
                                 <span>
                                    {vtranslate('LBL_INTRO', 'FieldFormula')}
                                 </span>
                            </div>  
                           
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-right cancelLinkContainer" style="margin-top:0px;">
                        <a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                    </div>
                    <button class="btn btn-success" type="submit" name="saveButton"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
                </div>
            </form>
        </div>
    </div>
{/strip}