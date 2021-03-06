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
	{assign var="deleted" value="deleted"|cat:$row_no}  
	{assign var="userid" value=$CURRENT_USER_MODEL->get('id')} 				
	<td>
		{*<i class="icon-trash deleteRow cursorPointer" title="{vtranslate('LBL_DELETE',$MODULE)}"></i>*}
		&nbsp;<a><img src="{vimage_path('drag.png')}" border="0" title="{vtranslate('LBL_DRAG',$MODULE)}"/></a>
		<input type="hidden" class="rowNumber" value="{$row_no}" />
	</td>
	<td>
	<select class="{$productcategory}{if $row_no neq 0} chzn-select {/if}" style="width:220px;" 
	 name="{$productcategory}" id="{$productcategory}"  >
	   <option value="">{vtranslate('LBL_SELECT_OPTION','Vtiger')}</option>
	   {foreach key=categoryid item=categoryname from=$PRODUCT_CATEGORIES}
			<option value="{$categoryid}" data-pc-label="{$categoryname}" {if trim(decode_html({$data.$productcategory})) eq trim($categoryid)} selected {/if}>{$categoryname}</option>
         {/foreach}
	</select>	
	<!--input type="text" id="{$productcategoryid}"  name="{$productcategoryid}" value="{$data.$productcategoryid}" class="productcategoryid"/>
	<input type="hidden" id="{$batchid}" name="{$batchid}" value="{$data.$batchid}" class="batchid"/-->
	</td>
	<td>
		<!-- Product Re-Ordering Feature Code Addition Starts -->
		<input type="hidden" name="row{$row_no}" id="row{$row_no}"  value="{$row_no}"/>
		<!-- Product Re-Ordering Feature Code Addition endsvalidate[required] -->
		<div>
			<input type="text" id="{$productName}" name="{$productName}" value="{$data.$productName}" class="productName {if $row_no neq 0} autoComplete {/if}" placeholder="{vtranslate('LBL_TYPE_SEARCH',$MODULE)}" data-validation-engine="" {if !empty($data.$productName)} disabled="disabled" {/if}/>
			<input type="hidden" id="{$productid}" name="{$productid}" value="{$data.$productid}" class="productid"/>   
			<input type="hidden" name="popupReferenceModule" id="popupReferenceModule" value="Products"/>
             <img class="lineItemPopup cursorPointer alignMiddle" data-popup="Popup" data-module-name="Products" title="{vtranslate('Products',$MODULE)}" data-field-name="productid" src="{vimage_path('Products.png')}"/> &nbsp;<i class="icon-remove-sign clearLineItem cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i>   
		</div>
	</td>
	
	<td>
	<!-- Prasent QtY data-validation-engine="validate[funcCall[Vtiger_GreaterThanZero_Validator_Js.invokeValidation]]"-->
		<input id="{$prasentqty}" readonly name="{$prasentqty}" type="text" class="prasentqty smallInputBox"  value="{if !empty($data.$prasentqty)}{$data.$prasentqty}{else}{/if}"/>
	</td>
	<td>
	<!-- Issued Qty -->
	<input id="{$issuedqty}" name="{$issuedqty}" type="text" class="qty smallInputBox" data-validation-engine="validate[funcCall[Vtiger_GreaterThanZero_Validator_Js.invokeValidation]]" value="{if !empty($data.$issuedqty)}{$data.$issuedqty}{else}{/if}"/>
		<span class="stockAlert redColor {if $data.$qty <= $data.$qtyInStock}hide{/if}" >
			{vtranslate('LBL_STOCK_NOT_ENOUGH',$MODULE)}
			<br>
			{vtranslate('LBL_MAX_QTY_SELECT',$MODULE)}&nbsp;<span class="maxQuantity">{$data.$qtyInStock}</span>
		</span>
	</td>
	<td>
	<!-- Issued BY -->
	<select class="{$issuedby}{if $row_no neq 0} chzn-select {/if}" style="width:220px;" 
	 name="{$issuedby}" id="{$issuedby}"  >
	   <option value="">{vtranslate('LBL_SELECT_OPTION','Vtiger')}</option>
	   {foreach key=OWNER_ID item=OWNER_NAME from=$ALL_ACTIVEUSER_LIST}
			<option value="{$OWNER_ID}" {if trim(decode_html({$data.$issuedby})) eq trim($OWNER_ID)} selected {elseif trim(decode_html({$data.$issuedby})) == '' && $userid == $OWNER_ID}
				 selected {/if}  >{$OWNER_NAME}</option>
         {/foreach}
	</select>	
	</td>
	<td>
		<textarea id="{$remarks}" name="{$remarks}" class="lineItemCommentBox">{$data.$remarks}</textarea>
	</td>