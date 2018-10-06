{literal}
<style>
.overwrite-ui-widget-content {
  border-radius: 6px;
  border-color: #ffffff;
  box-shadow: 0 0 3px -1px inset;
  margin-top: 2px;
  margin-left: 5px;
}

.overwrite-ui-tabs-panel {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0);
    border-width: 0;
    display: block;
    padding: 1em 1.4em;
}
</style>
{/literal}
<div class="contents">
	<table class="table table-bordered ">
		<tbody>
			<tr>
				<td class="opacity">
					<div class="row-fluid moduleManagerBlock">
						<div class="LanguagesSummaryView hide">
							<div class="row-fluid layoutBlockHeader">
							  <div class="blockLabel span5 padding10 marginLeftZero">
								<h3>
								  Languages in this CRM instance
								</h3>
							  <br/>The <b>current language</b> is highlighted in bold and marked with <sup><b>#</b></sup>
							  </div>
							  <div style="float:right !important;" class="span6 marginLeftZero">
							  {*manasa added this for 23rd aug 2016*}
								<div style="margin: 4px;" class="pull-right btn-toolbar">
									<div class="btn-group pull-right">
										<button class="btn dropdown-toggle" data-toggle="dropdown">
											<strong>{vtranslate('LBL_ACTIONS_OTHER_FILES', $QUALIFIED_MODULE)} </strong>&nbsp;&nbsp;
											<i class="caret"></i>
										</button>
										<ul class="dropdown-menu pull-right otherCRMLanguageFiles">
											{foreach key=languagetag item=languagelabel from=$OTHERFILESLIST}
											{if $languagelabel|@count == 1}
											{if $languagelabel != 'Vtiger'}
											<li class="newCRMLanguage">
												&nbsp;&nbsp;{vtranslate($languagelabel,$MODULE)}
												<span class="pull-right"><i onclick="editSelectedLanguage('{$LANGUAGE}', '{$languagelabel}');" class="icon-pencil"></i>&nbsp;&nbsp;</span>
												
											</li>
											{/if}
											{else}
											<li class="divider"></li>
											<li class="newCRMLanguage">
												&nbsp;&nbsp;Settings
												<ul class="dropdown-menu pull-right">
												{foreach key=key item=item from=$languagelabel}
													{if $item != 'Vtiger'}
												<li class="newCRMLanguage">
													&nbsp;&nbsp;{vtranslate($item,$MODULE)}
												<span class="pull-right"><i onclick="editSelectedLanguage('{$LANGUAGE}/Settings', '{$item}');" class="icon-pencil"></i>&nbsp;&nbsp;</span>
												</li>
													{/if}
												{/foreach}
												</ul>
											</li>
											{/if}
											{/foreach}
										</ul>
									</div>
								</div>
								<div style="margin: 4px;" class="pull-right btn-toolbar">
									<div class="btn-group pull-right">
										<button class="btn dropdown-toggle" data-toggle="dropdown">
											<strong>{vtranslate('LBL_ACTIONS', $QUALIFIED_MODULE)}</strong>&nbsp;&nbsp;
											<i class="caret"></i>
										</button>
										<ul class="dropdown-menu pull-right">
											<li class="newCRMLanguage">
												<a id="newCRMLanguageLink" href="javascript:newCRMLanguage();">{vtranslate('Make New Language Pack', $QUALIFIED_MODULE)}</a>
											</li>
											<!--li class="exportLanguage">
												<a href="javascript:void(0)">{vtranslate('Export Language pack', $QUALIFIED_MODULE)}</a>
											</li-->
										</ul>
									</div>
								</div>
							  </div>
							</div>
							<hr/>
							<table class="table equalSplit">
								<tr>
									<td>
										<strong>CRM Languages</strong>
										<table class="table crmlanguageslist">
										{foreach key=languagetag item=languagelabel from=$LANGUAGES}
										<tr><td>
										{if $languagetag == $LANGUAGE}
											<b>{$languagelabel}<sup>#</sup></b>
										{else}
											{$languagelabel}
										{/if}
										</td></tr>
										{/foreach}
										</table>
									</td>
									<td>
										<strong>Module Languages</strong>
										<table class="table modulelanguageslist">
										<tr><td></td></tr>
										</table>
									</td>
									<td>
										<strong>Module Languages to be created</strong>
										<table class="table missinglanguageslist">
										<tr><td></td></tr>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<hr/>
									</td>
								</tr>
							</table>
						</div>

						<div class="LanguageLabelsEditView hide">
						<table class="table">
							<tr>
								<td class="span7">
									<span id="languageFormHeading">
									</span>
								<hr/>
								<!--strong>
										Please edit the labels as necessary and select SAVE from Actions Button to confirm your changes
										<span class="pull-right"><button class="btn btn-success" name="vtbulktranslate" id="vtbulktranslate" onclick="bulkTranslate();" ><strong>Bulk Translate</strong></button></span>
								</strong-->
								</td>
								<td class="span2">
									<span class="pull-right"><button class="btn btn-success" onclick="saveModuleLanguage();" ><strong>Save</strong></button><a onclick="showLanguagesSummaryView();" type="reset" class="cancelLink">Cancel</a></span>
								</td>
							</tr>
						</table>
						<hr/>
							<div>
								<strong>
									Language Labels
								</strong>
								<span class="pull-right">
									<div class="btn-group pull-right">
										<button class="btn dropdown-toggle" data-toggle="dropdown" onclick="addNewLabel('lang');">
											<i class="icon-plus"></i>&nbsp;
											<strong>{vtranslate('Add Label', $QUALIFIED_MODULE)}</strong>&nbsp;&nbsp;
										</button>
									</div>
								</span>
							</div>
							<hr/>
							<form id="languageLabelsForm">
								<table>
									<tr><td colspan="2">
										<input type=hidden id="languageMode" />
										<input type=hidden id="sourceModule" value="{$SELECTED_MODULE_NAME}" />
										<input type=hidden id="forLanguage" />
									</td></tr>
								</table>
								<table width=100% id="labelEditForm">
									{foreach key=langtag item=langlabel from=$MODULELANGUAGELABELS}
										<tr>
											<td class="span4">
												{$langtag}
											</td>
											<td class="span8">
												<input class="span8" id='{$langtag}' name='{$langtag}' type=text size=200 value='{$langlabel}' />
											</td>
										</tr>
									{/foreach}
								</table>
							</form>
							<div>
								<strong>
									JS Language Labels
								</strong>
								<span class="pull-right">
									<div class="btn-group pull-right">
										<button class="btn dropdown-toggle" data-toggle="dropdown" onclick="addNewLabel('jslang');">
											<i class="icon-plus"></i>&nbsp
											<strong>{vtranslate('Add JS Label', $QUALIFIED_MODULE)}</strong>&nbsp;&nbsp;
										</button>
									</div>
								</span>
							</div>
							<hr/>
							{*if $MODULELANGUAGEJSLABELS|@count > 0*}
								<form id="JSlanguageLabelsForm">
									<table width=100% id="jslabelEditForm">
									{foreach key=langtag item=langlabel from=$MODULELANGUAGEJSLABELS}
										<tr>
											<td class="span4">
												{$langtag}
											</td>
											<td class="span8">
												<input class="span8" id='{$langtag}' name='{$langtag}' type=text size=200 value='{$langlabel}' />
											</td>
										</tr>
									{/foreach}
									</table>
								</form>
							{*/if*}
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<!--  newLanguageLabelModalData UI starts :: STP on 19th May,2013 -->
<div class="newLanguageLabelModalData">
	<div class="modal newLanguageLabelModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal" onclick="jQuery('.newLanguageLabelModal').addClass('hide');">&times</button>
			<h3>Create a new label</h3>
			Click on SAVE else CANCEL
		</div>
		<form class="form-horizontal contentsBackground newLanguageLabelForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
					Label Tag :
					</span>
					<div class="controls">
					<input type="text" id="labeltag" name="labeltag">
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
					Language Label :
					</span>
					<div class="controls">
					<input type="text" id="labelvalue" name="labelvalue" title="Update if needed to reflect local naming">
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>

<!--  newCRMLanguageModalData UI starts :: STP on 19th May,2013 -->
<div class="newCRMLanguageModalData">
	<div class="modal newCRMLanguageModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal" onclick="jQuery('.newCRMLanguageModal').addClass('hide');">&times</button>
			<h3>Create New Language Pack</h3>
			A complete replica of the US English Language Pack will be created for the new language selected<br>
			Please select a language from the world languages list<br>
			If you wish to proceed with creating, click on SAVE else CANCEL
		</div>
		<form class="form-horizontal contentsBackground newCRMLanguageForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
					Language Name :
					</span>
					<div class="controls">
					<input type="hidden" name="languageName" id="languageName"/>
						<select name="languageCode" id="languageCode" style="width:250px;" placeholder="{vtranslate('LBL_LANGUAGE', $MODULE)}" data-errormessage="{vtranslate('LBL_CHOOSE_LANGUAGE', $MODULE)}" class="validate[required] vtselector" onchange="setLanguageCode(this);">
								{foreach key=languagetag item=languagelabel from=$LANGUAGECODES}
									<option value="{$languagetag}">{vtranslate($languagelabel, $QUALIFIED_MODULE)}</option>
								{/foreach}
						</select>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
					Language Code :
					</span>
					<div class="controls">
					<input type="text" id="languageISOCode" name="languageISOCode" disabled>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
					Language Label :
					</span>
					<div class="controls">
					<input type="text" id="languageLabel" name="languageLabel" title="Update if needed to reflect local naming">
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>

<!--  bulkTranslateModalData UI starts :: STP on 19th May,2013 -->
<div class="bulkTranslateModalData">
	<div class="modalContainer modal bulkTranslateModal hide">
		<div class="contents tabbable">
			<div class="modal-header">
				<button class="close vtButton" data-dismiss="modal" onclick="jQuery('.bulkTranslateModal').addClass('hide');">&times</button>
				<h3>Bulk Translation</h3>
				The entire label set from the US English language is copied into the text area.	Copy the textarea contents to a translation program (viz Google Translate) and copy back the translated text into the text area. Review the results and click on SAVE else CANCEL
			</div>
			<form class="form-horizontal contentsBackground bulkTranslateForm">
				<div class="modal-body">
					<div class="control-group">
						<div id="tabs">
						  <ul>
							<li><a href="#tabs-1">PHP/TPL Labels</a></li>
							<li><a href="#tabs-2">JS Labels</a></li>
						  </ul>
						  <div id="tabs-1" style="height:225px">
                            <div class="control-group bulkLabelsContainer"><!--
                            <span class="control-label">
                            <strong>Bulk Labels</strong>
                            </span>
                            <div class="controls">-->
                            <textarea class="form-control" id="bulkLabels" name="bulkLabels" rows="10" onkeyup="update_textarea(this)">
                            </textarea>
                            <!--</div>-->
                            </div>
						  </div>
						  <div id="tabs-2" style="height:225px">
                            <div class="control-group jsbulkLabelsContainer"><!--
                            <span class="control-label">
                            <strong>JS Bulk Labels</strong>
                            </span>
                            <div class="controls">-->
                            <textarea class="form-control" id="jsbulkLabels" name="jsbulkLabels" rows="10" onkeyup="update_textarea(this)">
                            </textarea>
                            <!--</div>-->
					</div>

						  </div>
						 
						</div>
					</div>
				
				</div>
				{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
			</form>
		</div>
	</div>
</div>