<td style="15px;">
	<input type="hidden" name="task_userid{$row_no}" id="task_userid{$row_no}" value="{$row_no}"/>
	<span id="task_username{$row_no}">{$USERS_LIST_INFO[$pt_taskdata['userid']]}
	{$GROUPS_LIST_INFO[$pt_taskdata['userid']]}
	</span>
	{if $RECORD_ID}
	<a target="_blank" href="?module=ProjectTask&view=Detail&record={$RECORD_ID}&mode=showAllComments&tab_label=ModComments"><i class="icon-comment"></i></a>
	{/if}
</td>
<td style="25px;">
		<div class="input-append row-fluid">
			<div class="span12 row-fluid date">
			   <input id="task_startdate{$row_no}" type="text" style="width:70px;" data-date-format="{$dateFormat}" 
			   class="dateField input-small user_start_date" name="task_startdate{$row_no}" value="{$pt_taskdata['start_date']}"/>
			   <span class="add-on"><i class="icon-calendar"></i></span>
			</div>
		</div>
</td>
<td style="25px;">
		<div class="input-append row-fluid">
			<div class="span12 row-fluid date">
			   <input id="task_enddate{$row_no}" type="text" style="width:70px;" data-date-format="{$dateFormat}" 
			   class="dateField input-small user_end_date" name="task_enddate{$row_no}" value="{$pt_taskdata['end_date']}"/>
			   <span class="add-on"><i class="icon-calendar"></i></span>
			</div>
		</div>
</td>
<td style="10px;">
		<input type="text" name="task_allocatedhours{$row_no}" id="task_allocatedhours{$row_no}" value="{$pt_taskdata['allocated_hours']}" 
		style="width:120px;" class='user_task_allocatedhours'/>
</td>
<td style="10px;">
	<input type="text" name="task_workedhours{$row_no}" id="task_workedhours{$row_no}" value="{$pt_taskdata['worked_hours']}" 
		style="width:120px;" class='user_task_workedhours'/>
</td>
<td style="15px;">
	<select class="{if $row_no neq 0} chzn-select {/if}" style="width:100px;" 
	 name="taskstatus{$row_no}" id="taskstatus{$row_no}"  >
	   <option value="">{vtranslate('LBL_SELECT_OPTION','Vtiger')}</option>
	   {foreach item=PICKLIST_VALUE key=PICKLIST_NAME from=$PT_VALUES}
	   <option value="{Vtiger_Util_Helper::toSafeHTML($PICKLIST_VALUE)}" {if trim(decode_html({$pt_taskdata['status']})) eq trim($PICKLIST_VALUE)} selected {/if}>
	   {$PICKLIST_VALUE}
	   </option>
	   {/foreach}
	</select>
	<input type='hidden' name='notification{$row_no}' value="{$pt_taskdata['notification']}" id='idNotification' >
</td>
