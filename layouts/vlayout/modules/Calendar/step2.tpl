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
	<form class="form-horizontal eventEditView" id="event_step2" method="post" action="index.php">
		<input type="hidden" name="module" value="{$MODULE}" />
		<input type="hidden" name="view" value="Edit" />
		<input type="hidden" name="mode" value="step3" />
		<input type="hidden" name="moduleclass" value="Events" />
		<input type="hidden" name="record" value="{$RECORD_ID}" />
		<input type="hidden" name="subject" value="{$RECORD_MODEL->get('subject')}" />
		<input type="hidden" name="date_start" value="{$RECORD_MODEL->get('date_start')}" />
		<input type="hidden" name="assigned_user_id" value="{$RECORD_MODEL->get('assigned_user_id')}" />
		<input type="hidden" name="time_start" value="{$RECORD_MODEL->get('time_start')}" />
		<input type="hidden" name="due_date" value="{$RECORD_MODEL->get('due_date')}" />
		<input type="hidden" name="time_end" value="{$RECORD_MODEL->get('time_end')}" />
		<input type="hidden" name="eventstatus" value="{$RECORD_MODEL->get('eventstatus')}" />
		<input type="hidden" name="sendnotification" value="{$RECORD_MODEL->get('sendnotification')}" />
		<input type="hidden" name="activitytype" value="{$RECORD_MODEL->get('activitytype')}" />
		<input type="hidden" name="location" value="{$RECORD_MODEL->get('location')}" />
		<input type="hidden" name="taskpriority" value="{$RECORD_MODEL->get('taskpriority')}" />
		<input type="hidden" name="visibility" value="{$RECORD_MODEL->get('visibility')}" />
		<input type="hidden" name="followup_date_start" value="{$RECORD_MODEL->get('followup_date_start')}" />
		<input type="hidden" name="followup_time_start" value="{$RECORD_MODEL->get('followup_time_start')}" />
		<input type="hidden" name="followup" value="{$RECORD_MODEL->get('followup')}" />
		<!-- second Block -->
		<input type="hidden" name="set_reminder" value="{$RECORD_MODEL->get('set_reminder')}" />
		<input type="hidden" name="remdays" value="{$RECORD_MODEL->get('remdays')}" />
		<input type="hidden" name="remhrs" value="{$RECORD_MODEL->get('remhrs')}" />
		<input type="hidden" name="remmin" value="{$RECORD_MODEL->get('remmin')}" />
		
		<!-- Thrid Block -->
		<input type="hidden" name="recurringcheck" value="{$RECORD_MODEL->get('recurringcheck')}" />
		<input type="hidden" name="repeat_frequency" value="{$RECORD_MODEL->get('repeat_frequency')}" />
		<input type="hidden" name="recurringtype" value="{$RECORD_MODEL->get('recurringtype')}" />
		<input type="hidden" name="calendar_repeat_limit_date" value="{$RECORD_MODEL->get('calendar_repeat_limit_date')}" />
		
		<input type="hidden" name="sun_flag" value="{$RECORD_MODEL->get('sun_flag')}" />
		<input type="hidden" name="mon_flag" value="{$RECORD_MODEL->get('mon_flag')}" />
		<input type="hidden" name="tue_flag" value="{$RECORD_MODEL->get('tue_flag')}" />
		<input type="hidden" name="wed_flag" value="{$RECORD_MODEL->get('wed_flag')}" />
		<input type="hidden" name="thu_flag" value="{$RECORD_MODEL->get('thu_flag')}" />
		<input type="hidden" name="fri_flag" value="{$RECORD_MODEL->get('fri_flag')}" />
		<input type="hidden" name="sat_flag" value="{$RECORD_MODEL->get('sat_flag')}" />
		
		<input type="hidden" name="repeatMonth" value="{$RECORD_MODEL->get('repeatMonth')}" />
		<input type="hidden" name="repeatMonth_date" value="{$RECORD_MODEL->get('repeatMonth_date')}" />
		<input type="hidden" name="repeatMonth_daytype" value="{$RECORD_MODEL->get('repeatMonth_daytype')}" />
		<input type="hidden" name="repeatMonth_day" value="{$RECORD_MODEL->get('repeatMonth_day')}" />
		
		
		<input type="hidden" name="isDuplicate" value="{$IS_DUPLICATE}" />
		<input type="hidden" class="step" value="2" />
		<div class="well padding1per contentsBackground">
		{foreach key=BLOCK_LABEL item=BLOCK_FIELDS from=$RECORD_STRUCTURE name="EditViewBlockLevelLoop"}
            {if $BLOCK_FIELDS|@count lte 0}{continue}{/if}
			{if $BLOCK_LABEL neq 'LBL_EVENT_INFORMATION' &&  $BLOCK_LABEL neq 'LBL_REMINDER_INFORMATION' && $BLOCK_LABEL neq 'LBL_RECURRENCE_INFORMATION'}
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
        {/foreach}
		{* adding additional column for odd number of fields in a block *}
		{if $BLOCK_FIELDS|@end eq true and $BLOCK_FIELDS|@count neq 1 and $COUNTER eq 1}
			<td class="fieldLabel {$WIDTHTYPE}"></td><td class="{$WIDTHTYPE}"></td>
		{/if}
    </tr>
</tbody>
</table>
<br/>
{/if}
{/foreach}
			<input type="hidden" name="userChangedEndDateTime" value="{$USER_CHANGED_END_DATE_TIME}" />
    <table class="table table-bordered blockContainer showInlineTable">
        <tr>
            <th class="blockHeader" colspan="4">{vtranslate('LBL_INVITE_USER_BLOCK', $MODULE)}</th>
        </tr>
        <tr>
            <td class="fieldLabel">
                <label class="muted pull-right marginRight10px">
                    {vtranslate('LBL_INVITE_USERS', $MODULE)}
                </label>
            </td>
            <td class="fieldValue">
                <select id="selectedUsers" class="select2" multiple name="selectedusers[]" style="width:200px;">
                    {foreach key=USER_ID item=USER_NAME from=$ACCESSIBLE_USERS}
                        {if $USER_ID eq $CURRENT_USER->getId()}
                            {continue}
                        {/if}
                        <option value="{$USER_ID}" {if in_array($USER_ID,$INVITIES_SELECTED)}selected{/if}>
                            {$USER_NAME}
                        </option>
                    {/foreach}
                    <select>
                        </td>
                        </tr>
                        </table>
                        <br>
						<input type="hidden" id="nousers" value=""/>
						<input type="hidden" id="assignedtouserstatus" value=""/>
						<table class="table table-bordered blockContainer showInlineTable" id="finalusers">
        <tr>
            <th class="blockHeader" >Invitees</th>
			<th>TimeZone</th>
			<th>Availability</th>
			<th> Actions </th>
			</tr>
			<tbody id="inviteedata">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</tbody>
			</table>
		</div>
		<div class="pull-right block">
			<button type="button" class="btn btn-danger backStep"><strong>{vtranslate('LBL_BACK',$MODULE)}</strong></button>&nbsp;&nbsp;
			<button type="submit" class="btn btn-success nextStep"><strong>{vtranslate('LBL_NEXT',$MODULE)}</strong></button>&nbsp;&nbsp;
			<a class="cancelLink" onclick="window.history.back()">{vtranslate('LBL_CANCEL',$MODULE)}</a>
		<br>
		</div>
		<br><br>
	</form>
{/strip}