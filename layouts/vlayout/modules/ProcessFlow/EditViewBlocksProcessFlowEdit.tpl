{strip} 
    <style>
	.bold { color:#000!important; }
	.ui-dform-div label{
		    display: table-cell;
    		float: left;
     	 	margin-right: 21px;
    		margin-bottom: 0px;
    		width: 85%;
	}
	.ui-dform-div{
		margin-bottom:10px;
	}
	.commentscontainer {
		border: 2px solid #dedede;
		border-radius: 5px;
		padding: 10px;
		margin: 10px 0;
	}

	.darker {
		border-color: #ccc;
	}

	.commentscontainer::after {
		content: "";
		clear: both;
		display: table;
	}

	.commentscontainer img {
		    float: left;
    max-width: 60px;
    width: 40px;
    height: 33px;
    margin-right: 10px;
    border-radius: 50%;
	}

	.commentscontainer img.right {
		float: right;
		margin-left: 30px;
		margin-right: -7px;
		margin-top: 26px;
	}
	.darker h4{
		float: right;
		margin-left: -34px;
		margin-bottom: 43px;
		display: block;
	}
	.time-right {
		float: right;
		color: #aaa;
	}

	.time-left {
		float: left;
		color: #999;
	}
	.savecomment{
		position: relative;
		left: 87%;
		top: 4px;
	}
	.commentspanel{
		float: right;
		margin-left: 13px;
		min-width: 343px;
		width: 68%;
	}
	
	</style>
	<input type='hidden' id='idHdnTotalTaskCompleted' value="{$PROCESS_MASTER_DATA['total_completed_tasks']}">
	<input type='hidden' id='idHdnTotalTaskNotCompleted' value="{$PROCESS_MASTER_DATA['total_not_started_tasks']}">
	<input type='hidden' id='idHdnElapsedTime' value="{$PROCESS_MASTER_DATA['process_destails']['elapsed_time']}">
	<input type='hidden' id='idHdnCurrentTask' value="{$PROCESS_MASTER_DATA['current_task']}">
	<input type='hidden' id='idHdnTotalTasks' value="{$PROCESS_MASTER_DATA['total_tasks']}"> 
	<input type='hidden' id='idHdnTotalWaitingTasks' value="{$PROCESS_MASTER_DATA['total_tasks_Waiting']}"> 
	<input type='hidden' id='idHdnTerminationStatus' value="{$PROCESS_MASTER_DATA['termination_status']}"> 
	<input type='hidden' id='idHdnCurrentTime' value="{$CURRENT_TIME}"> 

	{assign var="roleid" value=$CURRENT_USER_MODEL->get('roleid')}
	 
	{assign var="userid" value=$CURRENT_USER_MODEL->get('id')}
	 
	<input type='hidden' id='idHdnProcessmasterid' value='{$PROCESS_MASTER_DATA['process_master_id']}'>
	{assign  var=process_Block_list value=$PROCESS_MASTER_DATA['process_Block_list']}
	<input type="hidden" id="idHdnSoundNotifications" value="{$PROCESS_MASTER_DATA['sound_notifications']}">	
	<input type="hidden" id="idHdnHelpDetails" value="{$PROCESS_MASTER_DATA['help_details']}">	

 
	<div class="accordion" id="accordion2">	 
	
		{foreach from=$PROCESS_MASTER_DATA['process_list'] key=pid item=pdata}
		 
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
				<table width="100%" style="border:0px solid gray;">
					<tr>
						<td width='' class="span3">
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
							 
							{if $roleid == $PROCESS_MASTER_DATA['assigne_role'] &&  ($ps == '' || $ps == 1 || $ps == 3 ) }									
								<p class='bold' >Assigned Role: <select class="chzn-select clsSelAssgnee" data-unitprocessid='{$pid}' >
									<option >Select Assigne</option>													
									{foreach from=$PROCESS_MASTER_DATA['assigne_users'] key=auserid item=ausername}
										<option value="{$ausername['roleid']}" data-user="{$ausername['rolename']}" {if $ausername['rolename'] == $pdata['assignedto']} selected {/if} >{$ausername['rolename']}</option>
									{/foreach}
								</select>	
								</p>
							{else}													
								{* assign var=uname value=$PROCESSFLOW_MODEL->getFullName($PROCESS_MASTER_DATA['assignee_data'][$pid]) *}
								<p class='bold'>Assigned to: <b>{$pdata['assignedto']}</b></p>
							{/if}
					</td>
					<td width='' class="span3">
						<p class="clsPLrnMode">					 
							{if empty($pdata['learnermodedetails'])} {else}
								<b>Details :</b> {$pdata['learnermodedetails']}
							{/if}
						</p>
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
							<!-- 0 - Not yet; 1 - started; 2 - completed; 3 - interrupted;-->
							{if $PROCESS_MASTER_DATA['termination_status'] == 'Aborted'}
								
							{elseif $pdata['blocktype'] == 11} 
								
								{assign var="branching_processids" value=","|explode:$pdata['post_unitprocess']}  
								{assign var=ALLCOMPLETED value=true }
								 
								{foreach from=$branching_processids item=branching_process_id}
								
									{if $branching_process_id > 0 }
										 
										{assign var=pstatus value=$PROCESSFLOW_MODEL->getProcessStatus($branching_process_id,$RECORD_ID)}		
										{if $pstatus == 1 || $pstatus == 3 || $pstatus == 4 } 
											
											{assign var=ALLCOMPLETED value=false }
										{/if}
									{/if}
								{/foreach} 
									 
								{if ($ps == 1 || $ps == 3 ) && $ALLCOMPLETED == true } 
									<button data-nextprocess="{$pdata['next_process']}" class='btn btn-warning btn-xs endprocess' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-lmd = '{$pdata['learnermodedetails']}'  data-assignedto="{$pdata['assignedto']}" >{if $pdata['next_process'] == '0'}Finish{else}Next{/if}</button>	 
								{/if}
								{if $ps == 2}	 
									{if $PROCESS_MASTER_DATA['process_destails']['operating_mode'] == 'Relaxed'}
										&nbsp;<button class='btn btn-danger  btn-xs updateProcessData' type='button'   data-unitprocessid='{$pid}' data-name='{$pdata['description']}' data-assignedto="{$pdata['assignedto']}">Update</button>
									{/if}												
								{/if}
							{elseif $pdata['blocktype'] == 9} 
							{if $ps == 1 || $ps == 3 || $ps == 4}
								<img src="assets/icons/branching.png">
								{assign var="branching_processids" value=","|explode:$pdata['post_unitprocess']}  
								{foreach from=$branching_processids item=branching_process_id}
									{* check branching_process  status *}
									{if $branching_process_id > 0}

									{assign var=pstatus value=$PROCESSFLOW_MODEL->getProcessStatus($branching_process_id,$RECORD_ID)}	
									{assign var=pname value=$PROCESS_MASTER_DATA['process_list'][$branching_process_id]['description']}
									{assign var=COMPLETED value=true }
									{if $pstatus == 4}
										<button title='Waiting' class='btn btn-info btn-xs btnClsBranching' data-unitprocessid='{$pid}' type='button' data-runningprocess="{$branching_process_id}" data-assignedto="{$pdata['assignedto']}"  data-branchids="{$pdata['post_unitprocess']}">{$pname}</button>&nbsp;
										{assign var=COMPLETED value=false }
									{elseif $pstatus==1 || $pstatus==3}
										<button title='Running' class='btn btn-warning btn-xs' data-assignedto="{$pdata['assignedto']}" data-unitprocessid='{$pid}' type='button' data-runningprocess="{$branching_process_id}" data-branchids="{$pdata['post_unitprocess']}" disabled >{$pname}</button>&nbsp;
										{assign var=COMPLETED value=false }						 
									{elseif $pstatus==2}
										<button title='completed' class='btn btn-success btn-xs' type='button' disabled>{$pname}</button>&nbsp;
									{else}
										{assign var=COMPLETED value=false }		
										<button title='Run Process' class='btn btn-info btn-xs btnClsBranching' data-assignedto="{$pdata['assignedto']}" data-unitprocessid='{$pid}' type='button' data-runningprocess="{$branching_process_id}" data-branchids="{$pdata['post_unitprocess']}">{$pname}</button>&nbsp;
									{/if}
										{/if}												
								{/foreach}
							 
								{if $COMPLETED == true && $ps == 4 } 
									{*Update waiting record to finish*}
									{assign var=psforupdate value=$PROCESSFLOW_MODEL->updateProcessStatus($pid,$RECORD_ID)}
								{/if} 
							{/if}
							{elseif $pdata['blocktype'] == 10}

								{if $ps == 1 || $ps == 3}
									{*assign var=decisionStatus value=$PROCESSFLOW_MODEL->getDecisionStatus($pid,$RECORD_ID)*}
									{*if $decisionStatus == true*}
									<button class='btn btn-success btn-xs btnClsDecision' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-postprocess="{$pdata['post_unitprocess']}" data-assignedto="{$pdata['assignedto']}" data-decision='yes'>Yes</button>
									{*else*}
									<!--<button class='btn btn-warning btn-xs btnClsDecision' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-postprocess="{$pdata['post_unitprocess']}" data-decision='no'>No</button>-->
									<button class='btn btn-warning btn-xs' type='button'   data-decision='no'>No</button>
									{*/if*}

								{/if}
								{if $ps == 2}
									{if $PROCESS_MASTER_DATA['process_destails']['operating_mode'] == 'Relaxed'}
										&nbsp;<button class='btn btn-danger  btn-xs updateProcessData' type='button'   data-unitprocessid='{$pid}' data-name='{$pdata['description']}' data-assignedto="{$pdata['assignedto']}" >Update</button>
									{/if} 
								{/if}
							
							{elseif $pdata['blocktype'] == 2}
								{assign var="decision_processids" value=","|explode:$pdata['post_unitprocess']}  
								{foreach from=$decision_processids item=decision_processid}
									{if $decision_processid > 0 }
										{assign var=pname value=$PROCESS_MASTER_DATA['process_list'][$decision_processid]['description']}
										{if $ps == 1 || $ps == 3}
											<button class='btn btn-warning btn-xs clsDecisionChose' data-unitprocessid='{$pid}' data-nextunitprocess="{$decision_processid}"  type='button' data-assignedto="{$pdata['assignedto']}" >{$pname}</button>&nbsp;	
										{/if}
									{/if}
								{/foreach}										
									
							{elseif $pdata['blocktype'] == 5}
								{if  $ps == 1 || $ps == 3}
									{if $roleid == $PROCESS_MASTER_DATA['supervisor_roleid']  }
										<button class='btn btn-warning btn-xs endprocess' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-nextprocess="{$pdata['next_process']}" data-assignedto="{$pdata['assignedto']}" >Approve ?</button>
									{else}
									<p class="label label-warning">Waiting for Supervisor Approval..</p>
									{/if}
								{/if}
							{elseif $pdata['blocktype'] == 6}
								{if $ps == 1 || $ps == 3} 										
									<div id='idDivNextBnFotTimer'>
										
										<!--<button class='btn btn-warning btn-xs endprocess' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button'   data-nextprocess="{$pdata['next_process']}">{if $pdata['next_process'] == '0'}Finish{else}Next{/if}</button>-->
										
										<button class='btn btn-success btn-xs btnClsDecision' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-postprocess="{$pdata['next_process']}" data-assignedto="{$pdata['assignedto']}" data-decision='yes'>Yes</button>
										
										<button class='btn btn-warning btn-xs btnClsDecisionNo' type='button'   data-decision='no' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' data-assignedto="{$pdata['assignedto']}" >No</button> 
										
									</div>
								{/if}
								{if $ps == 2}
									{if $PROCESS_MASTER_DATA['process_destails']['operating_mode'] == 'Relaxed'}
										&nbsp;<button class='btn btn-danger  btn-xs updateProcessData' type='button'   data-unitprocessid='{$pid}' data-name='{$pdata['description']}' data-assignedto="{$pdata['assignedto']}"  >Update</button>
									{/if}
								{/if}
							{else}
								{if $ps == 1 || $ps == 3} 
									<button data-nextprocess="{$pdata['next_process']}" class='btn btn-warning btn-xs endprocess' data-unitprocessid='{$pid}' data-name='{$pdata['description']}' type='button' data-assignedto="{$pdata['assignedto']}" data-lmd = '{$pdata['learnermodedetails']}' >{if $pdata['next_process'] == '0'}Finish{else}Next{/if}</button>								 
								{/if}
								{if $ps == 2}
									{if $PROCESS_MASTER_DATA['process_destails']['operating_mode'] == 'Relaxed'}
										&nbsp;<button class='btn btn-danger  btn-xs updateProcessData' type='button'   data-assignedto="{$pdata['assignedto']}" data-unitprocessid='{$pid}' data-name='{$pdata['description']}' >Update</button>
									{/if}
								{/if}

								{if $pdata['blocktype'] == 3 and ($ps != 1 || $ps != 3)}
									 <br>
									Documents :<br>
									{if $PROCESS_MASTER_DATA['pf_documents'][$pid]}
										{foreach from=$PROCESS_MASTER_DATA['pf_documents'][$pid] item=docdata key=key }
											<a href="index.php?module=Documents&view=Detail&record={$docdata['documentid']}" target="_blank"><i class="icon-file"></i>{$key+1} </a>
										{/foreach}
									{/if}
									 
								{/if}
							{/if}
							 
							{*$pdata['customform']|print_r*}
								{assign var=customform value=$pdata['customform']}
							{if $pdata['customform'] != ''}
							<script>									
								var x = {$customform|html_entity_decode}; 
									
								var id = {$pid};
								if (x != '' || x != '[]'){  formdata[id]= x;     } 
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
					<td width="" class="span3" id="">
						<div class="commentspanel">
							<h3>Comments</h3><hr>
							<div>
								<textarea placeholder="Add Comment here" id="comment{$pid}"></textarea><br>
								<button type="button" data-unitprocessid="{$pid}" data-userid="{$userid}" name="savecomment" id="savecomment" class="btn btn-success savecomment">Post</button>
							</div>
							<div class='commentsdiv' style="max-height:300px;overflow: auto;">
								{foreach from=$PROCESSFLOW_MODEL->getProcessFlowComments($pid,$RECORD_ID) key=index item=cdata}
								<div class="commentscontainer {if $userid != $cdata['id']}darker{/if}">
									<h4>{$cdata['user_name']}</h4>
									<img src="{if $cdata['imagename'] != ""}{$cdata['imagepath']}{$cdata['attachmentsid']}_{$cdata['imagename']}{else}layouts/vlayout/skins/images/DefaultUserIcon.png{/if}" alt="Avatar" class="{if $userid != $cdata['id']}right{/if}">
									<p>{$cdata['comments']}</p>
									<span class="time-{if $userid != $cdata['id']}left{else}right{/if}">{date("H:i", $cdata['date_time'])}</span>
								</div>
								{/foreach}
								
							</div>
						</div>
					</td>
				</tr>
			</table>
				</div>
			</div>
		</div>
		{/foreach}
		 
	</div> 
</div>


<script src="libraries/jquery/jquery.dform-1.1.0.min.js" ></script>
<script type="text/javascript" src="libraries/bootstrap/js/bootbox.min.js"></script>

<script>
jQuery(document).ready(function(){

	var recordId = jQuery('input[name="record"]').val();
 
	 

	/*change Assignee */
	jQuery('.clsSelAssgnee').change(function(){
			
		var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.action = 'AjaxProcessFlow';	
		sentdata.mode = 'changeAssigneeUser';					 
		sentdata.unitprocessid = jQuery(this).data('unitprocessid');	 		 
		sentdata.recordId = recordId;
		sentdata.assignee_user_id = jQuery(this).find(':selected').data('user');

		AppConnector.request(sentdata).then(
			function(data){ 						
				if(data.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate(data.result.message),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);									
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		); 	
	});
	
	

	jQuery('.savecomment').click(function(){
		var pid = jQuery(this).data("unitprocessid");
		var userid = jQuery(this).data("userid");
		var comment = jQuery("#comment"+pid).val();
		if(comment == "")
		{
			return false;
		}
		
		var commentdata ={};
		commentdata.module ='ProcessFlow'; 
		commentdata.action = 'AjaxProcessFlow';	
		commentdata.mode = 'addCommentProcessFlow';					 
		commentdata.unitprocessid = pid;	 		 
		commentdata.userid = userid;
		commentdata.recordId = recordId;
		commentdata.comment = comment;
 

		AppConnector.request(commentdata).then(
			function(responcedata){ 						
				if(responcedata.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate(responcedata.result.message),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);
					jQuery(this).prop('disabled', true);
					ajaxReload(recordId);							
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		); 

	});

	jQuery('.clsDecisionChose').click(function(){ 

		var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.action = 'AjaxProcessFlow';	
		sentdata.mode = 'decisionChose';					 
		sentdata.unitprocessid = jQuery(this).data('unitprocessid');			 
		sentdata.nextunitprocess = jQuery(this).data('nextunitprocess'); 			 
		sentdata.recordId = recordId;	 
		sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();
							
		AppConnector.request(sentdata).then(
			function(data){ 						
				
				if(data.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate(data.result.message),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);
					ajaxReload(recordId);
								
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		); 			
	}); 

	jQuery('.btnClsBranching').click(function(){  
		var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.action = 'AjaxProcessFlow';	
		sentdata.mode = 'branch_process';					 
		sentdata.unitprocessid = jQuery(this).data('unitprocessid'); 			 
		sentdata.runningprocess = jQuery(this).data('runningprocess'); 				 
		sentdata.recordId =recordId;
		sentdata.branchids = jQuery(this).data('branchids');
		sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();
		AppConnector.request(sentdata).then(
			function(data){ 						
				if(data.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate(data.result.message),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);
					ajaxReload(recordId);
								
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		); 			   
	});

	jQuery('.btnClsDecisionNo').click(function(){
		var p_name = jQuery(this).data('name');	 			 
		var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.action = 'AjaxProcessFlow';	
		sentdata.mode = 'decision_end_unit_process_no';				 
		sentdata.unitprocessid = jQuery(this).data('unitprocessid'); 			 
		sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();					 
		sentdata.recordId =  recordId;
		sentdata.decision = jQuery(this).data('decision');
		sentdata.postprocess = jQuery(this).data('postprocess'); 
							
		AppConnector.request(sentdata).then(
			function(data){ 						
				
				if(data.result.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate('<b>'+p_name+'</b><br> Process running.'),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);
					/* ajaxReload(recordId); */
								
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		); 
			
	});

	jQuery('.btnClsDecision').click(function(){
		var p_name = jQuery(this).data('name');	 			 
		var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.action = 'AjaxProcessFlow';	
		sentdata.mode = 'decision_end_unit_process';					 
		sentdata.unitprocessid = jQuery(this).data('unitprocessid'); 			 
		sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();					 
		sentdata.recordId =  recordId;
		sentdata.decision = jQuery(this).data('decision');
		sentdata.postprocess = jQuery(this).data('postprocess'); 
							
		AppConnector.request(sentdata).then(
			function(data){ 						
				
				if(data.result.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate('<b>'+p_name+'</b><br> Process Ended,Next Process Started.'),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);
					ajaxReload(recordId);
								
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		); 
			
	});

	jQuery('.endprocess').click(function(e){
		var commentfiles = '';
		var recordId = jQuery('input[name="record"]').val();
		var projectid = jQuery('input[name="pf_project_id"]').val();
		var p_name = jQuery(this).data('name');			 
		var lmd = jQuery(this).data('lmd');			 
		var nextprocess = jQuery(this).data('nextprocess');			 
		var unitprocessid = jQuery(this).data('unitprocessid'); 
		
		var formid = jQuery('#myform'+unitprocessid);
		var formdata  = formid.serializeArray();  
		var fdata = {};
		var sentdata = new FormData(formid[0]);
		sentdata.append('module', 'ProcessFlow');
		sentdata.append('action', 'AjaxProcessFlow');
		sentdata.append('mode', 'end_unit_process');
		sentdata.append('unitprocessid', unitprocessid);
		sentdata.append('process_master_id', jQuery('#idHdnProcessmasterid').val());
		sentdata.append('recordId', recordId);
		sentdata.append('nextprocess', nextprocess);
		sentdata.append('formdata',JSON.stringify(formdata));
		sentdata.append('projectid',projectid);

		this.disabled = true;
		nextUnitProcess(sentdata,p_name);
		 
		/* if(formdata.length > 0){
			jQuery.each(formdata,function(fkey,fvalue) {
				fdata[fvalue.name] = fvalue.value;
				var fname = fvalue.name;
			});
			sentdata.append('formdata',JSON.stringify(fdata));
			nextUnitProcess(sentdata,p_name);
		}else{  
			sentdata.append('formdata',JSON.stringify(formdata));
			this.disabled = true;
			nextUnitProcess(sentdata,p_name);
		}	 */
		
		/* if(fname.indexOf('product_') != -1){
			var fnames_split_array = fname.split("_");
			var pid = fnames_split_array[1];
			var qty = fvalue.value;
			/* check stock in Inventory 
			var pdata ={};
			pdata.module ='ProcessFlow'; 
			pdata.action = 'AjaxValidations';	
			pdata.mode = 'check_inventory';					 
			pdata.productid = pid;	 		 
			pdata.product_quantity = qty; 
			
			deferreds.push( AppConnector.request(pdata).then(
				function(data){ 
					if(data.success == true){ 	 
						if(data.result.status == false){
							var params = { 
								title : app.vtranslate('JS_MESSAGE'),
								text: app.vtranslate(data.result.message),
								animation: 'show',
								type: 'danger'
							};
							Vtiger_Helper_Js.showPnotify(params);
							jQuery('input[name="'+ fname +'"]').css('border-color', 'red');
							var error_product_status = true;
						} 	
					}else{						
						bootbox.alert("Try again");			 
					}
				})  
			);
		}else{
			/* if form data dont have product fields 
			error_product_status = false;
		}				
		*/ 
 
	});

	jQuery('.updateProcessData').click(function(){
		var p_name = jQuery(this).data('name');
		var unitprocessid = jQuery(this).data('unitprocessid'); 
		var formid = jQuery('#myform'+unitprocessid);
		var formdata  = formid.serializeArray();
		this.disabled = true;
		var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.action = 'AjaxProcessFlow';	
		sentdata.mode = 'updateProcessData';					 
		sentdata.unitprocessid = unitprocessid;	 
		sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();			 
		sentdata.recordId = recordId;				 
		sentdata.formdata = formdata; 
		console.log(sentdata);
		AppConnector.request(sentdata).then(
			function(data){ 						
				if(data.result.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate('<b> Updated Values </b>'),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);							 
								
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		);
	});
	jQuery('.btnAbort').click(function(){ 	
		 
		bootbox.confirm("Are you sure you want Abort Batch", function(result){ 
			if(result){   
				this.disabled = true; 
				var sentdata ={};
				sentdata.module ='ProcessFlow'; 
				sentdata.action = 'AjaxProcessFlow';	
				sentdata.mode = 'abort_batch';			 		 
				sentdata.recordId = recordId;	 
				abortBatch(sentdata); 
			}else{
				this.disabled = false;
			}
		});
	});

	if(recordId > 0){
		count ++;
		console.log(formdata);
		jQuery.each(formdata, function( index, value ) { 			 
			/* temp need to enable  */ 
			jQuery("#myform"+index).dform(value);
		}); 		
		  
		 


		if(Object.keys(formdatavalues).length  > 0 ){
			jQuery.each(formdatavalues, function( index, value ) { 	

				if('quantity_data' in value && Object.keys(value.quantity_data).length  > 0 ){ 
					jQuery.each(value.quantity_data, function(k,v){ 
						
						if(jQuery("input[name='"+v.name+"']").is(':checkbox')){
							jQuery("input[name='"+v.name+"']").val(v.value);
							if(v == 'on'){
								jQuery("input[name='"+v.name+"']").prop('checked', true);
							}else{
								jQuery("input[name='"+v.name+"']").prop('checked', false);
							}
						}else{
							jQuery("input[name='"+v.name+"']").val(v.value);
						}
						
					});
				 } 
				var productid = value.productid;
				var unitprocessid = value.unitprocessid;
				if(productid != ''){ 				 
					jQuery('#idProduct_'+unitprocessid).val(productid);
					jQuery('#idProduct_'+unitprocessid).trigger("chosen:updated");			 
				}		
			});
		}
		 
	}

	/*show / hide learner mode div*/
	var learner_mode = jQuery('#idHdnHelpDetails').val();	 
	if(learner_mode == 1){
		
	}else{
		jQuery('.clsPLrnMode').html('');
	}

	/* Set the date we're counting down to */
	var starttime = jQuery('#idHdnCurrentTime').val();
	var endtime = jQuery('#idHdnCurrentProcessEndTime').val();
	var pid = jQuery('#idHdnCurrentProcessId').val();
	var countDownDate = new Date(endtime).getTime();


	var process_status_end = false;
	/* Update the count down every 1 second */
	var x = setInterval(function() {

		/* Get todays date and timen */
		var now = new Date().getTime();

		/* Find the distance between now an the count down date*/
		var distance = countDownDate - now;

		/* Time calculations for days, hours, minutes and seconds */
		var days = Math.floor(distance / (1000 * 60 * 60 * 24));
		var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
		var seconds = Math.floor((distance % (1000 * 60)) / 1000);

		/* Output the result in an element with id="demo"*/ 
		var rTimeHtml = '';
		if(days > 0){ rTimeHtml += days + "d ";}
		if(hours > 0){ rTimeHtml += hours + "h ";}
		if(minutes > 0){ rTimeHtml += minutes + "m ";}
		if(seconds > 0){ rTimeHtml += seconds + "s ";}
		jQuery('#idHdnCurrentProcessRemainingTime').html(rTimeHtml);

		/* If the count down is over, write some text */
		if(process_status_end == false && distance < 50){
			jQuery('#idHdnCurrentProcessRemainingTime').removeClass('label-default');
			jQuery('#idMedia_'+pid).addClass('label-important');
			jQuery('#idMedia_'+pid).addClass('blink_me');
			jQuery('#idHdnCurrentProcessRemainingTime').addClass('blink_me');
			jQuery('#idHdnCurrentProcessRemainingTime').addClass('label-important');			
			process_status_end = true;
		}
		if (distance < 1) {
			jQuery("#idDivNextBnFotTimer").show();
			clearInterval(x);            
			jQuery('#ee').html("EXPIRED");
			
			/* jQuery('#callerTone').trigger('play');*/
			if(jQuery('#idHdnSoundNotifications').val() == 1){ 
				jQuery('#msgTone').trigger('play');
			}
		}
	}, 1000); 
	
		
	
	/* Left widget */
	if(recordId > 0){ 
		
		var TotalTaskCompleted = jQuery('#idHdnTotalTaskCompleted').val();
		var TotalTaskNotCompleted = jQuery('#idHdnTotalTaskNotCompleted').val();
		var ElapsedTime = jQuery('#idHdnElapsedTime').val();
		var CurrentTask = jQuery('#idHdnCurrentTask').val();
		var TotalTasks = jQuery('#idHdnTotalTasks').val();
		var TotalWaitingTasks = jQuery('#idHdnTotalWaitingTasks').val();
		var process_status = jQuery('[name="pf_process_status"]').chosen().val();
		if(process_status == "Completed" || process_status == "Destructed")
		{
			/* var done = '<a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate("LBL_CANCEL", $MODULE)}</a>';
			var save = '<a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate("LBL_CANCEL", $MODULE)}</a>';*/
			jQuery('#idSpnLeftBtnContainer').html('<a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate("LBL_CANCEL", $MODULE)}</a>');
			
		}else{
			/* var done = '<button class="btn btn-success btnDone" type="button">Done</strong></button><a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate("LBL_CANCEL", $MODULE)}</a>';
			var save = '<button class="btn btn-success" type="submit"><strong>{vtranslate("LBL_SAVE", $MODULE)}</strong></button><a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate("LBL_CANCEL", $MODULE)}</a>'; */

			jQuery('#idSpnLeftBtnContainer').html('<button class="btn btn-success" type="submit"><strong>{vtranslate("LBL_SAVE", $MODULE)}</strong></button><a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate("LBL_CANCEL", $MODULE)}</a>');
		}

		/*if(TotalTaskNotCompleted == 0 && (TotalTasks == TotalTaskCompleted)){		 
			jQuery('#idSpnLeftBtnContainer').html(done);
		}else{			 
			jQuery('#idSpnLeftBtnContainer').html(save);
		}*/
		/*end*/
		var widget ='<div class="quickWidget">'+
					'   <div class="accordion-heading accordion-toggle quickWidgetHeader" data-target="#processflow_custom" data-toggle="collapse" data-parent="#quickWidgets" data-label="Process Flow Widget"  >'+
					'      <span class="pull-left"><img class="imageElement" data-rightimage="layouts/vlayout/skins/images/rightArrowWhite.png" data-downimage="layouts/vlayout/skins/images/downArrowWhite.png" src="layouts/vlayout/skins/images/downArrowWhite.png"></span>					'+
					'      <h5 class="title widgetTextOverflowEllipsis pull-right" title="Process Flow Widget">Process Flow Widget</h5>'+
					'      <div class="loadingImg hide pull-right">'+
					'         <div class="loadingWidgetMsg"><strong>Loading Widget</strong></div>'+
					'      </div>'+
					'      <div class="clearfix"></div>'+
					'   </div>'+
					'   <div class="widgetContainer accordion-body collapse in" id="processflow_custom"   style="height: auto;">'+
					'      <div class="recordNamesList">'+
					'         <div class="row-fluid">'+
					'            <div class="">'+
					'               <ul class="nav nav-list">';
		if(TotalTasks == TotalTaskCompleted ){

		}else{			
			widget +='                  <li><a>Current Task <span style="font-weight: bold;">'+CurrentTask+'</span> of <span  style="font-weight: bold;">'+TotalTasks+'</span></a></li>';
		}
			 widget +='                  <li><a>Tasks completed : <span style="font-weight: bold;">'+TotalTaskCompleted+'</span></a></li>'+
					'                  <li><a>Not completed : <span style="font-weight: bold;">'+TotalTaskNotCompleted+'</span></a></li>'+
					'                  <li><a>Tasks Waiting :<span style="font-weight: bold;">'+TotalWaitingTasks+'</span></a></li>'+
					'                  <li><a>Elapsed Time (H:M:S)<br><span style="font-weight: bold;">'+ElapsedTime+'</span></a></li>'+
					'                  <!--<button class="btn btn-info btn-xs"  >Hide Completed</button>-->'+
					'                   <!--<button class="btn btn-info btn-xs"  >Hide Unstarted</button>-->'+
					'               </ul>'+
					'            </div>'+
					'         </div>'+
					'      </div>'+
					'   </div>'+
					'</div>';
					
		jQuery('.quickWidgetContainer').html(widget);
	}
	/* End Left widget */

	jQuery('.btnDone').attr("disabled", "disabled"); 
	jQuery("#idDivNextBnFotTimer").hide();
	
	var abortBatchstatus = jQuery("#idHdnTerminationStatus").val(); 
	if(abortBatchstatus == 'Aborted'){
		jQuery('button').prop('disabled', true);
	}

});

function abortBatch(sentdata){
	var recordId = jQuery('input[name="record"]').val();
	AppConnector.request(sentdata).then(
		function(data){ 						
			
			if(data.result.success == true){ 								
				var params = { 
					title : app.vtranslate('JS_MESSAGE'),
					text: app.vtranslate('Abort Batch'),
					animation: 'show',
					type: 'info'
				};
				Vtiger_Helper_Js.showPnotify(params);
				ajaxReload(recordId);
							
			}else{
				this.disabled = false;
				bootbox.alert("Try again");				 
			}
		}
	);
}

function nextUnitProcess(sentdata,p_name){ 
	var params = {
				url: "index.php",
				type: "POST",
				data: sentdata,
				processData: false,
				contentType: false
			};
	var recordId = jQuery('input[name="record"]').val();
	AppConnector.request(params).then(
		function(data){ 	
			console.log('data'); 
			console.log(data); 
			if(data.result.success == true){ 								
				var params = { 
					title : app.vtranslate('JS_MESSAGE'),
					text: app.vtranslate('<b>'+p_name+'</b><br> Process Ended,Next Process Started.'),
					animation: 'show',
					type: 'info'
				};
				Vtiger_Helper_Js.showPnotify(params);
				ajaxReload(recordId);
							
			}else{
				this.disabled = false;
				var params = { 
					title : app.vtranslate('JS_MESSAGE'),
					text: app.vtranslate(data.result.message),
					animation: 'show',
					type: 'danger'
				};
				Vtiger_Helper_Js.showPnotify(params);
				bootbox.alert(data.result.message);				 
			}
		}
	);
}

function ajaxReload(recordId){
	var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.view = 'AjaxProcesses';		 
		sentdata.recordId = recordId; 
		AppConnector.request(sentdata).then(
			function(data){ 						
				jQuery('#idProceessData').html(data);	 
			}
		);
}

function numberValidation(event){
	var keycode = event.which;
    if (!(event.shiftKey == false && (keycode == 46 || keycode == 8 || keycode == 37 || keycode == 39 || (keycode >= 48 && keycode <= 57)))) {
        event.preventDefault();
    }
}

</script>
{/strip}
