{strip}
{assign var=FIELD_TYPE_INFO value=$SELECTED_MODULE_MODEL->getAddFieldTypeInfo()}
{assign var=IS_SORTABLE value=$SELECTED_MODULE_MODEL->isSortableAllowed()}
{assign var=IS_BLOCK_SORTABLE value=$SELECTED_MODULE_MODEL->isBlockSortableAllowed()}
{assign var=ALL_BLOCK_LABELS value=[]}
{assign var=ACTIVE_FIELDS value=[]}
{assign var=IN_ACTIVE_FIELDS value=[]}
<div class='modelContainer modal addCustomFieldView' id="layoutEditorContainer">
	<div class="contents tabbable">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_CREATE_CUSTOM_FIELD', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground addCustomField" id="addCustomField" name="addCustomField">
			<input name="hdn_entityid" id="hdn_entityid" type="hidden" value="{$ENTITY_RECORD}" />
			<input name="hdn_blockid" id="hdn_blockid" type="hidden" value="{$BLOCK_ID}" />
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
						<strong>
							Select Field Type
						</strong>
					</span>
					<div class="controls">
						<span class="row-fluid">
							<select class="fieldTypesList span6" name="fieldType">
								{foreach item=FIELD_TYPE from=$ADD_SUPPORTED_FIELD_TYPES}
									<option title="{$ADD_SUPPORTED_FIELD_TITLES[$FIELD_TYPE]}" value="{$FIELD_TYPE}" 
											{foreach key=TYPE_INFO item=TYPE_INFO_VALUE from=$FIELD_TYPE_INFO[$FIELD_TYPE]}
												data-{$TYPE_INFO}="{$TYPE_INFO_VALUE}"
											{/foreach}
											>{vtranslate($FIELD_TYPE, $QUALIFIED_MODULE)}
									</option>
								{/foreach}
							</select>
						</span>
					</div>
				</div>
				<!-- Next -->
				<div class="control-group supportedType relatedtoOption hide">
					<span class="control-label">
						<strong>
							Related Module
						</strong>
					</span>
					<div class="controls">
						<span class="row-fluid">
							<select class="relatedModulesList span6" id="relatedModule" name="relatedModule" onchange="setRelatedLabel(this);">
								<option value="Users" title="Create a relation with {vtranslate('LBL_USERS', $QUALIFIED_MODULE)}">
									{vtranslate("LBL_USERS", $QUALIFIED_MODULE)}
								</option>
								{foreach item=MODULE_NAME from=$SUPPORTED_MODULES}
									<option title="Create a relation with {$MODULE_NAME}" value="{$MODULE_NAME}" {if $MODULE_NAME eq $SELECTED_MODULE_NAME} selected {/if}>
										{vtranslate($MODULE_NAME, $QUALIFIED_MODULE)}
									</option>
								{/foreach}
								<option value="Multimodule A" title="Creates a related field from a module choice of Vendors, Leads, Organizations, Contacts and Users">
									{vtranslate("Multimodule A", $QUALIFIED_MODULE)}
								</option>
								<option value="Multimodule B" title="Creates a related field from a module choice of Campaigns, Leads, Organizations, Opportunities and Tickets">
									{vtranslate("Multimodule B", $QUALIFIED_MODULE)}
								</option>
								<option value="Multimodule C" title="Creates a related field from a module choice of Organizations and Contacts">
									{vtranslate("Multimodule C", $QUALIFIED_MODULE)}
								</option>
								<option value="Multimodule D" title="Creates a related field from a module choice of Campaigns and Users">
									{vtranslate("Multimodule D", $QUALIFIED_MODULE)}
								</option>
							</select>
						</span>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							Label Name
						</strong>
						<span class="redColor">*</span>
					</span>
					<div class="controls">
						<input class="validate[required] text-input" type="text" maxlength="50" name="fieldLabel" id="fieldLabel" value="" data-validation-engine="validate[required, funcCall[Vtiger_Base_Validator_Js.invokeValidation]]"
							   data-validator={Zend_Json::encode([['name'=>'FieldLabel']])} />
						<!--input type="text" maxlength="50" name="fieldLabel" id="fieldLabel" value="" class="validate[required] text-input" /-->
					</div>
				</div>
				<div class="control-group supportedType lengthsupported">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_LENGTH', $QUALIFIED_MODULE)}
						</strong>
						<span class="redColor">*</span>
					</span>
					<div class="controls">
						<input class="validate[required]" type="text" name="fieldLength" value="" data-validation-engine="lengthsupported" />
					</div>
				</div>
			   <!-- Next --> 
				<div class="control-group supportedType decimalsupported hide">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_DECIMALS', $QUALIFIED_MODULE)}
						</strong>
						<span class="redColor">*</span>
					</span>
					<div class="controls">
						<input class="validate[required]" type="text" name="decimal" value="" data-validation-engine="decimalsupported" />
					</div>
				</div>
			  <!-- Next -->
			  <div class="control-group supportedType preDefinedValueExists hide">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_PICKLIST_VALUES', $QUALIFIED_MODULE)}
						</strong>
						<span class="redColor">*</span>
					</span>
					<div class="controls">
						<div class="row-fluid">
							<input class="validate[required] text-input span7 select2" type="hidden" id="picklistUi" name="pickListValues"
								placeholder="{vtranslate('LBL_ENTER_PICKLIST_VALUES', $QUALIFIED_MODULE)}" data-validation-engine="preDefinedValueExists"
								data-validator={Zend_Json::encode([['name'=>'PicklistFieldValues']])} />
						</div>
					</div>
				</div>
				<!-- Next -->
				<div class="control-group supportedType picklistOption hide">
					<span class="control-label">
						&nbsp;
					</span>
					<div class="controls">
						<label class="checkbox">
							<input type="checkbox" class="checkbox" name="isRoleBasedPickList" value="1" >&nbsp;{vtranslate('LBL_ROLE_BASED_PICKLIST',$QUALIFIED_MODULE)}
						</label>
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>
{/strip}