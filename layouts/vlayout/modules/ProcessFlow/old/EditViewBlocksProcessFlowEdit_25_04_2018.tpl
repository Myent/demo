{strip}
<script>
	var formdata = {};
	var formdatavalues = {};
	var count = 0;
	var core_productcategory = {};
</script>
<style>
	.clsTblProcess tbody tr:hover td, .clsTblProcess tbody tr:hover th {
		background-color: white !importent;
	}
	.accordion-inner{
		background-color:white;
	}
	 .alignleft {
			float: left;
		}
</style>
  
<audio id="callerTone" src="layouts/vlayout/modules/ProcessFlow/media/callertone.mp3" loop preload="auto"></audio>
<audio id="msgTone" src="layouts/vlayout/modules/ProcessFlow/media/msgtone.mp3" preload="auto"></audio>

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
					{if $PROCESS_MASTER_DATA['termination_status'] == 'Normal' ||  $PROCESS_MASTER_DATA['termination_status'] == ''}<button class="btn btn-success btnDone" type="button">Done</strong></button>
					<button class='btn btn-danger btn-xs btnAbort' type="button" >Abort Batch Run</button>
					{/if}                     
                </span>
				<!---Move to left menu -->
				<input type='hidden' id='idHdnTotalTaskCompleted' value="{$PROCESS_MASTER_DATA['total_completed_tasks']}">
				<input type='hidden' id='idHdnTotalTaskNotCompleted' value="{$PROCESS_MASTER_DATA['total_not_started_tasks']}">
				<input type='hidden' id='idHdnElapsedTime' value="{$PROCESS_MASTER_DATA['process_destails']['elapsed_time']}">
				<input type='hidden' id='idHdnCurrentTask' value="{$PROCESS_MASTER_DATA['current_task']}">
				<input type='hidden' id='idHdnTotalTasks' value="{$PROCESS_MASTER_DATA['total_tasks']}"> 
				<input type='hidden' id='idHdnTotalWaitingTasks' value="{$PROCESS_MASTER_DATA['total_tasks_Waiting']}"> 
				<input type='hidden' id='idHdnTerminationStatus' value="{$PROCESS_MASTER_DATA['termination_status']}"> 
				<input type='hidden' id='idHdnCurrentTime' value="{$CURRENT_TIME}"> 				
            </div>

 
{assign var="roleid" value=$CURRENT_USER_MODEL->get('roleid')}
{assign var="userid" value=$CURRENT_USER_MODEL->get('id')}


{if !empty($RECORD_ID)}
		<input type='hidden' id='idHdnProcessmasterid' value='{$PROCESS_MASTER_DATA['process_master_id']}'>
	 
			{*$PROCESS_MASTER_DATA|@print_r*}  
            {assign  var=process_Block_list value=$PROCESS_MASTER_DATA['process_Block_list']} 				
            <div id="idDivBody" style="overflow:auto;">  			
				<div class="accordion" id="accordion2">
					<div class="accordion-group">
						<div class="accordion-heading">
						<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse_0" style="font-size: 20px;color: #356635;border: 4px solid #356635;border-radius: 5px;" id="idMedia_0"> 
							<img src="assets/icons/Power-48.png" style='width:30px;' />
							<strong>Process Details</strong>  
						</a>
						</div>
						<div id="collapse_0" class="accordion-body collapse" style="height: auto;">
							<div class="accordion-inner">							 
								{*include file='/var/www/html/VTFormula/layouts/vlayout/modules/ProcessFlow/EditViewBlocksFieldsData.tpl'*}
								{include file="EditViewBlocksFieldsData.tpl"|@vtemplate_path:'ProcessFlow'}
									{*Manasa added APR 13 2018 Grids Purpose following 4 includes*}
									{include file="LineItemsEdit.tpl"|@vtemplate_path:'ProcessFlow'} 
 
							</div>
						</div>
					</div>
					
					{foreach from=$PROCESS_MASTER_DATA['process_list'] key=pid item=pdata}
					
						 {*$pdata|@print_r*} 
						{assign var=process_instance_list value=$PROCESS_MASTER_DATA['process_instance_list']}
						{assign var=process_instance_data value=$process_instance_list[$pid]}
						{assign var="ps" value=$process_instance_data['process_status']}

						{assign var="style" value=""}
						{if $ps == 1}
							{assign var="style" value="font-size: 20px;color: #f89406;border: 4px solid #f89406;border-radius: 5px;"}
						{elseif $ps == 2 }
							{assign var="style" value="font-size: 20px;color: #356635;border: 4px solid #356635;border-radius: 5px;"}
						{elseif $ps == 3 }
							{assign var="style" value="font-size: 20px;color: #49afcd;border: 4px solid #49afcd;border-radius: 5px;"}
						{elseif $ps == 4 }
							{assign var="style" value="font-size: 20px;color: #0088cc;border: 4px solid #0088cc;border-radius: 5px;"}
						{elseif $ps == 5 }
							{assign var="style" value="font-size: 20px;color: #f44336;border: 4px solid #f44336;border-radius: 5px;"}
						{/if}

					<div class="accordion-group">
						<div class="accordion-heading">
						<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse_{$pid}" style="{$style}" id="idMedia_{$pid}"> 
							<img src="assets/icons/{if $pdata['customicon'] == null }{$process_Block_list[$pdata['blocktype']]}{else}{$pdata['customicon']}{/if}"  style='width:30px;' />
							<strong > {$pdata['description']}<br></strong>  
						</a>
						</div>
						 
						<div id="collapse_{$pid}" class="accordion-body collapse {if $ps == 1 || $ps == 3 || $ps == 4}in{/if}">
							<div class="accordion-inner">
								<table>
								<tr>
									<td width='50%'>
										{assign var=MINITS value=$PROCESSFLOW_MODEL->getHoursMints($pdata['unitprocess_time'])}	
										<p class='bold'>Process Time(HH:MM) : {$MINITS}</p>							 
										{if $ps != ''}<p class='bold'>Start Time : {$process_instance_data['start_time']}</p>{/if}
										{if $ps == 2}
										<p class='bold'>End Time : {if $process_instance_data['end_time'] != '0000-00-00 00:00:00'}{$process_instance_data['end_time']}{/if} </p>{/if}
										{if $ps == 1 || $ps == 3}                             
										{assign var=ENDTIME value=$PROCESSFLOW_MODEL->getEndTime($process_instance_data['start_time'],$pdata['unitprocess_time'])}
										<input type="hidden" id="idHdnCurrentProcessId" value="{$pid}" >                       
										<input type="hidden" id="idHdnCurrentProcessEndTime" value="{$ENDTIME}" >                       
										<p class='bold'>Remaining Time(HH:MM) : <span id="idHdnCurrentProcessRemainingTime" class="label label-default"></span></p>								
										{/if}
										 
										{if $roleid == $PROCESS_MASTER_DATA['assigne_role'] &&  $ps == '' }									
											<p class='bold' >Select Assigned to: <select class="chzn-select clsSelAssgnee" data-unitprocessid='{$pid}' >
												<option >Select Assigne</option>													
												{foreach from=$PROCESS_MASTER_DATA['assigne_users'] key=auserid item=ausername}
													<option value="{$auserid}" {if $PROCESS_MASTER_DATA['assignee_data'][$pid] == $auserid } selected {/if} >{$ausername}</option>
												{/foreach}
											</select>	
											</p>
										{else}													
											{assign var=uname value=$PROCESSFLOW_MODEL->getFullName($PROCESS_MASTER_DATA['assignee_data'][$pid])}
											<p class='bold'>Assigned to: {$uname}</p>
										{/if}
								</td>
								<td width='50%'>
									{*if $pdata['subblocktype']  == 1  }
											<p class='bold' >
											<select  data-product="product" id='idProduct_{$pid}' >
												<option value=''>Select Product</option>													
												{foreach from=$PROCESS_MASTER_DATA['products_data'] key=spid item=spname}
													<option value="{$spid}"  >{$spname}</option>
												{/foreach}
											</select>	
											</p>
										{/if *}

									{if ($userid == $PROCESS_MASTER_DATA['assignee_data'][$pid] || $userid == $PROCESS_MASTER_DATA['created_by']|| $roleid == $PROCESS_MASTER_DATA['supervisor_roleid']) && $PROCESS_MASTER_DATA['termination_status'] != 'Aborted'  }
											<form id="myform{$pid}" name="myform{$pid}"></form>
										<!-- 0 - Not yet; 1 - started; 2 - Compleated; 3 - interrupted;-->
										{if $PROCESS_MASTER_DATA['termination_status'] == 'Aborted'}
										 
										{elseif $pdata['blocktype'] == 11} 

											{assign var="branching_processids" value=","|explode:$pdata['post_unitprocess']}  
											{assign var=ALLCOMPLETED value=true }
											{foreach from=$branching_processids item=branching_process_id}
												{if $branching_process_id >0 }
													{assign var=pstatus value=$PROCESSFLOW_MODEL->getProcessStatus($branching_process_id,$RECORD_ID)}
												 
												 	{if $pstatus != 2 || $pstatus != 4 } 
													{assign var=ALLCOMPLETED value=false }
													{/if}
												{/if}
											{/foreach} 
											 
											{if ($ps == 1 || $ps == 3 ) && $ALLCOMPLETED == true } 
												<button data-nextprocess="{$pdata['next_process']}" class='btn btn-warning btn-xs endprocess' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-lmd = '{$pdata['learnermodedetails']}'  >{if $pdata['next_process'] == '0'}Finish{else}Next{/if}</button>	 
											{/if}
											{if $ps == 2}	 
												{if $PROCESS_MASTER_DATA['process_destails']['operating_mode'] == 'Relaxed'}
													&nbsp;<button class='btn btn-danger  btn-xs updateProcessData' type='button'   data-unitprocessid='{$pid}' data-name='{$pdata['description']}' >Update</button>
												{/if}												
											{/if}
										{elseif $pdata['blocktype'] == 9} 
											<img src="assets/icons/branching.png">
											{assign var="branching_processids" value=","|explode:$pdata['post_unitprocess']}  
											{foreach from=$branching_processids item=branching_process_id}
												{* check branching_process  status *}
												{if $branching_process_id > 0}

												{assign var=pstatus value=$PROCESSFLOW_MODEL->getProcessStatus($branching_process_id,$RECORD_ID)}	
												{assign var=pname value=$PROCESS_MASTER_DATA['process_list'][$branching_process_id]['description']}
												{assign var=COMPLETED value=true }
												{if $pstatus == 4}
													<button title='Waiting' class='btn btn-info btn-xs btnClsBranching' data-unitprocessid='{$pid}' type='button' data-runningprocess="{$branching_process_id}" data-branchids="{$pdata['post_unitprocess']}">{$pname}</button>&nbsp;
													{assign var=COMPLETED value=false }
												{elseif $pstatus==1 || $pstatus==3}
													<button title='Running' class='btn btn-warning btn-xs' data-unitprocessid='{$pid}' type='button' data-runningprocess="{$branching_process_id}" data-branchids="{$pdata['post_unitprocess']}" disabled >{$pname}</button>&nbsp;
													{assign var=COMPLETED value=false }						 
												{elseif $pstatus==2}
													<button title='Compleated' class='btn btn-success btn-xs' type='button' disabled>{$pname}</button>&nbsp;
												{else}
													{assign var=COMPLETED value=false }		
													<button title='Run Process' class='btn btn-info btn-xs btnClsBranching' data-unitprocessid='{$pid}' type='button' data-runningprocess="{$branching_process_id}" data-branchids="{$pdata['post_unitprocess']}">{$pname}</button>&nbsp;
												{/if}
												 {/if}												
											{/foreach}

											{if $COMPLETED == true && $ps == 4 } 
												{*Update waiting record to finish*}
												{assign var=psforupdate value=$PROCESSFLOW_MODEL->updateProcessStatus($pid,$RECORD_ID)}
											{/if} 

										{elseif $pdata['blocktype'] == 10}

										 	{if $ps == 1 || $ps == 3}
											 {*assign var=decisionStatus value=$PROCESSFLOW_MODEL->getDecisionStatus($pid,$RECORD_ID)*}
												{*if $decisionStatus == true*}
												<button class='btn btn-success btn-xs btnClsDecision' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-postprocess="{$pdata['post_unitprocess']}" data-decision='yes'>Yes</button>
												{*else*}
												<!--<button class='btn btn-warning btn-xs btnClsDecision' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-postprocess="{$pdata['post_unitprocess']}" data-decision='no'>No</button>-->
												<button class='btn btn-warning btn-xs' type='button'   data-decision='no'>No</button>
												{*/if*}

											{/if}
											{if $ps == 2}
												{if $PROCESS_MASTER_DATA['process_destails']['operating_mode'] == 'Relaxed'}
													&nbsp;<button class='btn btn-danger  btn-xs updateProcessData' type='button'   data-unitprocessid='{$pid}' data-name='{$pdata['description']}' >Update</button>
												{/if} 
											{/if}
										
										{elseif $pdata['blocktype'] == 2}
											{assign var="decision_processids" value=","|explode:$pdata['post_unitprocess']}  
											{foreach from=$decision_processids item=decision_processid}
												{if $decision_processid > 0 }
													{assign var=pname value=$PROCESS_MASTER_DATA['process_list'][$decision_processid]['description']}
													{if $ps == 1 || $ps == 3}
														<button class='btn btn-warning btn-xs clsDecisionChose' data-unitprocessid='{$pid}' data-nextunitprocess="{$decision_processid}"  type='button' >{$pname}</button>&nbsp;	
													{/if}
												{/if}
											{/foreach}										
											 
										{elseif $pdata['blocktype'] == 5}
											{if  $ps == 1 || $ps == 3}
												{if $roleid == $PROCESS_MASTER_DATA['supervisor_roleid']  }
													<button class='btn btn-warning btn-xs endprocess' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-nextprocess="{$pdata['next_process']}" >Approve ?</button>
												{else}
												<p class="label label-warning">Waiting for Supervisor Approval..</p>
												{/if}
											{/if}
										{elseif $pdata['blocktype'] == 6}
											{if $ps == 1 || $ps == 3} 										
												<div id='idDivNextBnFotTimer'>
													
													<!--<button class='btn btn-warning btn-xs endprocess' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button'   data-nextprocess="{$pdata['next_process']}">{if $pdata['next_process'] == '0'}Finish{else}Next{/if}</button>-->
													
													<button class='btn btn-success btn-xs btnClsDecision' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-postprocess="{$pdata['next_process']}" data-decision='yes'>Yes</button>
													
													<button class='btn btn-warning btn-xs btnClsDecisionNo' type='button'   data-decision='no' data-unitprocessid='{$pid}' data-name='{$pdata['description']}'>No</button> 
													
												</div>
											{/if}
											{if $ps == 2}
												{if $PROCESS_MASTER_DATA['process_destails']['operating_mode'] == 'Relaxed'}
													&nbsp;<button class='btn btn-danger  btn-xs updateProcessData' type='button'   data-unitprocessid='{$pid}' data-name='{$pdata['description']}' >Update</button>
												{/if}
											{/if}
										{else}
											{if $ps == 1 || $ps == 3} 
												<button data-nextprocess="{$pdata['next_process']}" class='btn btn-warning btn-xs endprocess' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-lmd = '{$pdata['learnermodedetails']}' >{if $pdata['next_process'] == '0'}Finish{else}Next{/if}</button>								 
											{/if}
											{if $ps == 2}
												{if $PROCESS_MASTER_DATA['process_destails']['operating_mode'] == 'Relaxed'}
													&nbsp;<button class='btn btn-danger  btn-xs updateProcessData' type='button'   data-unitprocessid='{$pid}' data-name='{$pdata['description']}' >Update</button>
												{/if}
											{/if}
										{/if}
									 	{*$pdata['customform']|print_r*}
										
										 {assign var=customform value=$pdata['customform']}
										{if $pdata['customform'] != ''}
										<script>									
											var x = {$customform|html_entity_decode}; 
											 
											var id = {$pid};
											if (x != '' || x != '[]'){  formdata[id]= x;   } 
										</script>
										{/if}
										{if $process_instance_data['unit_instance_data'] != ''}
										 {assign var=unit_instance_data value=$process_instance_data['unit_instance_data']}
										<script>
											var y = {$unit_instance_data|html_entity_decode};
											var pid = {$pid};
											if (y != ''){  formdatavalues[pid]= y; }  
										</script>
										{/if}
									{/if}
									
									</td>
								</tr>
								</table>
							</div>
						</div>
					</div>
					{/foreach}
				</div> 
			</div>	 
  {/if}  

{/strip}