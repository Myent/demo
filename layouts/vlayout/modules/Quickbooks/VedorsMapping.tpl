<strip>
<div class="addQbVendorsForm hide">
	<div>
		<table class="table ">
			<tr>
				<td id="">
				</td>
				<td>
				<span class="pull-right"><button id="idBtnSaveUpdate" class="btn btn-success" onclick="saveQbVendorForm();" ><strong>Save</strong></button>
				<a onclick="showQbVendorsListView();" type="reset" class="cancelLink">Cancel</a></span>
				</td>
			</tr>
		</table>
	</div>
	<form class="qbVendorsProperties" id="idFrmQbVendorFMapping" name="frmAcrmIssues" action="post">
			<table class="table table-bordered">
				<thead>
					<tr>
					  <th>Quickbooks</th>
					  <th>Vendor</th>
					</tr>
				</thead>
			  <tbody>
			  {foreach item=VPICKLIST_VALUE key=VPICKLIST_KEY from=$VENDORS_LIST_VIEW}
				<tr>
					<td class="fieldValue medium">{$VPICKLIST_VALUE['qb_field_name']}</td>
					<td class="fieldValue medium">
						<div class="row-fluid">
							<span class="span10">
								<select name="Vendors[{$VPICKLIST_VALUE['qb_field_name']}]" id="{$VPICKLIST_VALUE['qb_field_name']}" class="Vendor"  >
									<option value="">-Select-</option>
									{foreach item=VENDORS_FIELDS_LIST from=$VENDORS_FIELDS_LIST_ARRAY}
										<option value="{$VENDORS_FIELDS_LIST}" {if $VENDORS_FIELDS_LIST == $VPICKLIST_VALUE['vtiger_field']} selected {/if} >{$VENDORS_FIELDS_LIST}</option>
									{/foreach}			  
								</select>
							<span>
						</div>
					</td>
				</tr>
				{/foreach}
			  
				 
			</tbody>
			</table>
			<input type="hidden" id= "idHdnModule" name="hdnModule" value="Vendors">
	</form>
</div>

<div class="QbVendorsList">
	<span class="span4">
		<span class="pull-right">
			<!--<button onclick="editBtnQbVendorMapping();" class="btn addButton"><strong>Edit</strong></button>-->
		</span>
	</span>
	<table class="table table-bordered QbVendorsList">
		<thead>
			<tr>
				<th>Quickbooks</th>
				<th>Vendor</th>				 
			</tr>
		</thead>
		<tbody>
		{foreach from=$VENDORS_LIST_VIEW key=k item=v}
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


function showQbVendorsListView(){
	jQuery(".QbVendorsList").removeClass("hide");
	jQuery(".addQbVendorsForm").addClass("hide");
}

function editBtnQbVendorMapping() {
	jQuery(".QbVendorsList").addClass("hide");
	jQuery(".addQbVendorsForm").removeClass("hide");
	
}

function saveQbVendorForm()
{ 
	var params = {};
	var params = jQuery("#idFrmQbVendorFMapping").serializeFormData();

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
				jQuery(".QbVendorsList").removeClass("hide");
				jQuery(".addQbVendorsForm").addClass("hide");
				Vtiger_Helper_Js.showMessage(params1);
				window.location.reload(true);
			} else {
				params1['text'] = data.error.message;
				params1['type'] = 'error';
				Vtiger_Helper_Js.showMessage(params1);
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
	params['action'] = 'VendorMapping';
	params['mode'] = 'getIssuesList';

	AppConnector.request(params).then(
	function(data) {
			if (data.success){
				var issuedata = data.result.message; 
				jQuery(".qbVendorsProperties").find("[name='field_name']").val(issuedata.vtiger_field).trigger("liszt:updated");
				jQuery(".qbVendorsProperties").find("[name='fieldqb_name']").val(issuedata.qb_field_name).trigger("liszt:updated");
				showIssuesList(pagenumber);
			}
        },
        function(error) {
                progressIndicatorElement.progressIndicator(hideparams);
                console.log("Very serious error. Investigate function showIssuesList in vendorsMapping.tpl");
        }
    );
}

</script>
				  		  		  
