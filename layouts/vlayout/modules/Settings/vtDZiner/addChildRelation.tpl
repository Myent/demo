<div class="modal addRelationModal hide">
	<div class="modal-header">
		<button class="close vtButton" data-dismiss="modal">x</button>
			<h3>{vtranslate('LBL_ADD_CHILD_RELATION', "Settings::vtDZiner")}</h3>
	</div>
	<form class="form-horizontal contentsBackground addRelationForm">
		<div class="modal-body">
			<div class="control-group">
				<span class="control-label">
					<strong>
						{vtranslate('LBL_RELATED_MODULE_NAME', "Settings::vtDZiner")} <span class="redColor">*</span>
					</strong>
				</span>
				<div class="controls">
					<input type="hidden" name="reltabid" id="{$smarty.request.reltabid}" />

					<input type="hidden" name="parentmodule" value='{$SELECTED_MODULE_NAME}' />
					<select name="childmodule" id="childmodule" class="span3 vtselector" data-validation-engine="validate[required]" onchange="getRelatedModuleFields(this.value);selectReferenceField('child');">
					{foreach item=MODULE_LABEL key=MODULE_NAME from=$SUPPORTED_MODULES}
						{if $MODULE_NAME|in_array:$RELATED_MODULES['Childtabs']}
						{else}
							<option value="{$MODULE_NAME}">{$MODULE_LABEL}</option>
						{/if}
					{/foreach}
					</select>
				</div>
			</div>
			<div class="control-group">
				<span class="control-label">
					<strong>
						{vtranslate('LBL_RELATED_REFERENCE', "Settings::vtDZiner")} <span class="redColor">*</span>
					</strong>
				</span>
				<div class="controls">
					<input type="checkbox" name="relatedreference" id="relatedreference" onclick="selectReferenceField('child');" title="Check to include Reference field from {$SELECTED_MODULE_NAME} into Child Relation"/>
				</div>
			</div>
			<!--<div class="relatedFieldGroup hide">
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_RELATED_REFERENCE_LABEL', "Settings::vtDZiner")}
						</strong>
					</span>
					<div class="controls">
						<input type="text" name="referencelabel" id="referencelabel" /><br/>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_RELATED_MODULE_FIELDS', "Settings::vtDZiner")}
						</strong>
					</span>
					<div class="controls">
						<input type="checkbox" name="relatedfields" id="relatedfields" onclick="selectRelatedFields('child');" title="Check to include more information from {$SELECTED_MODULE_NAME} into Child Relation"/>
						<span class="relatedfieldslistarea hide">
						<br>Select fields from drop down and arrange their sequence
						<hr>
                        <select name="sel_col" id="sel_col"   class="select2-container columnsSelect" multiple>
                        </select>
						</span>
					</div>
				</div>
			</div> -->
		</div>
		{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
	</form>
</div>