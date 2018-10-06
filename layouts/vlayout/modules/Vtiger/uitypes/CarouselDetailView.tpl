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
<div class="imageContainer" id="{$FIELD_MODEL->get('name')}">
	{foreach key=ITER item=IMAGE_INFO from=$RECORD->getGalleryDetails({$FIELD_MODEL->getName()})}
		{if !empty($IMAGE_INFO.path) && !empty({$IMAGE_INFO.orgname})}
			<img src="{$IMAGE_INFO.path}_{$IMAGE_INFO.orgname}" width="150" height="80">
		{/if}
	{/foreach}
</div>
<script>
	var tdid = jQuery("#{$FIELD_MODEL->get('name')}").closest('td').attr('id');
	console.log(tdid);
	jQuery("#"+tdid).next('td').remove();
</script>