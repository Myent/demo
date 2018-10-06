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
	<div class="checklist" id="checklist">
		<div class="">
			<ul class="nav nav-list">
			{foreach item=filterName from=$CHKLIST}
				<li>
					<a class="vtchk" onclick="Settings_OS2Checklist_ClController_Js.triggerLoad({$filterName[1]});" data-record="{$filterName[1]}">
						{$filterName[0]}
					</a>
				</li>
			{/foreach}
			</ul>
		</div>
	</div>

{/strip}
