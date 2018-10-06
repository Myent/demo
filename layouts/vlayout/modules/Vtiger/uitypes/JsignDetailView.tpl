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
{*print_r($JSIGN_DETAILS)*}
{foreach key=ITER item=IMAGE_INFO from=$RECORD->getJsignDetails()}
	{assign var='imgpath' value="`$IMAGE_INFO.path`_`$IMAGE_INFO.name`"}
	
	{if !empty($IMAGE_INFO.path) && !empty({$IMAGE_INFO.orgname}) && ($imgpath == $RECORD->get($FIELD_MODEL->getFieldName()))}		
		<img src="{$IMAGE_INFO.path}_{$IMAGE_INFO.name}" data-image-id="{$IMAGE_INFO.id}" width="150" height="80" >
	{/if}
{/foreach}