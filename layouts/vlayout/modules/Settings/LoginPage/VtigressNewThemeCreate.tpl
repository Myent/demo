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
<div class="widget_header row-fluid">
   <div class="span6">
      <h3>Login Page Generation</h3>
   </div>
</div>
<hr/> 
 	 
<form name="LoginPage" action="index.php?module=LoginPage&parent=Settings&view=CustomLoginPage&x={$ROWS}&y={$COLUMNS}"  method="post" class="form-horizontal" id="LoginPage" enctype="multipart/form-data">
<input type="hidden" name="record" value="{$record}">	
<div class="container-fluid">
	<div class="contents">
			<br>
			<table class="table table-bordered">
				<tbody>
					<tr class="listViewActionsDiv">
						<th colspan="5">Header Information</th>
					</tr>
					<tr class="container">
						<td class="fieldLabel medium"><label class="muted pull-right marginRight10px"><span class="redColor">*</span>Login Page Name</label></td>
						<td class="fieldValue medium">
							<input type='text' name='loginpagename' data-validation-engine="validate[required]" value="{$DATA['name']}" required />
						<br/><b>Note:</b>Please don't use special characters in name
						</td>
						<td colspan='2'>
						</td>
					</tr>
				</tbody>
			</table>
			<br>
			{if $ROWS!='' && $COLUMNS!=''}	
		
			<table class="table table-bordered">	
				<tbody>		
					<tr class="container" >	 
						<td class="fieldLabel medium"><label class="muted pull-right marginRight10px"><span class="redColor">*</span>Logo Image</label></td>
						<td class="fieldValue medium" colspan="3">
						  <div class="row-fluid">
							 <span class="span10">
								 <input type='file' name='logo' class='logo' id='idLogo' required >	
								 {if $DATA['data']['logo'] != ''}
									<img src="{$DATA['data']['logo']}" width="100px" style="border:1px solid #c0b4b4;padding:3px;" >
								 {/if}						   
							 </span>
						  </div>
						</td> 
					</tr>
					{for $x = 1 to $ROWS} 
						<tr id="{$x}" class="container">
						{for $y = 1 to $COLUMNS} 
							 <td style="padding: 15px;" id="{$x}{$y}" name="section[]" class="data">
							 	 
								<select name="page[]" class="text chzn-select select_page_view" id="{$x}{$y}" required >
									<option value="">Select Value</option>
									<option value="LoginBox" {if $DATA['data']['Data']["{$x}{$y}"]['type'] == 'LoginBox'} selected {/if}>Login Box</option>
									<option value="ImageSlider" {if $DATA['data']['Data']["{$x}{$y}"]['type'] == 'ImageSlider'} selected {/if}>Image Slider</option> 
								</select><br>
								<div class="content" id="div_{$x}{$y}">
									{if $DATA['data']['Data']["{$x}{$y}"]['type'] == 'LoginBox'} 
										<input name="{$x}{$y}" value="LoginBox" type="hidden">
										<table>
											<tr>
											<td>Title</td>
											<td><input type="text" name="loginbox_title" value="{$DATA['data']['Data']["{$x}{$y}"]['data']['loginbox_title']}"></td>
											</tr>
											<tr>
											<td>Sub Title</td>
											<td><input type="text" name="loginbox_sub_title" value="{$DATA['data']['Data']["{$x}{$y}"]['data']['loginbox_sub_title']}"></td>
											</tr>
											<tr>
											<td>Font Color</td>
											<td><input type="color" name="loginbox_font_color" value="{$DATA['data']['Data']["{$x}{$y}"]['data']['loginbox_font_color']}"></td>
											</tr>
										</table>
									{/if}
									{if $DATA['data']['Data']["{$x}{$y}"]['type'] == 'ImageSlider'}
										<input name="{$x}{$y}" value="ImageSlider" type="hidden">
										<table>
											<tr>
												<td>Images</td>
												<td><input type="file" name="sliderimages_11[]" multiple="multiple"></td>
												{foreach from=$DATA['data']['Data']["{$x}{$y}"]['data']  item=item key=key }
													<img src="{$item}" width="100px" style="border:1px solid #c0b4b4;padding:3px;" >
												{/foreach}
											</tr>
											<tr>
												<td>Slider Time(Sec)</td>
												<td><input type="number" min="1" max="60" name="sliderimages_time" value="{math equation="x /1000" x=$DATA['data']['slider_time']}"></td>
											</tr>
											<tr>
												<td>Slider Mode</td>
												<td>
													<select name="sliderimages_mode">
														<option value="horizontal" {if $DATA['data']['slider_mode'] == 'horizontal'} selected {/if}>Horizontal</option>
														<option value="vertical" {if $DATA['data']['slider_mode'] == 'vertical'} selected {/if}>Vertical</option>
														<option value="fade" {if $DATA['data']['slider_mode'] == 'fade'} selected {/if}>Fade</option>
													</select>
												</td>
											</tr>
										</table>
									{/if}
								</div>
							 </td>
						{/for}
						</tr>
					{/for}					
				</tbody>
			</table>
			<br>
			{/if}
			<table class="table table-bordered">
				<tbody>
					<tr class="container">
						<th colspan="5">Footer Information <input type='checkbox' name='footer' id='idCheckboxFooter' {if $DATA['data']['footer']|@count gt 0} checked {/if}> 	</th>
					</tr>
					<tr class="container" >
						<td class="fieldLabel medium"><label class="muted pull-right marginRight10px">Left</label></td>
						<td class="fieldValue medium">						 
							<select name="select_footer_left" class="text chzn-select select_page_view" id="idSelectFooterLeft"> 
								<option value="">Select Value</option>
								<option value="Content" {if $DATA['data']['footer']['left']['type'] == 'Content'} selected {/if}>Content</option>
								<option value="socialicons" {if $DATA['data']['footer']['left']['type'] == 'socialicons'} selected {/if}>Social Icons</option>
								<!--<option value="WebsiteLinks" {if $DATA['data']['footer']['left']['type'] == 'WebsiteLinks'} selected {/if}>Website Links</option>-->
							</select>			
						</td>
						<td class="fieldLabel medium"><label class="muted pull-right marginRight10px">Right</label></td>
						<td class="fieldValue medium">						 
							<select name="select_footer_right" class="text chzn-select" id="idSelectFooterRight"> 
								<option value="">Select Value</option>
								<option value="Content" {if $DATA['data']['footer']['right']['type'] == 'Content'} selected {/if}>Content</option>
								<option value="socialicons" {if $DATA['data']['footer']['right']['type'] == 'socialicons'} selected {/if}>Social Icons</option>
								<!--<option value="WebsiteLinks" {if $DATA['data']['footer']['right']['type'] == 'WebsiteLinks'} selected {/if}>Website Links</option>-->
							</select>			
						</td>					
					</tr>
					<tr class='container'>
						<td colspan='2' id='idTdLeftFooter'>
							{if $DATA['data']['footer']['left']['type'] == 'Content'}
								<textarea name="Content_leftFooter" rows="5">{$DATA['data']['footer']['left']['data']}</textarea>
							{/if}
							{if $DATA['data']['footer']['left']['type'] == 'socialicons'}
								<p>Please Enter Username only. </p>
								<img src="layouts/vlayout/skins/images/facebook.png"  class="icons" style="vertical-align: middle;">&nbsp;
								<input type="text" name="si_facebook_leftFooter" value="{$DATA['data']['footer']['left']['data']['facebook']}" placeholder="Facebook Link"><br>
								<img src="layouts/vlayout/skins/images/twitter.png" class="icons" style="vertical-align: middle;">&nbsp;
								<input type="text" name="si_twitter_leftFooter" value="{$DATA['data']['footer']['left']['data']['twitter']}" placeholder="Twitter Link"><br>
								<img src="layouts/vlayout/skins/images/linkedin.png" name="linkedin_icon" class="icons" style="vertical-align: middle;">&nbsp;
								<input type="text" name="si_linkedin_leftFooter" value="{$DATA['data']['footer']['left']['data']['linkedin']}" placeholder="LinkedIn Link">
							{/if}
							{if $DATA['data']['footer']['left']['type'] == 'WebsiteLinks'}
								<input type="text" name="wlTitle1_leftFooter" placeholder="Title" value="">&nbsp;
								<input type="text" name="wlUrl1_leftFooter" placeholder="URL" value=""><br>
								<input type="text" name="wlTitle2_leftFooter" placeholder="Title" value="">&nbsp;
								<input type="text" name="wlUrl2_leftFooter" placeholder="URL" value=""><br>
								<input type="text" name="wlTitle3_leftFooter" placeholder="Title" value="">&nbsp;
								<input type="text" name="wlUrl3_leftFooter" placeholder="URL" value="">';
							{/if}
						</td>
						<td colspan='2' id='idTdRightFooter'>
							{if $DATA['data']['footer']['right']['type'] == 'Content'}
								<textarea name="Content_rightFooter" rows="5">{$DATA['data']['footer']['right']['data']}</textarea>
							{/if}
							{if $DATA['data']['footer']['right']['type'] == 'socialicons'}
								<p>Please Enter Username only. </p>
								<img src="layouts/vlayout/skins/images/facebook.png"  class="icons" style="vertical-align: middle;">&nbsp;
								<input type="text" name="si_facebook_rightFooter" value="{$DATA['data']['footer']['right']['data']['facebook']}" placeholder="Facebook Link"><br>
								<img src="layouts/vlayout/skins/images/twitter.png" class="icons" style="vertical-align: middle;">&nbsp;
								<input type="text" name="si_twitter_rightFooter" value="{$DATA['data']['footer']['right']['data']['twitter']}" placeholder="Twitter Link"><br>
								<img src="layouts/vlayout/skins/images/linkedin.png" name="linkedin_icon" class="icons" style="vertical-align: middle;">&nbsp;
								<input type="text" name="si_linkedin_rightFooter" value="{$DATA['data']['footer']['right']['data']['linkedin']}" placeholder="LinkedIn Link">
							{/if}
							{if $DATA['data']['footer']['right']['type'] == 'WebsiteLinks'}
								<input type="text" name="wlTitle1_rightFooter" placeholder="Title" value="">&nbsp;
								<input type="text" name="wlUrl1_rightFooter" placeholder="URL" value=""><br>
								<input type="text" name="wlTitle2_rightFooter" placeholder="Title" value="">&nbsp;
								<input type="text" name="wlUrl2_rightFooter" placeholder="URL" value=""><br>
								<input type="text" name="wlTitle3_rightFooter" placeholder="Title" value="">&nbsp;
								<input type="text" name="wlUrl3_rightFooter" placeholder="URL" value="">';
							{/if}
						</td>
					</tr>
				</tbody>
			</table>
			
			<br>				 
				<button class="btn btn-success pull-right generate" name="generate"  type="submit">
				<strong>Preview</strong>
				</button>
				<!--<a class="btn btn-success pull-right save" name="save" id="save" >
				<strong>Save</strong>
				</a>-->
		
	</div>	
</form>
{/strip}
