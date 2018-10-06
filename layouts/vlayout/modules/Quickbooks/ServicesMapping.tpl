<strip>
<div class="addQbServicesForm hide">
	<div>
		<table class="table">
			<tr>
				<td id="">
				</td>
				<td>
				<span class="pull-right"><button id="idBtnSaveUpdate" class="btn btn-success" onclick="saveQbServicesForm();" ><strong>Save</strong></button>
				<a onclick="showQbServicessListView();" type="reset" class="cancelLink">Cancel</a></span>
				</td>
			</tr>
		</table>
	</div>
	<form class="qbServicesProperties" id="idFrmQbServicesFMapping" name="frmAcrmIssues" action="post">
			<table class="table table-bordered">
				<thead>
					<tr>
					  <th>Quickbooks</th>
					  <th>Services</th>
					</tr>
				</thead>
			  <tbody>
			  {foreach item=SPICKLIST_VALUE key=SPICKLIST_KEY from=$SERVICES_LIST_VIEW}
			 
				<tr>
					<td class="fieldValue medium">{$SPICKLIST_VALUE['qb_field_name']}</td>
					<td class="fieldValue medium">
						<div class="row-fluid">
							<span class="span10">
								<select name="Services[{$SPICKLIST_VALUE['qb_field_name']}]" id="{$SPICKLIST_VALUE['qb_field_name']}" class="Services"  >
									<option value="">-Select-</option>
									{foreach item=SERVICES_FIELDS_LIST from=$SERVICES_FIELDS_LIST_ARRAY}
										<option value="{$SERVICES_FIELDS_LIST}" {if $SERVICES_FIELDS_LIST == $SPICKLIST_VALUE['vtiger_field']} selected {/if} >{$SERVICES_FIELDS_LIST}</option>
									{/foreach}			  
								</select>
							<span>
						</div>
					</td>
				</tr>
				{/foreach}
			  
				 
			</tbody>
			</table>
			<input type="hidden" id= "idHdnModule" name="hdnModule" value="Services">
	</form>
</div>

<div class="QbServicessList">
	<span class="span4">
		<span class="pull-right">
			<!--<button onclick="editBtnQbServicesMapping();" class="btn addButton"><strong>Edit</strong></button>-->
		</span>
	</span>
	<table class="table table-bordered QbServicessList">
		<thead>
			<tr>
				<th>Quickbooks</th>
				<th>Services</th>				 
			</tr>
		</thead>
		<tbody>
		{foreach from=$SERVICES_LIST_VIEW key=k item=v}
			<tr>
				<td>{$v['qb_field_name']}</td>
				<td>{$v['vtiger_field']}</td>				 
			</tr>
		{/foreach}
		</tbody>
	</table>
</div>
</strip>
<script>
$(document).ready(function(){
	
});


function showQbServicessListView(){
	jQuery(".QbServicessList").removeClass("hide");
	jQuery(".addQbServicesForm").addClass("hide");
}

function editBtnQbServicesMapping() {
	jQuery(".QbServicessList").addClass("hide");
	jQuery(".addQbServicesForm").removeClass("hide");
	
}

function saveQbServicesForm()
{ 
	var params = {};
	var params = jQuery("#idFrmQbServicesFMapping").serializeFormData();

	var progressIndicatorElement = jQuery.progressIndicator({
			'position' : 'html',
			'blockInfo' : {
			'enabled' : true
			}
		});
	
	hideparams = {};
	hideparams['mode'] = 'hide';
	params['module'] = 'Quickbooks';
	params['action'] = 'Mapping';
	params['mode'] = 'updateQbModuleFieldsMapping'; 
	
	AppConnector.request(params).then(function(data){		
			progressIndicatorElement.progressIndicator ( hideparams);
			console.log(data);
			var params1 = {};
			if (data.success){
				params1['text'] = data.result.message;
				jQuery(".QbServicessList").removeClass("hide");
				jQuery(".addQbServicesForm").addClass("hide");				
				Vtiger_Helper_Js.showMessage(params1);
				window.location.reload(true);
			} else {
				params1['text'] = data.error.message;
				params1['type'] = 'error';
			}	
		},
		function(error) {
			console.log(error);
			progressIndicatorElement.progressIndicator ( hideparams);
			Vtiger_Helper_Js.showPnotify("oops error!,please try again later.");
		}
	);	
}

function showIssuesList()
{  	
	var params = {};
	params['module'] = 'Quickbooks';
	params['action'] = 'ServicesMapping';
	params['mode'] = 'getIssuesList';

	AppConnector.request(params).then(
	function(data) {
			if (data.success){
				var issuedata = data.result.message; 
				jQuery(".qbServicesProperties").find("[name='field_name']").val(issuedata.vtiger_field).trigger("liszt:updated");
				jQuery(".qbServicesProperties").find("[name='fieldqb_name']").val(issuedata.qb_field_name).trigger("liszt:updated");
				showIssuesList(pagenumber);
			}
        },
        function(error) {
                progressIndicatorElement.progressIndicator(hideparams);
                console.log("Very serious error. Investigate function showIssuesList in ServicesMapping.tpl");
        }
    );
}

</script>
				  		  		  
