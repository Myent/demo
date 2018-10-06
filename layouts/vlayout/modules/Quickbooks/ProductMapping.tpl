<strip>
<div class="addQbProductForm hide">
	<div>
		<table class="table">
			<tr>
				<td id="">
				</td>
				<td>
				<span class="pull-right"><button id="idBtnSaveUpdate" class="btn btn-success" onclick="saveQbProductForm();" ><strong>Save</strong></button>
				<a onclick="showQbProductsListView();" type="reset" class="cancelLink">Cancel</a></span>
				</td>
			</tr>
		</table>
	</div>
	<form class="qbProductProperties" id="idFrmQbProductFMapping" name="frmAcrmIssues" action="post">
			<table class="table table-bordered">
				<thead>
					<tr>
					  <th>Quickbooks</th>
					  <th>Product</th>
					</tr>
				</thead>
			  <tbody>
			  {foreach item=PPICKLIST_VALUE key=PPICKLIST_KEY from=$PRODUCTS_LIST_VIEW}
				<tr>
					<td class="fieldValue medium">{$PPICKLIST_VALUE['qb_field_name']}</td>
					<td class="fieldValue medium">
						<div class="row-fluid">
							<span class="span10">
								<select name="Products[{$PPICKLIST_VALUE['qb_field_name']}]" id="{$PPICKLIST_VALUE['qb_field_name']}" class="Products"  >
									<option value="">-Select-</option>
									{foreach item=PRODUCTS_FIELDS_LIST from=$PRODUCTS_FIELDS_LIST_ARRAY}
										<option value="{$PRODUCTS_FIELDS_LIST}" {if $PRODUCTS_FIELDS_LIST == $PPICKLIST_VALUE['vtiger_field']} selected {/if} >{$PRODUCTS_FIELDS_LIST}</option>
									{/foreach}			  
								</select>
							<span>
						</div>
					</td>
				</tr>
				{/foreach}
			  
				 
			</tbody>
			</table>
			<input type="hidden" id= "idHdnModule" name="hdnModule" value="Products">
	</form>
</div>

<div class="QbProductsList">
	<span class="span4">
		<span class="pull-right">
			<!--<button onclick="editBtnQbProductMapping();" class="btn addButton"><strong>Edit</strong></button>-->
		</span>
	</span>
	<table class="table table-bordered QbProductsList">
		<thead>
			<tr>
				<th>Quickbooks</th>
				<th>Product</th>				 
			</tr>
		</thead>
		<tbody>
		{foreach from=$PRODUCTS_LIST_VIEW key=k item=v}
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


function showQbProductsListView(){
	jQuery(".QbProductsList").removeClass("hide");
	jQuery(".addQbProductForm").addClass("hide");
}

function editBtnQbProductMapping() {
	jQuery(".QbProductsList").addClass("hide");
	jQuery(".addQbProductForm").removeClass("hide");
	
}

function saveQbProductForm()
{ 
	var params = {};
	var params = jQuery("#idFrmQbProductFMapping").serializeFormData();

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
				jQuery(".QbProductsList").removeClass("hide");
				jQuery(".addQbProductForm").addClass("hide");
			} else {
				params1['text'] = data.error.message;
				params1['type'] = 'error';
			}
			//Vtiger_Index_Js.showMessage ( params1 );
			
			//Vtiger_Helper_Js.showPnotify(params1);
			Vtiger_Helper_Js.showMessage(params1);
		},
		function(error) {
			console.log(error);
			progressIndicatorElement.progressIndicator ( hideparams);
			console.log("oops error!,Investigate function saveQbProductForm  in ProductMapping.tpl.");
		}
	);	
}

function showIssuesList()
{  	
	var params = {};
	params['module'] = 'Quickbooks';
	params['action'] = 'ProductMapping';
	params['mode'] = 'getIssuesList';

	AppConnector.request(params).then(
	function(data) {
			if (data.success){
				var issuedata = data.result.message; 
				jQuery(".qbProductProperties").find("[name='field_name']").val(issuedata.vtiger_field).trigger("liszt:updated");
				jQuery(".qbProductProperties").find("[name='fieldqb_name']").val(issuedata.qb_field_name).trigger("liszt:updated");
				showIssuesList(pagenumber);
			}
        },
        function(error) {
                progressIndicatorElement.progressIndicator(hideparams);
                console.log("Very serious error. Investigate function showIssuesList in ProductMapping.tpl");
        }
    );
}

</script>
				  		  		  
