{*/* ********************************************************************************
* The content of this file is subject to the Collaboration ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}
{if $RECORD_MODEL->get('favorite') eq 1}
    {assign var=FAVORITE value = 'star-favorite'}
{else}
    {assign var=FAVORITE value = 'star-empty'}
{/if}
{assign var=ROOMSUSERSINFO value = $RECORD_MODEL->get('roomsusersinfo')}
<section id="c-detail-container">
    <header class="c-detail-header">
        <h2>
            <a data-favorite="{$RECORD_MODEL->get('favorite')}" data-record="{$RECORD_MODEL->get('roomsusersid')}" class="favorite-action {$FAVORITE}" href="javascript:void(0);"></a>
            <span class="separator">{$RECORD_MODEL->get('room_type_alias')}</span>
            <span class="room-title">{$RECORD_MODEL->get('name')}</span>
            <input type="text" id="search_message_internal" data-record="{$RECORD_MODEL->getId()}" class="pull-right" placeholder="{vtranslate('LBL_SEARCH', 'Rooms')}" />
            <input type="hidden" value="1" name="message_page_number" />
            <input type="hidden" value="{$RECORD_MODEL->get('message_page_number_end')}" name="message_page_end" />
            <input type="hidden" value="{$RECORD_MODEL->get('room_type')}" id="room-type" />
            <input type="hidden" value="{$ROOMSUSERSINFO.room_status}" id="room-status" />
            <input type="hidden" value="{$RECORD_MODEL->getId()}" id="room-id" />
            <input type="hidden" value="{$IS_OWNER}" id="member-is-owner" />
            {if $RECORD_MODEL->get('room_type') eq 'Private Group'}
            <a id="member-in-room" class="">
                &nbsp;<small>({$COUNT_USER_ACTIVE}{vtranslate('LBL_MEMBER_IN_ROOM', 'Rooms')})</small>
                <div class="members-in-room btn-info" style="display: none;">
                    {if $COUNT_USER_ACTIVE gt 0}
                        <ul>
                            {foreach item=USER from=$USERS_ACTIVE}
                                {if $USER.id neq $CURRENT_USER->getId()}
                                <li>
                                    <span>{$USER.fullname}</span>
                                    {if $IS_OWNER eq 1}
                                        <button type="button" data-record="{$USER.roomsusersid}" class="btn btn-danger pull-right">{vtranslate('LBL_REJECT_USER_FROM_ROOM', 'Rooms')}</button>
                                    {/if}
                                </li>
                                {/if}
                            {/foreach}
                        </ul>
                    {else}
                        <span>{vtranslate('LBL_HAVE_NOT_OTHER_MEMBER_IN_ROOM', 'Rooms')}</span>
                    {/if}
                </div>
            </a>
            {/if}

            {if $RECORD_MODEL->get('room_type') eq 'Private Group'}
            <a id="add-new-member" class="btn btn-success pull-right">
                <i class="icon-plus icon-white"></i>{vtranslate('LBL_MEMBER_ADD_NEW', 'Rooms')}
                <div class="members-not-in-room btn-success" style="display: none;">
                    {if $COUNT_USER_INACTIVE gt 0}
                        <ul>
                            {foreach item=USER from=$USERS_INACTIVE}
                                <li>
                                    <span>{$USER.fullname}</span>
                                    <button type="button" data-userid="{$USER.id}" class="btn btn-success pull-right">{vtranslate('LBL_ADD_USER_TO_ROOM', 'Rooms')}</button>
                                </li>
                            {/foreach}
                        </ul>
                    {else}
                        <span>{vtranslate('LBL_HAVE_NOT_USER_READY', 'Rooms')}</span>
                    {/if}
                </div>
            </a>
            {/if}

            <div id="room-related-record">
                {if $PARENT_LABEL neq ''}
                    <a href="{$PARENT_URL}" target="_blank">{$PARENT_LABEL}</a>
                    <a href="javascript:void(0);" class="room-related-record-remove" onclick="Vtiger_Rooms_Js.removeParent({$RECORD_MODEL->getId()})">x</a>
                {/if}
            </div>
        </h2>
    </header>
    <div class="message-box">
        <div class="message-box-container">
            <ul class="message-list">
                {foreach item=MESSAGE from=$RECORD_MODEL->get('messages')}
                <li class="message-item" id="msg{$MESSAGE.roomsmessagesid}">
                    <div class="member-avatar">
                        {if $MESSAGE.avatar eq null}
                            <span style="background-color: {$MESSAGE.avatar_alias_bg}">{$MESSAGE.avatar_alias_html}</span>
                        {else}
                            <img src="{$MESSAGE.avatar}">
                        {/if}
                    </div>
                    <div class="member-message">
                        <div class="member-message-header">
                            <span class="member-name">{$MESSAGE.member_name}</span>
                            <span class="message-item-date">{$MESSAGE.message_date}</span>
                        </div>
                        <div class="member-message-body">
                            {if $MESSAGE.msg_type eq 'attachment'}
                                <a href="index.php?module=RoomsMessages&action=DownloadFile&record={$MESSAGE.roomsmessagesid}">{$MESSAGE.filename}</a>
                            {else}
                            {$MESSAGE.message}
                            {/if}
                        </div>
                    </div>
                </li>
                {/foreach}
            </ul>
        </div>
    </div>
    <footer>
        {if $RECORD_MODEL->get('room_type') eq 'Channel' & $ROOMSUSERSINFO.room_status eq 'Pending'}
            <div class="user-join-box">
                <span>{vtranslate('LBL_PREVIEW_ROOM_DETAIL', 'Rooms')}<strong>{$RECORD_MODEL->get('name')}</strong></span>
                <button class="btn btn-success join-btn" type="button" data-record="{$RECORD_MODEL->get('roomsusersid')}"><strong>{vtranslate('LBL_JOIN', 'Rooms')}</strong></button>
            </div>
        {else}
            <div id="room-attachment-form">
                <form name="room-attachment-form" id="attachmentForm{$RECORD_MODEL->getId()}" method="post" action="index.php" enctype="multipart/form-data">
                    <input type="hidden" name="module" value="RoomsMessages" />
                    <input type="hidden" name="action" value="AttachAjax" />
                    <input type="hidden" name="room_id" value="{$RECORD_MODEL->getId()}" />
                    <input type="file" name="attachment" value="" class="room-attachment-input" />
                    <button type="button" class="room-attachment-alias">&nbsp;</button>
                </form>
            </div>
            <div id="room-message-form">
                <form name="message-form" id="messageForm{$RECORD_MODEL->getId()}" method="post" action="index.php">
                    <input type="hidden" name="module" value="RoomsMessages" />
                    <input type="hidden" name="action" value="SaveAjax" />
                    <input type="hidden" name="room_id" value="{$RECORD_MODEL->getId()}" />
                    <input type="hidden" id="users_tag" value='{Zend_Json::encode($USERS_TAG)}' />
                    <textarea name="message" placeholder="{vtranslate('LBL_MESSAGE', 'Rooms')}"></textarea>
                </form>
                <div id="room-emotion">
                    {include file='Emoticons.tpl'|@vtemplate_path:'Rooms'}
                    <i class="room-emotion-btn"></i>
                </div>
                <div class="formatting-tips" aria-hidden="true" dir="auto">
                    <b class="formatting-normal formatting-tip" data-type="b">{vtranslate('LBL_BOLD', 'Rooms')}</b>,&nbsp;
                    <i class="formatting-normal formatting-tip" data-type="i">{vtranslate('LBL_ITALIC', 'Rooms')}</i>,&nbsp;
                    <u class="formatting-normal formatting-tip" data-type="u">{vtranslate('LBL_UNDERLINE', 'Rooms')}</u>,&nbsp;
                    <div class="formatting-font-size formatting-tip" data-type="size">
                        {vtranslate('LBL_FONT_SIZE', 'Rooms')}
                        <ul class="formatting-font-size-list" style="display: none;">
                            <li><font size="1">{vtranslate('LBL_FONT_SIZE_VERY_SMALL', 'Rooms')}</font></li>
                            <li><font size="2">{vtranslate('LBL_FONT_SIZE_SMALL', 'Rooms')}</font></li>
                            <li><font size="3">{vtranslate('LBL_FONT_SIZE_NORMAL', 'Rooms')}</font></li>
                            <li><font size="4">{vtranslate('LBL_FONT_SIZE_BIG', 'Rooms')}</font></li>
                            <li><font size="6">{vtranslate('LBL_FONT_SIZE_VERY_BIG', 'Rooms')}</font></li>
                        </ul>
                    </div>,&nbsp;
                    <span class="formatting-font-color formatting-tip" data-type="color">{vtranslate('LBL_FONT_COLOR', 'Rooms')}</span>,&nbsp;
                    <span class="formatting-normal formatting-tip" data-type="url">{vtranslate('LBL_URL', 'Rooms')}</span>
                </div>
            </div>
        {/if}
    </footer>
</section>