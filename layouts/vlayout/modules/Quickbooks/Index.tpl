<strip>
	<style type="text/css">
	.quickbooks td {
		border : 0px;
		padding : 0px;
	}

	</style>

	<div>
		<div class="contents tabbable">
			<ul class="nav nav-tabs layoutTabs massEditTabs"> 
				<li class="jtab active"><a data-toggle="tab" href="#generalOptions"><strong>QB Authentication </strong></a></li>
				<li class="jtab"><a data-toggle="tab" href="#idDivFieldsMapping"><strong>Fields Mapping</strong></a></li>
				<li class="jtab"><a data-toggle="tab" href="#idDivQbSettings"><strong>QB Settings</strong></a></li>
			</ul>
				<div class="tab-content layoutContent padding20 themeTableColor overflowVisible">
					<div class="tab-pane active" id="generalOptions">
						{include file="modules/Quickbooks/Authentication.tpl"}
					</div>
			
					<div class="tab-pane" id="idDivFieldsMapping">
						<div class="contents tabbable">
							<ul class="nav nav-tabs layoutTabs massEditTabs"> 
								<li class="jtab active"><a data-toggle="tab" href="#contactOptions"><strong>Contact Field Mapping</strong></a></li>
								<li class="jtab"><a data-toggle="tab" href="#vendorsExtension"><strong>Vendors Field Mapping</strong></a></li>
								<li class="jtab"><a data-toggle="tab" href="#productExtension"><strong>Product Field Mapping</strong></a></li>
								<li class="jtab"><a data-toggle="tab" href="#servicesExtension"><strong>Services Field Mapping</strong></a></li>
								<li class="jtab"><a data-toggle="tab" href="#invoiceOptions"><strong>Invoice Field mapping </strong></a></li>
							</ul>
								<div class="tab-content layoutContent padding20 themeTableColor overflowVisible">
									<div class="tab-pane" id="invoiceOptions">
										{include file='modules/Quickbooks/InvoiceMapping.tpl'}
									</div>
									
									<div class="tab-pane active" id="contactOptions">
										{include file='modules/Quickbooks/ContactMapping.tpl'}
									</div>
									
									<div class="tab-pane" id="vendorsExtension">
										{include file='modules/Quickbooks/VedorsMapping.tpl'}
									</div>
									
									<div class="tab-pane" id="productExtension">
										{include file='modules/Quickbooks/ProductMapping.tpl'}
									</div>
									
									<div class="tab-pane" id="servicesExtension">
										{include file='modules/Quickbooks/ServicesMapping.tpl'}
									</div>
									
								</div>	
						</div>
					</div>
		
					<div class="tab-pane" id="idDivQbSettings">
						{include file="modules/Quickbooks/QbSettings.tpl"}
					</div>
				</div>
		</div>	
	</div>
</strip>