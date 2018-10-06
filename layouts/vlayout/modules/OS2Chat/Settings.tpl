{*<!--
/* ********************************************************************************
 * The content of this file is subject to the Time Tracker ("License");
 * You may not use this file except in compliance with the License
 * The Initial Developer of the Original Code is VTExperts.com
 * Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
 * All Rights Reserved.
 * ****************************************************************************** */
-->*}
{strip}
<div class="container-fluid">
    <div class="widget_header row-fluid">
        <h3>{'POS Settings'}</h3>
    </div>
    <hr>
    <div class="clearfix"></div>
    <form action="index.php" id="formSettings">
        <input type="hidden" name="module" value="OS2Chat"/>
        <input type="hidden" name="action" value="IndexAjax"/>
        <input type="hidden" name="mode" value="OS2Chatsettings"/>
        <div class="summaryWidgetContainer">
            <ul class="nav nav-tabs massEditTabs">
                <li class="active">
                    <a href="#module_settings" data-toggle="tab">
                        <strong>{'OS2Chat Settings'}</strong>
                    </a>
                </li>
            </ul>
            <div class="tab-content massEditContent">
			
				<div class="tab-pane active" id="module_settings">
					<div class="widgetContainer" style="padding: 20px 5px 5px 20px;">
						<div id="stepone">
						<p>Note : use <code> nohup php server.php > /dev/null & </code>  command for start the chat server.</p>
						<table class="table table-bordered equalSplit" style="width: 50%;">
							<tr>
								<td><label>IP Address</label></td>
								<td>
									<div class="row-fluid">
										<span class="span10">
											<input type="text" class="input-large fieldInput" name="ip" value="{$ip}" />
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td><label>Port Number</label></td>
								<td>
									<div class="row-fluid">
										<span class="span10">
											<input type="text" class="input-large fieldInput" name="port" value="{$port}" />
										</span>
									</div>
								</td>
							</tr>
						</table>
							 
						</div>
					</div>
                </div>
                

            <div style="margin-top: 20px;">
                <span>
                    <button class="btn btn-success" type="button" id="btnSaveChatSettings">{vtranslate('LBL_SAVE')}</button>
                </span>
            </div>
        </div>
    </form>
</div>
{/strip}

<script type="text/javascript">

</script>