{*/* ********************************************************************************
* The content of this file is subject to the Collaboration ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}
<div class="history-message-result">
    <h3>{vtranslate('LBL_SHOWING', 'Rooms')} {$ALL_ROOM_RESULT_COUNT} {vtranslate('LBL_RESULTS', 'Rooms')}</h3>
    <ul class="message-list message-box">
        {foreach item=ROOM from=$ALL_ROOMS}
            <li class="c-panel-room-title" data-record="" data-room-id="{$ROOM.roomsid}">
                <label><strong>{$ROOM.room_type_alias}&nbsp;{$ROOM.name}</strong></label>
                {$ROOM.msg_count}&nbsp;messages<br />
                {$ROOM.join_date}
            </li>
        {/foreach}
    </ul>
</div>
<div class="history-room-archived-result">
    <h3>{vtranslate('LBL_SHOWING', 'Rooms')} {$ROOM_ARCHIVED_RESULT_COUNT} {vtranslate('LBL_ARCHIVED', 'Rooms')} {vtranslate('LBL_RESULTS', 'Rooms')}</h3>
    <ul class="rooms-archived-list">
        {foreach item=ROOM_ARCHIVED from=$ROOMS_ARCHIVED}
            <li class="c-panel-room-title" data-record="" data-room-id="{$ROOM_ARCHIVED.roomsid}">
                <label><strong>{$ROOM_ARCHIVED.room_type_alias}&nbsp;{$ROOM_ARCHIVED.name}</strong></label>
                {$ROOM_ARCHIVED.msg_count}&nbsp;messages<br />
                {$ROOM_ARCHIVED.join_date}
            </li>
        {/foreach}
    </ul>
</div>