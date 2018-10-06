{*<!--
/*+***********************************************************************************************************************************
 * The contents of this file are subject to the YetiForce Public License Version 1.1 (the "License"); you may not use this file except
 * in compliance with the License.
 * Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and limitations under the License.
 * The Original Code is YetiForce.
 * The Initial Developer of the Original Code is YetiForce. Portions created by YetiForce are Copyright (C) www.yetiforce.com. 
 * All Rights Reserved.
 *************************************************************************************************************************************/
-->*}
<input type="hidden" value="" id="tempField" name="tempField"/>
<input type="hidden" name="mainurl" id="mainurl" value="{$USERNAME}">
<input type="hidden" name="password" id="password" value="{$PASSWORD}">
<input type="hidden" name="siteurl" id="siteurl" value="{$URL}">
<script>
var height = window.innerHeight;

$(document).ready( function(){
	$('#roundcube_interface').css('height', height-83);
    var use = $('#mainurl').val();
    var urls = $('#siteurl').val();
    var cont = "?_task=login&_action=login&_toke=72ba9f7e6fd4124f8fc4c4a24de02306&_timezone=Asia/Kolkata&_host=mail.supremecluster.com&_user=";
    var url = urls+cont+use;
	 $('#roundcube_interface').attr('src',url);  
} );
</script>
<iframe id="roundcube_interface" style="width: 100%; height: 590px;margin-bottom: -5px;" frameborder="0" src="{$URL}?_task=login&_action=login&_toke=72ba9f7e6fd4124f8fc4c4a24de02306&_timezone=Asia/Kolkata&_host=mail.supremecluster.com" frameborder="0" onload="osmailclicked()" onKeyPress="osmailclicked()"> </iframe>
