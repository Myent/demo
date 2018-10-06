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
    <div class="relatedContents contents-bottomscroll">
        <div class="bottomscroll-div">
            <table class="table table-bordered listViewEntriesTable">
                <thead>
                    <tr class="listViewHeaders">
                        <th nowrap>{vtranslate('LBL_RELATED_HEADER_ROOM_NAME',$MODULE)}</th>
                        <th nowrap>{vtranslate('LBL_RELATED_HEADER_LAST_MESSAGE_BY',$MODULE)}</th>
                        <th nowrap>{vtranslate('LBL_RELATED_HEADER_LAST_MESSAGE_DATE',$MODULE)}</th>
                    </tr>
                </thead>
                <tbody>
                    {if $ENTITY_COUNT gt 0}
                        {foreach item=ROOM from=$ENTITIES}
                        <tr>
                            <td>
                                {if $ROOM.can_view eq 1}
                                <a href="javascript:void(0);" onclick="Vtiger_Rooms_Js.showRoomDetailFromRelatedList({$ROOM.room_id});">
                                    {$ROOM.name}
                                </a>
                                {else}
                                    {$ROOM.name}
                                {/if}
                            </td>
                            <td>{$ROOM.user_full_name}</td>
                            <td>{$ROOM.createdtime_display}</td>
                        </tr>
                        {/foreach}
                    {/if}
                </tbody>
            </table>
        </div>
    </div>
{/strip}
