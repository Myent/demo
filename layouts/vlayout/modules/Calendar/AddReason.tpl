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
    <div class="modelContainer" style='min-width:350px;'>
        <div class="modal-header contentsBackground">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>{vtranslate('Reason to Reject Invitation', $MODULE)}</h3>
        </div>
        <form class="form-horizontal" id="addReasonReject" method="post" action="index.php">
            <input type="hidden" name="module" value="{$MODULE}" />
            <input type="hidden" name="action" value="ReasonReject" />
            <input type="hidden" name="mode" value="save" />
            <div class="modal-body">
                <div class="row-fluid">
                    <div class="control-group">
                        <div class="">
						<input type="hidden" name="eventrecordid" value="{$smarty.request.record}"/>
                            <textarea rows="1" class="input-xxlarge fieldValue span6" data-validation-engine="validate[required, funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" name="rejectreason" id="rejectreason"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            {include file='ModalFooter.tpl'|@vtemplate_path:$MODULE}
        </form>
    </div>
{/strip}