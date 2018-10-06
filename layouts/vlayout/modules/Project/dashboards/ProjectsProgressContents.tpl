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

<div class="dashboardWidgetContent">
	{if count($MODELS) > 0}
	<div style='padding:5px'>
		<div class='row-fluid'>
		<table class='table'>
			<tr>
			{foreach item=HEADER from=$MODULE_HEADER}				 
				<td>
					<b>{vtranslate({$HEADER}, $MODULE_NAME)}</b>
				</td>				 
			{/foreach}				 
			</tr>
		   {foreach item=VALUE key=KEY_VALUE  from=$MODELS}
			    <tr>				 	
				   {foreach item=ITEM_VALUE key=KEY_VALUE from=$VALUE}	 
						<td>{$ITEM_VALUE}</td>			 
					{/foreach}			 
				</tr>
			{/foreach}
		</div>
	</div>
	{else}
		<span class="noDataMsg">
			{vtranslate('LBL_NO')} {vtranslate($MODULE_NAME, $MODULE_NAME)} {vtranslate('LBL_MATCHED_THIS_CRITERIA')}
		</span>
	{/if}
</div>
