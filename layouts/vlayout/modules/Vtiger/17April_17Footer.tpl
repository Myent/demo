{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
*
 ********************************************************************************/
-->*}
{strip}
		<input id='activityReminder' class='hide noprint' type="hidden" value="{$ACTIVITY_REMINDER}"/>

		{* Feedback side-panel button *}
		{if $HEADER_LINKS && $MAIN_PRODUCT_SUPPORT && !$MAIN_PRODUCT_WHITELABEL}
		{assign var="FIRSTHEADERLINK" value=$HEADER_LINKS.0}
		{assign var="FIRSTHEADERLINKCHILDRENS" value=$FIRSTHEADERLINK->get('childlinks')}
		{assign var="FEEDBACKLINKMODEL" value=$FIRSTHEADERLINKCHILDRENS.2}
		<div id="userfeedback" class="feedback noprint">
			<a href="https://discussions.vtiger.com" target="_blank" xonclick="{$FEEDBACKLINKMODEL->get('linkurl')}" class="handle">{vtranslate("LBL_FEEDBACK", "Vtiger")}</a>
		</div>
		{/if}

		{if !$MAIN_PRODUCT_WHITELABEL && isset($CURRENT_USER_MODEL)}
		<footer class="noprint">
                    <div class="vtFooter">
			<p>
				{vtranslate('SYSTEM ERP v. 6.5')} &nbsp;
				&copy; 2010 - {date('Y')}&nbsp&nbsp;
				<a href="//www.benchmarklabs.com" target="_blank">benchmark.com</a>
				&nbsp;|&nbspP
				<a href="http://www.benchmarklabs.com/license" target="_blank">{vtranslate('rivate License')}</a>
				&nbsp;|&nbsp;
				<a href="http://www.benchmarklabs.com/privacy" target="_blank">{vtranslate('Privacy Policy')}</a>
			</p>
                     </div>
		</footer>
		{/if}

		{* javascript files *}
		{include file='JSResources.tpl'|@vtemplate_path}
		{* BEGIN vtDZiner JS variables setting *}
			{if isset($BLOCKS)}<script>var vtBlockDetail = {$BLOCKS|json_encode};</script>{/if}
			{if isset($PANELTABS)}<script>var panelTabs = {$PANELTABS|json_encode};</script>{/if}
			{if isset($PICKBLOCKS)}<script>var pickBlocks = {$PICKBLOCKS|json_encode};</script>{/if}
			{if isset($RECORD)}<script>var vtRecordModel = {$RECORD|json_encode};</script>{/if}
			{if isset($RECORD_STRUCTURE) and {$RECORD_STRUCTURE|json_encode neq ""}}<script>var vtRecordStructure = {$RECORD_STRUCTURE|json_encode};</script>{/if}
			<script>
				var vtDZActive = "{$smarty.session.VTDZINERSTATUS}";
				var vtSession = {$smarty.session|json_encode};
			</script>
		{* vtDZiner JS variables setting END *}
		</div>
	</body>
</html>
{/strip}
