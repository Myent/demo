{foreach key=BLOCK_LABEL_KEY item=BLOCK_MODEL from=$BLOCKS}
	{assign var=BLOCK_ID value=$BLOCK_MODEL->get('id')}
	{$ALL_BLOCK_LABELS[$BLOCK_ID] = $BLOCK_LABEL_KEY}
{/foreach}
<div class="modelContainer modal addBlockModal" id="blockDetailsContainer">
	<div class="contents tabbable">
		<div class="modal-header contentsBackground">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h3>{vtranslate('LBL_ADD_CUSTOM_BLOCK', 'Settings::vtDZiner')}</h3>
		</div>
		<form class="form-horizontal addCustomBlockForm" method="POST">
			<div class="modal-body">
				<div class="control-group">
					<span class="control-label">
						<span class="redColor">*</span>
						<span>{vtranslate('LBL_BLOCK_NAME', 'Settings::vtDZiner')}</span>
					</span>
					<div class="controls">
						<input type="text" name="label" class="span3" data-validation-engine="validate[required]" />
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						{vtranslate('LBL_ADD_AFTER', 'Settings::vtDZiner')}
					</span>
					<div class="controls">
						<span class="row-fluid">
							<select class="span8 vtselector" name="beforeBlockId">
                            {foreach key=BLOCK_ID item=BLOCK_LABEL from=$ALL_BLOCK_LABELS}
                                <option value="{$BLOCK_ID}" data-label="{$BLOCK_LABEL}">{vtranslate($BLOCK_LABEL, $QUALIFIED_MODULE)}</option>
                            {/foreach}
							</select>
						</span>
					</div>
				</div>
				<div class="control-group">
					<span class="control-label">
						<strong>
							{vtranslate('LBL_CUSTOM_BLOCK_TYPE', 'Settings::vtDZiner')}
						</strong>
					</span>
					<div class="controls">
						<span class="row-fluid">
						<select class="span8 vtselector" name="blockType">
							<option title = "Vanilla Vtiger Block of Data fields" value="Standard" data-label="Standard">Standard</option>
							<!--option title = "Enables Comments block access from right side panel" value="Comments" data-label="Comments">Comments</option>
							<!--
							<option title = "Vanilla Vtiger Block of Data fields" value="Related" data-label="Related">Related</option>
							<option title = "Vanilla Vtiger Block of Data fields" value="Subpanels" data-label="Subpanels">Subpanels</option>
							<option value="Pickblock" data-label="Pickblock">Pickblock</option>
							<option value="Address" data-label=""></option>
							<option value="Grid" data-label=""></option>
							-->
						</select>
						</span>
					</div>
				</div>
			</div>
			{include file='ModalFooter.tpl'|@vtemplate_path:'Vtiger'}
		</form>
	<div>
</div>