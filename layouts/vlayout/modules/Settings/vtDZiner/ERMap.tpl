{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ********************************************************************************/
-->*}
<script>
// Globals used
var graph="";
var paper="";
var erd = "";
var jointJSLoaded = false;
var childModulesList = [];
var parentModulesList = [];
</script>
{strip}
	{foreach item=MODULE_MODEL from=$RELATED_CHILDMODULES}
		{if $MODULE_MODEL->isActive()}
		<script>
			childModulesList.push(["{$MODULE_MODEL->getId()}","{vtranslate($MODULE_MODEL->get('label'), $MODULE_MODEL->getRelationModuleName())}", "{$MODULE_MODEL->get('modulename')}"]); 
		</script>
		{/if}
	{/foreach}
	{foreach item=MODULE_MODEL from=$RELATED_PARENTMODULES}
		{if $MODULE_MODEL->isActive()}
		<script>
			parentModulesList.push(["{$MODULE_MODEL->getId()}","{vtranslate($MODULE_MODEL->get('modulename'), $MODULE_MODEL->getRelationModuleName())}", "{$MODULE_MODEL->get('modulename')}"]); 
		</script>
		{/if}
	{/foreach}
	<div class="container-fluid" id="layoutEditorContainer">
		<div class="contents row-fluid">
			<input type="hidden" class="inActiveFieldsArray" value='{ZEND_JSON::encode($IN_ACTIVE_FIELDS)}' />
		</div>
	</div>
	<div class="container-fluid">
		<div class="contents row-fluid">
			<h3 style="display:inline;">ER Map for {$SELECTED_MODULE_NAME}</h3>
			<span class="pull-right">
			Developed using <a href="http://www.jointjs.com" target="_blank"><strong>jointJS</strong></a>
			</span>
		</div>
		<div><hr></div>
		<div width="100%">
		<strong>Legend : <span style="background-color:#EEE423">&nbsp;Parent Entity&nbsp;</span>&nbsp;&nbsp;<span style="background-color:#2ECC71">&nbsp;Root Entity&nbsp;</span>&nbsp;&nbsp;<span style="background-color:#0FFADE">&nbsp;Child Entity&nbsp;</span>
		</strong>
			<span class="pull-right">
				<select name="VtigerModules" id="VtigerModules" onchange="changeRootModule();">
					{foreach item=MODULE_NAME from=$SUPPORTED_MODULES}
						<option value="{$MODULE_NAME}" {if $MODULE_NAME eq $SELECTED_MODULE_NAME} selected {/if}>{vtranslate($MODULE_NAME, $QUALIFIED_MODULE)}</option>
					{/foreach}
				</select>
			</span>
		</div>
		<div>
		<hr>
		</div><br>
		<div id="paper" width="100%">Rendering ER Map for {$SELECTED_MODULE_NAME} ...</div>
	</div>
{/strip}
<script>
// Globals used
 /**
  * function to load a given css file 
  */ 
 loadCSS = function(href) {
     var cssLink = jQuery("<link rel='stylesheet' type='text/css' href='"+href+"'>");
     jQuery("head").append(cssLink); 
 };

/**
 * function to load a given js file 
 */ 
 loadJS = function(src) {
     var jsLink = jQuery("<script type='text/javascript' src='"+src+"'>");
     jQuery("head").append(jsLink); 
 }; 
 // load the css file 

function changeRootModule(){
	var rootModule = jQuery("#VtigerModules").val();
	console.log(rootModule);
	window.location.assign("index.php?parent=Settings&module=vtDZiner&view=ERMap&source_module="+rootModule);
}

function loadJointJS(){

// load scripts if not loaded yet
	loadCSS("libraries/jointJS/joint.min.css");
// load the js file 
	//loadJS("libraries/jointJS/joint.min.js");
	loadJS("libraries/jointJS/joint.js");
	loadJS("libraries/jointJS/joint.shapes.vterd.js");
	jointJSLoaded=true;
}

function drawERMap(rootModule){
if (!jointJSLoaded){
	loadJointJS();
}

jQuery('#paper').empty();

graph = new joint.dia.Graph;
paper = new joint.dia.Paper({
el: jQuery('#paper'),
width: jQuery('#paper').innerWidth(),
height: 2000,
gridSize: 1,
model: graph
});

erd = joint.shapes.erd;

var element = function(elm, x, y, label, relatedModule) {
	var xlink = ((relatedModule == null) ? "javascript:void();" : "index.php?parent=Settings&module=vtDZiner&view=ERMap&source_module="+relatedModule);
    var cell = new elm({ 
		position: { 
			x: x, 
			y: y 
		}, 
		attrs: {
		a: { 'xlink:href': xlink, cursor: 'pointer'},
			text: {
				text: label
			} 
		} 
		});
    graph.addCell(cell);
    return cell;
};

var link = function(elm1, elm2) {
    var myLink = new erd.Line({ source: { id: elm1.id }, target: { id: elm2.id }});
    graph.addCell(myLink);
    return myLink;
};

rootPositionOffset = Math.floor(Math.max(parentModulesList.length, childModulesList.length)/2);
if (parentModulesList.length != childModulesList.length) {
	if (parentModulesList.length > childModulesList.length) {
			parentPositionOffset = 0;
			childPositionOffset = Math.floor(rootPositionOffset/2);
	} else {
			childPositionOffset = 0;
			parentPositionOffset = Math.floor(rootPositionOffset/2);
	}
}

var employee = element(erd.Entity, 350, rootPositionOffset*100, rootModule, null);

jQuery.each(parentModulesList, function(index,value){
	var parententity = element(erd.ParentEntity, 0, (index+parentPositionOffset)*100,  value[1], value[2]);
	link(parententity, employee).cardinality('1..N');
});

jQuery.each(childModulesList, function(index,value){
	var childentity = element(erd.ChildEntity, 700, (index+childPositionOffset)*100, value[1], value[2]);
	link(employee, childentity).cardinality('1..N');
});

console.log(jQuery('#paper').innerWidth(), ",", jQuery('#paper').innerHeight());
};

$( document ).ready(function() {
	setTimeout(function () {
        //jQuery('.drawERMap').trigger('click');
		drawERMap('{$SELECTED_MODULE_NAME}');
    }, 100);
});

//element(erd.Derived, 440, 80, "amount");
//element(erd.Entity, 400, 400, "Salesman");
//element(erd.ISA, 125, 300, "ISA");
//element(erd.IdentifyingRelationship, 350, 190, "gets paid");
//element(erd.Key, 0, 90, "number");
//element(erd.Multivalued, 150, 90, "skills");
//element(erd.Normal, 590, 80, "date");
//element(erd.Relationship, 300, 390, "uses");
//element(erd.WeakEntity, 530, 200, "Wage");
//link(employee, paid).cardinality('1');
//link(salesman, uses).cardinality('0..1');;
//link(car, uses).cardinality('1..1');
//link(wage, paid).cardinality('N');
</script>

