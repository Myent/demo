<div class="row-fluid layoutBlockHeader">
  <div class="blockLabel padding10 span5 marginLeftZero">
	{assign var="moduleImage" value="layouts/vlayout/skins/images/$SELECTED_MODULE_NAME.png"}
	{if file_exists($moduleImage)}
		<img id="moduleimg" title="Module Image/Icon" alt="Module Image/Icon" src="{$moduleImage}" class="alignMiddle moduleimg">
	{else}
		<img title="Module Image/Icon(default)" alt="Module Image/Icon(default)" src="layouts/vlayout/skins/images/DefaultModule.png" class="alignMiddle">
	{/if}
    <h3 style="display:inline">
      {vtranslate($SELECTED_MODULE_NAME, $QUALIFIED_MODULE)} :: {vtranslate('LBL_MODULEDZINER_OPTIONS', $QUALIFIED_MODULE)}
    </h3>
  </div>
  <div style="float:right !important;" class="span6 marginLeftZero moduleDZinerButtons">
    <div style="margin: 4px;" class="pull-right btn-toolbar blockActions">
		<!--
		<button class="btn addButton vtDZinerTestDrive" type="button" onclick="window.location.href = 'index.php?module={$SELECTED_MODULE_NAME}&view=List';"><i class="icon-road"></i>&nbsp;<strong>{vtranslate('LBL_TESTDRIVE', $QUALIFIED_MODULE)}</strong></button>
		&nbsp;
		-->
		<button class="btn addButton addCategory inline" type="button">
			<i class="icon-list"></i>&nbsp;
			<strong>Menu DZiner</strong>
		</button>
		&nbsp;
		<button class="btn addButton addCustomModule" type="button">
			<i class="icon-plus icon-white"></i>&nbsp;
			<strong>{vtranslate('LBL_CREATE_MODULE', $QUALIFIED_MODULE)}</strong>
		</button>
		&nbsp;
      <div class="btn-group" style="top:10px;">
        <button data-toggle="dropdown" class="btn dropdown-toggle">
          <strong>
            Actions
          </strong>
          &nbsp;&nbsp;
          <i class="caret">
          </i>
        </button>
        <ul class="dropdown-menu pull-right">
          <li class="ERMap">
            <a href="index.php?parent=Settings&module=vtDZiner&view=ERMap&source_module={$SELECTED_MODULE_NAME}">
              ER Map 
            </a>
          </li>
          <li class="changeParentCategory">
            <a href="javascript:void(0)">
              Parent Category
            </a>
          </li>
          <li class="uploadModuleImageIcon">
            <a href="javascript:void(0)">
              Upload Icon/Image
            </a>
          </li>
          <li class="registerCustomWorkflow">
            <a href="javascript:void(0)">
              Workflow Methods
            </a>
          </li>
          <li class="enableTracker">
            <a href="javascript:void(0)">
              {if $TRACKINGENABLED}Disable Tracker{else}Enable Tracker{/if}
            </a>
          </li>
          <!--li class="enablePortal">
            <a href="javascript:void(0)">
              Portal Settings
            </a>
          </li-->
          <li class="enablevtDZiner">
            <a href="javascript:void(0)">
              Enable {vtranslate('vtDZiner',$Module)}
            </a>
          </li>
          <li class="exportModule">
            <!--a href="javascript:void(0)"-->
            <a href="index.php?module=ModuleManager&parent=Settings&action=ModuleExport&mode=exportModule&forModule={$SELECTED_MODULE_NAME}">
              Export module
            </a>
          </li>
          <li class="importModule">
            <a href="index.php?module=ModuleManager&parent=Settings&view=ModuleImport&mode=importUserModuleStep1">
              Import module from ZIP
            </a>
          </li>
          <li class="disableModule">
            <a href="javascript:void(0)">
              Disable module
            </a>
          </li>
          <!--li class="removeModule">
            <a href="javascript:void(0)">
              Remove module
            </a>
          </li-->
        </ul>
      </div>
    </div>
  </div>
</div>
<hr/>
<div class="panel-group" id="accordion">
	<div class="panel panel-default blockHeader">
		<div class="panel-heading blockLabel">
			<h3 class="panel-title">
			<a data-toggle="collapse" data-parent="#accordion" href="#collapse1"><i class="icon-chevron-down alignMiddle"></i>&nbsp;Properties</a>
			</h3><br>
		</div>
		<div id="collapse1" class="panel-collapse collapse">
			<table class="table equalSplit">
				<tr><td>MODULE ID</td><td>{$SELECTED_MODULE_MODEL->id}</td><td>Fixed during setup or install</td></tr>
				<tr><td>MODULE NAME</td><td>{$SELECTED_MODULE_NAME}</td><td></td></tr>
				<tr><td>MODULE LABEL</td><td>{vtranslate($SELECTED_MODULE_MODEL->label, $QUALIFIED_MODULE)}</td><td></td></tr>
				<tr><td>MODULE CATEGORY</td><td>{$SELECTED_MODULE_MODEL->parent}</td><td></td></tr>
				<tr><td>MODULE DELETABLE</td><td>{$MODULEDELETABLE}</td><td></td></tr>
				<tr><td>SHOW VALUES</td><td>{$SHOWVALUES}</td><td></td></tr>
				<tr><td>MODULE ENABLED</td><td>{$MODULEENABLED}</td><td></td></tr>
				<tr><td>MODULE HIERARCHY ENABLED</td><td>{$MODULEHIERARCHYENABLED}</td><td></td></tr>
				<tr><td>MODULE PANEL ENABLED</td><td>{if isset($PANELTABS)}Yes{else}No{/if}</td><td></td></tr>
				<tr><td>MODULE PICKBLOCK ENABLED</td><td>{if isset($PICKBLOCKS)}Yes{else}No{/if}</td><td></td></tr>
				<tr><td>GRID BLOCKS ENABLED</td><td>{$GRIDBLOCKSENABLED}</td><td></td></tr>
				<tr><td>PORTAL ENABLED</td><td>{if $PORTALINFO["present"]}Present{if $PORTALINFO["visible"]}, Visibility is ON{else}, Visibility is OFF{/if}{else}Not Present{/if}</td><td></td></tr>
				<tr><td>TRACKING ENABLED</td><td>{if $TRACKINGENABLED}Yes{else}No{/if}</td><td></td></tr>
				<tr><td>TYPED BLOCKS</td><td>{$TYPEDBLOCKS}</td><td></td></tr>
				<tr><td>USER CUSTOM VIEW ID</td><td>{$USERCUSTOMVIEWID}</td><td></td></tr>
			</table>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<a data-toggle="collapse" data-parent="#accordion" href="#collapse2"><i class="icon-chevron-down alignMiddle"></i>&nbsp;Components</a>
			</h3><br>
		</div>
		<div id="collapse2" class="panel-collapse collapse">
			<table class="table equalSplit">
			<tr><td>MODULE LANGUAGES LIST</td><td class="dvtCellInfo modulelanguages"></td><td></td></tr>
			<tr><td>BLOCKS</td><td onmouseover="showModuleInfoDetails(blocksList);">{$BLOCKS|@count}</td><td></td></tr>
			<tr><td>ALL MODULE FIELDS</td><td>{$ALLMODULEFIELDS|@count}</td><td></td></tr>
			<tr><td>RELATED LIST</td><td>{$RELATEDLIST}</td><td></td></tr>
			<tr><td>PARENT RELATIONS LIST</td><td>{$RELATEDLIST}</td><td></td></tr>
			<tr><td>CUSTOM VIEWS</td><td>{$CUSTOMVIEWS|@count}</td><td></td></tr>
			<tr><td>GRID BLOCKS LIST</td><td>{$LISTBLOCKID|@count}</td><td></td></tr>
			<tr><td>PANEL LIST</td><td>{$PANELTABS|@count}</td><td></td></tr>
			<tr><td>PICKBLOCKS</td><td>{$PICKBLOCKS|@count}</td><td></td></tr>
			<tr><td>WIDGET LIST</td><td>{$MODULEWIDGETS|@count}</td><td></td></tr>
			<tr><td>WORKFLOW LIST</td><td>{$WORKFLOWLIST|@count}</td><td></td></tr>
			<tr><td>FIELDFORMULA LIST</td><td>{$WIDGETLIST|@count}</td><td></td></tr>
			<tr><td>TOOLTIP LIST</td><td>{$WIDGETLIST|@count}</td><td></td></tr>
			<tr><td>IMPORT MAPPINGS LIST</td><td>{$WIDGETLIST|@count}</td><td></td></tr>
			<tr><td>SCRIPTS LIST</td><td>{$WIDGETLIST|@count}</td><td></td></tr>
			</table>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
			<a data-toggle="collapse" data-parent="#accordion" href="#collapse3"><i class="icon-chevron-down alignMiddle"></i>&nbsp;Environment</a>
			</h3><br>
		</div>
		<div id="collapse3" class="panel-collapse collapse">
			<table class="table equalSplit">
				<tr><td>SCRIPT_NAME</td><td>{$SCRIPT_NAME}</td><td></td></tr>
				<tr><td>DATEFORMAT</td><td>{$USER_MODEL->date_format}</td><td></td></tr>
				<tr><td>IMAGE_PATH</td><td>{$SKIN_PATH}</td><td></td></tr>
				<tr><td>THEME</td><td>{$USER_MODEL->theme}</td><td></td></tr>
				<tr><td>PORTAL URL</td><td>{$PORTAL_URL}</td><td></td></tr>
			</table>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
			<a data-toggle="collapse" data-parent="#accordion" href="#collapse4"><i class="icon-chevron-down alignMiddle"></i>&nbsp;ERP Info</a>
			</h3><br>
		</div>
		<div id="collapse4" class="panel-collapse collapse">
			<table class="table equalSplit">
				<tr><td>MODULES</td><td>{$SUPPORTED_MODULES|@count}</td><td></td></tr>
				<tr><td>ALL TABS INFO</td><td>{$ALLTABSINFO}</td><td></td></tr>
				<tr><td>LANGUAGES LIST</td><td>{$LANGUAGES|@count}</td><td></td></tr>
				<tr><td>PARENT CATEGORIES</td><td>{$PARENTTAB|@count}</td><td></td></tr>
			</table>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
			<a data-toggle="collapse" data-parent="#accordion" href="#collapse5"><i class="icon-chevron-down alignMiddle"></i>&nbsp;{vtranslate('vtDZiner',$MODULE)}</a>
			</h3><br>
		</div>
		<div id="collapse5" class="panel-collapse collapse">
			<table class="table equalSplit">
				<tr><td>{vtranslate('Dzined',$MODULE)}</td><td>{$VTDZINSTALLED}</td><td></td></tr>
				<tr><td>UPDATED</td><td>{$VTDZLATEST}</td><td></td></tr>
				<tr><td>UI TYPES</td><td>{$ADD_SUPPORTED_FIELD_TYPES|@count}</td><td></td></tr>
			</table>
		</div>
	</div>
	<!--
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
			<a data-toggle="collapse" data-parent="#accordion" href="#collapse6"><i class="icon-chevron-down alignMiddle"></i>&nbsp;vtDZiner IDE</a>
			</h3><br>
		</div>
		<div id="collapse6" class="panel-collapse collapse">
			<h4>Enter vtDZiner script for results</h4>
			<table class="table equalSplit">
				<tr>
					<th>
					Tools
					</th>
					<th>
					Input Control Area
					</th>
					<th>
					Result Area
					</th>
				</tr>
				<tr>
					<td><span class="pull-left">
						<table>
						<tr>
						<td><i class="icon-asterisk alignMiddle"></i></td>
						<td><i class="icon-plus alignMiddle"></i></td>
						<td><i class="icon-minus alignMiddle"></i></td>
						<td><i class="icon-home alignMiddle"></i></td>
						<td><i class="icon-file alignMiddle"></i></td>
						<td><i class="icon-envelope alignMiddle"></i></td>
						<td><i class="icon-pencil alignMiddle"></i></td>
						<td><i class="icon-glass alignMiddle"></i></td>
						<td><i class="icon-music alignMiddle"></i></td>
						<td><i class="icon-search alignMiddle"></i></td>
						</tr>
						<tr>
						<td><i class="icon-heart alignMiddle"></i></td>
						<td><i class="icon-star alignMiddle"></i></td>
						<td><i class="icon-star-empty alignMiddle"></i></td>
						<td><i class="icon-user alignMiddle"></i></td>
						<td><i class="icon-film alignMiddle"></i></td>
						<td><i class="icon-th-large alignMiddle"></i></td>
						<td><i class="icon-th alignMiddle"></i></td>
						<td><i class="icon-th-list alignMiddle"></i></td>
						<td><i class="icon-ok alignMiddle"></i></td>
						<td><i class="icon-remove alignMiddle"></i></td>
						</tr>
						<tr>
						<td><i class="icon-zoom-in alignMiddle"></i></td>
						<td><i class="icon-zoom-out alignMiddle"></i></td>
						<td><i class="icon-off alignMiddle"></i></td>
						<td><i class="icon-signal alignMiddle"></i></td>
						<td><i class="icon-cog alignMiddle"></i></td>
						<td><i class="icon-time alignMiddle"></i></td>
						<td><i class="icon-road alignMiddle"></i></td>
						<td><i class="icon-download-alt alignMiddle"></i></td>
						<td><i class="icon-download alignMiddle"></i></td>
						<td><i class="icon-upload alignMiddle"></i></td>
						</tr>
						<tr>
						<td><i class="icon-inbox alignMiddle"></i></td>
						<td><i class="icon-play-circle alignMiddle"></i></td>
						<td><i class="icon-repeat alignMiddle"></i></td>
						<td><i class="icon-refresh alignMiddle"></i></td>
						<td><i class="icon-list-alt alignMiddle"></i></td>
						<td><i class="icon-lock alignMiddle"></i></td>
						<td><i class="icon-flag alignMiddle"></i></td>
						<td><i class="icon-headphones alignMiddle"></i></td>
						<td><i class="icon-volume-off alignMiddle"></i></td>
						<td><i class="icon-volume-down alignMiddle"></i></td>
						</tr>
						<tr>
						<td><i class="icon-volume-up alignMiddle"></i></td>
						<td><i class="icon-qrcode alignMiddle"></i></td>
						<td><i class="icon-barcode alignMiddle"></i></td>
						<td><i class="icon-tag alignMiddle"></i></td>
						<td><i class="icon-tags alignMiddle"></i></td>
						<td><i class="icon-book alignMiddle"></i></td>
						<td><i class="icon-bookmark alignMiddle"></i></td>
						<td><i class="icon-print alignMiddle"></i></td>
						<td><i class="icon-camera alignMiddle"></i></td>
						<td><i class="icon-font alignMiddle"></i></td>
						</tr>
						<tr>
						<td><i class="icon-bold alignMiddle"></i></td>
						<td><i class="icon-italic alignMiddle"></i></td>
						<td><i class="icon-text-height alignMiddle"></i></td>
						<td><i class="icon-text-width alignMiddle"></i></td>
						<td><i class="icon-align-left alignMiddle"></i></td>
						<td><i class="icon-align-center alignMiddle"></i></td>
						<td><i class="icon-align-right alignMiddle"></i></td>
						<td><i class="icon-align-justify alignMiddle"></i></td>
						<td><i class="icon-list alignMiddle"></i></td>
						<td><i class="icon-indent-left alignMiddle"></i></td>
						</tr>
						<tr>
						</tr>
						</table>
						</span>
					</td>
					<td>
					<textarea class="form-control" rows="10">&nbsp;</textarea>
					</td>
					<td>
					<textarea class="form-control" rows="10">&nbsp;</textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>


	//jQuery(document).ready(function(){    
	//    jQuery('#collapse6').on('shown', function () {
	//       jQuery(".icon-chevron-down").removeClass("icon-chevron-down").addClass("icon-chevron-up");
	//    });
	//
	//    jQuery('#collapse6').on('hidden', function () {
	//       jQuery(".icon-chevron-up").removeClass("icon-chevron-up").addClass("icon-chevron-down");
	//    });
	//});

	-->
</div>