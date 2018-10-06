{strip}
<!-- vtDZiner Add Module UI starts :: STP on 19th May,2013 -->               
<div class="modal addCustomModuleModal hide">
	<div class="modal-header">
		<button class="close vtButton" data-dismiss="modal">x</button>
		<h3>{vtranslate('LBL_CREATE_MODULE', $QUALIFIED_MODULE)}</h3>
	</div>
	<form class="form-horizontal contentsBackground addCustomModuleForm">
		<div class="modal-body">
			<div class="control-group">
				<span class="control-label">
					<strong>
					{vtranslate('LBL_CUSTOM_MODULE_TYPE', $QUALIFIED_MODULE)}
					</strong>
				</span>
				<div class="controls">
					<span class="row-fluid">
						<select class="span6 vtselector" name="moduleType">
							<option value="Entity" data-label="Entity">Entity</option>
							<!--option value="Extension" data-label="Extension">Extension</option>
							<!--option value="Language" disabled data-label="Language">Language</option>
							<option value="Theme" disabled data-label="Theme">Theme</option>
							<option value="Portal" disabled data-label="Portal">Portal</option>
							<option value="Process" disabled data-label="Process">Process</option>
							<option value="Chart" disabled data-label="Chart">Chart</option-->
						</select>
					</span>
				</div>
			</div>
			<div class="control-group">
				<span class="control-label">
					<strong>
					{vtranslate('LBL_MODULE_PARENT', $QUALIFIED_MODULE)} <span class="redColor">*</span>
					</strong>
				</span>
				<div class="controls">
					<span class="row-fluid">
					<select class="vtselector span6" name="label" id="label_dropdown">
						{foreach from=$PARENTTAB key=k item=v}
						<option value="{$v}">{$v}</option>
						{/foreach}
					</select>
					</span>
				</div>
			</div>
			<div class="control-group">
				<span class="control-label">
					<strong>
					{vtranslate('LBL_MODULE_NAME', $QUALIFIED_MODULE)} <span class="redColor">*</span>
					</strong>
				</span>
				<div class="controls">
					<!--input type="text" name="label_modulename" class="span3" data-validation-engine="validate[required]" /-->
					<input type="text" name="label_modulename" class="span3 validate[required] text-input" data-validation-engine='validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]],funcCall[Vtiger_AlphaNumericName_Validator_Js.invokeValidation]]'  />
				</div>
			</div>
			<div class="control-group">
				<span class="control-label">
					<strong>
					{vtranslate('LBL_RETURN_ACTION', $QUALIFIED_MODULE)}
					</strong>
				</span>
				<div class="controls">
					<span class="row-fluid">Choose an option<br>
						<input class="span1" name="returnaction" id="returnaction" type="radio" title="Check to stay in current module after creation" value="stayback"/>&nbsp;Stay in current module<br>
						<input class="span1" name="returnaction" id="returnaction" type="radio" title="Check to proceed to vtDZine new module after creation" value="vtdziner" checked="checked"/>&nbsp;TheracannDZine New Module<br>
						<input class="span1" name="returnaction" id="returnaction" type="radio" title="Check to proceed to new module after creation" value="newmodule"/>&nbsp;Go to new module<br>
						<input class="span1" name="returnaction" id="returnaction" type="radio" title="Check to proceed to Home after creation" value="showhome"/>&nbsp;Home<br>
					</span>
				</div>
			</div>
			<!--
			<div class="control-group">
				<span class="control-label">
					<strong>
					{vtranslate('LBL_AUTOSEQUENCE', $QUALIFIED_MODULE)}
					</strong>
				</span>
				<div class="controls">
					<span class="row-fluid">
						<table class="span2" ><tr><td>
							<input name="autosequence" id="returnaction" type="checkbox" title="Check to autosequence entity records"/>
						</td></tr></table>
						<table class="span2" >
							<tr><td>
								<input class="span2" name="as_prefix" id="as_prefix" type="text" title="Enter a preferred prefix for auto sequencing"/>
							</td></tr>
							<tr><td>
								<span>A/s Prefix</span>
							</td></tr>
						</table>
						<table class="span2" >
							<tr><td>
								<input class="span2" name="as_startnumber" id="as_startnumber" type="text" title="Enter the start number for auto sequencing"/>
							</td></tr>
							<tr><td>
								<span>A/s Start</span>
							</td></tr>
						</table>
					</span>
				</div>
			</div>
			-->
		</div>
		{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
	</form>
</div>
<!-- vtDZiner Add Module UI ends :: STP on 19th May,2013 -->   
{/strip}