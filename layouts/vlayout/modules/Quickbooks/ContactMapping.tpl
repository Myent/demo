<strip>
<div class="addQbContactForm hide">
	<div>
		<table class="table">
			<tr>
				<td id="">
				</td>
				<td>
				<span class="pull-right"><button id="idBtnSaveUpdate" class="btn btn-success" onclick="saveQbContactForm();" ><strong>Save</strong></button>
				<a onclick="showQbContactsListView();" type="reset" class="cancelLink">Cancel</a></span>
				</td>
			</tr>
		</table>
	</div>
	<form class="qbContactProperties" id="idFrmQbContactFMapping" name="frmAcrmIssues" action="post">
			<table class="table table-bordered">
				<thead>
					<tr>
					  <th>Quickbooks</th>
					  <th>Contact</th>
					</tr>
				</thead>
			  <tbody>
			  {foreach item=PICKLIST_VALUE key=PICKLIST_KEY from=$CONTACT_LIST_VIEW}
				<tr>
					<td class="fieldValue medium">{$PICKLIST_VALUE['qb_field_name']}</td>
					<td class="fieldValue medium">
						<div class="row-fluid">
							<span class="span10">
								<select name="Contacts[{$PICKLIST_VALUE['qb_field_name']}]" id="{$PICKLIST_VALUE['qb_field_name']}" class="contact"  >
									<option value="">-Select-</option>
									{foreach item=CONTACT_FIELDS_LIST from=$CONTACT_FIELDS_LIST_ARRAY}
										<option value="{$CONTACT_FIELDS_LIST}" {if $CONTACT_FIELDS_LIST == $PICKLIST_VALUE['vtiger_field']} selected {/if} >{$CONTACT_FIELDS_LIST}</option>
									{/foreach}			  
								</select>
							<span>
						</div>
					</td>
				</tr>
				{/foreach}
			  
				 
			</tbody>
			</table>
			<input type="hidden" id= "idHdnModule" name="hdnModule" value="Contacts">
	</form>
</div>

<div class="QbContactsList">
	<span class="span4">
		<span class="pull-right">
			<!--<button onclick="addAcrmCCMIssue();" class="btn addButton"><strong>Edit</strong></button>-->
		</span>
	</span>
	<table class="table table-bordered QbContactsList">
		<thead>
			<tr>
				<th>Quickbooks</th>
				<th>Contact</th>				 
			</tr>
		</thead>
		<tbody>
		{foreach from=$CONTACT_LIST_VIEW key=k item=v}
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

function showQbContactsListView(){
	jQuery(".QbContactsList").removeClass("hide");
	jQuery(".addQbContactForm").addClass("hide");
}

function addAcrmCCMIssue() {
	jQuery(".QbContactsList").addClass("hide");
	jQuery(".addQbContactForm").removeClass("hide");
	
}

function saveQbContactForm()
{ 
	var params = {};
	var params = jQuery("#idFrmQbContactFMapping").serializeFormData();

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
				jQuery(".QbContactsList").removeClass("hide");
				jQuery(".addQbContactForm").addClass("hide");
				Vtiger_Helper_Js.showMessage(params1);
				window.location.reload(true);
			} else {
				params1['text'] = data.error.message;
				params1['type'] = 'error';
				Vtiger_Helper_Js.showMessage(params1);
			}
			/* Vtiger_Index_Js.showMessage ( params1 );			
				Vtiger_Helper_Js.showPnotify(params1);	 */		
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
	params['action'] = 'Mapping';
	params['mode'] = 'getIssuesList';

	AppConnector.request(params).then(
	function(data) {
			if (data.success){
				var issuedata = data.result.message; 
				jQuery(".qbContactProperties").find("[name='field_name']").val(issuedata.vtiger_field).trigger("liszt:updated");
				jQuery(".qbContactProperties").find("[name='fieldqb_name']").val(issuedata.qb_field_name).trigger("liszt:updated");
				showIssuesList(pagenumber);
			}
        },
        function(error) {
                progressIndicatorElement.progressIndicator(hideparams);
                console.log("Very serious error. Investigate function showIssuesList in ContactMapping.tpl");
        }
    );
}

</script>
				  		  		  
