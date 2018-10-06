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


<link rel='stylesheet' href='libraries/jstree/themes/default/style.min.css' />   

<style>

.jstree-grid-wrapper { 
	border:1px solid #ddd;
}
.jstree-grid-midwrapper  { 	
	background-color:white;
}
 
.jstree-grid-header-cell {
	text-align:left;
	font-size:11px;
	border:1px solid #ddd;
	padding:5px;

	white-space:nowrap;
	color:#333;
	background: #fff;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));
	background: -moz-linear-gradient(top,  #fff,  #ededed);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');
}

.jstree-grid-separator {
	display:none;
}

.jstree-anchor,.jstree-grid-cell {
	text-overflow:ellipsis !important;
	white-space:nowrap !important;
	overflow:hidden !important;
}
</style>

<div class="relatedContainer">
        {assign var=RELATED_MODULE_NAME value=$RELATED_MODULE->get('name')}
        <input type="hidden" name="currentPageNum" value="{$PAGING->getCurrentPage()}" />
        <input type="hidden" name="relatedModuleName" class="relatedModuleName" value="{$RELATED_MODULE->get('name')}" />
        <input type="hidden" value="{$ORDER_BY}" id="orderBy">
        <input type="hidden" value="{$SORT_ORDER}" id="sortOrder">
        <input type="hidden" value="{$RELATED_ENTIRES_COUNT}" id="noOfEntries">
        <input type='hidden' value="{$PAGING->getPageLimit()}" id='pageLimit'>
        <input type='hidden' value="{$TOTAL_ENTRIES}" id='totalCount'>
        <div class="relatedHeader ">
            <div class="btn-toolbar row-fluid">
                <div class="span6">

                    {foreach item=RELATED_LINK from=$RELATED_LIST_LINKS['LISTVIEWBASIC']}
                        <div class="btn-group">
                            {assign var=IS_SELECT_BUTTON value={$RELATED_LINK->get('_selectRelation')}}
                            <button type="button" class="btn addButton
                            {if $IS_SELECT_BUTTON eq true} selectRelation {/if} "
                        {if $IS_SELECT_BUTTON eq true} data-moduleName={$RELATED_LINK->get('_module')->get('name')} {/if}
                        {if ($RELATED_LINK->isPageLoadLink())}
                        {if $RELATION_FIELD} data-name="{$RELATION_FIELD->getName()}" {/if}
                        data-url="{$RELATED_LINK->getUrl()}"
                    {/if}
								{if $IS_SELECT_BUTTON neq true}name="addButton"{/if}>{if $IS_SELECT_BUTTON eq false}<i class="icon-plus icon-white"></i>{/if}&nbsp;<strong>{$RELATED_LINK->getLabel()}</strong></button>
						</div>
					{/foreach}
					&nbsp;
				</div>
								
				<div class="span6">
					<div class="pull-right">
						 
						 
					</div>
				</div>
			</div>
		</div>
		<div class="contents-topscroll">
			<div class="topscroll-div">
				&nbsp;
			</div>
		</div>
		<div class="relatedContents contents-bottomscroll">
			<div class="bottomscroll-div">
				{assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
				<div class='row-fluid'>
					<div>
						<input class="search-input form-control" placeholder='Search'></input>
					</div>
					<div id='folder_tree' class=''></div>	
					 
				</div>
				 
			
			</div>
		</div>
	</div>
	
	 <!---------------Start CO Model---------------->
	<div id="tokenPandaDocModal" class="modal fade" role="dialog" style='border-radius: 0px;'>
		<div class="modal-dialog modal-lg">
			<!-- Modal content-->
			<div class="modal-content modelContainer">
				<div class="modal-header contentsBackground">
					<button type="button" class="close" data-dismiss="modal">&times;</button>				 
					<h3 class="modal-title" id='idTaskName'>Task</h3>
				</div>
				<div class="modal-body" id="idMBodyCoLinks"> 
					
				</div>
				<div class="modal-footer quickCreateActions">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!---------------End CO Model---------------->
	 
<script src="https://code.jquery.com/jquery-1.8.0.js"   integrity="sha256-00Fh8tkPAe+EmVaHFpD+HovxWk7b97qwqVi7nLvjdgs="  crossorigin="anonymous"></script>
<script src='libraries/jquery/jquery.dataAttr.min.js?v=6.4.0'></script>
<script src='libraries/jstree/jstree.js?v=6.4.0'></script>

<script src='libraries/jstree/jstreegrid_new.js?v=6.4.0'></script>
<script>  
$j = jQuery.noConflict(true);
$j(document).ready(function(){   
	
	/* Search 
	
	$j(".search-input").keyup(function() { 
        var searchString = $j(this).val();         
        $j('#folder_tree').jstree('search', searchString);
		
    }); */
	 
	var taskjsondata = {$FOLDERS_DATA};
  
	$j('#folder_tree').jstree({ 
		'plugins' : [   'types', 'state', 'grid','sort','themes','contextmenu','search','json_data' ],
				
		'core' : {
			'data' :  taskjsondata 
		},
		 
		'types' : {
				'default' : {
					'icon': 'jstree-folder'
				},
				'file' : {
					'icon': 'jstree-file'
				},
				'ticket' : {
					'icon': '<c:url value="layouts/vlayout/modules/Project/tree_icon.png" />'
				}
			},
			
        "search" : { 
			"show_only_matches" : false
			},
		'grid': {
				'columns': [
					{ 'width':'15%','header': "Project Task Name" },				  
					{ 'width':'10%','header': "Type",'value': "type" },				  
					{ 'width':'7%','header': "Assigned To",'value': "user" },				  
					{ 'width':'10%','header': "Budget",'value': "Budget" },	
					{ 'width':'5%','header': "Task Hours",'value': "Task_Hours" },	
					{ 'width':'5%','header': "Pro.H",'value': "Progress_in_Hours" },	
					{ 'width':'5%','header': "Pro.A D",'value': "Progress_Allotted_Dollars" },	
					{ 'width':'10%','header': "Start Date",'value': "startdate" },	
					{ 'width':'10%','header': "End Date",'value': "enddate" },	
					{ 'width':'5%','header': "Delay",'value': "delay" },	
					{ 'width':'15%','header': "Tools",'value': "tools"  }
				  
				],
				resizable:true 
			}
			
			
		});
 
		 var to = false;
			$j('.search-input').keyup(function () {  
				 if(to) { clearTimeout(to); }
				to = setTimeout(function () { 
					var searchString = $j('.search-input').val();  
					console.log(searchString);
					$j('#folder_tree').jstree(true).search(searchString);
				}, 250);
			});

		
		/* After jsTree has been loaded, set valid widths in percents */
		/* $j(".jstree-grid-header th:nth-child(1)").css( "width","30%" );*/
		 
		 
		 /* Anjaneya Date:20-06-2017*/
		 
		 
	});
	
	function co(crmid,task){
		var data = '<a href="index.php?module=Changes&view=Edit&taskid='+crmid+'&mode=Schedule">Schedule without changing deliverables</a></br>'+
		'<a href="index.php?module=Changes&view=Edit&taskid='+crmid+'&mode=Budget">Budget without changing schedule or deliverables</a></br>'+
		'<a href="index.php?module=Changes&view=Edit&taskid='+crmid+'&mode=Scope">Scope (changes both sched and budget)</a>';
		
		/*var task = jQuery('#create_co_'+crmid).dataAttr('task').value();*/
		$('#idTaskName').html('Chnage Order :: '+task);
		$('#idMBodyCoLinks').html(data);
		$('#tokenPandaDocModal').modal('show');
		
	}
	  
	  
	</script>
{/strip}
