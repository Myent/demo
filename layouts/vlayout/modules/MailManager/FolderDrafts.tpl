{*<!--/************************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ************************************************************************************/-->*}

{strip}
	<div class="listViewPageDiv" id="email_con" name="email_con">
		<div class="row-fluid" id="mail_fldrname">
			<h3>{$FOLDER->name()}</h3>
		</div>
		<hr>
		<div class="listViewTopMenuDiv noprint">
			<div class="listViewActionsDiv row-fluid">
				<div class="btn-toolbar span9">
					<button class='btn btn-danger delete' onclick="MailManager.massMailDelete('__vt_drafts');" value="{vtranslate('LBL_Delete',$MODULE)}">
						<strong>{vtranslate('LBL_Delete',$MODULE)}</strong>
					</button>
					<div class="pull-right">
						<input type="text" id='search_txt' class='span3' value="{$QUERY}" style="margin-bottom: 0px;" placeholder="{vtranslate('LBL_TYPE_SEARCH', $MODULE)}"/>
						<strong>&nbsp;&nbsp;{vtranslate('LBL_IN', $MODULE)}&nbsp;&nbsp;</strong>
						<select class='small' id="search_type" style="margin-bottom: 0px;">
							{foreach item=label key=value from=$SEARCHOPTIONS}
								<option value="{$value}" >{vtranslate($label,$MODULE)}</option>
							{/foreach}
						</select>&nbsp;
						<button type=submit class="btn edit" onclick="MailManager.search_drafts();" value="{vtranslate('LBL_FIND',$MODULE)}" id="mm_search">
							<strong>{vtranslate('LBL_FIND',$MODULE)}</strong>
						</button>
					</div>
				</div>
				<div class="btn-toolbar span3">
					<span class="pull-right">
						{if $FOLDER->mails()}
							<span class="pull-right btn-group">
								<span class="pageNumbers alignTop listViewActions">
									{$FOLDER->pageInfo()}&nbsp;
								</span>
								<span class="pull-right">
									<button class="btn"
										{if $FOLDER->hasPrevPage()}
											href="#{$FOLDER->name()}/page/{$FOLDER->pageCurrent(-1)}"
											onclick="MailManager.folder_drafts({$FOLDER->pageCurrent(-1)});"
										{else}
											disabled="disabled"
										{/if}>
										<span class="icon-chevron-left"></span>
									</button>
									<!-- added by jyothi -->
                                <button class="btn dropdown-toggle" type="button" id="listViewPageJump" data-toggle="dropdown" {if $PAGE_COUNT eq 1} disabled {/if}>
									<i class="vtGlyph vticon-pageJump" title="{vtranslate('LBL_LISTVIEW_PAGE_JUMP',$moduleName)}"></i>
							    </button>

								<a class="btn hide" id="about"
									{if $FOLDER->pageInfo()}
										href="#{$FOLDER->name()}/page/{$PAGE_JUMP}"
										onclick="MailManager.folder_open('{$FOLDER->name()}',{$PAGE_JUMP});"
									{else}
										disabled="disabled"
									{/if}>
								</a> 

								<ul class="listViewBasicAction dropdown-menu" id="listViewPageJumpDropDown">
									<li>
										<span class="row-fluid">
											<span class="span3 pushUpandDown2per"><span class="pull-right">{vtranslate('LBL_PAGE',$moduleName)}</span></span>
											<span class="span4">
												<input type="text" id="pageToJump"
	                                           
												class="listViewPagingInput" value="{$PAGE_NUMBER}"/>
											</span>
											<span class="span2 textAlignCenter pushUpandDown2per">
												{vtranslate('LBL_OF',$moduleName)}&nbsp;
											</span>
											<span class="span3 pushUpandDown2per" id="totalPageCount">{$PAGE_COUNT}</span>
										</span>
									</li>
								</ul>
<!-- ended here -->

									<button class="btn"
										{if $FOLDER->hasNextPage()}
											href="#{$FOLDER->name()}/page/{$FOLDER->pageCurrent(1)}"
											onclick="MailManager.folder_drafts({$FOLDER->pageCurrent(1)});"
										{else}
											disabled="disabled"
										{/if}>
										<span class="icon-chevron-right"></span>
									</button>
								</span>
							</span>
						{/if}
					</span>
				</div>
			</div>
		</div>
		<br>
		<div class="listViewContentDiv">
			<div class="listViewEntriesDiv">
				<table class="table table-bordered listViewEntriesTable">
					<thead>
						<tr class="listViewHeaders">
							<th width="3%" class="listViewHeaderValues" ><input align="left" type="checkbox" name="selectall" id="parentCheckBox" onClick='MailManager.toggleSelect(this.checked,"mc_box");'/></th>
                            <th width="27%" class="listViewHeaderValues"  >{vtranslate('LBL_TO', $MODULE)}</th>
							<th class="listViewHeaderValues" >{vtranslate('LBL_SUBJECT', $MODULE)}</th>
							<th width="17%" class="listViewHeaderValues"  align="right" >{vtranslate('LBL_Date', $MODULE)}</th>
						</tr>
					</thead>
					<tbody>
						{if $FOLDER->mails()}
							{foreach item=MAIL from=$FOLDER->mails()}
								<tr class="listViewEntries mm_normal mm_clickable"
									id="_mailrow_{$MAIL.id}" onmouseover='MailManager.highLightListMail(this);' onmouseout='MailManager.unHighLightListMail(this);'>
									<td width="3%" class="narrowWidthType">
										<input type='checkbox' value = "{$MAIL.id}" name = 'mc_box' class='small' onclick='MailManager.toggleSelectMail(this.checked, this);'>
									</td>
									<td width="27%" class="narrowWidthType" onclick="MailManager.mail_draft({$MAIL.id});">{$MAIL.saved_toid}</td>
									<td class="narrowWidthType" onclick="MailManager.mail_draft({$MAIL.id});">{$MAIL.subject}</td>
									<td width="17%" class="narrowWidthType" align="right" onclick="MailManager.mail_draft({$MAIL.id});">{$MAIL.date_start}</td>
								</tr>
							{/foreach}
						{elseif $FOLDER->mails() eq null}
							<tr>
								<td colspan="3"><strong>{vtranslate('LBL_No_Mails_Found',$MODULE)}</strong></td>
							</tr>
						{/if}
					</tbody>
				</table>
			</div>
		</div>
	</div>
{/strip}
<!-- added by jyothi -->
<script type="text/javascript">
$(function() {
    $(document).on('click', function(e) {
        if (e.target.id == 'listViewPageJump') {
            $("#listViewPageJumpDropDown").toggle();
        }
        else if (e.target.id == 'pageToJump') {
            $("#listViewPageJumpDropDown").show();
        } else {
            $("#listViewPageJumpDropDown").hide();
        }

    })
});
$(document).ready(function(){

	$('a.hide').css({ 'display': 'none'});

	$("#listViewPageJump").on('click',function(){
        $("#listViewPageJumpDropDown").toggle();
	});


	$('#pageToJump').keydown(function(e) {
	    if (e.which === 13) {
	        var pageJump = $("#pageToJump").val();
            var pageJumpTo = pageJump - 1; 
            var type= "{$FOLDER->name()}";
            var totalPages = "{$PAGE_COUNT}";
            var element = jQuery(e.currentTarget);
            var response = Vtiger_WholeNumberGreaterThanZero_Validator_Js.invokeValidation(element);
			if(typeof response != "undefined"){
				element.validationEngine('showPrompt',response,'',"topLeft",true);
			} 
			else {
             	if(pageJumpTo >= totalPages){
             		alert("not exist");
						var error = app.vtranslate('JS_PAGE_NOT_EXIST');
						element.validationEngine('showPrompt',error,'',"topLeft",true);
						return;
				}
	            if(pageJumpTo < totalPages){
		           	 $("#about").attr("href", "#"+type+'/page/'+pageJumpTo);

					var js = "MailManager.folder_drafts("+pageJumpTo+");";
					var newclick = new Function(js);
					$("#about").attr('onclick', newclick);
	            }
	    	}
 		}
 	});

});
</script>
<!-- ended here -->