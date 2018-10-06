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
	<div class="listViewPageDiv">
		<div class="listViewTopMenuDiv">
			<h3>{vtranslate('Counters',$QUALIFIED_MODULE)}</h3>
            <hr>
			<div class="clearfix"></div>
		</div>
		<div class="listViewContentDiv contents row-fluid " id="listViewContents" style="padding: 1%;">
			<div class="span7">
			<form name="counters" action="#" method="post" class="form-horizontal" id="counters">
				{foreach item=COUNTER_DETAILS from=$COUNTER_BY_ID_DETAILS}
			
				{assign var=VIEWDATA value=$COUNTER_DETAILS.view|json_decode:true}
				
				{assign var=SELECTED_FILTERS value=","|explode:$COUNTER_DETAILS.filtername}
				<input type="hidden" id="selectedfilters"  value="{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($SELECTED_FILTERS))}">	
				<input type="hidden" name="module" value="Counters" />
				<input type="hidden" name="action" value="Save" />
				<input type="hidden" name="parent" value="Settings" />
				<input type="hidden" name="counterid" value="{$COUNTER_DETAILS.counterid}"/>
			<div class="row-fluid">
				<label class="fieldLabel span3"><strong>{vtranslate('Name of Widget',$QUALIFIED_MODULE)}</strong></label>
				<div class="span6 fieldValue">
					<input type="text" name="nameofwidget" class="" data-validation-engine='validate[required]' value="{$COUNTER_DETAILS.countername}">
				</div>
			</div><br/>
			<div class="row-fluid">
				<label class="fieldLabel span3"><strong>{vtranslate('LBL_SELECT_MODULE',$QUALIFIED_MODULE)} </strong></label>
				<div class="span6 fieldValue">
					<select class="chzn-select" id="pickListModules" name="modulename" data-validation-engine='validate[required]'>
						<optgroup>
							<option value="">{vtranslate('LBL_SELECT_OPTION',$QUALIFIED_MODULE)}</option>
							{foreach item=PICKLIST_MODULE from=$PICKLIST_MODULES}
								<option {if $COUNTER_DETAILS.module eq $PICKLIST_MODULE->get('name')} selected="" {/if}  value="{$PICKLIST_MODULE->get('name')}">{vtranslate($PICKLIST_MODULE->get('label'),$QUALIFIED_MODULE)}</option>
							{/foreach}	
						</optgroup>
					</select>
				</div>
			</div><br>
			
			<div class="row-fluid">
				<label class="fieldLabel span3"><strong>Filters</strong></label>
					{assign var=SELECTED_MODULE_IDS value=array()}
					<input type="hidden" id="filterDetails" name="filters" value="{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($FILTER_NAME))}">	
					<select data-placeholder="add filter" id="menuListSelectElement" data-validation-engine='validate[required]' class="select2 span6" multiple="" data-validation-engine="validate[required]" style="width:21%;" name="filtersname[]">
						
							<optgroup>
							<option value="">{vtranslate('LBL_SELECT_OPTION',$QUALIFIED_MODULE)}</option>
							{foreach item=PICKLIST_MODULE key=viewid from=$FILTER_NAME[$COUNTER_DETAILS.module]}
								<option  value="{$viewid}">{$PICKLIST_MODULE}</option>
							{/foreach}	
						</optgroup>
					</select>
				</div><br>
				<div class="row-fluid">
					<label class="fieldLabel span3"><strong>Widget Available Location</strong></label>
					<div class="span6 fieldValue">
						<input type="checkbox" name="widgetview[]" class="alignTop" value="List" {if List|in_array:$VIEWDATA} checked {/if}> 
						&nbsp;&nbsp;{vtranslate('List',$QUALIFIED_MODULE)}
						<br/>
						<input type="checkbox" name="widgetview[]" class="alignTop" value="Edit" {if Edit|in_array:$VIEWDATA} checked {/if}> 
						&nbsp;&nbsp;{vtranslate('Edit',$QUALIFIED_MODULE)}
						<br/>
						<input type="checkbox" name="widgetview[]" class="alignTop" value="Detail" {if Detail|in_array:$VIEWDATA} checked {/if}> 
						&nbsp;&nbsp;{vtranslate('Detail',$QUALIFIED_MODULE)}
						<br/>
						<input type="checkbox" name="widgetview[]" class="alignTop" value="HomeDashboard" {if HomeDashboard|in_array:$VIEWDATA} checked {/if}> 
						&nbsp;&nbsp;{vtranslate('HomeDashboard',$QUALIFIED_MODULE)}
						<br/>
						<input type="checkbox" name="widgetview[]" class="alignTop" value="ModuleDashboard" {if ModuleDashboard|in_array:$VIEWDATA} checked {/if}>
						&nbsp;&nbsp;{vtranslate('ModuleDashboard',$QUALIFIED_MODULE)}
					</div>
				</div>
			<br>

		
		   <div class="row-fluid">
				<div class="" style="margin-left: 340px">
					<button class="btn btn-success" id="button_save" type="submit"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
					<a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $MODULE)}</a>
				</div>
			</div>
			<div class="clearfix"></div>
			</div>
			<div class='span5'>
					<div class="row-fluid">
						
						<div class="span6 fieldValue" style='padding-top:90px;'>
								<i class="icon-info-sign alignMiddle"></i>&nbsp;{vtranslate('point1',$QUALIFIED_MODULE)}<br>
								<i class="icon-info-sign alignMiddle"></i>&nbsp;{vtranslate('point2',$QUALIFIED_MODULE)}<br>
								<i class="icon-info-sign alignMiddle"></i>&nbsp;{vtranslate('point3',$QUALIFIED_MODULE)}<br>
								<i class="icon-info-sign alignMiddle"></i>&nbsp;{vtranslate('point4',$QUALIFIED_MODULE)}<br>
								<i class="icon-info-sign alignMiddle"></i>&nbsp;{vtranslate('point5',$QUALIFIED_MODULE)}
						</div>
						
					</div>
			</div>
        </div>
		<br>
		{/foreach}
    </form>
</div>
	{/strip}	
