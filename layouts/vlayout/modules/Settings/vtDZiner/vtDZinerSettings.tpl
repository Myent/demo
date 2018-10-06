<div class="contents">
	<table class="table">
		<tr class="alignMiddle">
			<td>
			<div>
				<div class="blockLabel marginLeftZero">
					<h3 style="display:inline;">{vtranslate('LBL_VTDZ_SETTINGS_TEXT', $QUALIFIED_MODULE)}</h3>
					<span class="pull-right">
						<button class="btn vtDZinerDeActivation">
							<i class="icon-remove"></i>&nbsp;<strong>{vtranslate('LBL_VTDEACTIVATE', $QUALIFIED_MODULE)}</strong>
						</button>
					</span>
				</div>
			</div>
			</td>
		</tr>
	</table>
  <table class="table table-bordered equalSplit">
    <tbody>
      <tr>
        <td class="opacity">
          <div class="row-fluid moduleManagerBlock">
			  <table class="table narrow">
				<tr>
					<td>
						<strong>{vtranslate('vtDZiner', $QUALIFIED_MODULE)} Usage Log</strong>
					</td>
					<td>
						{include file="file:test/user/vtDZiner.log" assign=usagecontents}
						<textarea class="form-control" rows="5" id="usagecontents">{$usagecontents}</textarea>
					</td>
				</tr>
				<tr>
					<td>
						<strong>Inform DZiner Status</strong>
					</td>
					<td>
						<input type="checkbox" id="cbInFormMode" onclick="cbInFormClicked();">
					</td>
				</tr>
				<!--
				<tr>
					<td>
						<strong>vtDZiner Installed Version is {$VTDZINER_CURRENTVERSION}<br/>
						Latest Version is {$VTDZINER_LATESTVERSION}</strong>
					</td>
					<td>
						{if $VTDZINER_UPGRADEABLE}
						<button class="btn upgradevtDZiner"><i class="icon-refresh"></i>&nbsp;Update</button>
						{else}
						<strong>vtDZiner is uptodate !!</strong>
						{/if}
					</td>
				</tr>
				<tr>
					<td>
						<strong>Uninstall vtDZiner</strong>
					</td>
					<td>
						<button class="btn"><i class="icon-trash"></i>&nbsp;Uninstall</button>
					</td>
				</tr>
				<tr>
					<td>
						<strong>Import UI Types (Requires UI Types ZIP file from vTigress.com)</strong>
					</td>
					<td>
						<button class="btn"><i class="icon-download-alt"></i>&nbsp;Import</button>
					</td>
				</tr>
				<tr>
					<td>
						<strong>Import vTigress Extensions</strong>
					</td>
					<td>
						<select>
							<optgroup label="Enhancements">
								<option>Forex Synchroniser</option>
								<option>vtTestData</option>
								<option>Inventory Import</option>
								<option>vtVisualizer</option>
								<option>vtTogether</option>
							</optgroup>
							<optgroup label="Integrations">
								<option>Orange HRM</option>
								<option>FrontAccounting</option>
								<option>Quickbooks</option>
								<option>Tally</option>
								<option>SAP</option>
								<option>GnuCash</option>
								<option>Magento</option>
								<option>Joomla</option>
								<option>Zen Cart</option>
								<option>SmartPOS</option>
							</optgroup>
						</select>
						<br>
						<button class="btn"><i class="icon-circle-arrow-down"></i>&nbsp;Install</button>
					</td>
				</tr>
				-->
			  </table>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
  
  <table class="table">
		<tr class="alignMiddle">
			<td colspan="2">
			<div>
				<div class="blockLabel marginLeftZero">
					<h3 style="display:inline;">{vtranslate('LBL_GOOGLE_MAP_KEY', $QUALIFIED_MODULE)}</h3>
					
				</div>
			</div>
			</td>
		</tr>
		<tr>
			<td style="font-size:14px;">
			<span class="pull-right" >
							<strong>Google API KEY</strong>
			</span>
			</td>
			<td>
			<span class="googleapikeydisplay">
			{include file="file:test/user/googlemap.txt" assign=GOOGLEAPIKEY}
				{$GOOGLEAPIKEY}&nbsp;&nbsp;<span class="icon-pencil editgooglemapkey" title="Edit Google API Key" >
				</span>
				&nbsp;<br/><br/>
				<span style="color:blue">More info how to create google API key <a href="https://developers.google.com/maps/documentation/javascript/get-api-key" target="_blank" >Click here </a>
				</span>
			</span>
			<span class="edit hide">
				<input type="text" name="mapkey" id="mapkey" value="{$GOOGLEAPIKEY}"/>
				&nbsp;&nbsp;<button class="btn btn-success googleapikey" type="button" >
				<strong>Save</strong>
			</button>
			</span>
			</td>
		</tr>
		
	</table>
</div>