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
<style>
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
	{foreach key=BLOCK_LABEL_KEY item=FIELD_MODEL_LIST from=$RECORD_STRUCTURE}
		{assign var=BLOCK value=$BLOCK_LIST[$BLOCK_LABEL_KEY]}
		{if $BLOCK eq null or $FIELD_MODEL_LIST|@count lte 0}{continue}{/if}
		{assign var=IS_HIDDEN value=$BLOCK->isHidden()}
		{assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
			{assign var="userid" value=$CURRENT_USER_MODEL->get('id')}

		<input type=hidden name="timeFormatOptions" data-value='{$DAY_STARTS}' />
		<table class="table table-bordered equalSplit detailview-table">
		<thead>
		<tr>
				<th class="blockHeader" colspan="4">
						<img class="cursorPointer alignMiddle blockToggle {if !($IS_HIDDEN)} hide {/if} "  src="{vimage_path('arrowRight.png')}" data-mode="hide" data-id={$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}>
						<img class="cursorPointer alignMiddle blockToggle {if ($IS_HIDDEN)} hide {/if}"  src="{vimage_path('arrowDown.png')}" data-mode="show" data-id={$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}>
						&nbsp;&nbsp;{vtranslate({$BLOCK_LABEL_KEY},{$MODULE_NAME})}
				</th>
		</tr>
		</thead>
		 <tbody {if $IS_HIDDEN} class="hide" {/if}>
		{assign var=COUNTER value=0}
		<tr>
		{foreach item=FIELD_MODEL key=FIELD_NAME from=$FIELD_MODEL_LIST}
			{if !$FIELD_MODEL->isViewableInDetailView()}
				 {continue}
			 {/if}
			 {if $FIELD_MODEL->get('uitype') eq "83"}
				{foreach item=tax key=count from=$TAXCLASS_DETAILS}
				{if $tax.check_value eq 1}
					{if $COUNTER eq 2}
						</tr><tr>
						{assign var="COUNTER" value=1}
					{else}
						{assign var="COUNTER" value=$COUNTER+1}
					{/if}
					<td class="fieldLabel {$WIDTHTYPE}">
					<label class='muted pull-right marginRight10px'>{vtranslate($tax.taxlabel, $MODULE)}(%)</label>
					</td>
					 <td class="fieldValue {$WIDTHTYPE}">
						 <span class="value">
							 {$tax.percentage}
						 </span>
					 </td>
				{/if}
				{/foreach}
			{else if $FIELD_MODEL->get('uitype') eq "69" || $FIELD_MODEL->get('uitype') eq "105"}
				{if $COUNTER neq 0}
					{if $COUNTER eq 2}
						</tr><tr>
						{assign var=COUNTER value=0}
					{/if}
				{/if}
				<td class="fieldLabel {$WIDTHTYPE}"><label class="muted pull-right marginRight10px">{vtranslate({$FIELD_MODEL->get('label')},{$MODULE_NAME})}</label></td>
				<td class="fieldValue {$WIDTHTYPE}">
					<div id="imageContainer" width="300" height="200">
						{foreach key=ITER item=IMAGE_INFO from=$IMAGE_DETAILS}
							{if !empty($IMAGE_INFO.path) && !empty({$IMAGE_INFO.orgname})}
								<img src="{$IMAGE_INFO.path}_{$IMAGE_INFO.orgname}" width="300" height="200">
							{/if}
						{/foreach}
					</div>
				</td>
				{assign var=COUNTER value=$COUNTER+1}
			{else}
				{if $FIELD_MODEL->get('uitype') eq "20" or $FIELD_MODEL->get('uitype') eq "19"}
					{if $COUNTER eq '1'}
						<td class="{$WIDTHTYPE}"></td><td class="{$WIDTHTYPE}"></td></tr><tr>
						{assign var=COUNTER value=0}
					{/if}
				{/if}
				 {if $COUNTER eq 2}
					 </tr><tr>
					{assign var=COUNTER value=1}
				{else}
					{assign var=COUNTER value=$COUNTER+1}
				 {/if}
				 {if ($FIELD_MODEL->getName() eq 'autologout_time') && ($USER_MODEL->get('is_admin') neq 'on')}
				 <td></td>
				 {else}
				 <td class="fieldLabel {$WIDTHTYPE}" id="{$MODULE_NAME}_detailView_fieldLabel_{$FIELD_MODEL->getName()}" {if $FIELD_MODEL->getName() eq 'description' or $FIELD_MODEL->get('uitype') eq '69'} style='width:8%'{/if}>
					 <label class="muted pull-right marginRight10px">
						 {vtranslate({$FIELD_MODEL->get('label')},{$MODULE_NAME})}
						 {if ($FIELD_MODEL->get('uitype') eq '72') && ($FIELD_MODEL->getName() eq 'unit_price')}
							({$BASE_CURRENCY_SYMBOL})
						{/if}
					 </label>
				 </td>
				 {/if}
				 {if ($FIELD_MODEL->getName() eq 'autologout_time') && ($USER_MODEL->get('is_admin') neq 'on')}
				 <td></td>
				 {else}
				 <td class="fieldValue {$WIDTHTYPE}" id="{$MODULE_NAME}_detailView_fieldValue_{$FIELD_MODEL->getName()}" {if $FIELD_MODEL->get('uitype') eq '19' or $FIELD_MODEL->get('uitype') eq '20'} colspan="3" {assign var=COUNTER value=$COUNTER+1} {/if}>
					 <span class="value" data-field-type="{$FIELD_MODEL->getFieldDataType()}" {if $FIELD_MODEL->get('uitype') eq '19' or $FIELD_MODEL->get('uitype') eq '20' or $FIELD_MODEL->get('uitype') eq '21'} style="white-space:normal;" {/if}>
                        {include file=vtemplate_path($FIELD_MODEL->getUITypeModel()->getDetailViewTemplateName(),$MODULE_NAME) FIELD_MODEL=$FIELD_MODEL USER_MODEL=$USER_MODEL MODULE=$MODULE_NAME RECORD=$RECORD}
					 </span>
					 {if $IS_AJAX_ENABLED && $FIELD_MODEL->isEditable() eq 'true' && ($FIELD_MODEL->getFieldDataType()!=Vtiger_Field_Model::REFERENCE_TYPE) && $FIELD_MODEL->isAjaxEditable() eq 'true'}
						 <span class="hide edit">
							 {include file=vtemplate_path($FIELD_MODEL->getUITypeModel()->getTemplateName(),$MODULE_NAME) FIELD_MODEL=$FIELD_MODEL USER_MODEL=$USER_MODEL MODULE=$MODULE_NAME}
                             {if $FIELD_MODEL->getFieldDataType() eq 'multipicklist'}
                                <input type="hidden" class="fieldname" value='{$FIELD_MODEL->get('name')}[]' data-prev-value='{$FIELD_MODEL->getDisplayValue($FIELD_MODEL->get('fieldvalue'))}' />
                             {else}
                                 <input type="hidden" class="fieldname" value='{$FIELD_MODEL->get('name')}' data-prev-value='{Vtiger_Util_Helper::toSafeHTML($FIELD_MODEL->getDisplayValue($FIELD_MODEL->get('fieldvalue')))}' />
                             {/if}
						 </span>
					 {/if}
				 </td>
				 {/if}
			 {/if}

		{if $FIELD_MODEL_LIST|@count eq 1 and $FIELD_MODEL->get('uitype') neq "19" and $FIELD_MODEL->get('uitype') neq "20" and $FIELD_MODEL->get('uitype') neq "30" and $FIELD_MODEL->get('name') neq "recurringtype" and $FIELD_MODEL->get('uitype') neq "69" and $FIELD_MODEL->get('uitype') neq "105"}
			<td class="fieldLabel {$WIDTHTYPE}"></td><td class="{$WIDTHTYPE}"></td>
		{/if}
		{/foreach}
		{* adding additional column for odd number of fields in a block *}
		{if $FIELD_MODEL_LIST|@end eq true and $FIELD_MODEL_LIST|@count neq 1 and $COUNTER eq 1}
			<td class="fieldLabel {$WIDTHTYPE}"></td><td class="{$WIDTHTYPE}"></td>
		{/if}
		</tr>
		</tbody>
	</table>
	
	  
	<br>
	{/foreach}
	
	{if $KITDETAILS['ckymotype']}
	{assign var="kit" value=$KITDETAILS['kid']} 
	<table class="table table-bordered equalSplit">
		<thead>
		<tr>
				<th class="" colspan="4">						 
						<img class="cursorPointer alignMiddle blockToggle {if ($IS_HIDDEN)} hide {/if}"  src="{vimage_path('arrowDown.png')}" data-mode="show"  >
						&nbsp;&nbsp; Phylos Bioscience Genetic Info widget
				</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><iframe width="600" height="600" scrolling="no" frameborder="0" allowtransparency="true" src="https://dataviz.phylosbioscience.com/seal/?size=600&id={$kit}&bkgd=ffffff"></iframe></td>
		</tr>
		</tbody>
	</table>
	{/if}

	{if $GRIDINFORMATION}
	{foreach item=data key=index from=$GRIDINFORMATION}
		<table class="table table-bordered equalSplit">
			<thead>
				<tr class="blockHeader">
					<th  colspan="6" style="border-bottom: 1px solid #ddd;">{$index}</th>
				</tr>
			</thead>
			<tbody>
			<tr>
				<th class="" colspan="">Product Category</th>
				<th class="" colspan="">Product Name</th>
				<th class="" colspan="">Present Stock</th>
				<th class="" colspan="">Issued Qty</th>
				<th class="" colspan="">Issued By</th>
				<th class="" colspan="">Remarks</th>
			</tr>
		{foreach item=datainfo key=id from=$data}
			<tr>
				<td class="" colspan="">{$datainfo.productcategory}</td>
				<td class="" colspan="">{$datainfo.productname}</td>
				<td class="" colspan="">{$datainfo.prasentqty}</td>
				<td class="" colspan="">{$datainfo.issuedqty}</td>
				<td class="" colspan="">{$datainfo.fullname}</td>
				<td class="" colspan="">{$datainfo.remarks}</td>
			</tr>	
		{/foreach}
			</tbody>
		</table>
		<br>
	{/foreach}
	{/if}
	  <!--Accordion wrapper-->
	{if $PROCESSLIST}
		<div class="accordion" id="accordion2">
		{foreach item=pdata key=index from=$PROCESSLIST}
			{assign var="customform" value=$pdata.customform}

			{assign var='process_instance_data' value=$process_instance_list[$index]}


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
				<a class="accordion-toggle" data-toggle="collapse" style="{$style}" data-parent="#accordion2" href="#collapse{$index}">
				<img src="assets/icons/{if $pdata['customicon'] == null }{$BLOCKTYPE[$pdata['blocktype']]}{else}{$pdata['customicon']}{/if}"  style='width:30px;' />
				<strong > {$pdata['description']}<br></strong>


				</a>
				</div>
				<div id="collapse{$index}" class="accordion-body collapse {if $ps == 1 || $ps == 3 || $ps == 4}in{/if}">
				<div class="accordion-inner">
					<table width="100%" style="border:0px solid gray;">
						<tbody>
							<tr>
								<td width="" class="span3">
								{if $pdata.unitprocess_time}
								{assign var=MINITS value=$PROCESSFLOW_MODEL->getHoursMints($pdata.unitprocess_time)}	
									<p class='bold'>Process Time(HH:MM) : {$MINITS}</p>
								{/if}
								{if $process_instance_data.start_time}
									<p class="bold">Start Time : {$process_instance_data.start_time}</p>
								{/if}
								{if $process_instance_data.end_time}	
									<p class="bold">End Time : {$process_instance_data.end_time} </p>
								{/if}
								{if $pdata.assignedto}
									<p class="bold">Assigned to: {$pdata.assignedto}<b></b></p>
								{/if}	
								</td>
								
								<td width="" class="span3">
									<p class="clsPLrnMode"></p>
									{foreach from=$PROCESSFLOW_MODEL->getCustomFormInfo($pdata.processmasterid, $pdata.unitprocessid, $RECORD_ID) key=sindex item=cdata}
									<form id="myform119" name="myform119" method="POST" enctype="multipart/form-data" class="ui-dform-form">
										<div class="ui-dform-div"><label for="{$cdata.name}" class="ui-dform-label">{$cdata.caption} :  

										{if  $cdata.type == "checkbox"}
											{if $cdata.value == "on"}
											 yes
											{else}
											 no
											{/if}
										{else}
											{$cdata.value}
										{/if}

										{if $pdata.blocktype == 3}
											{if $DOCUMENT[$pdata.unitprocessid]['documentid'] && $cdata.type == "file"}
											files
											<a href="index.php?module=Documents&view=Detail&record={$DOCUMENT[$pdata.unitprocessid]['documentid']}" target="_blank"><i class="icon-file"></i></a>
											{/if}
										{/if}
										</label></div>
									</form>
									{/foreach}
								</td>
								
								<td width="" class="span3" id="">
								<div class='commentsdiv' style="max-height:300px;overflow: auto;">
									{foreach from=$PROCESSFLOW_MODEL->getProcessFlowComments($pdata.unitprocessid,$RECORD_ID) key=index item=cdata}
										<div class="commentscontainer {if $userid != $cdata['id']}darker{/if}">
											<h4>{$cdata['user_name']}</h4>
											<img src="{if $cdata['imagename'] != ""}{$cdata['imagepath']}{$cdata['attachmentsid']}_{$cdata['imagename']}{else}layouts/vlayout/skins/images/DefaultUserIcon.png{/if}" alt="Avatar" class="{if $userid != $cdata['id']}right{/if}">
											<p>{$cdata['comments']}</p>
											<span class="time-{if $userid != $cdata['id']}left{else}right{/if}">{date("H:i", $cdata['date_time'])}</span>
										</div>
									{/foreach}
								</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</div>
			</div>
		{/foreach}
		</div>
	{/if}
{/strip}
