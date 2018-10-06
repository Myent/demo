{*/* ********************************************************************************
* The content of this file is subject to the Collaboration ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}
<script type="text/javascript" src="layouts/vlayout/modules/Rooms/resources/emoticons.js" />
<script type="text/javascript" src="libraries/jquery/colorpicker/js/colorpicker.js" />

<div id="collaboration-container" class="collaboration-{$CURRENT_USER->get('theme')}">
    <input type="hidden" value='{Zend_Json::encode($RELATED_MODULES)}' id="list-related-modules" />
    <div class="c-panel">
        <div class="c-me">
            <div class='avatar'>
                {if $CURRENT_USER_AVATAR.id eq null}
                    <span style="background-color: {$CURRENT_USER_AVATAR.alias_bg}">{$CURRENT_USER_AVATAR.alias_html}</span>
                {else}
                    <img src="{$CURRENT_USER_AVATAR.path}_{$CURRENT_USER_AVATAR.name}">
                {/if}
            </div>
            <div class="full-name" title="{$CURRENT_USER->getName()}"><h4>{$CURRENT_USER->getName()}</h4></div>
        </div>
        <div class="clearfix"></div>
        <div class="c-panel-subs c-panel-sub-available">
            <div class="c-panel-favorites">
                <h3>{vtranslate('LBL_FAVORITES', 'Rooms')}</h3>
                <ul>
                    {if $FAVORITE_ROOM_COUNT gt 0}
                        {foreach item=FAVORITE_ROOM from=$FAVORITE_ROOMS}
                            <li data-record="{$FAVORITE_ROOM.roomsid}" class="c-panel-room-title">
                                <span>{$FAVORITE_ROOM.name}</span>
                            </li>
                        {/foreach}
                    {/if}
                </ul>
            </div>
            <div class="c-panel-channel">
                <h3>{vtranslate('LBL_CHANNELS', 'Rooms')}<i class="icon-plus icon-white pull-right" data-type="channel" title="{vtranslate('LBL_CREATE_NEW_ROOM', 'Rooms')}"></i></h3>
                <div class="channel-list">
                {if $CHANNEL_ROOM_COUNT gt 0}
                    <ul>
                        {foreach item=CHANNEL_ROOM from=$CHANNEL_ROOMS}
                            <li data-room-type="{$CHANNEL_ROOM.room_type}" data-record="{$CHANNEL_ROOM.roomsid}" data-record-user="{$CHANNEL_ROOM.roomsusersid}" class="c-panel-room-title">
                                <span>{$CHANNEL_ROOM.name}</span><label class="room-unread-number unread-number-{$CHANNEL_ROOM.roomsid}"></label>
                                <i class="icon-off pull-right icon-white hide room-leave-btn" title="{vtranslate('LBL_LEAVE_TOOLTIP_TITLE', 'Rooms')}"></i>
                                <i class="icon-eye-close pull-right icon-white hide room-archive-btn" title="{vtranslate('LBL_ARCHIVE_TOOLTIP_TITLE', 'Rooms')}"></i>
                            </li>
                        {/foreach}
                    </ul>
                    <span class="c-panel-channel-more group-more" data-type="Channel">
                        {vtranslate('LBL_MORE_CHANNELS', 'Rooms')}
                    </span>
                {else}
                    <ul></ul>
                    {vtranslate('LBL_NO_CHANNELS', 'Rooms')}
                {/if}
                </div>
            </div>
            <div class="c-panel-direct-message">
                <h3>{vtranslate('LBL_DIRECT_MESSAGES', 'Rooms')}<i class="icon-plus icon-white pull-right" data-type="direct-message" title="{vtranslate('LBL_CREATE_NEW_ROOM', 'Rooms')}"></i></h3>
                <div class="direct-message-list">
                    {if $DIRECT_MESSAGE_ROOM_COUNT gt 0}
                    <ul>
                        {foreach item=DIRECT_MESSAGE_ROOM from=$DIRECT_MESSAGE_ROOMS}
                        <li data-room-type="{$DIRECT_MESSAGE_ROOM.room_type}" data-record="{$DIRECT_MESSAGE_ROOM.roomsid}" data-record-user="{$DIRECT_MESSAGE_ROOM.roomsusersid}" class="c-panel-room-title">
                            <span>{$DIRECT_MESSAGE_ROOM.name}</span><label class="room-unread-number unread-number-{$DIRECT_MESSAGE_ROOM.roomsid}"></label>
                            <i class="icon-off pull-right icon-white hide room-leave-btn" title="{vtranslate('LBL_LEAVE_TOOLTIP_TITLE', 'Rooms')}"></i>
                            <i class="icon-eye-close pull-right icon-white hide room-archive-btn" title="{vtranslate('LBL_ARCHIVE_TOOLTIP_TITLE', 'Rooms')}"></i>
                        </li>
                        {/foreach}
                    </ul>
                    <span class="c-panel-direct-message-more group-more" data-type="Direct Message">
                        {vtranslate('LBL_MORE_DIRECT_MESSAGES', 'Rooms')}
                    </span>
                    {else}
                        <ul></ul>
                        {vtranslate('LBL_NO_DIRECT_MESSAGES', 'Rooms')}
                    {/if}
                </div>
            </div>
            <div class="c-panel-private-group">
                <h3>{vtranslate('LBL_PRIVATE_GROUPS', 'Rooms')}<i class="icon-plus icon-white pull-right" data-type="private-group" title="{vtranslate('LBL_CREATE_NEW_ROOM', 'Rooms')}"></i></h3>
                <div class="private-group-list">
                    {if $PRIVATE_GROUP_ROOM_COUNT gt 0}
                    <ul>
                        {foreach item=PRIVATE_GROUP_ROOM from=$PRIVATE_GROUP_ROOMS}
                            <li data-room-type="{$PRIVATE_GROUP_ROOM.room_type}" data-record="{$PRIVATE_GROUP_ROOM.roomsid}" data-record-user="{$PRIVATE_GROUP_ROOM.roomsusersid}" class="c-panel-room-title">
                                <span>{$PRIVATE_GROUP_ROOM.name}</span><label class="room-unread-number unread-number-{$PRIVATE_GROUP_ROOM.roomsid}"></label>
                                <i class="icon-off pull-right icon-white hide room-leave-btn" title="{vtranslate('LBL_LEAVE_TOOLTIP_TITLE', 'Rooms')}"></i>
                                <i class="icon-eye-close pull-right icon-white hide room-archive-btn" title="{vtranslate('LBL_ARCHIVE_TOOLTIP_TITLE', 'Rooms')}"></i>
                            </li>
                        {/foreach}
                    </ul>
                    <span class="c-panel-private-group-more group-more" data-type="Private Group">
                        {vtranslate('LBL_MORE_PRIVATE_GROUPS', 'Rooms')}
                    </span>
                    {else}
                        <ul></ul>
                        {vtranslate('LBL_NO_PRIVATE_GROUPS', 'Rooms')}
                    {/if}
                </div>
            </div>
            <div class="c-panel-archived">
                <h3>{vtranslate('LBL_ARCHIVE', 'Rooms')}</h3>
                <div class="archived-list">
                    {if $ARCHIVED_ROOM_COUNT gt 0}
                        <ul>
                            {foreach item=ARCHIVED_ROOM from=$ARCHIVED_ROOMS}
                                <li data-room-type="{$ARCHIVED_ROOM.room_type}" data-record="{$ARCHIVED_ROOM.roomsid}" data-record-user="{$ARCHIVED_ROOM.roomsusersid}" class="c-panel-room-title">
                                    <span>{$ARCHIVED_ROOM.name}</span><label class="room-unread-number unread-number-{$ARCHIVED_ROOM.roomsid}"></label>
                                    <i class="icon-off pull-right icon-white hide room-leave-btn" title="{vtranslate('LBL_LEAVE_TOOLTIP_TITLE', 'Rooms')}"></i>
                                    <i class="icon-eye-open pull-right icon-white hide room-restore-archive-btn" title="{vtranslate('LBL_REMOVE_ARCHIVE_TOOLTIP_TITLE', 'Rooms')}"></i>
                                </li>
                            {/foreach}
                        </ul>
                        <span class="c-panel-archived-more group-more" data-type="Archived">
                        {vtranslate('LBL_MORE_ARCHIVE', 'Rooms')}
                    </span>
                    {else}
                        <ul></ul>
                        {vtranslate('LBL_NO_ARCHIVE', 'Rooms')}
                    {/if}
                </div>
            </div>
            <div class="c-panel-history">
                <h3>{vtranslate('LBL_HISTORY', 'Rooms')}</h3>
            </div>
        </div>
        <div class="c-panel-subs c-panel-sub-form">
            <div class="c-panel-sub-form-child c-panel-channel-form">
                <h4>{vtranslate('LBL_CREATE_CHANEL', 'Rooms')}</h4>
                <div class="input-line">
                    <label for="channel-name">{vtranslate('LBL_ROOM_NAME', 'Rooms')}</label>
                    <input type="text" id="channel-name" class="required">
                </div>
                <div class="input-submit">
                    <button class="btn btn-success" type="button" data-type="channel"><strong>{vtranslate('LBL_SAVE', 'Rooms')}</strong></button>
                    <button class="cancelLink btn btn-warning" type="button">{vtranslate('LBL_CANCEL', 'Rooms')}</button>
                </div>
            </div>
            <div class="c-panel-sub-form-child c-panel-direct-message-form">
                <h4>{vtranslate('LBL_CREATE_DIRECT_MESSAGE', 'Rooms')}</h4>
                <div class="input-line">
                    <label for="who">{vtranslate('LBL_WITH_WHOM', 'Rooms')}</label>
                    <select name="who" class="chzn-select" id="who" data-placeholder="{vtranslate('LBL_MEMBERS', 'Rooms')}">
                        {foreach item=USER from=$USER_LIST}
                            <option value="{$USER.id}" class="user-status status-{{$USER.log_status_class}}">{$USER.fullname}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="input-submit">
                    <button class="btn btn-success" type="button" data-type="direct-message"><strong>{vtranslate('LBL_SAVE', 'Rooms')}</strong></button>
                    <button class="cancelLink btn btn-warning" type="button">{vtranslate('LBL_CANCEL', 'Rooms')}</button>
                </div>
            </div>
            <div class="c-panel-sub-form-child c-panel-private-group-form">
                <h4>{vtranslate('LBL_CREATE_PRIVATE_GROUP', 'Rooms')}</h4>
                <div class="input-line">
                    <label for="private-group-name">{vtranslate('LBL_ROOM_NAME', 'Rooms')}</label>
                    <input type="text" id="private-group-name" class="required">
                </div>
                <div class="input-line">
                    <label for="group-members">{vtranslate('LBL_MEMBERS', 'Rooms')}</label>
                    <select name="private-group-members" class="chzn-select" id="private-group-members" multiple="multiple" data-placeholder="{vtranslate('LBL_MEMBERS', 'Rooms')}">
                        {foreach item=USER from=$USER_LIST}
                            <option value="{$USER.id}" class="user-status status-{{$USER.log_status_class}}">{$USER.fullname}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="input-submit">
                    <button class="btn btn-success" type="button" data-type="private-group"><strong>{vtranslate('LBL_SAVE', 'Rooms')}</strong></button>
                    <button class="cancelLink btn btn-warning" type="button">{vtranslate('LBL_CANCEL', 'Rooms')}</button>
                </div>
            </div>
        </div>
        <div class="c-panel-subs c-panel-sub-all">
            <div class="c-panel-all-rooms">
            </div>
        </div>
    </div>
    <div class="c-details">
        {vtranslate('LBL_COLLABORATION_HOME', 'Rooms')}
    </div>
    <div id="collaboration_js_strings" class="hide noprint">{Zend_Json::encode($JS_LANGUAGES)}</div>
</div>

