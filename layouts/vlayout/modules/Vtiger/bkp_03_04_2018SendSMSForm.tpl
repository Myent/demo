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
<div id="sendSmsContainer" class='modelContainer'>
	<div class="modal-header contentsBackground">
        <button data-dismiss="modal" class="close" title="{vtranslate('LBL_CLOSE')}">&times;</button>
		<h3>{vtranslate('LBL_SEND_SMS_TO_SELECTED_NUMBERS', $MODULE)}</h3>
	</div>
	<form class="form-horizontal" id="massSave" method="post" action="index.php">
		<input type="hidden" name="module" value="{$MODULE}" />
		<input type="hidden" name="source_module" value="{$SOURCE_MODULE}" />
		<input type="hidden" name="action" value="MassSaveAjax" />
		<input type="hidden" name="viewname" value="{$VIEWNAME}" />
		<input type="hidden" name="selected_ids" value={ZEND_JSON::encode($SELECTED_IDS)}>
		<input type="hidden" name="excluded_ids" value={ZEND_JSON::encode($EXCLUDED_IDS)}>
        <input type="hidden" name="search_key" value= "{$SEARCH_KEY}" />
        <input type="hidden" name="operator" value="{$OPERATOR}" />
        <input type="hidden" name="search_value" value="{$ALPHABET_VALUE}" />
        <input type="hidden" name="search_params" value='{ZEND_JSON::encode($SEARCH_PARAMS)}' />
               
		<div class="modal-body tabbable">
			



			 <div class="row-fluid">

					<div class="span2">{vtranslate('LBL_STEP_1',$MODULE)}<span class="redColor">*</span></div>
					<div class="span8 row-fluid">
						<input type="text" class="span5 fields" data-validation-engine='validate[required]' name="sms_recepient" value="{$TASK_OBJECT->sms_recepient}" id="mob_no" required />
						<span class="span6">
							<select name="sel_mob_no" data-placeholder="{vtranslate('LBL_ADD_MORE_FIELDS',$MODULE)}" class="chzn-select task-fields" id="sel_mob_no" onchange="return change_val();">
					{foreach item=PHONE_FIELD from=$PHONE_FIELDS}
						{assign var=PHONE_FIELD_NAME value=$PHONE_FIELD->get('name')}
						<option value=",${$PHONE_FIELD_NAME}">
							{if !empty($SINGLE_RECORD)}
								{assign var=FIELD_VALUE value=$SINGLE_RECORD->get($PHONE_FIELD_NAME)}
							{/if}
							{vtranslate($PHONE_FIELD->get('label'), $SOURCE_MODULE)}{if !empty($FIELD_VALUE)} ({$FIELD_VALUE}){/if}
						</option>
					{/foreach}
					
							</select>	
						</span>
					</div>
				</div>
			    <br />
			<div class="row-fluid">
					<div class="span2">{vtranslate('LBL_STEP_2',$MODULE)}</div>
					<div class="span10">
						<select class="chzn-select task-fieldse" name="fild_name" data-placeholder="{vtranslate('LBL_ADD_MORE_FIELDS',$MODULE)}" id="fild_name" onchange="return messchange();">
							{foreach item=NAME_FIELD from=$NAME_FIELDS}
						{assign var=NAME_FIELD_NAME value=$NAME_FIELD->get('name')}
						<option value="${$NAME_FIELD_NAME}">
							{if !empty($SINGLE_NAME_RECORD)}
								{assign var=FIELD_VALUE value=$SINGLE_NAME_RECORD->get($NAME_FIELD_NAME)}
							{/if}
							{vtranslate($NAME_FIELD->get('label'), $SOURCE_MODULE)}{if !empty($FIELD_VALUE)} ({$FIELD_VALUE}){/if}
						</option>
					{/foreach}
						</select>	
					</div>
				<br />


		<div class="row-fluid" style="margin-top:15px">
			<div class="span2">{vtranslate('LBL_STEP_3',$MODULE)}</div>
			<textarea name="message" class="span8 fieldse" id="mess_box" required >{$TASK_OBJECT->content}</textarea>
		</div>
	</div>
    <br />










			
		</div>
		<div class="modal-footer">
			<div class=" pull-right cancelLinkContainer">
				<a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $MODULE)}</a>
			</div>
			<button class="btn btn-success" type="submit" name="saveButton"><strong>{vtranslate('LBL_SEND', $MODULE)}</strong></button>
		</div>
	</form>
</div>
{/strip}
