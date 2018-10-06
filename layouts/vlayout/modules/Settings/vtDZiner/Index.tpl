{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
* ("License"); You may not use this file except in compliance with the License
* The Original Code is:  vtiger CRM Open Source
* The Initial Developer of the Original Code is vtiger.
* Portions created by vtiger are Copyright (C) vtiger.
* All Rights Reserved.
********************************************************************************/
-->*}
{strip}
    <div class="container-fluid" id="layoutEditorContainer">
        <input id="selectedModuleName" type="hidden" value="{$SELECTED_MODULE_NAME}" />
        <div class="vtContents widget_header row-fluid">
			<div class="span6">
				<h3 style="display:inline">{vtranslate('vtDZiner', $QUALIFIED_MODULE)}
				<!--:: <span title="{vtranslate($SELECTED_MODULE_MODEL->label, $QUALIFIED_MODULE)} is the External name for this module">{vtranslate($SELECTED_MODULE_MODEL->label, $QUALIFIED_MODULE)}</span>&nbsp;[ <span title="{$SELECTED_MODULE_NAME} is the internal CRM name for module">{$SELECTED_MODULE_NAME}</span> ]
				<span title="Click on the link to view and accept recent updates to vtDZiner. Installed version is {$VTDZINER_CURRENTVERSION}. Latest version is {$VTDZINER_LATESTVERSION}">{if $VTDZINER_UPGRADEABLE}&nbsp;<sup><a class="upgradevtDZiner">Updates</a></sup>{/if}</span></h3>
				-->
			</div>
			<!-- Feb 2 2018 :: Manasa Added the Following Code -->
			 {assign var=AVAILABLEMODULESLIST value=Settings_ModuleManager_Module_Model::getAll()}
			 <select class="select2 span3 hide" name="AvailableModules">
				{foreach item=MODULE_MODEL key=MODULE_ID from=$AVAILABLEMODULESLIST}
					{assign var=MODULE_NAME value=$MODULE_MODEL->get('name')}
						<option value="{$MODULE_NAME}" >{vtranslate($MODULE_NAME, $MODULE_NAME)}</option>
				{/foreach}
			</select>
			<!-- Feb 2 2018 :: Manasa Added the Following Code Ended -->
            <div class="span6">
                <div class="pull-right">
                    <select class="select2 span3" name="layoutEditorModules">
                        {foreach item=MODULE_NAME from=$SUPPORTED_MODULES}
                            <option value="{$MODULE_NAME}" {if $MODULE_NAME eq $SELECTED_MODULE_NAME} selected {/if}>{vtranslate($MODULE_NAME, $QUALIFIED_MODULE)}</option>
                        {/foreach}
                    </select>&nbsp;<button class="btn" style="margin-top: 0;" title="Test drive {$SELECTED_MODULE_NAME}" onclick="window.open('index.php?module={$SELECTED_MODULE_NAME}&view=List','_self')">&nbsp;<i class="icon-road alignMiddle"></i>&nbsp;</button>
                </div>
            </div>
        </div>
        <hr>
		{assign var='MODULEMODEL' value=Vtiger_Module_Model::getInstance($SELECTED_MODULE_NAME)}
		
		
        <div class="contents tabbable">
            <ul class="nav nav-tabs layoutTabs massEditTabs">
				<li class="jtab vtModuleTab active"><a data-toggle="tab" href="#vtModuleSettings"><i class="icon-th-large"></i>&nbsp;<strong>{vtranslate('LBL_MODULE_OPTIONS', $QUALIFIED_MODULE)}</strong></a></li>
                <li class="jtab vtLayoutTab"><a data-toggle="tab" href="#detailViewLayout"><strong>{vtranslate('LBL_DETAILVIEW_LAYOUT', $QUALIFIED_MODULE)}</strong></a></li>
                <li class="jtab relatedListTab"><a data-toggle="tab" href="#relatedTabOrder"><i class="icon-random"></i>&nbsp;<strong>{vtranslate('LBL_ARRANGE_RELATED_TABS', $QUALIFIED_MODULE)}</strong></a></li>
				<!--li class="jtab vtDZinerTab"><a data-toggle="tab" href="#vtEventDZinerSettings"><i class="icon-binoculars"></i>&nbsp;<strong>{vtranslate('LBL_EVENTDZINER_SETTINGS', $QUALIFIED_MODULE)}</strong></a></li-->
				{if $MODULEMODEL->isExportable()}
				<li class="jtab vtDZinerTab"><a data-toggle="tab" href="#vtViewDZinerSettings"><i class="icon-binoculars"></i>&nbsp;<strong>{vtranslate('LBL_VIEWDZINER_SETTINGS', $QUALIFIED_MODULE)}</strong></a></li>
				{/if}
				<li class="jtab vtDZinerTab"><a data-toggle="tab" href="#vtWidgetDZinerSettings"><strong>{vtranslate('LBL_WIDGETDZINER_SETTINGS', $QUALIFIED_MODULE)}</strong></a></li>
				<li class="jtab vtDZinerTab"><a data-toggle="tab" href="#vtLanguageDZinerSettings"><strong>{vtranslate('LBL_LANGUAGEDZINER_SETTINGS', $QUALIFIED_MODULE)}</strong></a></li>
				<li class="jtab vtDZinerTab"><a data-toggle="tab" href="#vtDZinerSettings"><i class="icon-cog"></i>&nbsp;<strong>{vtranslate('LBL_VTDZINER_SETTINGS', $QUALIFIED_MODULE)}</strong></a></li>
				<!--li class="jtab vtDZinerTab"><a data-toggle="tab" href="#vtDZinerAbout"><i class="icon-bullhorn"></i>&nbsp;<strong>{vtranslate('LBL_VTDZINER_ABOUT', $QUALIFIED_MODULE)}</strong></a></li-->
            </ul>
            <div class="tab-content layoutContent padding20 themeTableColor overflowVisible">
				<div class="tab-pane active" id="vtModuleSettings">
					{include file="vtModuleSettings.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
				</div>
				<div class="tab-pane" id="vtDZinerSettings">
					{include file="vtDZinerSettings.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
				</div>
				<div class="tab-pane" id="vtEventDZinerSettings">
					<h3>Coming Soon</h3>
				</div>
				{if $MODULEMODEL->isExportable()}
					<div class="tab-pane" id="vtViewDZinerSettings">
						{include file="vtViewDZinerSettings.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
					</div>
				{/if}
				<div class="tab-pane" id="vtWidgetDZinerSettings">
					{include file="vtWidgetDZinerSettings.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
				</div>
				<div class="tab-pane" id="vtLanguageDZinerSettings">
					{include file="vtLanguageDZinerSettings.tpl"|@vtemplate_path:$QUALIFIED_MODULE}
				</div>
				<!--div class="tab-pane" id="vtDZinerAbout">
					{*include file="vtDZinerAbout.tpl"|@vtemplate_path:$QUALIFIED_MODULE*}
				</div-->
                <div class="tab-pane" id="detailViewLayout">
                    {assign var=FIELD_TYPE_INFO value=$SELECTED_MODULE_MODEL->getAddFieldTypeInfo()}
                    {assign var=IS_SORTABLE value=$SELECTED_MODULE_MODEL->isSortableAllowed()}
                    {assign var=IS_BLOCK_SORTABLE value=$SELECTED_MODULE_MODEL->isBlockSortableAllowed()}
                    {assign var=ALL_BLOCK_LABELS value=[]}
                    {if $IS_SORTABLE}
                        <div class="btn-toolbar">
                            <button class="btn addButton addCustomBlock" type="button">
                                <i class="icon-plus"></i>&nbsp;
                                <strong>{vtranslate('LBL_ADD_CUSTOM_BLOCK', $QUALIFIED_MODULE)}</strong>
                            </button>&nbsp;
                            <button class="btn addButton" type="button" onclick="window.open('index.php?parent=Settings&module=Picklist&view=Index&source_module={$SELECTED_MODULE_NAME}','_self')">
                                <i class="icon-list"></i>&nbsp;
                                <strong>{vtranslate('Edit Picklists', $QUALIFIED_MODULE)}</strong>
                            </button>&nbsp;
                            <span class="pull-right">
                                <button class="btn btn-success saveFieldSequence hide" type="button">
                                    <strong>{vtranslate('LBL_SAVE_FIELD_SEQUENCE', $QUALIFIED_MODULE)}</strong>
                                </button>
                            </span>
                        </div>
                    {/if}
                    <div id="moduleBlocks">
                        {foreach key=BLOCK_LABEL_KEY item=BLOCK_MODEL from=$BLOCKS}
                            {assign var=FIELDS_LIST value=$BLOCK_MODEL->getLayoutBlockActiveFields()}
                            {assign var=BLOCK_ID value=$BLOCK_MODEL->get('id')}
                            {$ALL_BLOCK_LABELS[$BLOCK_ID] = $BLOCK_LABEL_KEY}
                            <div id="block_{$BLOCK_ID}" class="editFieldsTable block_{$BLOCK_ID} marginBottom10px border1px {if $IS_BLOCK_SORTABLE} blockSortable{/if}" data-block-id="{$BLOCK_ID}" data-sequence="{$BLOCK_MODEL->get('sequence')}" style="border-radius: 4px 4px 0px 0px;background: white;">
                                <div class="row-fluid layoutBlockHeader">
                                    <div class="blockLabel span5 padding10 marginLeftZero">
                                        <img class="alignMiddle" src="{vimage_path('drag.png')}" />&nbsp;&nbsp;
                                        <strong>{vtranslate($BLOCK_LABEL_KEY, $SELECTED_MODULE_NAME)}</strong>
                                    </div>
                                    <div class="span6 marginLeftZero" style="float:right !important;">
										<div class="pull-right btn-toolbar blockActions" style="margin: 4px;">
											{if $BLOCK_MODEL->isAddCustomFieldEnabled()}
												<div class="btn-group">
													<!--
													<button class="btn addCustomFields" type="button">
														<strong>{vtranslate('LBL_ADD_CUSTOM_FIELDS', $QUALIFIED_MODULE)}</strong>
													</button>
													-->
													<button class="btn addCustomField" type="button">
														<strong>{vtranslate('LBL_ADD_CUSTOM_FIELD', $QUALIFIED_MODULE)}</strong>
													</button>
												</div>
											{/if}
											{if $BLOCK_MODEL->isActionsAllowed()}
												<div class="btn-group">
													<button class="btn dropdown-toggle" data-toggle="dropdown">
														<strong>{vtranslate('LBL_ACTIONS', $QUALIFIED_MODULE)}</strong>&nbsp;&nbsp;
														<i class="caret"></i>
													</button>
													<ul class="dropdown-menu pull-right">
														<li class="blockVisibility" data-visible="{if !$BLOCK_MODEL->isHidden()}1{else}0{/if}" data-block-id="{$BLOCK_MODEL->get('id')}">
															<a href="javascript:void(0)">
																<i class="icon-ok {if $BLOCK_MODEL->isHidden()} hide {/if}"></i>&nbsp;
																{vtranslate('LBL_ALWAYS_SHOW', $QUALIFIED_MODULE)}
															</a>
														</li>
														<li class="inActiveFields">
															<a href="javascript:void(0)">{vtranslate('LBL_INACTIVE_FIELDS', $QUALIFIED_MODULE)}</a>
														</li>
														{if $BLOCK_MODEL->isCustomized()}
															<li class="deleteCustomBlock">
																<a href="javascript:void(0)">{vtranslate('LBL_DELETE_CUSTOM_BLOCK', $QUALIFIED_MODULE)}</a>
															</li>
														{/if}
													</ul>
												</div>
											{/if}
										</div>
									</div>
								</div>
                                <div class="blockFieldsList {if $SELECTED_MODULE_MODEL->isFieldsSortableAllowed($BLOCK_LABEL_KEY)}blockFieldsSortable {/if} row-fluid" style="padding:5px;min-height: 27px">
                                    <ul name="sortable1" class="connectedSortable span6" style="list-style-type: none; float: left;min-height: 1px;padding:2px;">
                                        {foreach item=FIELD_MODEL from=$FIELDS_LIST name=fieldlist}
                                            {assign var=FIELD_INFO value=$FIELD_MODEL->getFieldInfo()}
                                            {if $smarty.foreach.fieldlist.index % 2 eq 0}
                                                <li>
                                                    <div class="opacity editFields marginLeftZero border1px" data-block-id="{$BLOCK_ID}" data-field-id="{$FIELD_MODEL->get('id')}" data-sequence="{$FIELD_MODEL->get('sequence')}">
                                                        <div class="row-fluid padding1per">
                                                            {assign var=IS_MANDATORY value=$FIELD_MODEL->isMandatory()}
                                                            <span class="span1">&nbsp;
                                                                {if $FIELD_MODEL->isEditable()}
                                                                    <a>
                                                                        <img src="{vimage_path('drag.png')}" border="0" title="{vtranslate('LBL_DRAG',$QUALIFIED_MODULE)}"/>
                                                                    </a>
                                                                {/if}
                                                            </span>
                                                            <div class="span11 marginLeftZero" style="word-wrap: break-word;">
                                                                <span class="fieldLabel">{vtranslate($FIELD_MODEL->get('label'), $SELECTED_MODULE_NAME)}&nbsp;
                                                                {if $IS_MANDATORY}<span class="redColor">*</span>{/if}
																</span>
																<span class="btn-group pull-right actions">
																	{if $FIELD_MODEL->isEditable()}
																		<a href="javascript:void(0)" class="dropdown-toggle editFieldDetails" data-toggle="dropdown">
																			<i class="icon-pencil alignMiddle" title="{vtranslate('LBL_EDIT', $QUALIFIED_MODULE)}"></i>
																		</a>
																		<div class="basicFieldOperations pull-right hide" style="width : 250px;">
																			<form class="form-horizontal fieldDetailsForm" method="POST">
																				<div class="modal-header contentsBackground">
																					<strong>{vtranslate($FIELD_MODEL->get('label'), $SELECTED_MODULE_NAME)}</strong>
																					<div class="pull-right"><a href="javascript:void(0)" class='cancel'>X</a></div>
																				</div>
																				<div style="padding-bottom: 5px;">
																					<span>
																						<input type="hidden" name="mandatory" value="O" />
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																							<input type="checkbox" name="mandatory" {if $IS_MANDATORY} checked {/if}
																							{if $FIELD_MODEL->isMandatoryOptionDisabled()} readonly="readonly" {/if} value="M" />&nbsp;
																						{vtranslate('LBL_MANDATORY_FIELD', $QUALIFIED_MODULE)}
																						</label>
																					</span>
																					<span>
																						<input type="hidden" name="presence" value="1" />
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																						<input type="checkbox" name="presence" {if $FIELD_MODEL->isViewable()} checked {/if}
																						{if $FIELD_MODEL->isActiveOptionDisabled()} readonly="readonly" class="optionDisabled"{/if} {if $IS_MANDATORY} readonly="readonly" {/if} value="2" />&nbsp;
																						{vtranslate('LBL_ACTIVE', $QUALIFIED_MODULE)}
																						</label>
																					</span>
																					<span>
																						<input type="hidden" name="quickcreate" value="1" />
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																							<input type="checkbox" name="quickcreate" {if $FIELD_MODEL->isQuickCreateEnabled()} checked {/if}
																						{if $FIELD_MODEL->isQuickCreateOptionDisabled()} readonly="readonly" class="optionDisabled"{/if} {if $IS_MANDATORY} readonly="readonly" {/if} value="2" />&nbsp;
																						{vtranslate('LBL_QUICK_CREATE', $QUALIFIED_MODULE)}
																						</label>
																					</span>
																					<span>
																						<input type="hidden" name="summaryfield" value="0"/>
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																							<input type="checkbox" name="summaryfield" {if $FIELD_MODEL->isSummaryField()} checked {/if}
																							{if $FIELD_MODEL->isSummaryFieldOptionDisabled()} readonly="readonly" class="optionDisabled"{/if} value="1" />&nbsp;
																						{vtranslate('LBL_SUMMARY_FIELD', $QUALIFIED_MODULE)}
																						</label>
																					</span>
																					<span>
																						<input type="hidden" name="masseditable" value="2" />
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																							<input type="checkbox" name="masseditable" {if $FIELD_MODEL->isMassEditable()} checked {/if}
																							{if $FIELD_MODEL->isMassEditOptionDisabled()} readonly="readonly" {/if} value="1" />&nbsp;
																						{vtranslate('LBL_MASS_EDIT', $QUALIFIED_MODULE)}
																						</label>
																					</span>
																					<span>
																						<input type="hidden" name="defaultvalue" value="" />
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																							<input type="checkbox" name="defaultvalue" {if $FIELD_MODEL->hasDefaultValue()} checked {/if}
																							{if $FIELD_MODEL->isDefaultValueOptionDisabled()} readonly="readonly" {/if} value="" />&nbsp;
																						{vtranslate('LBL_DEFAULT_VALUE', $QUALIFIED_MODULE)}
																						</label>
																						<div class="padding1per defaultValueUi {if !$FIELD_MODEL->hasDefaultValue()} zeroOpacity {/if}" style="padding : 0px 10px 0px 25px;">
																							{if $FIELD_MODEL->isDefaultValueOptionDisabled() neq "true"}
																								{if $FIELD_MODEL->getFieldDataType() eq "picklist"}
																									{assign var=PICKLIST_VALUES value=$FIELD_MODEL->getPicklistValues()}
																									<select class="span2" name="fieldDefaultValue" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if} data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" data-fieldinfo='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($FIELD_INFO))}'>
																										{foreach item=PICKLIST_VALUE key=PICKLIST_NAME from=$PICKLIST_VALUES}
																											<option value="{Vtiger_Util_Helper::toSafeHTML($PICKLIST_NAME)}" {if decode_html($FIELD_MODEL->get('defaultvalue')) eq $PICKLIST_NAME} selected {/if}>{vtranslate($PICKLIST_VALUE, $SELECTED_MODULE_NAME)}</option>
																										{/foreach}
																									</select>
																								{elseif $FIELD_MODEL->getFieldDataType() eq "multipicklist"}
																									{assign var=PICKLIST_VALUES value=$FIELD_MODEL->getPicklistValues()}
																									{assign var="FIELD_VALUE_LIST" value=explode(' |##| ',$FIELD_MODEL->get('defaultvalue'))}
																									<select multiple class="span2" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if}  name="fieldDefaultValue" data-fieldinfo='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($FIELD_INFO))}'>
																										{foreach item=PICKLIST_VALUE from=$PICKLIST_VALUES}
																											<option value="{Vtiger_Util_Helper::toSafeHTML($PICKLIST_VALUE)}" {if in_array(Vtiger_Util_Helper::toSafeHTML($PICKLIST_VALUE), $FIELD_VALUE_LIST)} selected {/if}>{vtranslate($PICKLIST_VALUE, $SELECTED_MODULE_NAME)}</option>
																										{/foreach}
																									</select>
																								{elseif $FIELD_MODEL->getFieldDataType() eq "boolean"}
																									<input type="hidden" name="fieldDefaultValue" value="" />
																									<input type="checkbox" name="fieldDefaultValue" value="1"
																									{if $FIELD_MODEL->get('defaultvalue') eq 1} checked {/if} data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' />
																								{elseif $FIELD_MODEL->getFieldDataType() eq "time"}
																									<div class="input-append time">
																										<input type="text" class="input-small" data-format="{$USER_MODEL->get('hour_format')}" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if} data-toregister="time" value="{$FIELD_MODEL->get('defaultvalue')}" name="fieldDefaultValue" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}'/>
																										<span class="add-on cursorPointer">
																											<i class="icon-time"></i>
																										</span>
																									</div>
																								{elseif $FIELD_MODEL->getFieldDataType() eq "date"}
																									<div class="input-append date">
																										{assign var=FIELD_NAME value=$FIELD_MODEL->get('name')}
																										<input type="text" class="input-medium" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if} name="fieldDefaultValue" data-toregister="date" data-date-format="{$USER_MODEL->get('date_format')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}'
																											   value="{$FIELD_MODEL->getEditViewDisplayValue($FIELD_MODEL->get('defaultvalue'))}" />
																										<span class="add-on">
																											<i class="icon-calendar"></i>
																										</span>
																									</div>
																								{elseif $FIELD_MODEL->getFieldDataType() eq "percentage"}
																									<div class="input-append">
																										<input type="number" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if}  class="input-medium" name="fieldDefaultValue"
																											   value="{$FIELD_MODEL->get('defaultvalue')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' step="any" />
																										<span class="add-on">%</span>
																									</div>
																								{elseif $FIELD_MODEL->getFieldDataType() eq "currency"}
																									<div class="input-prepend">
																										<span class="add-on">{$USER_MODEL->get('currency_symbol')}</span>
																										<input type="text" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if}  class="input-medium" name="fieldDefaultValue"
																											   data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' value="{$FIELD_MODEL->getEditViewDisplayValue($FIELD_MODEL->get('defaultvalue'))}"
																											   data-decimal-seperator='{$USER_MODEL->get('currency_decimal_separator')}' data-group-seperator='{$USER_MODEL->get('currency_grouping_separator')}' />
																									</div>
																								{else if $FIELD_MODEL->getFieldName() eq "terms_conditions" && $FIELD_MODEL->get('uitype') == 19}
																									{assign var=INVENTORY_TERMS_AND_CONDITIONS_MODEL value= Settings_Vtiger_MenuItem_Model::getInstance("INVENTORYTERMSANDCONDITIONS")}
																									<a href="{$INVENTORY_TERMS_AND_CONDITIONS_MODEL->getUrl()}" target="_blank">{vtranslate('LBL_CLICK_HERE_TO_EDIT', $QUALIFIED_MODULE)}</a>
																								{else}
																									<input type="text" class="input-medium" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if}  name="fieldDefaultValue" value="{$FIELD_MODEL->get('defaultvalue')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}'/>
																								{/if}
																							{/if}
																						</div>
																					</span>
																				</div>
																				<div class="modal-footer" style="padding: 0px;">
																					<span class="pull-right">
																						<div class="pull-right"><a href="javascript:void(0)" style="margin: 5px;color:#AA3434;margin-top:10px;" class='cancel'>{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}</a></div>
																						<button class="btn btn-success saveFieldDetails" data-field-id="{$FIELD_MODEL->get('id')}" type="submit" style="margin: 5px;">
																							<strong>{vtranslate('LBL_SAVE', $QUALIFIED_MODULE)}</strong>
																						</button>
																					</span>
																				</div>
																			</form>
																		</div>
																	{/if}
																	{if $FIELD_MODEL->isCustomField() eq 'true'}
																		<a href="javascript:void(0)" class="deleteCustomField" data-field-id="{$FIELD_MODEL->get('id')}">
																			<i class="icon-trash alignMiddle" title="{vtranslate('LBL_DELETE', $QUALIFIED_MODULE)}"></i>
																		</a>
																	{/if}
																</span>
															</div>
														</div>
													</div>
												</li>
											{/if}
										{/foreach}
									</ul>
									<ul {if $SELECTED_MODULE_MODEL->isFieldsSortableAllowed($BLOCK_LABEL_KEY)}name="sortable2"{/if} class="connectedSortable span6" style="list-style-type: none; margin: 0; float: left;min-height: 1px;padding:2px;">
										{foreach item=FIELD_MODEL from=$FIELDS_LIST name=fieldlist1}
											{assign var=FIELD_INFO value=$FIELD_MODEL->getFieldInfo()}
											{if $smarty.foreach.fieldlist1.index % 2 neq 0}
												<li>
													<div class="opacity editFields marginLeftZero border1px" data-block-id="{$BLOCK_ID}" data-field-id="{$FIELD_MODEL->get('id')}" data-sequence="{$FIELD_MODEL->get('sequence')}">
														<div class="row-fluid padding1per">
															{assign var=IS_MANDATORY value=$FIELD_MODEL->isMandatory()}
															<span class="span1">&nbsp;
																{if $FIELD_MODEL->isEditable()}
																	<a>
																		<img src="{vimage_path('drag.png')}" border="0" title="{vtranslate('LBL_DRAG',$QUALIFIED_MODULE)}"/>
																	</a>
																{/if}
															</span>
															<div class="span11 marginLeftZero" style="word-wrap: break-word;">
																<span class="fieldLabel">
																	{if $IS_MANDATORY}
																		<span class="redColor">*</span>
																	{/if}
																	{vtranslate($FIELD_MODEL->get('label'), $SELECTED_MODULE_NAME)}&nbsp;
																</span>
																<span class="btn-group pull-right actions">
																	{if $FIELD_MODEL->isEditable()}
																		<a href="javascript:void(0)" class="dropdown-toggle editFieldDetails" data-toggle="dropdown">
																			<i class="icon-pencil alignMiddle" title="{vtranslate('LBL_EDIT', $QUALIFIED_MODULE)}"></i>
																		</a>
																		<div class="basicFieldOperations pull-right hide" style="width : 250px;">
																			<form class="form-horizontal fieldDetailsForm" method="POST">
																				<div class="modal-header contentsBackground">
																					<strong>{vtranslate($FIELD_MODEL->get('label'), $SELECTED_MODULE_NAME)}</strong>
																					<div class="pull-right"><a href="javascript:void(0)" class="cancel">X</a></div>
																				</div>
																				<div style="padding-bottom: 5px;">
																					<span>
																						<input type="hidden" name="mandatory" value="O" />
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																							<input type="checkbox" name="mandatory" {if $IS_MANDATORY} checked {/if}
																							{if $FIELD_MODEL->isMandatoryOptionDisabled()} readonly="readonly" {/if} value="M" />&nbsp;
																							{vtranslate('LBL_MANDATORY_FIELD', $QUALIFIED_MODULE)}
																						</label>
																					</span>
																					<span>
																						<input type="hidden" name="presence" value="1" />
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																							<input type="checkbox" name="presence" {if $FIELD_MODEL->isViewable()} checked {/if}
																							{if $FIELD_MODEL->isActiveOptionDisabled()} readonly="readonly" class="optionDisabled"{/if} {if $IS_MANDATORY} readonly="readonly" {/if} value="2" />&nbsp;
																							{vtranslate('LBL_ACTIVE', $QUALIFIED_MODULE)}
																						</label>
																					</span>
																					<span>
																						<input type="hidden" name="quickcreate" value="1" />
																						<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																							<input type="checkbox" name="quickcreate" {if $FIELD_MODEL->isQuickCreateEnabled()} checked {/if}
																								{if $FIELD_MODEL->isQuickCreateOptionDisabled()} readonly="readonly" class="optionDisabled"{/if} {if $IS_MANDATORY} readonly="readonly" {/if} value="2" />&nbsp;
																							{vtranslate('LBL_QUICK_CREATE', $QUALIFIED_MODULE)}
																						</label>
																					</span>
																<span>
																	<input type="hidden" name="summaryfield" value="0"/>
																	<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																		<input type="checkbox" name="summaryfield" {if $FIELD_MODEL->isSummaryField()} checked {/if}
																		{if $FIELD_MODEL->isSummaryFieldOptionDisabled()} readonly="readonly" class="optionDisabled"{/if} value="1" />&nbsp;
																		{vtranslate('LBL_SUMMARY_FIELD', $QUALIFIED_MODULE)}
																	</label>
																</span>
																<span>
																	<input type="hidden" name="masseditable" value="2" />
																	<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																		<input type="checkbox" name="masseditable" {if $FIELD_MODEL->isMassEditable()} checked {/if}
																		{if $FIELD_MODEL->isMassEditOptionDisabled()} readonly="readonly" {/if} value="1" />&nbsp;
																	{vtranslate('LBL_MASS_EDIT', $QUALIFIED_MODULE)}
																	</label>
																</span>
														<span>
															<input type="hidden" name="defaultvalue" value="" />
															<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																<input type="checkbox" name="defaultvalue" {if $FIELD_MODEL->hasDefaultValue()} checked {/if}
																{if $FIELD_MODEL->isDefaultValueOptionDisabled()} readonly="readonly" {/if} value="" />&nbsp;
															{vtranslate('LBL_DEFAULT_VALUE', $QUALIFIED_MODULE)}
															</label>
															<div class="padding1per defaultValueUi {if !$FIELD_MODEL->hasDefaultValue()} zeroOpacity {/if}" style="padding : 0px 10px 0px 25px;">
																{if $FIELD_MODEL->isDefaultValueOptionDisabled() neq "true"}
																	{if $FIELD_MODEL->getFieldDataType() eq "picklist"}
																		{assign var=PICKLIST_VALUES value=$FIELD_MODEL->getPicklistValues()}
																		<select class="span2" name="fieldDefaultValue" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if} data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" data-fieldinfo='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($FIELD_INFO))}'>
																			{foreach item=PICKLIST_VALUE key=PICKLIST_NAME from=$PICKLIST_VALUES}
																				<option value="{Vtiger_Util_Helper::toSafeHTML($PICKLIST_NAME)}" {if decode_html($FIELD_MODEL->get('defaultvalue')) eq $PICKLIST_NAME} selected {/if}>{vtranslate($PICKLIST_VALUE, $SELECTED_MODULE_NAME)}</option>
																			{/foreach}
																		</select>
																	{elseif $FIELD_MODEL->getFieldDataType() eq "multipicklist"}
																		{assign var=PICKLIST_VALUES value=$FIELD_MODEL->getPicklistValues()}
																		{assign var="FIELD_VALUE_LIST" value=explode(' |##| ',$FIELD_MODEL->get('defaultvalue'))}
																		<select multiple class="span2" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if}  name="fieldDefaultValue" data-fieldinfo='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($FIELD_INFO))}'>
																			{foreach item=PICKLIST_VALUE from=$PICKLIST_VALUES}
																				<option value="{Vtiger_Util_Helper::toSafeHTML($PICKLIST_VALUE)}" {if in_array(Vtiger_Util_Helper::toSafeHTML($PICKLIST_VALUE), $FIELD_VALUE_LIST)} selected {/if}>{vtranslate($PICKLIST_VALUE, $SELECTED_MODULE_NAME)}</option>
																			{/foreach}
																		</select>
																	{elseif $FIELD_MODEL->getFieldDataType() eq "boolean"}
																		<input type="hidden" name="fieldDefaultValue" value="" />
																		<input type="checkbox" name="fieldDefaultValue" value="1"
																		{if $FIELD_MODEL->get('defaultvalue') eq 1} checked {/if} data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' />
																	{elseif $FIELD_MODEL->getFieldDataType() eq "time"}
																		<div class="input-append time">
																			<input type="text" class="input-small" data-format="{$USER_MODEL->get('hour_format')}" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if} data-toregister="time" value="{$FIELD_MODEL->get('defaultvalue')}" name="fieldDefaultValue" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}'/>
																			<span class="add-on cursorPointer">
																				<i class="icon-time"></i>
																			</span>
																		</div>
																	{elseif $FIELD_MODEL->getFieldDataType() eq "date"}
																		<div class="input-append date">
																			{assign var=FIELD_NAME value=$FIELD_MODEL->get('name')}
																			<input type="text" class="input-medium" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if} name="fieldDefaultValue" data-toregister="date" data-date-format="{$USER_MODEL->get('date_format')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}'
																				   value="{$FIELD_MODEL->getEditViewDisplayValue($FIELD_MODEL->get('defaultvalue'))}" />
																			<span class="add-on">
																				<i class="icon-calendar"></i>
																			</span>
																		</div>
																	{elseif $FIELD_MODEL->getFieldDataType() eq "percentage"}
																		<div class="input-append">
																			<input type="number" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if}  class="input-medium" name="fieldDefaultValue"
																				   value="{$FIELD_MODEL->get('defaultvalue')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' step="any" />
																			<span class="add-on">%</span>
																		</div>
																	{elseif $FIELD_MODEL->getFieldDataType() eq "currency"}
																		<div class="input-prepend">
																			<span class="add-on">{$USER_MODEL->get('currency_symbol')}</span>
																			<input type="text" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if}  class="input-medium" name="fieldDefaultValue"
																				   data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' value="{$FIELD_MODEL->getEditViewDisplayValue($FIELD_MODEL->get('defaultvalue'))}"
																				   data-decimal-seperator='{$USER_MODEL->get('currency_decimal_separator')}' data-group-seperator='{$USER_MODEL->get('currency_grouping_separator')}' />
																		</div>
																	{else}
																		<input type="text" class="input-medium" data-validation-engine="validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" {if !$FIELD_MODEL->hasDefaultValue()} disabled="" {/if}  name="fieldDefaultValue" value="{$FIELD_MODEL->get('defaultvalue')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}'/>
																	{/if}
																{/if}
															</div>
														</span>
													</div>
													<div class="modal-footer" style="padding: 0px;">
														<span class="pull-right">
															<div class="pull-right"><a href="javascript:void(0)" style="margin: 5px;color:#AA3434;margin-top:10px;" class="cancel">{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}</a></div>
															<button class="btn btn-success saveFieldDetails" data-field-id="{$FIELD_MODEL->get('id')}" type="submit" style="margin: 5px;">
																<strong>{vtranslate('LBL_SAVE', $QUALIFIED_MODULE)}</strong>
															</button>
														</span>
													</div>
												</form>
										</div>
										{/if}
										{if $FIELD_MODEL->isCustomField() eq 'true'}
											<a href="javascript:void(0)" class="deleteCustomField" data-field-id="{$FIELD_MODEL->get('id')}">
												<i class="icon-trash alignMiddle" title="{vtranslate('LBL_DELETE', $QUALIFIED_MODULE)}"></i>
											</a>
										{/if}
										</span>
										</div>
										</div>
										</div>
										</li>
										{/if}
										{/foreach}
									</ul>
								</div>
							</div>
						{/foreach}
					</div>

					<input type="hidden" class="inActiveFieldsArray" value='{ZEND_JSON::encode($IN_ACTIVE_FIELDS)}' />

					<div class="newCustomBlockCopy hide marginBottom10px border1px {if $IS_BLOCK_SORTABLE}blockSortable {/if}" data-block-id="" data-sequence="" style="border-radius: 4px;">
						<div class="row-fluid layoutBlockHeader">
							<div class="span6 blockLabel padding10">
								<img class="alignMiddle" src="{vimage_path('drag.png')}" />&nbsp;&nbsp;
							</div>
							<div class="span6 marginLeftZero">
								<div class="pull-right btn-toolbar blockActions" style="margin: 4px;">
									<div class="btn-group">
										<button class="btn addCustomField hide" type="button">
											<strong>{vtranslate('LBL_ADD_CUSTOM_FIELD', $QUALIFIED_MODULE)}</strong>
										</button>
									</div>
									<div class="btn-group">
										<button class="btn dropdown-toggle" data-toggle="dropdown">
											<strong>{vtranslate('LBL_ACTIONS', $QUALIFIED_MODULE)}</strong>&nbsp;&nbsp;
											<i class="caret"></i>
										</button>
										<ul class="dropdown-menu pull-right">
											<li class="blockVisibility" data-visible="1" data-block-id="">
												<a href="javascript:void(0)">
													<i class="icon-ok"></i>&nbsp;{vtranslate('LBL_ALWAYS_SHOW', $QUALIFIED_MODULE)}
												</a>
											</li>
											<li class="inActiveFields">
												<a href="javascript:void(0)">{vtranslate('LBL_INACTIVE_FIELDS', $QUALIFIED_MODULE)}</a>
											</li>
											<li class="deleteCustomBlock">
												<a href="javascript:void(0)">{vtranslate('LBL_DELETE_CUSTOM_BLOCK', $QUALIFIED_MODULE)}</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="blockFieldsList row-fluid blockFieldsSortable" style="padding:5px;min-height: 27px">
							<ul class="connectedSortable span6 ui-sortable" style="list-style-type: none; float: left;min-height:1px;padding:2px;" name="sortable1"></ul>
							<ul class="connectedSortable span6 ui-sortable" style="list-style-type: none; margin: 0;float: left;min-height:1px;padding:2px;" name="sortable2"></ul>
						</div>
					</div>

					<li class="newCustomFieldCopy hide">
						<div class="marginLeftZero border1px" data-field-id="" data-sequence="">
							<div class="row-fluid padding1per">
								<span class="span1">&nbsp;
									{if $IS_SORTABLE}
										<a>
											<img src="{vimage_path('drag.png')}" border="0" title="{vtranslate('LBL_DRAG',$QUALIFIED_MODULE)}"/>
										</a>
									{/if}
								</span>
								<div class="span11 marginLeftZero" style="word-wrap: break-word;">
									<span class="fieldLabel"></span>
									<span class="btn-group pull-right actions">
										{if $IS_SORTABLE}
											<a href="javascript:void(0)" class="dropdown-toggle editFieldDetails" data-toggle="dropdown">
												<i class="icon-pencil alignMiddle" title="{vtranslate('LBL_EDIT', $QUALIFIED_MODULE)}"></i>
											</a>
											<div class="basicFieldOperations hide pull-right" style="width: 250px;">
												<form class="form-horizontal fieldDetailsForm" method="POST">
													<div class="modal-header contentsBackground">
													</div>
													<div style="padding-bottom: 5px;">
														<span>
															<input type="hidden" name="mandatory" value="O" />
															<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																<input type="checkbox" name="mandatory" value="M" />&nbsp;{vtranslate('LBL_MANDATORY_FIELD', $QUALIFIED_MODULE)}
															</label>
														</span>
														<span>
															<input type="hidden" name="presence" value="1" />
															<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																<input type="checkbox" name="presence" value="2" />&nbsp;{vtranslate('LBL_ACTIVE', $QUALIFIED_MODULE)}
															</label>
														</span>
														<span>
															<input type="hidden" name="quickcreate" value="1" />
															<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																<input type="checkbox" name="quickcreate" value="2" />&nbsp;{vtranslate('LBL_QUICK_CREATE', $QUALIFIED_MODULE)}
															</label>
														</span>
														<span>
															<input type="hidden" name="summaryfield" value="0"/>
															<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																<input type="checkbox" name="summaryfield" value="1" />&nbsp;{vtranslate('LBL_SUMMARY_FIELD', $QUALIFIED_MODULE)}
															</label>
														</span>
														<span>
															<input type="hidden" name="masseditable" value="2" />
															<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																<input type="checkbox" name="masseditable" value="1" />&nbsp;{vtranslate('LBL_MASS_EDIT', $QUALIFIED_MODULE)}
															</label>
														</span>
														<span>
															<input type="hidden" name="defaultvalue" value="" />
															<label class="checkbox" style="padding-left: 25px; padding-top: 5px;">
																<input type="checkbox" name="defaultvalue" value="" />&nbsp;
																{vtranslate('LBL_DEFAULT_VALUE', $QUALIFIED_MODULE)}</label>
															<div class="padding1per defaultValueUi" style="padding : 0px 10px 0px 25px;"></div>
														</span>
													</div>
													<div class="modal-footer">
														<span class="pull-right">
															<div class="pull-right"><a href="javascript:void(0)" style="margin-top: 5px;margin-left: 10px;color:#AA3434;" class='cancel'>{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}</a></div>
															<button class="btn btn-success saveFieldDetails" data-field-id="" type="submit"><strong>{vtranslate('LBL_SAVE', $QUALIFIED_MODULE)}</strong></button>
														</span>
													</div>
												</form>
											</div>
										{/if}
										<a href="javascript:void(0)" class="deleteCustomField" data-field-id=""><i class="icon-trash alignMiddle" title="{vtranslate('LBL_DELETE', $QUALIFIED_MODULE)}"></i></a>
									</span>
								</div>
							</div>
						</div>
					</li>

					{include file='ModuleSettingsmodals.tpl'|@vtemplate_path:'Settings::vtDZiner'}
					{include file='NewModule.tpl'|@vtemplate_path:'Settings::vtDZiner'}
					{include file='NewMenuCategory.tpl'|@vtemplate_path:'Settings::vtDZiner'}

					<div class="modal addBlockModal hide">
						<div class="modal-header contentsBackground">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h3>{vtranslate('LBL_ADD_CUSTOM_BLOCK', $QUALIFIED_MODULE)}</h3>
						</div>
						<form class="form-horizontal addCustomBlockForm" method="POST">
							<div class="modal-body">
								<div class="control-group">
									<span class="control-label">
										<span class="redColor">*</span>
										<span>{vtranslate('LBL_BLOCK_NAME', $QUALIFIED_MODULE)}</span>
									</span>
									<div class="controls">
										<input type="text" name="label" class="span3" data-validation-engine="validate[required]" />
									</div>
								</div>
								<div class="control-group">
									<span class="control-label">
										{vtranslate('LBL_ADD_AFTER', $QUALIFIED_MODULE)}
									</span>
									<div class="controls">
										<span class="row-fluid">
											<select class="span8" name="beforeBlockId">
												{foreach key=BLOCK_ID item=BLOCK_LABEL from=$ALL_BLOCK_LABELS}
													<option value="{$BLOCK_ID}" data-label="{$BLOCK_LABEL}">{vtranslate($BLOCK_LABEL, $SELECTED_MODULE_NAME)}</option>
												{/foreach}
											</select>
										</span>
									</div>
								</div>
								<div class="control-group">
									<span class="control-label">
										<strong>
											{vtranslate('LBL_CUSTOM_BLOCK_TYPE', $QUALIFIED_MODULE)}
										</strong>
									</span>
									<div class="controls">
										<span class="row-fluid"><select class="span8" name="blockType">
											<option title = "Vanilla Vtiger Block of Data fields" value="Standard" data-label="Standard">Standard</option>
											<!--option title = "Enables Comments block access from right side panel" value="Comments" data-label="Comments">Comments</option>
											<!--
											<option value="Related" data-label="Related">Related</option>
											<option value="Subpanels" data-label="Subpanels">Subpanels</option>
											<option value="Pickblock" data-label="Pickblock">Pickblock</option>
											<option value="Address" data-label=""></option>
											<option value="Grid" data-label=""></option>
											-->
										</select></span>
									</div>
								</div>
							</div>
							{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
						</form>
					</div>

					<div class="modal createFieldModal hide">
						<div class="modal-header contentsBackground">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h3>{vtranslate('LBL_CREATE_CUSTOM_FIELD', $QUALIFIED_MODULE)}</h3>
						</div>
						<form class="form-horizontal createCustomFieldForm" method="POST">
							<div class="modal-body">
								<div class="control-group">
									<span class="control-label">
										{vtranslate('LBL_SELECT_FIELD_TYPE', $QUALIFIED_MODULE)}
									</span>
									<div class="controls">
										<span class="row-fluid">
											<select class="fieldTypesList span7" name="fieldType">
												{foreach item=FIELD_TYPE from=$ADD_SUPPORTED_FIELD_TYPES}
													<option value="{$FIELD_TYPE}"
															{foreach key=TYPE_INFO item=TYPE_INFO_VALUE from=$FIELD_TYPE_INFO[$FIELD_TYPE]}
																data-{$TYPE_INFO}="{$TYPE_INFO_VALUE}"
															{/foreach}>
														{vtranslate($FIELD_TYPE, $QUALIFIED_MODULE)}
													</option>
												{/foreach}
											</select>
										</span>
									</div>
								</div>
								<div class="control-group supportedType relatedtoOption hide">
									<span class="control-label">
										<strong>
											{vtranslate('LBL_RELATED_MODULE_NAME', $QUALIFIED_MODULE)}
										</strong>
									</span>
									<div class="controls">
										<span class="row-fluid"><select class="relatedModulesList span6" name="relatedModule">
											{foreach item=MODULE_NAME from=$SUPPORTED_MODULES}
												<option value="{$MODULE_NAME}" {if $MODULE_NAME eq $SELECTED_MODULE_NAME} selected {/if}>{vtranslate($MODULE_NAME, $QUALIFIED_MODULE)}</option>
											{/foreach}
										</select></span>
									</div>
								</div>
								<div class="control-group">
									<span class="control-label">
										<span class="redColor">*</span>&nbsp;
										{vtranslate('LBL_LABEL_NAME', $QUALIFIED_MODULE)}
									</span>
									<div class="controls">
										<input type="text" maxlength="50" name="fieldLabel" value="" data-validation-engine="validate[required, funcCall[Vtiger_Base_Validator_Js.invokeValidation]]"
											   data-validator={Zend_Json::encode([['name'=>'FieldLabel']])} />
									</div>
								</div>
								<div class="control-group supportedType lengthsupported">
									<span class="control-label">
										<span class="redColor">*</span>&nbsp;
										{vtranslate('LBL_LENGTH', $QUALIFIED_MODULE)}
									</span>
									<div class="controls">
										<input type="text" name="fieldLength" value="" data-validation-engine="validate[required, funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" />
									</div>
								</div>
								<div class="control-group supportedType decimalsupported hide">
									<span class="control-label">
										<span class="redColor">*</span>&nbsp;
										{vtranslate('LBL_DECIMALS', $QUALIFIED_MODULE)}
									</span>
									<div class="controls">
										<input type="text" name="decimal" value="" data-validation-engine="validate[required, funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" />
									</div>
								</div>
								<div class="control-group supportedType preDefinedValueExists hide">
									<span class="control-label">
										<span class="redColor">*</span>&nbsp;
										{vtranslate('LBL_PICKLIST_VALUES', $QUALIFIED_MODULE)}
									</span>
									<div class="controls">
										<div class="row-fluid">
											<input type="hidden" id="picklistUi" class="span7 select2" name="pickListValues"
												   placeholder="{vtranslate('LBL_ENTER_PICKLIST_VALUES', $QUALIFIED_MODULE)}" data-validation-engine="validate[required, funcCall[Vtiger_Base_Validator_Js.invokeValidation]]" data-validator={Zend_Json::encode([['name'=>'PicklistFieldValues']])} />
										</div>
									</div>
								</div>
								<div class="control-group supportedType picklistOption hide">
									<span class="control-label">
										&nbsp;
									</span>
									<div class="controls">
										<label class="checkbox span3" style="margin-left: 0px;">
											<input type="checkbox" class="checkbox" name="isRoleBasedPickList" value="1" >&nbsp;{vtranslate('LBL_ROLE_BASED_PICKLIST',$QUALIFIED_MODULE)}
										</label>
									</div>
								</div>
							</div>
							{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
						</form>
					</div>

					<div class="modal inactiveFieldsModal hide">
						<div class="modal-header contentsBackground">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h3>{vtranslate('LBL_INACTIVE_FIELDS', $QUALIFIED_MODULE)}</h3>
						</div>
						<form class="form-horizontal inactiveFieldsForm" method="POST">
							<div class="modal-body">
								<div class="row-fluid inActiveList"></div>
							</div>
							<div class="modal-footer">
								<div class=" pull-right cancelLinkContainer">
									<a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}</a>
								</div>
								<button class="btn btn-success" type="submit" name="reactivateButton">
									<strong>{vtranslate('LBL_REACTIVATE', $QUALIFIED_MODULE)}</strong>
								</button>
							</div>
						</form>
					</div>
				</div>
				<div class="tab-pane" id="relatedTabOrder">
				</div>
			</div>
		</div>
	</div>
{/strip}
<script>
	var blocksList = {$ALL_BLOCK_LABELS|json_encode};
	var themesList = {$VTIGERTHEMES|json_encode};
	var tabid = {$SELECTED_MODULE_MODEL->id};
	var sourceModule = "{$SELECTED_MODULE_NAME}";
	var path = "";
	var mypath = [];
	var plparams ={};
	var pickBlock = {};			// will hold the array of blockids assigned as pickblock for each picklist item
	var vtDZ_pickBlocks = {};	// will hold the array of blockids that have been chosed as pickblocks for the picklist 
	var plFieldId = {};			// will hold the fieldid of the picklist field
	var plFieldName = {};		// will hold the fieldid of the picklist field
	var plFieldBlockId = {};	// will hold the blockid of the picklist field, used to prevent selection as pickblock
	var plFieldLabel2Name = {}; // will hold the field label as value of the picklist field, used to preload
	var panelsList = {$PANELTABS|json_encode};
	if (panelsList.length == 0) panelsList = {};
	var widgetObject = {$MODULEWIDGETS|json_encode}; 
	languagesList=[];
	crmLanguages = {$LANGUAGES|json_encode};
	alllanguagesList = {$LANGUAGESLIST|json_encode};			// global
	worldLanguages  = {$LANGUAGECODES|json_encode};				// Not used
	currentLanguage = "{$LANGUAGE}";
	langlabelsobject ="";										// Re used, conside local scope
	bulkLabels ="";												// Re used, conside local scope
	jsbulkLabels ="";											// Re used, conside local scope
	langLabels_Smarty = {$MODULELANGUAGELABELS|json_encode};
	jslangLabels_Smarty = {$MODULELANGUAGEJSLABELS|json_encode};
	otherlangLabels_Smarty = {$OTHERLANGUAGESLIST|json_encode};
	jsotherlangLabels_Smarty = {$JSOTHERLANGUAGESLIST|json_encode};
	// TODO Get rid of this messy handling in splitting path names
	directory_separator = "{$HOST_DIRECTORY_SEPERATOR}";
	var vtDZParentRelations = []; 
	var moduleLanguagesList;
	var widgetTypesList = [
		["DETAILVIEW","Place a button in the Detail View header","index.php?module=Reports&view=Detail&record=12"],
		["DETAILVIEWBASIC","Adds a hyperlink in Actions button, in Detail View mode only, ( eg Import)","index.php?module=gas&view=Import<br/> index.php?module=Documents&action=EditView&return_module=$MODULE$&return_action=DetailView&return_id=$RECORD$&parent_id=$RECORD$ <br/> index.php?module=gas&view=Export&selected_ids=[$RECORD$]"],
		["DASHBOARDWIDGET","Place a widget in the Dashboard Add Widget button dropdown","index.php?module=modulename&view=ShowWidget&name=History -- History of records"],
		["DETAILVIEWSETTING","Adds a hyperlink in Settings dropdown in Detail View mode only, ( eg Import)","index.php?module=MenuEditor&parent=Settings&view=Index -- Menu Editor<br/> index.php?module=MenuEditor&parent=Settings&view=Index&block=2&fieldid=11 -- Users List"],
		
		["DETAILVIEWSIDEBARLINK","Place a hyperlink in the Sidebar, in Detail View mode only","index.php?module=Contacts&view=List"],
		["DETAILVIEWSIDEBARWIDGET","Place a action window in the Sidebar, in Detail View mode only","module=Products&view=List&viewname=52"],
		["DETAILVIEWTAB","Adds items to right side bar in Detail View (eg Record Summary)","index.php?module=Products&view=List&viewname=52<br/>index.php?module=modulename&view=ShowWidget&name=History"],
		["DETAILVIEWWIDGET","Adds a Block to Detail view with Custom Actions, like Comments block","module=Products&view=List&viewname=52"],
		
		["HEADERCSS","Preloads the specified source CSS in CRM","Write your own for css menu modification and upload into crm and give proper path suppose <b>layouts\vlayout\skins\firebrick\style.css</b>"],
		["HEADERLINK","Place a link in the CRM Header Area, to the right of the default links",'Please Specify proper url'],
		["HEADERSCRIPT","Preloads the specified source javascript in CRM","Add your javascript code with disturbing header.tpl add new js, External js also it is accepting.Inside crm js means give proper path."],
		["LISTVIEW","Adds a hyperlink in Actions button, in List View mode only, ( eg Import)"," http://www.google.com, Internal CRM paths"],
		["LISTVIEWBASIC","Place a button in the List View header"," http://www.google.com, Internal CRM paths or custom functionalty on popup like add folder in documents module"],
		["LISTVIEWMASSACTION ","Add a Mass Action link in Actions drop down, to be operated on all selected records","Please write your own functionality to do something or give inside crm paths index.php?module=Documents&view=List"],
		["LISTVIEWSETTING","Adds a hyperlink in Settings dropdown in List View mode only, ( eg Import)","module=Users&parent=Settings&view=List"],
		["LISTVIEWSIDEBARLINK","Place a hyperlink in the Sidebar, in List View mode only","module=Users&parent=Settings&view=List"],
		["LISTVIEWSIDEBARWIDGET","Place a action window in the Sidebar, in List View mode only","module=Users&parent=Settings&view=List"],
		["SIDEBARLINK","Place a hyperlink in the Sidebar, irrespective of View mode","index.php?module=Contacts&view=List"],
		["SIDEBARWIDGET","Place a action window in the Sidebar, irrespective of View mode","module=Products&view=List&viewname=52"]
	];

	// http://www.geocities.ws/xpf51/HTMLREF/HEX_CODES.html
		colornames={};
		colornames['#CD5C5C'] = 'indianred';
		colornames['#F08080'] = 'lightcoral';
		colornames['#FA8072'] = 'salmon';
		colornames['#E9967A'] = 'darksalmon';
		colornames['#FFA07A'] = 'lightsalmon';
		colornames['#DC143C'] = 'crimson';
		colornames['#FF0000'] = 'red';
		colornames['#B22222'] = 'firebrick';
		colornames['#8B0000'] = 'darkred';
		colornames['#FFC0CB'] = 'pink';
		colornames['#FFB6C1'] = 'lightpink';
		colornames['#FF69B4'] = 'hotpink';
		colornames['#FF1493'] = 'deeppink';
		colornames['#C71585'] = 'mediumvioletred';
		colornames['#DB7093'] = 'palevioletred';
		colornames['#FFA07A'] = 'lightsalmon';
		colornames['#FF7F50'] = 'coral';
		colornames['#FF6347'] = 'tomato';
		colornames['#FF4500'] = 'orangered';
		colornames['#FF8C00'] = 'darkorange';
		colornames['#FFA500'] = 'orange';
		colornames['#FFD700'] = 'gold';
		colornames['#FFFF00'] = 'yellow';
		colornames['#FFFFE0'] = 'lightyellow';
		colornames['#FFFACD'] = 'lemonchiffon';
		colornames['#FAFAD2'] = 'lightgoldenrodyellow';
		colornames['#FFEFD5'] = 'papayawhip';
		colornames['#FFE4B5'] = 'moccasin';
		colornames['#FFDAB9'] = 'peachpuff';
		colornames['#EEE8AA'] = 'palegoldenrod';
		colornames['#F0E68C'] = 'khaki';
		colornames['#BDB76B'] = 'darkkhaki';
		colornames['#E6E6FA'] = 'lavender';
		colornames['#D8BFD8'] = 'thistle';
		colornames['#DDA0DD'] = 'plum';
		colornames['#EE82EE'] = 'violet';
		colornames['#DA70D6'] = 'orchid';
		colornames['#FF00FF'] = 'fuchsia';
		colornames['#FF00FF'] = 'magenta';
		colornames['#BA55D3'] = 'mediumorchid';
		colornames['#9370DB'] = 'mediumpurple';
		colornames['#8A2BE2'] = 'blueviolet';
		colornames['#9400D3'] = 'darkviolet';
		colornames['#9932CC'] = 'darkorchid';
		colornames['#8B008B'] = 'darkmagenta';
		colornames['#800080'] = 'purple';
		colornames['#4B0082'] = 'indigo';
		colornames['#6A5ACD'] = 'slateblue';
		colornames['#483D8B'] = 'darkslateblue';
		colornames['#7B68EE'] = 'mediumslateblue';
		colornames['#ADFF2F'] = 'greenyellow';
		colornames['#7FFF00'] = 'chartreuse';
		colornames['#7CFC00'] = 'lawngreen';
		colornames['#00FF00'] = 'lime';
		colornames['#32CD32'] = 'limegreen';
		colornames['#98FB98'] = 'palegreen';
		colornames['#90EE90'] = 'lightgreen';
		colornames['#00FA9A'] = 'mediumspringgreen';
		colornames['#00FF7F'] = 'springgreen';
		colornames['#3CB371'] = 'mediumseagreen';
		colornames['#2E8B57'] = 'seagreen';
		colornames['#228B22'] = 'forestgreen';
		colornames['#008000'] = 'green';
		colornames['#006400'] = 'darkgreen';
		colornames['#9ACD32'] = 'yellowgreen';
		colornames['#6B8E23'] = 'olivedrab';
		colornames['#808000'] = 'olive';
		colornames['#556B2F'] = 'darkolivegreen';
		colornames['#66CDAA'] = 'mediumaquamarine';
		colornames['#8FBC8F'] = 'darkseagreen';
		colornames['#20B2AA'] = 'lightseagreen';
		colornames['#008B8B'] = 'darkcyan';
		colornames['#008080'] = 'teal';
		colornames['#00FFFF'] = 'aqua';
		colornames['#00FFFF'] = 'cyan';
		colornames['#E0FFFF'] = 'lightcyan';
		colornames['#AFEEEE'] = 'paleturquoise';
		colornames['#7FFFD4'] = 'aquamarine';
		colornames['#40E0D0'] = 'turquoise';
		colornames['#48D1CC'] = 'mediumturquoise';
		colornames['#00CED1'] = 'darkturquoise';
		colornames['#5F9EA0'] = 'cadetblue';
		colornames['#4682B4'] = 'steelblue';
		colornames['#B0C4DE'] = 'lightsteelblue';
		colornames['#B0E0E6'] = 'powderblue';
		colornames['#ADD8E6'] = 'lightblue';
		colornames['#87CEEB'] = 'skyblue';
		colornames['#87CEFA'] = 'lightskyblue';
		colornames['#00BFFF'] = 'deepskyblue';
		colornames['#1E90FF'] = 'dodgerblue';
		colornames['#6495ED'] = 'cornflowerblue';
		colornames['#7B68EE'] = 'mediumslateblue';
		colornames['#4169E1'] = 'royalblue';
		colornames['#0000FF'] = 'blue';
		colornames['#0000CD'] = 'mediumblue';
		colornames['#00008B'] = 'darkblue';
		colornames['#000080'] = 'navy';
		colornames['#191970'] = 'midnightblue';
		colornames['#FFF8DC'] = 'cornsilk';
		colornames['#FFEBCD'] = 'blanchedalmond';
		colornames['#FFE4C4'] = 'bisque';
		colornames['#FFDEAD'] = 'navajowhite';
		colornames['#F5DEB3'] = 'wheat';
		colornames['#DEB887'] = 'burlywood';
		colornames['#D2B48C'] = 'tan';
		colornames['#BC8F8F'] = 'rosybrown';
		colornames['#F4A460'] = 'sandybrown';
		colornames['#DAA520'] = 'goldenrod';
		colornames['#B8860B'] = 'darkgoldenrod';
		colornames['#CD853F'] = 'peru';
		colornames['#D2691E'] = 'chocolate';
		colornames['#8B4513'] = 'saddlebrown';
		colornames['#A0522D'] = 'sienna';
		colornames['#A52A2A'] = 'brown';
		colornames['#800000'] = 'maroon';
		colornames['#FFFFFF'] = 'white';
		colornames['#FFFAFA'] = 'snow';
		colornames['#F0FFF0'] = 'honeydew';
		colornames['#F5FFFA'] = 'mintcream';
		colornames['#F0FFFF'] = 'azure';
		colornames['#F0F8FF'] = 'aliceblue';
		colornames['#F8F8FF'] = 'ghostwhite';
		colornames['#F5F5F5'] = 'whitesmoke';
		colornames['#FFF5EE'] = 'seashell';
		colornames['#F5F5DC'] = 'beige';
		colornames['#FDF5E6'] = 'oldlace';
		colornames['#FFFAF0'] = 'floralwhite';
		colornames['#FFFFF0'] = 'ivory';
		colornames['#FAEBD7'] = 'antiquewhite';
		colornames['#FAF0E6'] = 'linen';
		colornames['#FFF0F5'] = 'lavenderblush';
		colornames['#FFE4E1'] = 'mistyrose';
		colornames['#DCDCDC'] = 'gainsboro';
		colornames['#D3D3D3'] = 'lightgrey';
		colornames['#C0C0C0'] = 'silver';
		colornames['#A9A9A9'] = 'darkgray';
		colornames['#808080'] = 'gray';
		colornames['#696969'] = 'dimgray';
		colornames['#778899'] = 'lightslategray';
		colornames['#708090'] = 'slategray';
		colornames['#2F4F4F'] = 'darkslategray';
		colornames['#000000'] = 'black';
	// end color names http://www.geocities.ws/xpf51/HTMLREF/HEX_CODES.html
</script>
{*include file="AllFunctions.tpl"|@vtemplate_path:$QUALIFIED_MODULE*}
{foreach item=MODULE_MODEL from=$RELATED_PARENTMODULES}
	{if $MODULE_MODEL->isActive()}
	<script>
		vtDZParentRelations.push("{$MODULE_MODEL->get('modulename')}");
	</script>
	{/if}
{/foreach}