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
	<div class="recordDetails">
		<div>
			<h4>Process Flow Module Summary</h4>
			<hr>
		</div>
         {foreach key=FIELD_NAME_DATA item=FIELD_VALUE_DATA from=$SUMMARY_INFORMATION_PROCESSFLOW}
            <div class="row-fluid textAlignCenter roundedCorners">
                {foreach key=FIELD_NAME item=FIELD_VALUE from=$FIELD_VALUE_DATA}
                    <span class="well squeezedWell span3">
                        <div>
                            <label class="font-x-small">
                                {vtranslate($FIELD_NAME,$MODULE_NAME)}
                            </label>
                        </div>
                        <div>
                            <label class="font-x-x-large {if $FIELD_NAME == "Pending Decision" || $FIELD_NAME == "Pending Approval" || $FIELD_NAME == "Task Completed" || $FIELD_NAME == "Total Time Spent"}showpopup{/if}" {if $FIELD_NAME == "Pending Decision" || $FIELD_NAME == "Pending Approval" || $FIELD_NAME == "Task Completed" || $FIELD_NAME == "Total Time Spent"}data-id="{$FIELD_NAME}"{/if}>
                                {if !empty($FIELD_VALUE['total']) && $FIELD_VALUE['filter'] != '' }<a href="index.php?module=Project&relatedModule=ProcessFlow&view=Detail&record={$RECORDID}&mode=showRelatedList&tab_label=ProcessFlow&pf_process_status={$FIELD_VALUE['filter']}" >{$FIELD_VALUE['total']}</a>{else}<a href="#x">{$FIELD_VALUE['total']}</a>{/if}
                            </label>
                        </div> 
                    </span>
                {/foreach}
            </div>
        {/foreach}
	</div>

	<div class="recordDetails">
		<div>
			<h4>Project {vtranslate('LBL_RECORD_SUMMARY',$MODULE_NAME)}	</h4>
			<hr>
		</div>
        {foreach item=SUMMARY_CATEGORY from=$SUMMARY_INFORMATION}
            <div class="row-fluid textAlignCenter roundedCorners">
                {foreach key=FIELD_NAME item=FIELD_VALUE from=$SUMMARY_CATEGORY}
                    <span class="well squeezedWell span3">
                        <div>
                            <label class="font-x-small">
                                {vtranslate($FIELD_NAME,$MODULE_NAME)}
                            </label>
                        </div>
                        <div>
                            <label class="font-x-x-large" >
                                {if !empty($FIELD_VALUE)}<a href="index.php?module=Project&relatedModule=ProjectTask&view=Detail&record={$RECORDID}&mode=showRelatedList&tab_label=Project Tasks&type={$FIELD_NAME}" data-label-key="Project Tasks">{$FIELD_VALUE}</a>{else}0{/if}
                            </label>
                        </div>
                    </span>
                {/foreach}
            </div>
        {/foreach}
		{include file='SummaryViewContents.tpl'|@vtemplate_path}
	</div>
    <!-- Button trigger modal -->

<!-- Modal -->
<!-- Modal -->
<style>
.modal{
    width: 80%; /* respsonsive width */
    margin-left:-40%; /* width/2) */ 
}
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>This is a large modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
{/strip}
