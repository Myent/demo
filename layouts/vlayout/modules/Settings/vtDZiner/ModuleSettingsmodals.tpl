<!--
All Module Settings Modals are written here
-->

<!-- vtDZinerDeActivation UI starts :: STP on 19th May,2013 -->               
<div class="modal vtDZinerDeActivationModal hide">
	<div class="modal-header">
		<button class="close vtButton" data-dismiss="modal">&times</button>
		<h3>vtDZiner Deactivation</h3>
		Are you sure you wish to Deactivate?<br>
		If you wish to proceed with Deactivate, click on SAVE else CANCEL
	</div>
	<form class="form-horizontal contentsBackground vtDZinerDeActivationForm">
		<div class="modal-body">
			<div class="control-group">
				<span class="control-label">
				Activation Key :
				</span>
				<div class="controls">
				<input type="text" name="vtDZinerKey" class="span4" data-validation-engine="validate[required]" />
				</div>
			</div>
		</div>
		{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
	</form>
</div>

<div class="ModuleSettingsmodals">
	<!-- upgradevtDZiner UI starts :: STP on 19th May,2013 -->               
	<div class="modal upgradevtDZinerModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">&times</button>
			<h3>vtDZiner Update</h3>
			Are you sure you wish to upgrade?<br>
			If you wish to proceed with vtDZiner update, enter your activation key amd click on SAVE<br>
			else click on CANCEL to not upgrade
		</div>
		<form class="form-horizontal contentsBackground upgradevtDZinerForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
					Activation Key :
					</span>
					<div class="controls">
					<input type="text" name="vtDZinerKey" class="span3" data-validation-engine="validate[required]" />
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div> 

	<div class="modal enableTrackerModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_CONFIRM_TRACKER_TOGGLE', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground enableTrackerForm">
			<input type="hidden" name="sourceModule" value="{$SELECTED_MODULE_NAME}">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('Tracker Status', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls alignMiddle">
						{if $TRACKINGENABLED}ON{else}OFF{/if}. Save to toggle status, cancel to retain status
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>

	<div class="modal enablePortalModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_CONFIRM_ENABLE_PORTAL', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground enablePortalForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('Portal Status', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<input type="checkbox" name="cbTracker" {if $PORTALINFO["present"]}checked disabled="disabled"{/if}/>&nbsp;
						{if $PORTALINFO["present"]}Present{if $PORTALINFO["visible"]}, Visibility is ON{else}, Visibility is OFF{/if}<br/><a href="index.php?module=CustomerPortal&parent=Settings&view=Index&block=4&fieldid=30" target="_blank">Click for More options</a>{else}Not Present<br/>Set checkbox on and click on SAVE to setup in CRM{/if}
					</div>
				</div>
				{if $PORTALINFO["present"]}
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('Portal Module Source Files 6.0, 6.1', $QUALIFIED_MODULE)}
						</strong>
					</span>
					<div class="controls">
						<a href="test/user/{$SELECTED_MODULE_NAME}.6.1.zip">Click to Download</a>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('Portal Module Source Files 6.2', $QUALIFIED_MODULE)}
						</strong>
					</span>
					<div class="controls">
						<a href="test/user/{$SELECTED_MODULE_NAME}.6.2.zip">Click to Download</a>
					</div>
				</div>
				{/if}
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>

	<div class="modal enablevtDZinerModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_CONFIRM_UPGRADE_MODULE', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground enablevtDZinerForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('vtDZiner Compatibility', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<input type="checkbox" name="cbvtDZiner"/>
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>

	<div class="modal disableModuleModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_CONFIRM_DISABLE_MODULE', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground disableModuleForm">
			<div class="modal-body">
				<div class="control-group">
					<strong>
						{vtranslate('You can re-enable from Module Manager', $QUALIFIED_MODULE)} <span class="redColor">*</span>
					</strong>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>

	<!--div class="modal exportModuleModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_CONFIRM_EXPORT_MODULE', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground exportModuleForm">
		<input type="hidden" name="forModule" value="{$SELECTED_MODULE_NAME}">
			<div class="modal-body">
				<div class="control-group">
					<strong>
						{vtranslate('Export module and attributes to a Vtiger installable ZIP file', $QUALIFIED_MODULE)} <span class="redColor">*</span>
					</strong>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div-->

	<div class="modal removeModuleModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_CONFIRM_REMOVE_MODULE', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground removeModuleForm">
			<div class="modal-body">
				<div class="control-group">
					<strong>
						{vtranslate('Be Absolutely SURE !!! This step is not revocable. Ensure that you have a backup and are quite sure of this step. This action will delete all module scripts, data and crm meta data', $QUALIFIED_MODULE)} <span class="redColor">*</span>
					</strong>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('vtDZiner Key', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<input type="text" name="vtDZinerKey" value='' />
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('vtDZiner Reset Key', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<input type="text" name="vtDZinerResetKey" value='' />
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>

	<div class="modal registerCustomWorkflowModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_ADD_WORKFLOW_METHOD', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground registerCustomWorkflowForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_WORKFLOW_LABEL', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<input type="text" name="cmLabel" value='' />
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_WORKFLOW_METHOD_NAME', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<input type="text" name="cmName" value='' />
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_WORKFLOW_HANDLER_NAME', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<input type="text" name="cmHandler" value='' />
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>

	<div class="modal changeParentCategoryModal hide">
			<div class="modal-header">
					<button class="close vtButton" data-dismiss="modal">x</button>
							<h3>{vtranslate('Change Parent Menu for ', "Settings::vtDZiner")}{$SELECTED_MODULE_NAME}</h3>
			</div>
			<form class="form-horizontal contentsBackground changeParentCategoryForm">
					<div class="modal-body">
							<div class="control-group">
									<span class="control-label">
									{vtranslate('LBL_MENU_CATEGORYNAME', "Settings::vtDZiner")}<br>
									Present Parent Menu Category is <strong>{$SELECTED_MODULE_MODEL->parent}</strong>
									</span>
									<div class="controls">
										<span class="row-fluid">
											<select class="vtselector span6" name="newParentCategory" id="newParentCategory">
												{foreach from=$PARENTTAB key=k item=v}
													<option value="{$v}">{$v}</option>
												{/foreach}
											</select>
										</span>
									</div>
							</div>
					</div>
					{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
					<input type="hidden" name="oldParentCategory" value="{$SELECTED_MODULE_MODEL->parent}">
					<input type="hidden" name="sourceModule" value="{$SELECTED_MODULE_NAME}">
			</form>
	</div>

	<div class="modal uploadModuleImageIconModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal">x</button>
				<h3>{vtranslate('LBL_MODULE_IMAGE', $QUALIFIED_MODULE)}</h3>
		</div>
		<form class="form-horizontal contentsBackground uploadModuleImageIconForm" enctype="multipart/form-data">
		<input name="module" id="module" type="hidden" value="vtDZiner" />
		<input name="parent" id="parent" type="hidden" value="Settings" />
		<input name="view" id="view" type="hidden" value="IndexAjax" />
		<input name="mode" id="mode" type="hidden" value="saveIcon" />
		<input id="selectedModuleName" name="selectedModuleName" type="hidden" value="{$SELECTED_MODULE_NAME}" />
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_PRESENT_IMAGE', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						{assign var="moduleImage" value="layouts/vlayout/skins/images/$SELECTED_MODULE_NAME.png"}
						{if file_exists($moduleImage) }
							<img title="Present Image/Icon" alt="Present Image/Icon" src="{$moduleImage}" class="alignMiddle">	
						{else}
							No present image found
						{/if}
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_PROPOSED_IMAGE', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<div id="preview"></div>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_SELECT_IMAGE_FILE', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<!--<input type="file" id = "moduleImageFile" name="moduleImageFile" onchange="readURL(this);"/>-->
						<input type="file" id="file" class="file_uploader" multiple name="file"/>
					</div>
				</div>
				
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_PROPOSED_IMAGE_SUMVIEW', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<div id="preview_sum"></div>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_SELECT_IMAGE_FILE_SUMVIEW', $QUALIFIED_MODULE)} <span class="redColor">*</span>
						</strong>
					</span>
					<div class="controls">
						<!--<input type="file" id = "moduleImageFile" name="moduleImageFile" onchange="readURL(this);"/>-->
						<input type="file" id="file_sum" class="file_uploader_sum" multiple name="file_sum"/>
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>