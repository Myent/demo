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
<style>

    #vte-checklist-details{
        width: 900px;
        height: 500px;
        padding: 10px 10px;
        overflow-y: auto;
		 background-color: #fcf8e3;
    }
	#vte-checklist-details .item-note-add{
        display: none;
    }
    #vte-checklist-details .upload-file,
    #vte-checklist-details .add-note,
    #vte-checklist-details .show-all-notes{
        text-decoration: underline;
    }
	
.panel-pricing {
  -moz-transition: all .3s ease;
  -o-transition: all .3s ease;
  -webkit-transition: all .3s ease;
}
.panel-pricing:hover {
  box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.2);
}

.panel-pricing .list-group-item {
  color: #777777;
  border-bottom: 1px solid rgba(250, 250, 250, 0.5);
}
.panel-pricing .list-group-item:last-child {
  border-bottom-right-radius: 0px;
  border-bottom-left-radius: 0px;
}
.panel-pricing .list-group-item:first-child {
  border-top-right-radius: 0px;
  border-top-left-radius: 0px;
}
.panel-pricing .panel-body {
  background-color: #f0f0f0;
  font-size: 40px;
  color: #777777;
  padding: 20px;
  margin: 0px;
}
.panel-warning{
border-color: #faebcc;
}
.panel-pricing{
  
}

</style>

{strip}
	<div class="modelContainer" id="vte-checklist-details"> 
		<input type="hidden" name="curr_date" value="">
		<input type="hidden" name="curr_time" value="">
		<input type="hidden" name="accountid" id="accountid" value="{$recordId}">
		
		<div class="col-md-4 text-center" style=" background-color: #fcf8e3;"> 
			<center>
				<i class="fa fa-desktop"></i><h2 style="color:brown;">{$checklistname}</h2>
			</center>
		</div>
		
		{foreach item=CATEGORY key=COUNTS from=$Array}
		<!--{foreach item=ITEM key=COUNT from=$CATEGORY.tit}-->
		<div class="">
		
			<table width="100%" class="table" style="border-color:#faebcc;">
				<tr class="panel panel-warning panel-pricing">
					<div class="fa fa-desktop"><h3>{$CATEGORY['cat']}</h3></div>
					<td width="3%" valign="top">
					</td>
					<td width="52%" valign="top">
						<div class="checklist-item-header">
							<div class="checklist-item-title">
								<center><h4>{$CATEGORY['tit']}</h4></center>
							</div>
						</div>
						
							<div class="list-group text-center">
								<div class="list-group-item">
									<span style="font-family:'Open Sans', Arial, sans-serif;font-size:14px;text-align:justify;">{$CATEGORY['desc']}</span>
								</div>
									<!--<pre>{$Array|@print_r}</pre>{'-----'}{$COUNTS}-->
							</div>	
					</td>
						<td width="50%">
						 <div class="checklist-item-related">
							{if $CATEGORY['notes'] eq 1 }
									<div class="document-related">
										<form action="index.php?module=Documents&action=SaveAjax&count={$COUNTS}" method="post" class="checklist-upload-form" enctype="multipart/form-data">
											<input type="hidden" name="module" value="Documents">
											<input type="hidden" name="action" value="SaveAjax">
											<input type="hidden" name="sourceModule" value="Accounts">
											<input type="hidden" name="sourceRecord" id= "checklistid" value="{$checklistid}">
											<input type="hidden" name="relationOperation" value="true">
											<input type="hidden" name="notes_title" value="">
											<input type="hidden" name="filelocationtype" value="I">
											<input type="file" name="filename" class="add-document" >
											<input type="hidden" name="sequence" id="sequence" value="{$COUNTS}" >
											
											<div class="checklist-item-documents">
												<ul class="nav nav-tabs nav-stacked">
												{foreach item=TITLE from=$LIST[$COUNTS]}
													
												<li>
													<a href="index.php?module=Documents&action=DownloadFile&record={$TITLE['notesid']}&fileid=">{$TITLE['title']}
														<span class="relationDelete pull-right" data-record="{$checklistid}" data-related-record="{$TITLE['notesid']}">
															<i title="Delete" class="icon-trash alignMiddle"></i>
														</span>
													</a>
												</li>
												{/foreach}
												</ul>
											</div>
										</form>
									</div>
								{/if}
								{if $CATEGORY['comments'] eq 1}
								<div class="comment-related">
									<div class="item-note-box">
										<a class="add-note" href="javascript:void(0);">{'Add Note'}</a>
										<div class="item-note-add" >
											<textarea class="item-note-content" placeholder="Add your comment here..."></textarea>
											</br><button class="btn btn-success add-comment" type="button" name="submit{$COUNTS}" data-record="{$checklistid}"><strong>Submit</strong></button>
										</div>
										<div class="item-note-list">
											<ul class="commentContainer">
											{foreach item=CDATA key=foo from=$COMMENT[$COUNTS]}
												<li class="commentDetails">
													<p>{$CDATA['comment_content']}</p>
													<p><small>{$CDATA['username']} | {$CDATA['time']}</small></p>
												</li>
											{/foreach}
											</ul>
										</div>
									</div>
								</div>
								{/if}
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		<!--{/foreach}-->
		</div>
		{/foreach}
	</div>
{/strip}
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src='jquery.form.js' type="text/javascript" language="javascript"></script>

