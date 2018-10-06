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


<link rel='stylesheet' href='libraries/jstree/themes/default/style.min.css' />   

<style>
.jstree-grid-wrapper { 
	border:1px solid #ddd;
}
.jstree-grid-midwrapper  { 	
	background-color:white;
}
 
 
.jstree-grid-header-cell {
	text-align:left;
	font-size:11px;
	border:1px solid #ddd;
	padding:5px;

	white-space:nowrap;
	color:#333;
	background: #fff;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));
	background: -moz-linear-gradient(top,  #fff,  #ededed);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');
}

.jstree-grid-separator {
	display:none;
}

.jstree-anchor,.jstree-grid-cell {
	text-overflow:ellipsis !important;
	white-space:nowrap !important;
	overflow:hidden !important;
}
</style>

    <div class='container-fluid editViewContainer'>
        <form class="form-horizontal recordEditView" id="EditView" name="EditView" method="post" action="index.php" enctype="multipart/form-data">
            {assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
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
            <input type="hidden" name="action" value="Save" />
            <input type="hidden" name="record" value="{$RECORD_ID}" />
            <input type="hidden" name="defaultCallDuration" value="{$USER_MODEL->get('callduration')}" />
            <input type="hidden" name="defaultOtherEventDuration" value="{$USER_MODEL->get('othereventduration')}" />
            {if $IS_RELATION_OPERATION }
                <input type="hidden" name="sourceModule" value="{$SOURCE_MODULE}" />
                <input type="hidden" name="sourceRecord" value="{$SOURCE_RECORD}" />
                <input type="hidden" name="relationOperation" value="{$IS_RELATION_OPERATION}" />
            {/if}
            <div class="contentHeader row-fluid">
                {assign var=SINGLE_MODULE_NAME value='SINGLE_'|cat:$MODULE}
                {if $RECORD_ID neq ''}
                    <h3 class="span8 textOverflowEllipsis" title="{vtranslate('LBL_EDITING', $MODULE)} {vtranslate($SINGLE_MODULE_NAME, $MODULE)} {$RECORD_STRUCTURE_MODEL->getRecordName()}">{vtranslate('LBL_EDITING', $MODULE)} {vtranslate($SINGLE_MODULE_NAME, $MODULE)} - {$RECORD_STRUCTURE_MODEL->getRecordName()}</h3>
                {else}
                    <h3 class="span8 textOverflowEllipsis">{vtranslate('LBL_CREATING_NEW', $MODULE)} {vtranslate($SINGLE_MODULE_NAME, $MODULE)}</h3>
                {/if}
                <span class="pull-right">
                    <button class="btn btn-success" type="submit"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
                    <a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                </span>
            </div>
            {foreach key=BLOCK_LABEL item=BLOCK_FIELDS from=$RECORD_STRUCTURE name="EditViewBlockLevelLoop"}
            {if $BLOCK_FIELDS|@count lte 0}{continue}{/if}
			
			{if $BLOCK_LABEL == 'Project Parent Tree'}  
            <table class="table table-bordered ">
			{else}
			  <table class="table table-bordered blockContainer showInlineTable equalSplit">
				{/if}
                <thead>
                    <tr>
                        <th class="blockHeader" colspan="4">{vtranslate($BLOCK_LABEL, $MODULE)}</th>
                    </tr>
                </thead>
                <tbody>
					{if $BLOCK_LABEL == 'Project Parent Tree'}  
					<tr>
						<td colspan='4'> 
							<div class='row-fluid'>
							<span type='button' class='btn btn-success' id='btnjsTreeProjectTasks'>Load Project Parent Tree</span>
							<!--<input type='hidden' name='pcm_parent_task_id' id='ProjectTask_editView_fieldName_pcm_parent_task_id' >-->
								<div>
									<input class="search-input form-control" placeholder='Search' style='display:none;'></input>
								</div>
								<div id='task_tree_in_editer' class=''></div>							 
							</div>					
						</td>		 
					</tr>
					{/if}		
				
						<tr>
							{assign var=COUNTER value=0}
							
							{foreach key=FIELD_NAME item=FIELD_MODEL from=$BLOCK_FIELDS name=blockfields}
							{if $FIELD_NAME == 'pcm_active'}							 	
								<!--<input type='hidden' name='{$FIELD_NAME}' value="1">-->
							{/if}
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
				{if $BLOCK_LABEL == 'Users'}			
					<tr>
						{assign var=ProjectTask_MODULE_MODEL value=Vtiger_Module_Model::getInstance('ProjectTask')}
						{assign var=PT_FIELD_MODEL value=$ProjectTask_MODULE_MODEL->getField('projecttaskstatus')}
						{assign var=PT_VALUES value=$PT_FIELD_MODEL->getPicklistValues()}
						{assign var="dateFormat" value=$USER_MODEL->get('date_format')}
						{assign var="USERS_LIST_INFO" value=$USER_MODEL->getAccessibleUsersForModule($MODULE)}
						{assign var="GROUPS_LIST_INFO" value=$USER_MODEL->getAccessibleGroupForModule($MODULE)}
						<input type="hidden" id="ACCESSIBLE_USER_LIST" value="{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($USERS_LIST_INFO))}"/>
						<input type="hidden" id="ACCESSIBLE_GROUP_LIST" value="{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($GROUPS_LIST_INFO))}"/>
						<td colspan='4'> 
							<table class="table table-bordered userinfo equalSplit" id="userinfotable">
								<thead>
									<tr>
										<th>User</th>
										<th>Start Date</th>
										<th>End Date</th>
										<th>Allocated Hours</th>
										<th>Worked Hours</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody id="Userinfoblock">
								<tr id="userrow0" class="hide userslineItemCloneCopy">
									{include file="Project_User_Task.tpl"|@vtemplate_path:'ProjectTask' row_no=0 data=[]}
								</tr>
								{foreach key=info item=pt_taskdata from=$PROJECT_TASK_USERINFO}
									{assign var=row_no value=$pt_taskdata['userid']}
								<tr id="userrow{$row_no}" class="userslineItemRow">
									{include file="Project_User_Task.tpl"|@vtemplate_path:'ProjectTask' row_no=$row_no data=$pt_taskdata}

								</tr>
								
								{/foreach}
								</tbody>
							</table>							
						</td>		 
					</tr>
					{/if}
					 
			</tbody>
		</table>
<br>

{/foreach}
 	 
<script src="https://code.jquery.com/jquery-1.8.0.js"    crossorigin="anonymous"></script>
<script src='libraries/jquery/jquery.dataAttr.min.js?v=6.4.0'></script>
<script src='libraries/jstree/jstree.js?v=6.4.0'></script>

<script src='libraries/jstree/jstreegrid_new.js?v=6.4.0'></script>
 <script>
jQuery(document).ready(function(){
 
	 var active  = $('#ProjectTask_editView_fieldName_pcm_active').val();
	 if(active == 0){
		jQuery("input,select,textarea").prop('disabled', true);
		jQuery('button').prop('disabled', true); 		 
	 }
	
	}); 
 </script>
 
 
{/strip}