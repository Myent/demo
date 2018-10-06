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
<style>
	.checklist-item {
		border: 1px solid #ccc;
		padding: 20px 0;
		display: block;
		overflow: hidden;
		margin: 10px 0;
	}
	label {
		display: inline-block;
	}
</style>

{strip}
	{assign var=CURRENCY_ID value=$RECORD_MODEL->getId()}
	 
    <form id='CustomView' class="form-horizontal" method="POST">
    <div class="container-fluid" id="vte-primary-box" style="height: 563px; width: 1240px;">
			<input type="hidden" name="module" value="OS2CheckList" />
			<input type="hidden" value="Settings" name="parent">
			<input type="hidden" name="action" value="SaveAjax">
			<input type="hidden" id="textarea_id" name="count" value="0">
			<input type="hidden" name="checklistid" id="checklistid" value="{$CURRENCY_ID}">
			
			<input type="hidden" id="nameee" value="{$COUNT}">
            
			<div class="row-fluid" style="padding: 10px 0;">
				<h3 class="textAlignCenter">Edit<small aria-hidden="true" data-dismiss="modal" class="pull-right ui-checklist-closer" style="cursor: pointer;" title=" LBL_MODAL_CLOSE">x</small>
				</h3>
				<hr>
			</div>
			<div class="listViewContentDiv row-fluid" id="listViewContents" style="height: 450px; overflow-y: auto; width: 1250px;">
            <div class="marginBottom10px">
                <div class="row-fluid">
                    <div class="row marginBottom10px">
						
                        <div class="span4 textAlignRight">Check List Name</div>
						
                        <div class="fieldValue span6">
                            <input type="text" name="checklistname" value="{$RECORD_MODEL->get('checklistname')}" class="input-large">
                        </div>
                    </div>

                    <div class="row marginBottom10px">
                        <div class="span4 textAlignRight">Module Name</div>
							<div class="fieldValue span6">
								<select name="modulename" class="chzn-select" >
									{foreach item=PICKLIST_MODULE key=key from=$PICKLIST_MODULES}
										<option {if $modulename eq $PICKLIST_MODULE[0]} selected="" {/if} value="{$PICKLIST_MODULE[0]}">{$PICKLIST_MODULE[1]}</option>
									{/foreach}	
								</select>
							</div>
					</div>
				</div>
			
			<div class="marginBottom10px items-list">
                <table width="100%" cellpadding="5" cellspacing="5" class="items-list-table">
                    <tbody class="ui-sortable">
					{for $foo=0 to {$COUNT-1}}
						<tr class="checklist-item">
                            <td width="14" valign="middle"><i class="icon-move alignMiddle" title="Change ordering" data-record=""></i></td>
                            <td width="1172">
                                <table width="100%" cellpadding="5" cellspacing="5">
                                    <tbody class="ui-sortable">
									<tr>									
                                        <td width="25%"><img title="Category" data-url="" class="icon-info category_info" src="layouts/vlayout/modules/Settings/OS2CheckList/resources/info.png" width="16" height="16">
											<input type="text" name="category[]" value="{$CATEGORY[$foo]}" >
                                        </td>
                                        <td width="25%"><img title="Title" data-url="" class="icon-info title_info" src="layouts/vlayout/modules/Settings/OS2CheckList/resources/info.png" width="16" height="16">
                                            <input type="text" name="title[]" value="{$TITLE[$foo]}" placeholder="Title">
                                        </td>
                                        <td width="25%"><img title="Require Document/Attachment?" data-url="" class="icon-info allow_upload_info" src="layouts/vlayout/modules/Settings/OS2CheckList/resources/info.png" width="16" height="16">
                                        <label>Require Document/Attachment?</label>
                                        <input type="checkbox" class="allow_upload" value="0" {if $UPLOAD[$foo] eq 1}checked{/if}>
                                        <input type="hidden" name="allow_upload[]" class="allow_upload_value" value="{$UPLOAD[$foo]}">
                                        </td>
                                        <td width="25%"><img title="Allow Notes" data-url="" class="icon-info allow_note_info" src="layouts/vlayout/modules/Settings/OS2CheckList/resources/info.png" width="16" height="16">
                                        <label>Allow Notes</label>
                                        <input type="checkbox" class="allow_note" value="0" {if $NOTE[$foo] eq 1}checked{/if}>
                                        <input type="hidden" name="allow_note[]" class="allow_note_value" value="{$NOTE[$foo]}">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
											<textarea name="description[]" class="description" placeholder="Description" style="width: 800px; height: 75px; visibility: hidden; display: none;" id="desc_0">{$DESCRIPTION[$foo]}
											</textarea>
										</td>
									</tr>
								
									</tbody>
								</table>
							</td>
						</tr>
					{/for}
					</tbody>
				</table>
			</div>
			<div class="filterActions" style="padding: 10px 0;">
				<button class="btn addButton btn-add pull-left marginRight10px" id="add-checklist-item" type="button"><i class="icon-plus"></i>&nbsp;<strong>Add Checklist Item</strong></button>
				<button class="btn btn-success pull-right" id="save-checklist" type="submit"><strong>Save</strong></button>
			</div>
	</div>
	</form>

	<script type="text/javascript" src="libraries/jquery/ckeditor/ckeditor.js"></script>
{/strip}	