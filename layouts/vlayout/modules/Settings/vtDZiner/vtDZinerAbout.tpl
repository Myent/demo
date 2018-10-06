<div class="contents">
	<table class="table">
		<tr class="alignMiddle">
			<td>
			<div>
				<div class="blockLabel marginLeftZero">
					<h3 style="display:inline;">{vtranslate('vtDZiner Readme File', $QUALIFIED_MODULE)}</h3>
					<span class="pull-right">
						<button class="btn" onclick="window.open('https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KE4N26TJMJMBE', '_blank').focus();"><i class="icon-shopping-cart alignMiddle"></i>
							<strong>{vtranslate('Shop', $QUALIFIED_MODULE)}</strong>
						</button>&nbsp;
						<button class="btn" onclick="window.open('http://blog.vtigress.com', '_blank').focus();"><i class="icon-asterisk alignMiddle"></i>
							<strong>{vtranslate('Blog', $QUALIFIED_MODULE)}</strong>
						</button>&nbsp;
						<button class="btn" onclick="window.open('http://theracanncorp.com/', '_blank').focus();"><i class="icon-asterisk alignMiddle"></i>
							<strong>{vtranslate('Site', $QUALIFIED_MODULE)}</strong>
						</button>&nbsp;
						<button class="btn" onclick="window.open('https://drive.google.com/file/d/0B_W4iPZxUrNQVjlmTDRicG9LRVU/view?usp=sharing', '_blank').focus();"><i class="icon-book alignMiddle"></i>
							<strong>{vtranslate('Documentation', $QUALIFIED_MODULE)}</strong>
						</button>
					</span>
				</div>
			</div>
			</td>
		</tr>
	</table>
	<table class="table table-bordered equalSplit">
		<tbody>
			<tr>
			<td class="opacity">
			<div class="row-fluid moduleManagerBlock">
			<table> <tr> <td>
			{include file="file:modules/vtDZiner/README.txt" assign=aboutcontents}
			{$aboutcontents|nl2br}
			</td> </tr> </table>
			</div>
			</td>
			</tr>
		</tbody>
	</table>
</div>