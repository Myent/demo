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

/*********************************************************************************
 ** The contents of this file are originally from vTiger distribution. 
  *  These are distributed with certain enhancements keeping in view the 
  *  vtiger CRM Public License Version 1.0
  *  Certain 3rd party components may have been deployed here keeping in mind their
  *  rights and licences
  *  Where used, these are acknoweledged inline with suitable comments
 *
 ********************************************************************************/

-->*}
{strip}
{assign var="FIELD_INFO" value=Zend_Json::encode($FIELD_MODEL->getFieldInfo())}
{assign var="SPECIAL_VALIDATOR" value=$FIELD_MODEL->getValidator()}
{assign var="FIELD_NAME" value=$FIELD_MODEL->get('name')}
<embed src="{$FIELD_MODEL->get('fieldvalue')}">
{/strip}
