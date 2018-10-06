{*<!--/************************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ************************************************************************************/-->*}

{strip}
<div class="detailViewContainer" id="open_email_con" name="open_email_con">
        {assign var=ATTACHMENT_COUNT value=(count($ATTACHMENTS))}
        <input type="hidden" id="mmAttchmentCount" value="{$ATTACHMENT_COUNT}">

    <div class="row-fluid detailViewTitle">
        <div class="span12">
            <div class="row-fluid">
                <div>
                    <h3 id="_mailopen_subject">{$MAIL->subject()}</h3>
                </div>
            </div>
            <br>
            <div class="row-fluid">
                <div class="btn-toolbar span10">
                    <div class="btn-group">
                        <button class="btn pull-left" onclick="MailManager.mail_close();" href='javascript:void(0);'><strong>&#171; {$FOLDER->name()}</strong></button>
                    </div>
                    <div class="btn-group">
                        <button class="btn" onclick="MailManager.mail_reply(true);"><strong>{vtranslate('LBL_Reply_All',$MODULE)}</strong></button>
                        <button class="btn" onclick="MailManager.mail_reply(false);"><strong>{vtranslate('LBL_Reply',$MODULE)}</strong></button>
                        <button class="btn" onclick="MailManager.mail_forward({$MAIL->msgno()});"><strong>{vtranslate('LBL_Forward',$MODULE)}</strong></button>
                        <button class="btn" onclick="MailManager.mail_mark_unread('{$FOLDER->name()}', {$MAIL->msgno()});"><strong>{vtranslate('LBL_Mark_As_Unread',$MODULE)}</strong></button>
                        <button class="btn" onclick="MailManager.mail_print();"><strong>{vtranslate('LBL_Print',$MODULE)}</strong></button>
                    </div>
                    <div class="btn-group">
                        <button class="btn btn-danger" id = 'mail_delete_dtlview' onclick="MailManager.maildelete('{$FOLDER->name()}',{$MAIL->msgno()},true);"><strong>{vtranslate('LBL_Delete',$MODULE)}</strong></button>
                    </div>
                </div>
				<div class="span2">
					<span class="btn-group pull-right">
						<button class="btn"
							{if $MAIL->msgno() < $FOLDER->count()}
								onclick="MailManager.mail_open( '{$FOLDER->name()}', {$MAIL->msgno(1)});"
							{else}
								disabled="disabled"
							{/if}>
							<span class="icon-chevron-left"></span>
						</button>
						<button class="btn"
							{if $MAIL->msgno() > 1}
								onclick="MailManager.mail_open( '{$FOLDER->name()}', {$MAIL->msgno(-1)});"
							{else}
								disabled="disabled"
							{/if}>
							<span class="icon-chevron-right"></span>
						</button>
					</span>
				</div>
            </div>
        </div>
    </div>

    <div class="detailViewInfo row-fluid">
        <div class="span12 details">
            <div class="contents" style="padding-right: 2.2%;">
                <div class="row-fluid">
                    <div class="span6">
                        <span id="_mailopen_msgid_" style="display:none;">{$MAIL->_uniqueid|@escape:'UTF-8'}</span>

                        <label class="displayInlineBlock"><strong>{vtranslate('LBL_FROM', $MODULE)} :&nbsp;</strong></label>
                        <span id="_mailopen_from">
                            {foreach item=SENDER from=$MAIL->from()}
                                {$SENDER}
                            {/foreach}
                        </span><br>

                        {if $MAIL->to()}
                            <label class="displayInlineBlock"><strong>{vtranslate('LBL_TO',$MODULE)} :&nbsp;</strong></label>
                            <span id="_mailopen_to">
                                {foreach item=RECEPIENT from=$MAIL->to() name="TO"}
                                {if $smarty.foreach.TO.index > 0}, {/if}{$RECEPIENT}
                            {/foreach}
                        </span><br>
                    {/if}

                    {if $MAIL->cc()}
                        <label class="displayInlineBlock"><strong>{vtranslate('LBL_CC',$MODULE)} :&nbsp;</strong></label>
                        <span id="_mailopen_cc">
                            {foreach item=CC from=$MAIL->cc() name="CC"}
                            {if $smarty.foreach.CC.index > 0}, {/if}{$CC}
                        {/foreach}
                    </span><br>
                {/if}

                {if $MAIL->bcc()}
                    <label class="displayInlineBlock"><strong>{vtranslate('LBL_BCC',$MODULE)} :&nbsp;</strong></label>
                    <span id="_mailopen_cc">
                        {foreach item=BCC from=$MAIL->bcc() name="BCC"}
                        {if $smarty.foreach.BCC.index > 0}, {/if}{$BCC}
                    {/foreach}
                </span><br>
            {/if}

            <label class="displayInlineBlock"><strong>{vtranslate('LBL_Date',$MODULE)} :&nbsp;</strong></label>
            <span id="_mailopen_date">{$MAIL->date()}</span><br>
 	       {if $ATTACHMENT_COUNT gt 0}
	    <label class="displayInlineBlock"><strong>{vtranslate('LBL_Attachments',$MODULE)} :&nbsp;</strong></label>
                {foreach item=ATTACHVALUE from=$ATTACHMENTS name="attach"}
                    {assign var=ATTACHNAME value=$ATTACHVALUE['filename']}
		     {assign var=DOWNLOAD_LINK value=$ATTACHNAME|@escape:'url'}
					    <span>
                            
                            <a href="index.php?module={$MODULE}&view=Index&_operation=mail&_operationarg=attachment_dld&_muid={$MAIL->muid()}&_atname={$DOWNLOAD_LINK|@escape:'htmlall':'UTF-8'}">
                                {$ATTACHNAME}
                            </a>
                            <span>&nbsp;&nbsp;({$ATTACHVALUE['size']})</span>
                            <a href="index.php?module={$MODULE}&view=Index&_operation=mail&_operationarg=attachment_dld&_muid={$MAIL->muid()}&_atname={$DOWNLOAD_LINK|@escape:'htmlall':'UTF-8'}">
                                &nbsp;&nbsp;<i class="fa fa-download"></i>
                            </a>
                        </span>
                        <br>
		{/foreach}
		{/if}

            
        </div>

        <div class="span6">
            <div class="pull-right">
			<!--Manasa commented on nov 8 2017 to disable "FindRelations.." button
                <strong>{vtranslate('LBL_RELATED_RECORDS',$MODULE)}</strong>
                <button class="small" id="_mailrecord_findrel_btn_" onclick="MailManager.mail_find_relationship();">{vtranslate('JSLBL_Find_Relation_Now',$MODULE)}</button>
			Ended here -->
                <div id="_mailrecord_relationshipdiv_"></div>
            </div>
        </div>
    </div>
	<hr>
    <br>
    <div class="row-fluid">
        <div class='mm_body' id="_mailopen_body">
            {$MAIL->body()}
        </div>
    </div>
    </div>
    </div>
    </div>
{/strip}