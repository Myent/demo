
	{strip}


	{literal}
	 <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.min.css" rel="stylesheet">
	 <link href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet">
	 <link href="https://cdn.datatables.net/buttons/1.2.4/css/buttons.dataTables.min.css" rel="stylesheet">
	 
	{/literal}

	 <!--
	<div class="listViewPageDiv" width="100%">	 
		<ul class="breadcrumb_custom">
		  <li><a href="index.php?module=PCMReports&view=DashBoard" title="KPI Reports List">PCM Reports</a></li>	 	  
			<li class="active">Projects Work Status</li>
		 </ul>			 			
		<form class="form-inline" method="post" action="">
			<input name="module" type="hidden" value="PCMReports" />
			<input name="view" type="hidden" value="DashBoard" />
			<input name="mode" type="hidden" value="ProjectsWorkStatus" />			 	 
			<table class=""> 
				<tbody> 
					<tr>
						<td>
							<label for="project">Project</label>&nbsp; 
							<select id="idProject" name="project" class="form-control" >
								<option value="">All</option>
								 {foreach from=$PROJECTS key=k item=project}
									 {if isset($smarty.post.branch)} 
										{if $smarty.post.branch == $k} 
											{assign var="sel" value="selected"}
										{else}
											{assign var="sel" value=""}
										{/if}
									 {/if}
									<option value="{$k}" {$sel} > {$project}</option>
									{/foreach}									
							</select> &nbsp; 
						</td>
						<td>
							<label for="branch">Project task</label>&nbsp; 
							<select id="idProjectTask" name="projectTask" class="form-control" >
								<option value="">All</option> 
							</select> &nbsp; 
						</td>
						<td>
							<label for="branch">Status</label>&nbsp; 
							<select id="idStatus" name="status" class="form-control" >
								<option value="">All</option> 
							</select> &nbsp; 
						</td>
						<td>
							<label for="branch">Assignee</label>&nbsp; 
							<select id="idAssignee" name="assignee" class="form-control" >
								<option value="">All</option> 
							</select> &nbsp; 
						</td>
						<td>			   
							<label for="from_date">Start Date(search within a specified number of days)</label>&nbsp; 
							{if isset($smarty.post.from_date)}
								{assign var="fromdate" value="{$smarty.post.from_date}"} 								
							{else}
								{assign var="fromdate" value=""}				
							{/if}
							<input type="text" class="form-control" id="idFrom" name="from_date" value="{$fromdate}" autocomplete="off">&nbsp; 							
						</td> 
						<td>
							<button type="submit" name="submit" value="submit" class="btn btn-success">Submit</button>
						</td>
					</tr>
				<tbody> 
			</table>
			</form>
	</div> -->
			
		<hr/>
		<!--<input type="text" class="form-control" id="testing" name="" value="">&nbsp; -->
		 
			<table class="table table-bordered display dataTable" id="idReportDataTable"   >
				<thead>
					<tr>
						<th>#</th>
						<th class="idThNameRow">Project Name</th>
						<th>Project Task Name</th>
						<th>Assignee</th>
						<th>Allocated Hours</th>
						<th>Worked Hours</th>
						<th>Progress(%)</th>
						<th>Start Date</th>
						<th>End date</th>
						<th>Status</th>				
					</tr>
				</thead>
				 
				<tbody>
					{if $PROJECT_DATA|@count > 0}
					 {foreach from=$PROJECT_DATA key=k item=data}
						<tr>
							<td>{$k+1}</td>							 
							<td class="text-right">{$data.projectname}</td>
							<td class="text-right">{$data.projecttaskname}</td>
							<td class="text-right">{$data.username}</td>
							<td class="text-right">{$data.allocated_hours}</td>							 
							<td class="text-right">{$data.worked_hours}</td>							
							<td class="text-right"> {if $data.allocated_hours > 0} {math equation="(x / y) * 100" x=$data.worked_hours y=$data.allocated_hours format="%.2f"}{else} 0.00 {/if} </td>
							<td class="text-right">{$data.start_date}</td>
							<td class="text-right">{$data.end_date}</td>
							<td class="text-right">{$data.status}</td>							
						</tr>
					   {/foreach} 
						{else}
					<tr><td colspan="9" align="middle">No Data</td></tr>
					{/if}
				</tbody>
			</table>
			 
	</div>
{literal}
	
 
<script type="text/javascript" src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" ></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js" ></script>
<script type="text/javascript" src="//cdn.datatables.net/buttons/1.2.4/js/buttons.flash.min.js" ></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js" ></script>
<script type="text/javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js" ></script>
<script type="text/javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js" ></script>
<script type="text/javascript" src="//cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js" ></script>
<script type="text/javascript" src="//cdn.datatables.net/buttons/1.2.4/js/buttons.print.min.js" ></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js" ></script>

<script>
$(document).ready(function() {
	 /* on chnage projects list */
	$('#idProject').on('change', function() {
		getProjectTask(this.value);
	});

	/* on chnage projects list */
	$('#idProjectTask').on('change', function() {
		getAssignee(this.value);
	});
	 
	var nowTemp = new Date();
	var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
	 
	var checkin = jQuery('#idFrom').datepicker({
	  format: 'dd-mm-yyyy',
	  onRender: function(date) {
		return date.valueOf() < now.valueOf() ? 'disabled' : '';
	  }
	}).on('changeDate', function(ev) {
	  if (ev.date.valueOf() > checkout.date.valueOf()) {
		var newDate = new Date(ev.date)
		newDate.setDate(newDate.getDate() + 1);
		checkout.setValue(newDate);
	  }
	  checkin.hide();
	  jQuery('#idTo')[0].focus();
	}).data('datepicker');
	var checkout = jQuery('#idTo').datepicker({
	  format: 'dd-mm-yyyy',
	  onRender: function(date) {
		return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
	  }
	}).on('changeDate', function(ev) {
	  checkout.hide();
	}).data('datepicker');
 
	//data table
    $('#idReportDataTable').DataTable({ 
		 "dom": '<"top"i>rt<"bottom"flp><"clear">'
		});
	
	

});

</script>

<script>
function addCommas(x)
    {
       //var x=12345652457.557;
		x=x.toString();
		var afterPoint = '';
		if(x.indexOf('.') > 0)
		   afterPoint = x.substring(x.indexOf('.'),x.length);
		x = Math.floor(x);
		x=x.toString();
		var lastThree = x.substring(x.length-3);
		var otherNumbers = x.substring(0,x.length-3);
		if(otherNumbers != '')
			lastThree = ',' + lastThree;
		var res = otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",") + lastThree + afterPoint;
       return res;
    }
	
function removeCommas(x)
	{
		var res = x.replace(/,/g, '');
		return res;
	}
	
function getProjectTask(id){ 
	
	var params = {};
	params['module'] = 'PCMReports';     
	params['action'] = 'IndexAjax';
	params['mode'] = 'getProjectsList';
	params['projectid'] = id;
	AppConnector.request(params).then(
		function(data) { 
			if (data.success)
			{ 
				$('#idProjectTask').html(data.result.message);
			}			},
		function(error) {

		}
	);
}
function getAssignee(id){ 
	
	var params = {};
	params['module'] = 'PCMReports';     
	params['action'] = 'IndexAjax';
	params['mode'] = 'getAssignee';
	params['projecttaskid'] = id;
	AppConnector.request(params).then(
		function(data) { 
			if (data.success)
			{ 
				$('#idAssignee').html(data.result.message);
			}			},
		function(error) {

		}
	);
}
	
</script>
 
 
{/literal}    
{/strip}