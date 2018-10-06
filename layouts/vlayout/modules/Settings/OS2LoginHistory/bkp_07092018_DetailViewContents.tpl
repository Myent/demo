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

<div class="container-fluid">
    <div class="row-fluid">
		<input type="hidden" name="moduledata" id="moduledata" value="{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($ISSUES_LIST))}">
				<table class="table table-striped table-bordered login_table modules-data">
					<thead>
					<tr>
					<th width="{$WIDTH}%" style="border-left: 1px solid #DDD !important;" nowrap="nowrap">
						{vtranslate('LBL_WHODID', $QUALIFIED_MODULE)}
					</th>
					<th width="{$WIDTH}%" style="border-left: 1px solid #DDD !important;" nowrap="nowrap">
						{vtranslate('LBL_MODULES', $QUALIFIED_MODULE)}
					</th>
					<th width="{$WIDTH}%" style="border-left: 1px solid #DDD !important;" nowrap="nowrap">
						{vtranslate('LBL_FIELDNAME', $QUALIFIED_MODULE)}
					</th>
					<th width="{$WIDTH}%" style="border-left: 1px solid #DDD !important;" nowrap="nowrap">
						{vtranslate('LBL_PRE_VALUE', $QUALIFIED_MODULE)}
					</th>
					<th width="{$WIDTH}%" style="border-left: 1px solid #DDD !important;" nowrap="nowrap">
						{vtranslate('LBL_POST_VALUE', $QUALIFIED_MODULE)}
					</th>
					<th width="{$WIDTH}%" style="border-left: 1px solid #DDD !important;" nowrap="nowrap">
						{vtranslate('LBL_CHANGEON', $QUALIFIED_MODULE)}
					</th>
					<th></th>
					</tr>
					<tr>
							<th><div class="row-fluid">
								<input type="text" name="search_username" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SEARCH_USERNAME}"/>
							</div></th>
							<th><div class="row-fluid">
								<input type="text" name="search_modulename" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SEARCH_MODULENAME}"/>
							</div></th>
							<th><div class="row-fluid">
								<input type="text" name="search_fieldname" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SEARCH_FIELDNAME}"/>
							</div></th>
							<th><div class="row-fluid">
								<input type="text" name="search_prevalue" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SEARCH_PRE_VALUE}"/>
							</div></th>
							<th><div class="row-fluid">
								<input type="text" name="search_postvalue" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SEARCH_POST_VALUE}"/>
							</div></th>
							<th><div class="row-fluid">
								<input id="listviewsearchfield" type="text" class="changedon dateField span9 listSearchContributor autoComplete ui-autocomplete-input" name="search_changedon" data-date-format="dd-mm-yyyy" value="{$SEARCH_CHANGEDON}" data-validation-engine="validate[funcCall[Vtiger_Base_Validator_Js.invokeValidation]]">
					  			<span class="add-on"><i class="icon-calendar change"></i></span>

							<!-- 	<input type="text" name="search_changedon" class="span9 listSearchContributor autoComplete ui-autocomplete-input" id="listviewsearchfield" value ="{$SEARCH_CHANGEDON}"/> -->
							</div></th>
							<th><div class="row-fluid">
								<button class="btn search_btn" data-trigger="listSearch">{vtranslate('LBL_SEARCH', $MODULE )}</button>
							</div></th>
						</tr>

					</thead>
					<tbody>
					{if $ISSUES_LIST['pagination']['totalcount'] > 0}
						{foreach key=INDEX item=LINE_ITEM_DETAIL from=$ISSUES_LIST}
						<tr>
	                           <td>{$LINE_ITEM_DETAIL["whodid"]}</td>
	                           <td>{$LINE_ITEM_DETAIL["module"]}</td>
	                           <td>{$LINE_ITEM_DETAIL["fieldname"]}</td>
	                           <td>{$LINE_ITEM_DETAIL["prevalue"]}</td>
						       <td>{$LINE_ITEM_DETAIL["postvalue"]}</td>
						       <td>{$LINE_ITEM_DETAIL['changedon']}</td>
							   <td></td>
						</tr>
						{/foreach}{else}
						<tr><td colspan='7'>No Actions Performed</td></tr>
						{/if}
					</tbody>
				</table>
	</div>
</div>
{/strip}
<script type="text/javascript">
	$(document).ready(function(){

   	   app.registerEventForDatePickerFields('.changedon');
		jQuery('.change').on('click',function(){
		  jQuery(".changedon").trigger("focus");
		 });
});	
</script>
 	  