<strip>
<div class="addQbInvoiceForm hide">
	<div>
		<table class="table">
			<tr>
				<td id="">
				</td>
				<td>
				<span class="pull-right"><button id="idBtnSaveUpdate" class="btn btn-success" onclick="saveQbInvoiceForm();" ><strong>Save</strong></button>
				<a onclick="showQbInvoicesListView();" type="reset" class="cancelLink">Cancel</a></span>
				</td>
			</tr>
		</table>
	</div>
	<form class="qbInvoiceProperties" id="idFrmQbInvoiceFMapping" name="frmAcrmIssues" action="post">
			<table class="table table-bordered">
				<thead>
					<tr>
					  <th>Quickbooks</th>
					  <th>Invoice</th>
					</tr>
				</thead>
			  <tbody>
			  {foreach item=IPICKLIST_VALUE key=IPICKLIST_KEY from=$INVOICE_LIST_VIEW}
				<tr>
					<td class="fieldValue medium">{$IPICKLIST_VALUE['qb_field_name']}</td>
					<td class="fieldValue medium">
						<div class="row-fluid">
							<span class="span10">
								<select name="Invoice[{$IPICKLIST_VALUE['qb_field_name']}]" id="{$SPICKLIST_VALUE['qb_field_name']}" class="Invoice"  >
									<option value="">-Select-</option>
									{foreach item=INVOICE_FIELDS_LIST from=$INVOICE_FIELDS_LIST_ARRAY}
										<option value="{$INVOICE_FIELDS_LIST}" {if $INVOICE_FIELDS_LIST == $IPICKLIST_VALUE['vtiger_field']} selected {/if} >{$INVOICE_FIELDS_LIST}</option>
									{/foreach}			  
								</select>
							<span>
						</div>
					</td>
				</tr>
				{/foreach}
			  
				 
			</tbody>
			</table>
			<input type="hidden" id= "idHdnModule" name="hdnModule" value="Invoice">
	</form>
</div>

<div class="QbInvoicesList">
	<span class="span4">
		<span class="pull-right">
			<!--<button onclick="editBtnQbInvoiceMapping();" class="btn addButton"><strong>Edit</strong></button>-->
		</span>
	</span>
	<table class="table table-bordered QbInvoicesList">
		<thead>
			<tr>
				<th>Quickbooks</th>
				<th>Invoice</th>				 
			</tr>
		</thead>
		<tbody>
		{foreach from=$INVOICE_LIST_VIEW key=k item=v}
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


function showQbInvoicesListView(){
	jQuery(".QbInvoicesList").removeClass("hide");
	jQuery(".addQbInvoiceForm").addClass("hide");
}

function editBtnQbInvoiceMapping() {
	jQuery(".QbInvoicesList").addClass("hide");
	jQuery(".addQbInvoiceForm").removeClass("hide");
	
}

function saveQbInvoiceForm()
{ 
	var params = {};
	var params = jQuery("#idFrmQbInvoiceFMapping").serializeFormData();

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
				jQuery(".QbInvoicesList").removeClass("hide");
				jQuery(".addQbInvoiceForm").addClass("hide");
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
			Vtiger_Helper_Js.showMessage("oops error!,please try again later.");
		}
	);	
}

function showIssuesList()
{  	
	var params = {};
	params['module'] = 'Quickbooks';
	params['action'] = 'InvoiceMapping';
	params['mode'] = 'getIssuesList';

	AppConnector.request(params).then(
	function(data) {
			if (data.success){
				var issuedata = data.result.message; 
				jQuery(".qbInvoiceProperties").find("[name='field_name']").val(issuedata.vtiger_field).trigger("liszt:updated");
				jQuery(".qbInvoiceProperties").find("[name='fieldqb_name']").val(issuedata.qb_field_name).trigger("liszt:updated");
				showIssuesList(pagenumber);
			}
        },
        function(error) {
                progressIndicatorElement.progressIndicator(hideparams);
                console.log("Very serious error. Investigate function showIssuesList in InvocieMapping.tpl");
        }
    );
}

</script>
				  		  		  
