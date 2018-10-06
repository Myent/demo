{foreach key=BLOCK_LABEL_KEY item=BLOCK_MODEL from=$BLOCKS}
	{assign var=BLOCK_ID value=$BLOCK_MODEL->get('id')}
	{$ALL_BLOCK_LABELS[$BLOCK_ID] = vtranslate($BLOCK_LABEL_KEY, $SELECTED_MODULE_NAME)}
{/foreach}
<div class="viewDZinercontents tabbable">
	<ul class="nav nav-tabs viewDZinerTabs massEditTabs">
		<li class="vtViewTab active"><a data-toggle="tab" href="#vtPanelSettings"><strong>{vtranslate('Panels', $QUALIFIED_MODULE)}</strong></a></li>
		<li class="vtViewTab"><a data-toggle="tab" href="#vtPickblocksSettings"><strong>{vtranslate('Pickblocks', $QUALIFIED_MODULE)}</strong></a></li>
		<!--li class="vtViewTab"><a data-toggle="tab" href="#vtDetailViewSettings"><strong>{vtranslate('Detail View', $QUALIFIED_MODULE)}</strong></a></li>
		<li class="vtViewTab"><a data-toggle="tab" href="#vtSummaryViewSettings"><strong>{vtranslate('Summary View', $QUALIFIED_MODULE)}</strong></a></li>
		<li class="vtViewTab"><a data-toggle="tab" href="#vtDashBoardSettings"><strong>{vtranslate('Dashboard', $QUALIFIED_MODULE)}</strong></a></li>
		<li class="vtViewTab"><a data-toggle="tab" href="#vtPopupSelectionSettings"><strong>{vtranslate('Selection Popup', $QUALIFIED_MODULE)}</strong></a></li>
		<li class="vtViewTab"><a data-toggle="tab" href="#vtFilterSettings"><strong>{vtranslate('Filters', $QUALIFIED_MODULE)}</strong></a></li>
		<li class="vtViewTab"><a data-toggle="tab" href="#vtThemeSettings"><strong>{vtranslate('Themes', $QUALIFIED_MODULE)}</strong></a></li-->
	</ul>
	<div class="tab-content layoutContent viewDZinerContent padding20 themeTableColor overflowVisible">
		<div class="tab-pane" id="vtFilterSettings">
			<div class="row-fluid layoutBlockHeader">
			  <div class="blockLabel span5 padding10 marginLeftZero">
				<h4>{vtranslate('Filters', $QUALIFIED_MODULE)}</h4>
			  </div>
			  <div style="float:right !important;" class="span6 marginLeftZero">
				<div style="margin: 4px;" class="pull-right btn-toolbar blockActions">
				  <div class="btn-group">
					<button class="btn addButton addFilterView" onclick="addFilterView('{$SELECTED_MODULE_NAME}');" type="button">
						<i class="icon-plus icon-white"></i>&nbsp;
						<strong>Add Filter</strong>
					</button>
				  </div>
				</div>
			  </div>
			</div>
			<hr/>
			<table class="table filterviewlist">
				<thead>
					<tr>
						<th>
							Name
						</th>
						<th>
							Fields
						</th>
						<th>
							Condition
						</th>
						<th>
						<span class="pull-right">
							Actions
						</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="tab-pane" id="vtPickblocksSettings">
			<table class="table pickblocklist">
				<thead>
					<tr>
						<th>
							Picklist Field
						</th>
						<th>
							Pick Blocks
						</th>
						<th>
							Value
							<span class="pull-right">Displayed Block</span>
						</th>
						<th>
						<span class="pull-right">
							Actions
						</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<hr/>
			Information about Pickblocks will be shown here
		</div>
		<div class="tab-pane active" id="vtPanelSettings">
			<div class="row-fluid layoutBlockHeader">
				<div style="float:right !important;" class="span6 marginLeftZero">
					<div style="margin: 4px;" class="pull-right btn-toolbar blockActions">
						<div class="btn-group">
							<button class="btn addButton addFilterView" type="button" onclick="editPanel('', 'INSERT', '');">
							<i class="icon-plus icon-white"></i>&nbsp;
							<strong>Add Panels</strong>
							</button>
						</div>
					</div>
				</div>
			</div>
			<hr/>
			<div>
				<table class="table panelsList">
				<thead>
					<tr>
						<th>
						Panel Label
						</th>
						<th>
						Included blocks
						</th>
						<th>
						<span class="pull-right">
						Actions
						</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
				</table>
			</div>
			<hr/>
			Information about panel view will be shown here
		</div>
		<div class="tab-pane" id="vtThemeSettings">
			<div class="InstalledThemes">
				<div class="row-fluid layoutBlockHeader">
					<div style="float:right !important;" class="span6 marginLeftZero">
						<div style="margin: 4px;" class="pull-right btn-toolbar blockActions">
							<div class="btn-group">
								<button class="btn addButton addThemeView" type="button" onclick="editTheme('', 'INSERT', '');">
								<i class="icon-plus icon-white"></i>&nbsp;
								<strong>New Theme</strong>
								</button>
							</div>
						</div>
					</div>
				</div>
				<hr/>
				<div>
					<table class="table themesList">
					<thead>
						<tr>
							<th>
							Theme Label
							</th>
							<th>
							Theme Base Color
							</th>
							<th>
							Theme Base Color Code
							</th>
							<th>
							Theme Base Color Name
							</th>
							<th>
							<span class="pull-right">
							Actions
							</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
					</table>
				</div>
				<hr/>
				Information about Vtiger Themes will be shown here
			</div>
			<div class="ThemePalette hide">
				<div class="row-fluid layoutBlockHeader">
					<div class="marginLeftZero">
						<h3 style="display:inline;">Color Palette</h3>
						<span class="pull-right alignMiddle">
						<button class="btn addButton" onclick="viewThemeCSS();">
						<strong>View CSS</strong></button>&nbsp;<button class="btn addButton" onclick="viewThemeList();"><strong>Save Theme</strong></button>
						</span>
					</div>
				</div>
				<hr/>
				<div>
					<table class="table colorPalette">
						<thead>
							<tr>
								<th>
									Color Code
								</th>
								<th>
									Color Name<sup>#</sup>
								</th>
								<th>
									Color
								</th>
								<th>
									New Color
								</th>
								<th>
								<span class="pull-right">
									Actions
								</th>
							</tr>
						</thead>
						<tbody>
							<tr><td>#894400</td><td>894400</td><td bgcolor="#894400">&nbsp;</td><td><input type=color value="#894400" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#231100</td><td>231100</td><td bgcolor="#231100">&nbsp;</td><td><input type=color value="#231100" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#3d1e00</td><td>3d1e00</td><td bgcolor="#3d1e00">&nbsp;</td><td><input type=color value="#3d1e00" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#562b00</td><td>562b00</td><td bgcolor="#562b00">&nbsp;</td><td><input type=color value="#562b00" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#453322</td><td>453322</td><td bgcolor="#453322">&nbsp;</td><td><input type=color value="#453322" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#703700</td><td>703700</td><td bgcolor="#703700">&nbsp;</td><td><input type=color value="#703700" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#000000</td><td>000000</td><td bgcolor="#000000">&nbsp;</td><td><input type=color value="#000000" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#ffaa56</td><td>ffaa56</td><td bgcolor="#ffaa56">&nbsp;</td><td><input type=color value="#ffaa56" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#a35100</td><td>a35100</td><td bgcolor="#a35100">&nbsp;</td><td><input type=color value="#a35100" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
							<tr><td>#090500</td><td>090500</td><td bgcolor="#090500">&nbsp;</td><td><input type=color value="#090500" style="margin-bottom: 0px; padding: 0px;"></td><td><i class="icon-folder"></i></td></tr>
						</tbody>
					</table>
				</div>
				<hr/>
				View the color palette used in this theme and change as needed.<br># From Wikipedia
			</div>
			<div class="ThemeCssScript hide">
				<div class="row-fluid layoutBlockHeader">
					<div class="marginLeftZero">
						<strong class="alignMiddle"><input type="radio" name="css_script">Style.ccs&nbsp;<input type="radio" name="css_script">Style.less&nbsp;<input type="radio" name="css_script">Variables.less&nbsp;</strong>
						<!--<input type="button" onclick="alert(doGetCaretPosition(document.getElementById('cssScriptTextArea')));" value="Get Position">&nbsp;
						<input type="text" id="caretPosition" style="width:15px;">
						<input type="button" onclick="setCaretProcess();" value="Set Position">-->
						&nbsp;<h4 style="display:inline;">All Classes</h4>&nbsp;
						<span class="pull-right alignMiddle inline">
							<input type="text" id="styleClassNames" style="margin-bottom: 0px;">
							<button class="btn addButton" onclick="showThemePalette();"><strong>View Palette</strong></button>&nbsp;
							<button class="btn addButton" onclick="viewThemeList();"><strong>Themes List</strong></button>
						</span>
					</div>
				</div>
				<hr/>
				<div>
					<div class="input-group">
						<input id="CssSearchText" type="text" class="form-control"/>
						<span class="input-group-addon">
							<i class="icon-search" onclick="findTextInCssScript(document.getElementById('CssSearchText').value);"></i>
						</span>
						<span id="caretpos">
						</span>
					</div>
					<hr/>
					<div>
						<textarea id="cssScriptTextArea" class="form-inline" rows="15">Css Script</textarea>
					</div>
				</div>
				<hr/>
				Review the style sheet used in this theme
			</div>
		</div>
		<div class="tab-pane" id="vtDetailViewSettings">
			<div class="row-fluid layoutBlockHeader">
			  <div class="blockLabel span5 padding10 marginLeftZero">
				<h4>{vtranslate('Detail View', $QUALIFIED_MODULE)}</h4>
			  </div>
			  <div style="float:right !important;" class="span6 marginLeftZero">
				<div style="margin: 4px;" class="pull-right btn-toolbar blockActions">
				  <div class="btn-group">
					<button class="btn addButton addFilterView" type="button">
						<i class="icon-plus icon-white"></i>&nbsp;
						<strong>Add Detail View</strong>
					</button>
				  </div>
				</div>
			  </div>
			</div>
			<hr/>
			Table of detail view information will be shown here, <strong>COMING SOON</strong>
		</div>
		<div class="tab-pane" id="vtSummaryViewSettings">
			<div class="row-fluid layoutBlockHeader">
			  <div class="blockLabel span5 padding10 marginLeftZero">
				<h4>{vtranslate('Summary View', $QUALIFIED_MODULE)}</h4>
			  </div>
			  <div style="float:right !important;" class="span6 marginLeftZero">
				<div style="margin: 4px;" class="pull-right btn-toolbar blockActions">
				  <div class="btn-group">
					<button class="btn addButton addFilterView" type="button">
						<i class="icon-plus icon-white"></i>&nbsp;
						<strong>Add Summary View</strong>
					</button>
				  </div>
				</div>
			  </div>
			</div>
			<hr/>
			Table of summary view information will be shown here, <strong>COMING SOON</strong>
		</div>
		<div class="tab-pane" id="vtDashBoardSettings">
			<div class="row-fluid layoutBlockHeader">
			  <div class="blockLabel span5 padding10 marginLeftZero">
				<h4>{vtranslate('Dashboard View', $QUALIFIED_MODULE)}</h4>
			  </div>
			  <div style="float:right !important;" class="span6 marginLeftZero">
				<div style="margin: 4px;" class="pull-right btn-toolbar blockActions">
				  <div class="btn-group">
					<button class="btn addButton addFilterView" type="button">
						<i class="icon-plus icon-white"></i>&nbsp;
						<strong>Add Dashboard</strong>
					</button>
				  </div>
				</div>
			  </div>
			</div>
			<hr/>
			Information about this module dashboard will be shown here, <strong>COMING SOON</strong>
		</div>
		<div class="tab-pane" id="vtPopupSelectionSettings">
			<div class="row-fluid layoutBlockHeader">
			  <div class="blockLabel span5 padding10 marginLeftZero">
				<h4>{vtranslate('Popup Management', $QUALIFIED_MODULE)}</h4>
			  </div>
			  <div style="float:right !important;" class="span6 marginLeftZero">
				<div style="margin: 4px;" class="pull-right btn-toolbar blockActions">
				  <div class="btn-group">
					<button class="btn addButton addFilterView" type="button">
						<i class="icon-plus icon-white"></i>&nbsp;
						<strong>Edit Popup</strong>
					</button>
				  </div>
				</div>
			  </div>
			</div>
			<hr/>
			Information about this module's Selection Popup will be shown here, <strong>COMING SOON</strong>
		</div>
	</div>
</div>

<div class="editCustomView hide">
</div>

<!--  panelBlockSelectionModalData UI starts :: STP on 19th May,2013 -->
<div class="panelBlockSelectionModalData">
	<div class="modal panelBlockSelectionModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal" onclick="jQuery('.panelBlockSelectionModal').addClass('hide');jQuery('.panelBlockSelectionModal').find('.vtselector').select2('destroy');">&times</button>
			<h3>Select Blocks for <span id="panelHeader"></span></h3>
			After selection is complete, click on SAVE else CANCEL
		</div>
		<form class="form-horizontal contentsBackground panelBlockSelectionForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label panellabelfield">
					Panel Label :
					</span>
					<div class="controls">
						<span class="row-fluid">
							<input type="hidden" name="tabid" id="tabid" value="{$SELECTED_MODULE_MODEL->id}">
							<input type="hidden" name="sourceModule" id="sourceModule" value="{$SELECTED_MODULE_NAME}">
							<input type="hidden" name="panelLabel" id="panelLabel">
						</span>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
					Select Blocks :
					</span>
					<div class="controls">
						<span class="row-fluid">
							<select class="span8 vtselector" name="blockIds" multiple>
								{foreach key=BLOCK_ID item=BLOCK_LABEL from=$ALL_BLOCK_LABELS}
									<option value="{$BLOCK_ID}" data-label="{$BLOCK_LABEL}">{vtranslate($BLOCK_LABEL, $SELECTED_MODULE_NAME)}</option>
								{/foreach}
							</select>
						</span>
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>

<!--  themeBlockSelectionModalData UI starts :: STP on 19th May,2013 -->
<div class="themeBlockSelectionModalData">
	<div class="modal themeBlockSelectionModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal" onclick="jQuery('.themeBlockSelectionModal').addClass('hide');jQuery('.themeBlockSelectionModal').find('.vtselector').select2('destroy');">&times</button>
			<h3>Select Blocks for <span id="themeHeader"></span></h3>
			After selection is complete, click on SAVE else CANCEL
		</div>
		<form class="form-horizontal contentsBackground themeBlockSelectionForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label themelabelfield">
					Theme Label :
					</span>
					<div class="controls">
						<span class="row-fluid">
							<input type="hidden" name="tabid" id="tabid" value="{$SELECTED_MODULE_MODEL->id}">
							<input type="hidden" name="sourceModule" id="sourceModule" value="{$SELECTED_MODULE_NAME}">
							<input type="hidden" name="themeLabel" id="themeLabel">
						</span>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
					Select Base Color :
					</span>
					<div class="controls">
						<span class="row-fluid">
							<input type="color" name="themeBaseColor" id="themeBaseColor" value="#ff0000"/>
						</span>
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>

<!--  pickBlocksSelectionModalData UI starts :: STP on 19th May,2013 -->
<div class="pickBlocksSelectionModalData">
	<div class="modal pickBlocksSelectionModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal" onclick="jQuery('.pickBlocksSelectionModal').addClass('hide');jQuery('.pickBlocksSelectionModal').find('.vtselector').select2('destroy');">&times</button>
			<h3>Select Pick Blocks for <span id="pickblocksHeader"></span></h3>
			After selection is complete, click on SAVE else CANCEL
		</div>
		<form class="form-horizontal contentsBackground pickBlocksSelectionForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
					Select Blocks :
					</span>
					<div class="controls">
						<span class="row-fluid">
							<input type="hidden" name="tabid" id="tabid" value="{$SELECTED_MODULE_MODEL->id}">
							<input type="hidden" name="sourceModule" id="sourceModule" value="{$SELECTED_MODULE_NAME}">
							<input type="hidden" name="pickblocksLabel" id="pickblocksLabel">
							<select class="span8 vtselector" name="pickblockIds" id="pickblockIds" multiple>
								{*foreach key=BLOCK_ID item=BLOCK_LABEL from=$ALL_BLOCK_LABELS}
									<option value="{$BLOCK_ID}" data-label="{$BLOCK_LABEL}">{vtranslate($BLOCK_LABEL, $SELECTED_MODULE_NAME)}</option>
								{/foreach*}
							</select>
						</span>
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>

<!--  pickBlockSelectionModalData UI starts :: STP on 19th May,2013 -->
<div class="pickBlockSelectionModalData">
	<div class="modal pickBlockSelectionModal hide">
		<div class="modal-header">
			<button class="close vtButton" data-dismiss="modal" onclick="jQuery('.pickBlockSelectionModal').addClass('hide');jQuery('.pickBlockSelectionModal').find('.vtselector').select2('destroy');">&times</button>
			<h3>Select Display Block for <span id="pickblockHeader"></span></h3>
			After selection is complete, click on SAVE else CANCEL
		</div>
		<form class="form-horizontal contentsBackground pickBlockSelectionForm">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
					Select Blocks :
					</span>
					<div class="controls">
						<span class="row-fluid">
							<input type="hidden" name="tabid" id="tabid" value="{$SELECTED_MODULE_MODEL->id}">
							<input type="hidden" name="sourceModule" id="sourceModule" value="{$SELECTED_MODULE_NAME}">
							<input type="hidden" name="pickblockLabel" id="pickblockLabel">
							<select class="span8 vtselector" name="blockId" id="pickBlockId">
								{*foreach key=BLOCK_ID item=BLOCK_LABEL from=$ALL_BLOCK_LABELS}
									<option value="{$BLOCK_ID}" data-label="{$BLOCK_LABEL}">{vtranslate($BLOCK_LABEL, $SELECTED_MODULE_NAME)}</option>
								{/foreach*}
							</select>
						</span>
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	</div>
</div>