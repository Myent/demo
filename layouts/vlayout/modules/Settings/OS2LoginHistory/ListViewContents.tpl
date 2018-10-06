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
<input type="hidden" id="pageStartRange" value="{$PAGING_MODEL->getRecordStartRange()}" />
<input type="hidden" id="pageEndRange" value="{$PAGING_MODEL->getRecordEndRange()}" />
<input type="hidden" id="previousPageExist" value="{$PAGING_MODEL->isPrevPageExists()}" />
<input type="hidden" id="nextPageExist" value="{$PAGING_MODEL->isNextPageExists()}" />
<input type="hidden" id="totalCount" value="{$LISTVIEW_COUNT}" />
<input type="hidden" value="{$ORDER_BY}" id="orderBy">
<input type="hidden" value="{$SORT_ORDER}" id="sortOrder">
<input type="hidden" id="totalCount" value="{$LISTVIEW_COUNT}" />
<input type='hidden' value="{$PAGE_NUMBER}" id='pageNumber'>
<input type='hidden' value="{$PAGING_MODEL->getPageLimit()}" id='pageLimit'>
<input type="hidden" value="{$LISTVIEW_ENTRIES_COUNT}" id="noOfEntries">


<div class="listViewEntriesDiv" style='overflow-x:auto;'>
	<span class="listViewLoadingImageBlock hide modal" id="loadingListViewModal">
		<img class="listViewLoadingImage" src="{vimage_path('loading.gif')}" alt="no-image" title="{vtranslate('LBL_LOADING', $MODULE)}"/>
		<p class="listViewLoadingMsg">{vtranslate('LBL_LOADING_LISTVIEW_CONTENTS', $MODULE)}........</p>
	</span>
	<form action="" id="export-form" method="POST">
	  <input type="hidden" value='' id='hidden-type' name='ExportType'/>
	</form>
	{assign var="NAME_FIELDS" value=$MODULE_MODEL->getNameFields()}
	{assign var=WIDTHTYPE value=$CURRENT_USER_MODEL->get('rowheight')}
	<table class="table table-bordered table-condensed listViewEntriesTable">
		<thead>
			<tr class="listViewHeaders">
				<th width="1%" class="{$WIDTHTYPE}"></th>
				{assign var=WIDTH value={99/(count($LISTVIEW_HEADERS))}}
				{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
				<th width="{$WIDTH}%" nowrap {if $LISTVIEW_HEADER@last}colspan="" {/if} class="{$WIDTHTYPE}">
					<a  {if !($LISTVIEW_HEADER->has('sort'))} class="listViewHeaderValues cursorPointer" data-nextsortorderval="{if $COLUMN_NAME eq $LISTVIEW_HEADER->get('name')}{$NEXT_SORT_ORDER}{else}ASC{/if}" data-columnname="{$LISTVIEW_HEADER->get('name')}" {/if}>{vtranslate($LISTVIEW_HEADER->get('label'), $QUALIFIED_MODULE)}
						{if $COLUMN_NAME eq $LISTVIEW_HEADER->get('name')}<img class="{$SORT_IMAGE} icon-white">{/if}</a>
				</th>

				{/foreach}
					<th width="1%" nowrap class="{$WIDTHTYPE} alignMiddle">Actions</th>
					<th width="1%" nowrap class="{$WIDTHTYPE}"></th>
			</tr>
			<tr>
				<th width="1%" class="{$WIDTHTYPE}"></th>
							<th><div class="row-fluid">
								<input type="text" name="user_name" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SEARCH_USER}"/>
							</div></th>
							<th><div class="row-fluid">
								<input type="text" name="user_ip" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$USER_IP}"/>
							</div></th>
							<th>
								<span class="row-fluid input-append">
							     <input id="listviewsearchfield" type="text" class="logintime dateField span9 listSearchContributor autoComplete ui-autocomplete-input" name="login_time" data-date-format="dd-mm-yyyy" value="{$SIGNIN_TIME}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]">
				                 <span class="add-on"><i class="icon-calendar login"></i></span> 

								<!-- <input type="text" name="login_time" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SIGNIN_TIME}"/> -->
							</span></th>
							<th><span class="row-fluid input-append">


							  <input id="listviewsearchfield" type="text" class="logouttime dateField span9 listSearchContributor autoComplete ui-autocomplete-input" name="logout_time" data-date-format="dd-mm-yyyy" value="{$SIGNOUT_TIME}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]">
							  <span class="add-on"><i class="icon-calendar logout"></i></span> 

								<!-- <input type="text" name="logout_time" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SIGNOUT_TIME}"/> -->
							</span></th>
							<th><div class="row-fluid">
								<input type="text" name="status" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$STATUS}"/>
							</div></th>
							<th><div class="row-fluid"></div></th>
							<th><div class="row-fluid">
								<button class="btn btn-success search_btn" data-trigger="listSearch">{vtranslate('LBL_SEARCH', $MODULE )}</button>
							</div></th>
						</tr>
		</thead>
		<tbody>

		{foreach item=LISTVIEW_ENTRY from=$LISTVIEW_ENTRIES}
			<tr class="listViewEntries" data-id="{$LISTVIEW_ENTRY->getId()}"
					{if method_exists($LISTVIEW_ENTRY,'getDetailViewUrl')}data-recordurl="{$LISTVIEW_ENTRY->getDetailViewUrl()}"{/if}
			 >
			<td width="1%" nowrap class="{$WIDTHTYPE}">
				{if $MODULE eq 'CronTasks'}
					<img src="{vimage_path('drag.png')}" class="alignTop" title="{vtranslate('LBL_DRAG',$QUALIFIED_MODULE)}" />
				{/if}
			</td>
				{foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
					{assign var=LISTVIEW_HEADERNAME value=$LISTVIEW_HEADER->get('name')}
					{assign var=LAST_COLUMN value=$LISTVIEW_HEADER@last}
					<td class="listViewEntryValue {$WIDTHTYPE}"  width="{$WIDTH}%" nowrap>
						&nbsp;{$LISTVIEW_ENTRY->getDisplayValue($LISTVIEW_HEADERNAME)}
						{if $LAST_COLUMN && $LISTVIEW_ENTRY->getRecordLinks()}
							</td>
							<td nowrap class="{$WIDTHTYPE}">
								<div class="pull-right actions">
									<span class="actionImages">
										{foreach item=RECORD_LINK from=$LISTVIEW_ENTRY->getRecordLinks()}
											{assign var="RECORD_LINK_URL" value=$RECORD_LINK->getUrl()}
											<a {if stripos($RECORD_LINK_URL, 'javascript:')===0} onclick="{$RECORD_LINK_URL|substr:strlen("javascript:")};if(event.stopPropagation){ldelim}event.stopPropagation();{rdelim}else{ldelim}event.cancelBubble=true;{rdelim}" {else} href='{$RECORD_LINK_URL}' {/if}>
												<i class="{$RECORD_LINK->getIcon()} alignMiddle" title="{vtranslate($RECORD_LINK->getLabel(), $QUALIFIED_MODULE)}"></i>
											</a>
											{if !$RECORD_LINK@last}
												&nbsp;&nbsp;
											{/if}
										{/foreach}

									</span>
								</div>
							</td>
						{/if}
					</td>
				{/foreach}
				<td width="1%" nowrap class="{$WIDTHTYPE}">
				{if $MODULE eq 'OS2LoginHistory'}
					<!--<a href="{$LISTVIEW_ENTRY->getDetailViewUrl()}"   title="Activities" style="text-align:center;display:block;" ><i class="icon-list"></i>&nbsp;{$LISTVIEW_ENTRY->getDisplayValue('total')}</a>-->
					
					
					{if $LISTVIEW_ENTRY->getDisplayValue('total') gt 0}
					<a href="{$LISTVIEW_ENTRY->getDetailViewUrl()}"   title="Activities" style="text-align:center;display:block;" ><img src="layouts/vlayout/modules/Settings/OS2LoginHistory/list-view.png" width="17px"></a>
					{else}					
					<a title="No Activities to show" class ="btns disabled" style="text-align:center;display:block;"><img src="layouts/vlayout/modules/Settings/OS2LoginHistory/list-view-black.png" width="17px"></a>
					{/if}
					
				{/if}
			    </td>
			<td width="1%" nowrap class="{$WIDTHTYPE}">
			</td>
			</tr>
		{/foreach}
		</tbody>
	</table>
		<button type="button" class="btn btn-info btn-lg" data-toggle="modal" id="usersignbtn" data-target="#signedinmodal" style="display:none;">Open Modal</button>
		 <div class="modal fade" id="signedinmodal" role="dialog" style="width:90%;left: 25%;">
			<div class="modal-dialog">

			  <!-- Modal content-->
			  <div class="modal-content">
				<div class="modal-header">
				  <button type="button" class="close" data-dismiss="modal">&times;</button>
				  <h4 class="modal-title">OS2LoginHistory</h4>
				</div>
				<div class="modal-body" id="userlogdetails">
				  
				</div>
				<div class="modal-footer">
				  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			  </div>

			</div>
		  </div>


	<!--added this div for Temporarily -->
	{if $LISTVIEW_ENTRIES_COUNT eq '0'}
	<table class="emptyRecordsDiv">
		<tbody>
			<tr>
				<td>
					{vtranslate('LBL_EQ_ZERO')} {vtranslate($MODULE, $QUALIFIED_MODULE)} {vtranslate('LBL_FOUND')}
				</td>
			</tr>
		</tbody>
	</table>
	{/if}
</div>
{/strip}

<!-- added by jyothi for login++ -->
<script>
   $(document).ready(function(){
    $('[data-toggle="popover"]').popover();  
   	   app.registerEventForDatePickerFields('.logintime');
		jQuery('.login').on('click',function(){
		  jQuery(".logintime").trigger("focus");
		 });

		app.registerEventForDatePickerFields('.logouttime');
		jQuery('.logout').on('click',function(){
		  jQuery(".logouttime").trigger("focus");
		 });

		 jQuery('.search_btn').on('click',function(e){
		  var usersFilter =  jQuery('#usersFilter').val();
		  var user_name = jQuery('#usersFilter option:selected').text();
		  var username	=	jQuery('input[name=user_name]').val();
		  var userip	=	jQuery('input[name=user_ip]').val();
		  var signintime	=	jQuery('input[name=login_time]').val();
		  var signouttime	=	jQuery('input[name=logout_time]').val();
		  var status	=	jQuery('input[name=status]').val();
		  var pageNumber = jQuery('#pageNumber').val();
		  var currentLocation = 'index.php?module=OS2LoginHistory&parent=Settings&view=List&user_name='+user_name+'&search_key=user_name&search_value='+usersFilter+'&search_user='+username+'&userip='+userip+'&signintime='+signintime+'&signouttime='+signouttime+'&status='+status;
		  window.location.href=currentLocation;

      });

   });
</script>
<!-- ended here -->
<style media="screen">
.medium, .table td.medium, .listViewEntries td.medium, td.listViewEntryValue.medium {
	padding: 10px 6px !important;
}
	.btns.disabled, .btns[disabled] {
    cursor: default;
    background-image: none;    
    opacity: 0.40;
    filter: alpha(opacity=65);
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
    box-shadow: none;
}
	
.chzn-container-single .chzn-drop{
	display: inline-grid;
} 
 
</style>
