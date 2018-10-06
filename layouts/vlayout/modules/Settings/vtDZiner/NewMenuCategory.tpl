{strip}
<!-- Parent Category UI starts :: Vivek on 19th May,2013 -->               
<div class="modal addCategoryModal hide">
		<div class="modal-header">
				<button class="close vtButton" data-dismiss="modal">x</button>
						<h3>{vtranslate('LBL_CREATE_PARENT_MENU', "Settings::vtDZiner")}</h3>
		</div>
		<form class="form-horizontal contentsBackground addCategoryForm">
				<div class="modal-body">
						<div class="control-group">
								<span class="control-label">
								{vtranslate('LBL_MENU_CATEGORYNAME', "Settings::vtDZiner")}
								</span>
								<div class="controls">
								<!--input type="text" name="label_parcat" class="span3" data-validation-engine="validate[required]" /-->
								<input type="text" name="label_parcat" class="span3 validate[required] text-input" data-validation-engine='validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]],funcCall[Vtiger_AlphaNumericName_Validator_Js.invokeValidation]]' />
								</div>
						</div>
				</div>
				{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
</div>
<!-- Parent Category UI ends :: Vivek on 19th May,2013 -->  
{/strip}