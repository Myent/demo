{strip}
{*$FIELDMODEL|@var_export:true}
{
Array (
	[0] => Settings_vtDZiner_Field_Model Object (
		[webserviceField] =>
		[id] => 778
		[name] => cf_778
		[label] => OS
		[table] => vtiger_employmenthistorycf
		[column] => cf_778
		[columntype] =>
		[helpinfo] =>
		[summaryfield] => 0
		[masseditable] => 1
		[uitype] => 16
		[typeofdata] => V~O
		[displaytype] => 1
		[generatedtype] => 2
		[readonly] => 1
		[presence] => 2
		[defaultvalue] =>
		[maximumlength] => 100
		[sequence] => 8
		[quickcreate] => 1
		[quicksequence] =>
		[info_type] => BAS
		[block] => Vtiger_Block Object (
			[id] => 123
			[label] => LBL_EMPLOYMENTHISTORY_INFORMATION
			[sequence] => 1
			[showtitle] => 0
			[visible] => 0
			[increateview] => 0
			[ineditview] => 0
			[indetailview] => 0
			[display_status] => 1
			[iscustom] => 0
			[module] => Vtiger_Module Object (
				[id] => 55
				[name] => EmploymentHistory
				[label] => Employment History
				[version] => 0.0.1
				[minversion] =>
				[maxversion] =>
				[presence] => 0
				[ownedby] => 0
				[tabsequence] => -1
				[parent] => Human Resources
				[customized] => 1
				[trial] => 0
				[isentitytype] => 1
				[entityidcolumn] =>
				[entityidfield] =>
				[basetable] => vtiger_employmenthistory
				[basetableid] => employmenthistoryid
				[customtable] =>
				[grouptable] =>
			)
		)
	)
)
*}
<form id="FieldDetails">
<div id="globalmodal" style="display: block;">
<div class="currencyModalContainer">
<div class="modal-header contentsBackground">
<button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button><h3>Edit Field</h3>
</div>
<table width="100%" border="0" class="table table-bordered table-condensed">
	<tr>
		<td>Field Label</td>
		<td>
		<input name="hdn_fieldid" type="hidden" value="{$FIELDMODEL[0]->id}" />
		<input id = "txtfieldlabel" name="fieldlabel" type="text" value="{$FIELDMODEL[0]->label}" />
		</td>
	</tr>
	<tr>
		<td>UI Type</td>
		<td>
			{if $FIELDMODEL[0]->uitype == "16"}
				Click to Manage Picklist
			{/if}
		</td>
	</tr>
	<tr>
		<td>Mandatory Field</td>
		<td>
			{if $FIELDMODEL[0]->typeofdata|strstr:"~M" <> ""}
				<input type="checkbox" name="mandatory" id="cbmandatory" checked>
			{else}
				<input type="checkbox" name="mandatory" id="cbmandatory">
			{/if}
		</td>
	  </tr>
	<tr>
		<td>Active</td>
		<td>
			{if $FIELDMODEL[0]->presence == 2}
				<input type="checkbox" name="presence" id="cbpresence" checked>
			{elseif $FIELDMODEL[0]->presence == 0}
				<input type="checkbox" name="presence" id="cbpresence" checked disabled>
			{elseif $FIELDMODEL[0]->presence == 1}
				<input type="checkbox" name="presence" id="cbpresence">
			{/if}
		</td>
	</tr>
	<tr>
		<td>Quick Create</td>
		<td>
			{if $FIELDMODEL[0]->quickcreate == 1}
				<input type="checkbox" name="quickcreate" id="cbquickcreate" checked>
			{else}
				<input type="checkbox" name="quickcreate" id="cbquickcreate">
			{/if}
		</td>
	</tr>
	<tr>
		<td>Summary View</td>
		<td>
			{if $FIELDMODEL[0]->summaryfield == 1}
				<input type="checkbox" name="summaryfield" id="cbsummaryfield" checked>
			{else}
				<input type="checkbox" name="summaryfield" id="cbsummaryfield">
			{/if}
		</td>
	</tr>
	<tr>
		<td>Mass Edit</td>
		<td>
			{if $FIELDMODEL[0]->masseditable == 1}
				<input type="checkbox" name="masseditable" id="cbmasseditable" checked>
			{else}
				<input type="checkbox" name="masseditable" id="cbmasseditable">
			{/if}
		</td>
	  </tr>
	<tr>
		<td>Helpinfo</td>
		<td><input name="helpinfo" id="txthelpinfo"  type="text" value = "{$FIELDMODEL[0]->helpinfo}"></td>
	</tr>
	<!--
	<tr>
		<td>Searchable</td>
		<td><input type="checkbox" value="" name="searchable"></td>
	  </tr>
	  <tr>
		<td>All Filter</td>
		<td><input type="checkbox" value="" name="inAllFilter"></td>
	</tr>
	-->
	<tr>
		<td align="right" colspan="2">
		<span class="pull-right"><button style="margin: 5px;" id = "saveFieldDetails" type="submit" data-field-id="117" class="btn btn-success saveFieldDetails"><strong>Save</strong></button></span>
		</td>
	</tr>
</table>
</div>
</div>
</form>
{/strip}