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
	<form class="form-horizontal eventEditView" id="event_step3" method="post" action="index.php">
		<input type="hidden" name="module" value="{$MODULE}" />
		<input type="hidden" name="action" value="Save" />
		<input type="hidden" name="moduleclass" value="Events" />
	
		<input type="hidden" name="record" value="{$RECORD_ID}" />
		<input type="hidden" name="isDuplicate" value="{$IS_DUPLICATE}" />
		{if !empty($PICKIST_DEPENDENCY_DATASOURCE)}
			<input type="hidden" name="picklistDependency" value='{Vtiger_Util_Helper::toSafeHTML($PICKIST_DEPENDENCY_DATASOURCE)}' />
		{/if}
		{assign var=QUALIFIED_MODULE_NAME value={$MODULE}}
		{assign var=IS_PARENT_EXISTS value=strpos($MODULE,":")}
		{if $IS_PARENT_EXISTS}
			{assign var=SPLITTED_MODULE value=":"|explode:$MODULE}
			<input type="hidden" name="module" value="{$SPLITTED_MODULE[1]}" />
			<input type="hidden" name="parent" value="{$SPLITTED_MODULE[0]}" />
		{else}
			<input type="hidden" name="module" value="{$MODULE}" />
		{/if}
		<input type="hidden" name="defaultCallDuration" value="{$USER_MODEL->get('callduration')}" />
		<input type="hidden" name="defaultOtherEventDuration" value="{$USER_MODEL->get('othereventduration')}" />
		{if $IS_RELATION_OPERATION }
			<input type="hidden" name="sourceModule" value="{$SOURCE_MODULE}" />
			<input type="hidden" name="sourceRecord" value="{$SOURCE_RECORD}" />
			<input type="hidden" name="relationOperation" value="{$IS_RELATION_OPERATION}" />
		{/if}
		
		<input type="hidden" name="subject" value="{$RECORD_MODEL->get('subject')}" />
		<input type="hidden" name="mode" value="{if $RECORD_ID}edit{/if}" />
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
		
		<!-- Step2 related fields -->
		<input type="hidden" name="popupReferenceModule" value="{$RECORD_MODEL->get('popupReferenceModule')}" />
		<input type="hidden" name="contact_id_display" value="{$RECORD_MODEL->get('contact_id_display')}" />
		<input type="hidden" name="relatedContactInfo" value="{$RECORD_MODEL->get('relatedContactInfo')}" />
		<input type="hidden" name="parent_id" value="{$RECORD_MODEL->get('parent_id')}" />
		<input type="hidden" name="parent_id_display" value="{$RECORD_MODEL->get('parent_id_display')}" />
		<input type="hidden" name="description" value="{$RECORD_MODEL->get('description')}" />
		<input type="hidden" name="userChangedEndDateTime" value="{$RECORD_MODEL->get('userChangedEndDateTime')}" />
		
		<input type="hidden" name="contactidlist" value="{$RECORD_MODEL->get('contactidlist')}" />
		<input type="hidden" name="inviteesid" value="{$RECORD_MODEL->get('inviteesid')}" />
		<input type="hidden" name="selectedusers" value='{ZEND_JSON::encode($RECORD_MODEL->get("selectedusers"))}' />
		
		<!-- Step2 ended here -->
		<input type="hidden" class="step" value="3" />
<!-- New Custom Fields -->
<input type="hidden" name="invoiceid" value="{$RECORD_MODEL->get('invoiceid')}" />
		<input type="hidden" name="duration_seconds" value="{$RECORD_MODEL->get('duration_seconds')}" />
		<input type="hidden" name="cf_activityid" value="{$RECORD_MODEL->get('cf_activityid')}" />
<!-- Ended Here -->
		<div class="padding1per contentsBackground">
			The following users and contacts are invited for event created.
			<br/>
			<b>Users:</b>
			<ul>
			{foreach from=$EVENTUSERS key=key item=item}
				
				{foreach from=$item key=k item=i}
					<li>{$i}</li>
				{/foreach}
			{/foreach}
			</ul>
			<b>Contacts:</b>
			<ul>
			{foreach from=$EVENTCONTACTS key=key item=item}
				{foreach from=$item key=k item=i}
					<li>{$i}</li>
				{/foreach}
			{/foreach}
			</ul>
		</div>
		<br>
		<div class="pull-right block">
			<button type="button" class="btn btn-danger backStep"><strong>{vtranslate('LBL_BACK',$MODULE)}</strong></button>&nbsp;&nbsp;
			<button type="submit" class="btn btn-success" id="generateReport"><strong>{vtranslate('LBL_SAVE',$MODULE)}</strong></button>&nbsp;&nbsp;
			<a  class="cancelLink" onclick="window.history.back()">{vtranslate('LBL_CANCEL',$MODULE)}</a>&nbsp;&nbsp;
		</div>
	</form>
{/strip}
