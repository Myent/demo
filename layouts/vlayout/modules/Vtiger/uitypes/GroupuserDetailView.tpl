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
 
 {assign var=USERS_LIST_INFO value=$USER_MODEL->getAccessibleUsersForModule($MODULE)}
{assign var=GROUPS_LIST_INFO value=$USER_MODEL->getAccessibleGroupForModule($MODULE)}
	
{assign var=FIELD_VALUE value=explode(';',$FIELD_MODEL->get('fieldvalue'))}
 
	

{assign var=names value= $FIELD_MODEL->getDisplayValue($FIELD_MODEL->get('fieldvalue'), $RECORD->getId(), $RECORD)}
 
 {foreach item=PICKLIST_VALUE key=PICKLIST_NAME  from=$FIELD_VALUE}     
	 {$GROUPS_LIST_INFO[$PICKLIST_VALUE]}
	 {$USERS_LIST_INFO[$PICKLIST_VALUE]}<br>
    {/foreach}
{/strip} 

