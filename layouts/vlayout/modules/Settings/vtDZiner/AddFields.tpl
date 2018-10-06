{strip}
{assign var=FIELD_TYPE_INFO value=$SELECTED_MODULE_MODEL->getAddFieldTypeInfo()}
{assign var=IS_SORTABLE value=$SELECTED_MODULE_MODEL->isSortableAllowed()}
{assign var=IS_BLOCK_SORTABLE value=$SELECTED_MODULE_MODEL->isBlockSortableAllowed()}
{assign var=ALL_BLOCK_LABELS value=[]}
{assign var=ACTIVE_FIELDS value=[]}
{assign var=IN_ACTIVE_FIELDS value=[]}
<div class='modelContainer addCustomFieldsView' id="addCustomFieldsContainer">
	<div class="contents tabbable">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">&times</button>
			<h3>{vtranslate('LBL_ADD_FIELDS', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground addCustomFields" id="addCustomFields" name="addCustomFields">
			<input name="hdn_entityid" id="hdn_entityid" type="hidden" value="{$ENTITY_RECORD}" />
			<input name="hdn_blockid" id="hdn_blockid" type="hidden" value="{$BLOCK_ID}" />
			<div class="modal-body">
				<table class="table equalSplit">
					<tr>
						<td class="fieldLabel medium" colspan=4><strong>Click the checkbox if you wish to create the new fields in a new block</strong></td>
					</tr>
					<tr>
						<td class="fieldLabel medium"><label class="muted pull-right marginRight10px">
							Create in new block</label>
						</td>
						<td class="fieldValue medium">
							<span class="value"><input type="checkbox" id="createNewBlock" name="createNewBlock" onclick="allowNewBlockInfo();"></span>
						</td>
						<td class="fieldLabel medium"><label class="muted pull-right marginRight10px">
							Block Label</label>
						</td>
						<td class="fieldValue medium">
							<span class="value"><input id="newBlockLabel" name="newBlockLabel" class="validate[required] text-input" type="text" class="span3" placeholder="Enter label for new block" disabled></span>
						</td>
					</tr>
				</table>
				<table>
					<thead>
						<tr>
							<th>
								<strong>
									Label Name
								</strong>
							</th>
							<th>
								<strong>
									Field UI Type
								</strong>
							</th>
							<th>
								<strong>
									Field Properties (dependant on Field UI Type)
								</strong>
							</th>
						</tr>
					</thead>
					<tbody>
					{for $fieldseq=1 to 10}
						<tr>
							<td>
								<input data-toggle='tooltip' id="fieldLabel_{$fieldseq}" type="text" maxlength="50" name="fieldLabel[{$fieldseq}]" value="" title="Enter a descriptive for the new custom field, leave blank and SAVE to submit"/>
							</td>
							<td>
								<select id="fieldType{$fieldseq}" class="fieldTypesList" name="fieldType[{$fieldseq}]" style="width:150px" onchange="setFieldProperties(this, {$fieldseq})">
									{foreach item=FIELD_TYPE from=$ADD_SUPPORTED_FIELD_TYPES}
										<option title="{$ADD_SUPPORTED_FIELD_TITLES[$FIELD_TYPE]}" value="{$FIELD_TYPE}"
											{foreach key=TYPE_INFO item=TYPE_INFO_VALUE from=$FIELD_TYPE_INFO[$FIELD_TYPE]}
												data-{$TYPE_INFO}="{$TYPE_INFO_VALUE}"
											{/foreach}>
											{vtranslate($FIELD_TYPE, $QUALIFIED_MODULE)}
										</option>
									{/foreach}
								</select>
							</td>
							<td>
								<table id="properties_{$fieldseq}">
									<tr class="standard">
										<td class="fieldlength">
											Length&nbsp;
										</td>
										<td>
											<input class="validate[required] text-input" id="fieldlength_{$fieldseq}" type="text" size="10" style="width:100px" name="fieldlength[{$fieldseq}]">
										</td>
										<td class="fielddecimals hide">
											Decimals&nbsp;
										</td>
										<td class="fielddecimals hide">
											<input class="validate[required] text-input" id="fielddecimallength_{$fieldseq}" type="text" size="10" style="width:100px" name="fielddecimallength[{$fieldseq}]">
										</td>
									</tr>
									<tr class="fieldrelation hide">
										<td>
											Related Module&nbsp;
										</td>
										<td>
											<!--input class="validate[required] text-input" id="fieldrelatedmodule_{$fieldseq}" type="text" size="20" style="width:200px" name="fieldrelatedmodule[{$fieldseq}]"-->
											<select class="relatedModulesList span3" id="fieldrelatedmodule_{$fieldseq}" name="fieldrelatedmodule_{$fieldseq}">
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
										</td>
									</tr>
									<tr class="fieldpicklist hide">
										<td>
											Picklist Values&nbsp;
										</td>
										<td>
											<input class="validate[required] text-input" id="fieldpicklistvalues_{$fieldseq}" type="text" size="20" style="width:200px" name="fieldpicklistvalues[{$fieldseq}]">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					{/for}
					<tbody>
				</table>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>
{/strip}