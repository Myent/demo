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
    <input type="hidden" id="pageStartRange" value="{$PAGING_MODEL->getRecordStartRange()}" />
    <input type="hidden" id="pageEndRange" value="{$PAGING_MODEL->getRecordEndRange()}" />
    <input type="hidden" id="previousPageExist" value="{$PAGING_MODEL->isPrevPageExists()}" />
    <input type="hidden" id="nextPageExist" value="{$PAGING_MODEL->isNextPageExists()}" />
    <input type="hidden" id="totalCount" value="{$LISTVIEW_COUNT}" />
    <input type="hidden" value="{$ORDER_BY}" id="orderBy">
    <input type="hidden" value="{$SORT_ORDER}" id="sortOrder">
    <input type="hidden" id="totalCount" value="{$LISTVIEW_COUNT}" />
    <input type='hidden' value="{$PAGE_NUMBER}" id='pageNumber'>
    <input type='hidden' value="{$PAGING_MODEL->getPageLimit()}" id='pageLimit'>
    <input type="hidden" value="{$LISTVIEW_ENTRIES_COUNT}" id="noOfEntries">

	
    <div class="listViewEntriesDiv row-fluid" id="listViewContents">
            <table class="table table-bordered listViewEntriesTable vte-checklist-items">
                <thead>
                    <tr class="listViewHeaders">
                        <th class="medium"></th>
                        <th class="medium">Check List Name</th>
                        <th class="medium">Module Name</th>
                        <th class="medium">Created</th>
                        <th class="medium" colspan="2">Status</th>
                    </tr>
                </thead>
				<tbody>
            {foreach item=LISTVIEW_ENTRY from=$LISTVIEW_ENTRIES}
                <tr class="listViewEntries" data-id="{$LISTVIEW_ENTRY->getId()}"
                {if method_exists($LISTVIEW_ENTRY,'getDetailViewUrl')}data-recordurl="{$LISTVIEW_ENTRY->getDetailViewUrl()}"{/if}
                >
                <td width="5%" nowrap class="{$WIDTHTYPE}">
                    <img src="{vimage_path('drag.png')}" class="alignTop" title="{vtranslate('LBL_DRAG',$QUALIFIED_MODULE)}" />
                </td>
                {foreach item=LISTVIEW_HEADER from=$LISTVIEW_HEADERS}
                    {assign var=LISTVIEW_HEADERNAME value=$LISTVIEW_HEADER->get('name')}
                    {assign var=LAST_COLUMN value=$LISTVIEW_HEADER@last}
                    <td class="listViewEntryValue {$WIDTHTYPE}"  width="{$WIDTH}%" nowrap>
                        {if $LISTVIEW_HEADERNAME  eq 'currency_status' }
                            {if {$LISTVIEW_ENTRY->getDisplayValue($LISTVIEW_HEADERNAME)}  eq 'Active' } 
                               &nbsp;{vtranslate('LBL_ACTIVE',$QUALIFIED_MODULE)}  
                            {else} 
                               &nbsp;{vtranslate('LBL_INACTIVE',$QUALIFIED_MODULE)}
                            {/if}
                        {else}
                            &nbsp;{$LISTVIEW_ENTRY->getDisplayValue($LISTVIEW_HEADERNAME)}
                        {/if}
                        
                    </td>
				{/foreach}
					<td nowrap class="{$WIDTHTYPE}">
                            <div class="pull-right actions">
                                <span class="actionImages">
                                    {foreach item=RECORD_LINK from=$LISTVIEW_ENTRY->getRecordLinks()}
                                        {assign var="RECORD_LINK_URL" value=$RECORD_LINK->getUrl()}
                                       <a {if stripos($RECORD_LINK_URL, 'javascript:')===0} onclick="{$RECORD_LINK_URL|substr:strlen("javascript:")};if(event.stopPropagation){ldelim}event.stopPropagation();{rdelim}else{ldelim}event.cancelBubble=true;{rdelim}" {else} href='{$RECORD_LINK_URL}' {/if}>
                                            <i class="{$RECORD_LINK->getIcon()} alignMiddle" title="{vtranslate($RECORD_LINK->getLabel(), $QUALIFIED_MODULE)}"></i>
                                        </a>
                                    {/foreach}
                                </span>
                            </div>
                        </td>
                  
                    </td>
            </tr>
        {/foreach}
    </tbody>
    </table>
        </div>
{/strip}   