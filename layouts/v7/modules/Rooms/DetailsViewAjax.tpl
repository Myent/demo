{*/* ********************************************************************************
* The content of this file is subject to the Collaboration ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}
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