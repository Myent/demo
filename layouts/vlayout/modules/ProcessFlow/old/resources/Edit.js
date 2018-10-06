/*+***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *************************************************************************************/

Vtiger_Edit_Js("ProcessFlow_Edit_Js",{
},{

	registerOnLoad : function(){
		var thisInstance = this; 
		jQuery('.chzn-select').chosen({ "search_contains": true });

		var learner_mode = jQuery('#ProcessFlow_editView_fieldName_learner_mode').is(':checked');
			 if(learner_mode == true){
				 
			 }else{
				jQuery('.clsPLrnMode').html('');
			 } 

		
		jQuery("#id_raw_materials").chosen().change(function(e, params){
			var values =jQuery("#id_raw_materials").chosen().val(); 
			jQuery('#raw_materials').val(values);
		});

		var height = jQuery( window ).height();		 
		jQuery('#idDivBody').height(height-220);

		jQuery('#id_end_product_category').on('change',function(){ 
			var product_category = jQuery(this).val();		 
			jQuery('input[name="end_product_category"]').val(product_category);
		});
		
		jQuery('#idProcessmasterid').on('change',function(){ 

			var progressIndicatorElement = jQuery.progressIndicator();	
			var processid = jQuery(this).val();		 
			jQuery('input[name="processmasterid"]').val(processid);
			
			var sentdata ={};
			sentdata.module ='ProcessFlow'; 
			sentdata.action = 'AjaxValidations';	
			sentdata.mode = 'getProductsCategorysList';					 
			sentdata.processid = processid;  

			AppConnector.request(sentdata).then(
				function(data){ 			 
					if(data.result.status == true){ 
						
						/*  materials */
						console.log(data);
						var pcid = data.result.materials;					 
						var pcidArray = pcid.split(',');
						jQuery('#idtbodyGrid1 >.grid1ItemRow').remove();
						for(var i=1;i<=pcidArray.length;i++){
							jQuery('#addGrid1').trigger('click');
						}
						jQuery.each(pcidArray, function( index, value ) {
							var c = index+1;							 
							jQuery('#grid1productcategory'+c).val(value).trigger("liszt:updated");
							/* jQuery('#grid1productcategory'+c).prop('disabled', true).trigger("liszt:updated");*/
						});

						/*  vessels */
						var vesselsArray = data.result.vessels;					 
						//var vesselsArray = vessels.split(',');
						jQuery('#idtbodyGrid2 >.grid2ItemRow').remove();
						for(var i=1;i<=vesselsArray.length;i++){
							jQuery('#addGrid2').trigger('click');
						}
						jQuery.each(vesselsArray, function( index, value ) {
							console.log(value.assetname);
							var c = index+1;							 
							jQuery('#grid2assetName'+c).val(value.assetname).prop('readonly', true);
							jQuery('#grid2assetsid'+c).val(value.assetsid);
							jQuery('#grid2assetcategory'+c).val(value.cf_829).trigger("liszt:updated"); 
						});	 

						/* tools */
						var toolsArray = data.result.tools;					 
						//var toolsArray = tools.split(',');
						jQuery('#idtbodyGrid3 >.grid3ItemRow').remove();
						for(var i=1;i<=toolsArray.length;i++){
							jQuery('#addGrid3').trigger('click');
						}
						jQuery.each(toolsArray, function( index, value ) { 							 
							var c = index+1;							 
							jQuery('#grid3assetName'+c).val(value.assetname).prop('readonly', true);
							jQuery('#grid3assetsid'+c).val(value.assetsid);
							jQuery('#grid3assetcategory'+c).val(value.cf_829).trigger("liszt:updated"); 
						});

						/* machinery */
						var machineryArray = data.result.machinery;					 
						//var machineryArray = machinery.split(',');
						jQuery('#idtbodyGrid4 >.grid4ItemRow').remove();
						for(var i=1;i<=machineryArray.length;i++){
							jQuery('#addGrid4').trigger('click');
						}
						jQuery.each(machineryArray, function( index, value ) { 							 
							var c = index+1;							 
							jQuery('#grid4assetName'+c).val(value.assetname).prop('readonly', true);
							jQuery('#grid4assetsid'+c).val(value.assetsid);
							jQuery('#grid4assetcategory'+c).val(value.cf_829).trigger("liszt:updated"); 
						});

						progressIndicatorElement.progressIndicator({'mode' : 'hide'});					
					}else{
						this.disabled = false;
						bootbox.alert("Try again");				 
					}
				}
			);
			
		 });
		 
		 
		 var processid = jQuery('input[name="processmasterid"]').val();		 
		 if(processid != ''){
			jQuery('#idProcessmasterid').val(processid);		 
			jQuery('#idProcessmasterid').trigger("liszt:updated");
			jQuery('#idProcessmasterid').prop('disabled', true).trigger("liszt:updated");
			jQuery("input[name='process_flow_start_time']").prop('disabled',true);
			jQuery("input[name='process_flow_end_time']").prop('disabled',true);			
			jQuery("select[name='termination']").prop('disabled', true).trigger("liszt:updated");
		 }

		/* Counter time  for Present task */
		  // Set the date we're counting down to
		  var starttime = jQuery('#idHdnCurrentTime').val();
		  var endtime = jQuery('#idHdnCurrentProcessEndTime').val();
		  var pid = jQuery('#idHdnCurrentProcessId').val();
		  var countDownDate = new Date(endtime).getTime();
		  
		 
		var process_status_end = false;
		  // Update the count down every 1 second
		var x = setInterval(function() {
		  
		  	// Get todays date and time
			var now = new Date().getTime();
			 
			// Find the distance between now an the count down date
			var distance = countDownDate - now;
			
			// Time calculations for days, hours, minutes and seconds
			var days = Math.floor(distance / (1000 * 60 * 60 * 24));
			var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
			var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
			var seconds = Math.floor((distance % (1000 * 60)) / 1000);
			
			/* Output the result in an element with id="demo"*/
			
			var rTimeHtml = ''
			if(days > 0){ rTimeHtml += days + "d ";}
			if(hours > 0){ rTimeHtml += hours + "h ";}
			if(minutes > 0){ rTimeHtml += minutes + "m ";}
			if(seconds > 0){ rTimeHtml += seconds + "s ";}
			
			jQuery('#idHdnCurrentProcessRemainingTime').html(rTimeHtml);
		  
		  /* If the count down is over, write some text */
			if(process_status_end == false && distance < 50){
				jQuery('#idHdnCurrentProcessRemainingTime').removeClass('label-default');
				jQuery('#idMedia_'+pid).addClass('label-important');
				jQuery('#idMedia_'+pid).addClass('blink_me');
				jQuery('#idHdnCurrentProcessRemainingTime').addClass('blink_me');
				jQuery('#idHdnCurrentProcessRemainingTime').addClass('label-important');			
				process_status_end = true;
			}
			if (distance < 1) {
				$("#idDivNextBnFotTimer").show();
				clearInterval(x);            
				jQuery('#idHdnCurrentProcessRemainingTime').html("EXPIRED");
				 
				/* jQuery('#callerTone').trigger('play');*/
				if(jQuery('#idHdnSoundNotifications').val() == 1){ 
					jQuery('#msgTone').trigger('play');
				}
				
			}
		  }, 1000); 
		var recordId = jQuery('input[name="record"]').val();
		if(recordId > 0 && count == 0){
			count ++;
			jQuery.each(formdata, function( index, value ) { 			 
				/* temp need to enable  */
				 jQuery("#myform"+index).dform(value); 
			}); 
			jQuery.each(formdatavalues, function( index, value ) { 			 
				jQuery.each(value.quantity_data, function(k,v){ 
					/* jQuery("#myform"+index  "input[name="+v.name+"]").val(v.value); */
					jQuery("input[name='"+v.name+"']").val(v.value);
				}); 
				var productid = value.productid;
				var unitprocessid = value.unitprocessid;
				if(productid != ''){ 				 
					jQuery('#idProduct_'+unitprocessid).val(productid);
					jQuery('#idProduct_'+unitprocessid).trigger("chosen:updated");			 
				}		
			});
		}	
		 
		
		

		jQuery('.btnAbort').click(function(){
		 
			bootbox.confirm("Are you sure you want Abort Batch", function(result){ 
				if(result){   
					this.disabled = true; 
					var sentdata ={};
					sentdata.module ='ProcessFlow'; 
					sentdata.action = 'AjaxProcessFlow';	
					sentdata.mode = 'abort_batch';			 		 
					sentdata.recordId = jQuery('input[name="record"]').val();		 
					thisInstance.abortBatch(sentdata); 
				}else{
					this.disabled = false;
				}
			});
		});

		jQuery('.updateProcessData').click(function(){
			var p_name = jQuery(this).data('name');
			var unitprocessid = jQuery(this).data('unitprocessid'); 
			var formid = jQuery('#myform'+unitprocessid);
			var formdata  = formid.serializeArray();
			this.disabled = true;
			var sentdata ={};
				sentdata.module ='ProcessFlow'; 
				sentdata.action = 'AjaxProcessFlow';	
				sentdata.mode = 'updateProcessData';					 
				sentdata.unitprocessid = unitprocessid;	 
				sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();			 
				sentdata.recordId = jQuery('input[name="record"]').val();				 
				sentdata.formdata = formdata; 
				AppConnector.request(sentdata).then(
					function(data){ 						
						if(data.result.success == true){ 								
							var params = { 
								title : app.vtranslate('JS_MESSAGE'),
								text: app.vtranslate('<b> Updated Values </b>'),
								animation: 'show',
								type: 'info'
							};
							Vtiger_Helper_Js.showPnotify(params);							 
										
						}else{
							this.disabled = false;
							bootbox.alert("Try again");				 
						}
					}
				);
		});


		jQuery('.endprocess').click(function(){

            var p_name = jQuery(this).data('name');			 
            var lmd = jQuery(this).data('lmd');			 
            var nextprocess = jQuery(this).data('nextprocess');			 
		
			var unitprocessid = jQuery(this).data('unitprocessid'); 
			var formid = jQuery('#myform'+unitprocessid);
			var formdata  = formid.serializeArray();
			var productid  = jQuery('#idProduct_'+unitprocessid).val();
		 if(productid == ''){ 
			 var params = { 
				title : app.vtranslate('JS_MESSAGE'),
				text: app.vtranslate('Select Product'),
				animation: 'show',
				type: 'danger'
			};
			Vtiger_Helper_Js.showPnotify(params);
			return false;
		 }else if(productid == undefined ){
			 /* All ok then goto next process */
			 this.disabled = true;
			 var sentdata ={};
				 sentdata.module ='ProcessFlow'; 
				 sentdata.action = 'AjaxProcessFlow';	
				 sentdata.mode = 'end_unit_process';					 
				 sentdata.unitprocessid = unitprocessid;	 
				 sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();			 
				 sentdata.recordId = jQuery('input[name="record"]').val();
				 sentdata.nextprocess = nextprocess;
				 sentdata.formdata = formdata;
				 sentdata.productid = productid;
				 
			/* var learner_mode = jQuery('#ProcessFlow_editView_fieldName_learner_mode').is(':checked');
			 if(learner_mode == true){
				if(lmd == ''){
					var nxtAlert = "Are you sure you want End <b>"+p_name+"</b> Process";
				}else{
					var nxtAlert = lmd;
				}
				 bootbox.confirm(nxtAlert, function(result){ 
					 if(result){    
						 thisInstance.nextUnitProcess(sentdata,p_name); 
					 }else{
						 this.disabled = false;
					 }
				 }); 
			 }else{
				 thisInstance.nextUnitProcess(sentdata,p_name);	
			 } */
			 thisInstance.nextUnitProcess(sentdata,p_name); 
		 } else{
			  
			var product_quantity = 0;
			var error_status = false;
			jQuery.each(formdata, function(k,v){ 
				if(v.value != '' || v.value > 0){
					product_quantity = parseInt(product_quantity) + parseInt(v.value);
					jQuery('input[name="'+ v.name +'"]').css('border-color', '#cccccc');	
				}else{ 				 
					jQuery('input[name="'+ v.name +'"]').css('border-color', 'red');
					error_status = true;			
				}		 
			});
			if(error_status == true){
				return false;
			}
			/* check stock in Inventory */
			 
			var pdata ={};
			pdata.module ='ProcessFlow'; 
			pdata.action = 'AjaxValidations';	
			pdata.mode = 'check_inventory';					 
			pdata.productid = productid;	 		 
			pdata.product_quantity = product_quantity; 

			AppConnector.request(pdata).then(
				function(data){ 						
				
					if(data.success == true){ 	 

						if(data.result.status == false){
							var params = { 
								title : app.vtranslate('JS_MESSAGE'),
								text: app.vtranslate(data.result.message),
								animation: 'show',
								type: 'danger'
							};
							Vtiger_Helper_Js.showPnotify(params);
							 
							return false;
						}else{
							/* All ok then goto next process */
							this.disabled = true;
							var sentdata ={};
								sentdata.module ='ProcessFlow'; 
								sentdata.action = 'AjaxProcessFlow';	
								sentdata.mode = 'end_unit_process';					 
								sentdata.unitprocessid = unitprocessid;	 
								sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();			 
								sentdata.recordId = jQuery('input[name="record"]').val();
								sentdata.nextprocess = nextprocess;
								sentdata.formdata = formdata;
								sentdata.productid = productid;
								 
							var learner_mode = jQuery('#ProcessFlow_editView_fieldName_learner_mode').is(':checked');
							if(learner_mode == true){
								bootbox.confirm("Are you sure you want End <b>"+p_name+"</b> Process", function(result){ 
									if(result){    
										thisInstance.nextUnitProcess(sentdata,p_name); 
									}else{
										this.disabled = false;
									}
								}); 
							}else{
								thisInstance.nextUnitProcess(sentdata,p_name);	
							} 
						}	
					}else{						
						bootbox.alert("Try again");
						var product_status = false;				 
					}
				}
			); 
			} 
		});  

		jQuery('.btnClsDecision').click(function(){
			var p_name = jQuery(this).data('name');	 			 
			var sentdata ={};
			sentdata.module ='ProcessFlow'; 
			sentdata.action = 'AjaxProcessFlow';	
			sentdata.mode = 'decision_end_unit_process';					 
			sentdata.unitprocessid = jQuery(this).data('unitprocessid'); 			 
			sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();					 
			sentdata.recordId =  jQuery('input[name="record"]').val(); 
			sentdata.decision = jQuery(this).data('decision');
			sentdata.postprocess = jQuery(this).data('postprocess'); 
								
			AppConnector.request(sentdata).then(
				function(data){ 						
				 
					if(data.result.success == true){ 								
						var params = { 
							title : app.vtranslate('JS_MESSAGE'),
							text: app.vtranslate('<b>'+p_name+'</b><br> Process Ended,Next Process Started.'),
							animation: 'show',
							type: 'info'
						};
						Vtiger_Helper_Js.showPnotify(params);
						setTimeout(location.reload.bind(location), 3000);
									
					}else{
						this.disabled = false;
						bootbox.alert("Try again");				 
					}
				}
			); 
			   
		}); 

		jQuery('.btnClsDecisionNo').click(function(){
			var p_name = jQuery(this).data('name');	 			 
			var sentdata ={};
			sentdata.module ='ProcessFlow'; 
			sentdata.action = 'AjaxProcessFlow';	
			sentdata.mode = 'decision_end_unit_process_no';				 
			sentdata.unitprocessid = jQuery(this).data('unitprocessid'); 			 
			sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();					 
			sentdata.recordId =  jQuery('input[name="record"]').val(); 
			sentdata.decision = jQuery(this).data('decision');
			sentdata.postprocess = jQuery(this).data('postprocess'); 
								
			AppConnector.request(sentdata).then(
				function(data){ 						
				 
					if(data.result.success == true){ 								
						var params = { 
							title : app.vtranslate('JS_MESSAGE'),
							text: app.vtranslate('<b>'+p_name+'</b><br> Process running.'),
							animation: 'show',
							type: 'info'
						};
						Vtiger_Helper_Js.showPnotify(params);
						/* setTimeout(location.reload.bind(location), 3000); */
									
					}else{
						this.disabled = false;
						bootbox.alert("Try again");				 
					}
				}
			); 
			   
		});
		
		jQuery('.btnClsBranching').click(function(){  
			var sentdata ={};
			sentdata.module ='ProcessFlow'; 
			sentdata.action = 'AjaxProcessFlow';	
			sentdata.mode = 'branch_process';					 
			sentdata.unitprocessid = jQuery(this).data('unitprocessid'); 			 
			sentdata.runningprocess = jQuery(this).data('runningprocess'); 				 
			sentdata.recordId =jQuery('input[name="record"]').val(); 
			sentdata.branchids = jQuery(this).data('branchids');
			sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();
								
			AppConnector.request(sentdata).then(
				function(data){ 						
				 
					if(data.success == true){ 								
						var params = { 
							title : app.vtranslate('JS_MESSAGE'),
							text: app.vtranslate(data.result.message),
							animation: 'show',
							type: 'info'
						};
						Vtiger_Helper_Js.showPnotify(params);
						setTimeout(location.reload.bind(location), 3000);
									
					}else{
						this.disabled = false;
						bootbox.alert("Try again");				 
					}
				}
			); 
			   
        }); 
		
		jQuery('.clsDecisionChose').click(function(){ 

			var sentdata ={};
			sentdata.module ='ProcessFlow'; 
			sentdata.action = 'AjaxProcessFlow';	
			sentdata.mode = 'decisionChose';					 
			sentdata.unitprocessid = jQuery(this).data('unitprocessid');			 
			sentdata.nextunitprocess = jQuery(this).data('nextunitprocess'); 			 
			sentdata.recordId = jQuery('input[name="record"]').val();		 
			sentdata.process_master_id = jQuery('#idHdnProcessmasterid').val();
								
			AppConnector.request(sentdata).then(
				function(data){ 						
				 
					if(data.success == true){ 								
						var params = { 
							title : app.vtranslate('JS_MESSAGE'),
							text: app.vtranslate(data.result.message),
							animation: 'show',
							type: 'info'
						};
						Vtiger_Helper_Js.showPnotify(params);
						setTimeout(location.reload.bind(location), 3000);
									
					}else{
						this.disabled = false;
						bootbox.alert("Try again");				 
					}
				}
			); 
			   
        }); 
		  
		
	 
		
		/* End Counter time  for Present task */

	if(recordId > 0){
		var sentdata ={};
		sentdata.module ='ProcessFlow'; 
		sentdata.view = 'AjaxProcesses';		 
		sentdata.recordId = recordid; 
		AppConnector.request(sentdata).then(
			function(data){ 						
				jQuery('#idDivMapping').html(data);	 
			}
		); 
	}
	
	if(recordId > 0){

		/* Left widget */
		var TotalTaskCompleted = jQuery('#idHdnTotalTaskCompleted').val();
		var TotalTaskNotCompleted = jQuery('#idHdnTotalTaskNotCompleted').val();
		var ElapsedTime = jQuery('#idHdnElapsedTime').val();
		var CurrentTask = jQuery('#idHdnCurrentTask').val();
		var TotalTasks = jQuery('#idHdnTotalTasks').val();
		var TotalWaitingTasks = jQuery('#idHdnTotalWaitingTasks').val();
		
		var widget ='<div class="quickWidget">'+
					'   <div class="accordion-heading accordion-toggle quickWidgetHeader" data-target="#processflow_custom" data-toggle="collapse" data-parent="#quickWidgets" data-label="Process Flow Widget"  >'+
					'      <span class="pull-left"><img class="imageElement" data-rightimage="layouts/vlayout/skins/images/rightArrowWhite.png" data-downimage="layouts/vlayout/skins/images/downArrowWhite.png" src="layouts/vlayout/skins/images/downArrowWhite.png"></span>					'+
					'      <h5 class="title widgetTextOverflowEllipsis pull-right" title="Process Flow Widget">Process Flow Widget</h5>'+
					'      <div class="loadingImg hide pull-right">'+
					'         <div class="loadingWidgetMsg"><strong>Loading Widget</strong></div>'+
					'      </div>'+
					'      <div class="clearfix"></div>'+
					'   </div>'+
					'   <div class="widgetContainer accordion-body collapse in" id="processflow_custom"   style="height: auto;">'+
					'      <div class="recordNamesList">'+
					'         <div class="row-fluid">'+
					'            <div class="">'+
					'               <ul class="nav nav-list">';
		if(TotalTasks == TotalTaskCompleted ){

		}else{			
		var widget ='                  <li><a>Current Task <span style="font-weight: bold;">'+CurrentTask+'</span> of <span  style="font-weight: bold;">'+TotalTasks+'</span></a></li>';
		}
		var widget ='                  <li><a>Tasks Compleated : <span style="font-weight: bold;">'+TotalTaskCompleted+'</span></a></li>'+
					'                  <li><a>Not Compleated : <span style="font-weight: bold;">'+TotalTaskNotCompleted+'</span></a></li>'+
					'                  <li><a>Tasks Waiting :<span style="font-weight: bold;">'+TotalWaitingTasks+'</span></a></li>'+
					'                  <li><a>Elapsed Time (H:M:S)<br><span style="font-weight: bold;">'+ElapsedTime+'</span></a></li>'+
					'                  <!--<button class="btn btn-info btn-xs"  >Hide Completed</button>-->'+
					'                   <!--<button class="btn btn-info btn-xs"  >Hide Unstarted</button>-->'+
					'               </ul>'+
					'            </div>'+
					'         </div>'+
					'      </div>'+
					'   </div>'+
					'</div>';
					
		jQuery('.quickWidgetContainer').append(widget);
	}
		/* End Left widget */

		jQuery('.btnDone').attr("disabled", "disabled"); 
		jQuery("#idDivNextBnFotTimer").hide();
		
		var abortBatchstatus = jQuery("#idHdnTerminationStatus").val(); 
		if(abortBatchstatus == 'Aborted'){
			jQuery('button').prop('disabled', true);
		}

		/*change Assignee */
		jQuery('.clsSelAssgnee').change(function(){
			 
			var sentdata ={};
			sentdata.module ='ProcessFlow'; 
			sentdata.action = 'AjaxProcessFlow';	
			sentdata.mode = 'changeAssigneeUser';					 
			sentdata.unitprocessid = jQuery(this).data('unitprocessid');	 		 
			sentdata.recordId = jQuery('input[name="record"]').val();
			sentdata.assignee_user_id = jQuery(this).val();

			AppConnector.request(sentdata).then(
				function(data){ 						
				 
					if(data.success == true){ 								
						var params = { 
							title : app.vtranslate('JS_MESSAGE'),
							text: app.vtranslate(data.result.message),
							animation: 'show',
							type: 'info'
						};
						Vtiger_Helper_Js.showPnotify(params);									
					}else{
						this.disabled = false;
						bootbox.alert("Try again");				 
					}
				}
			); 	
		});
	},

	/**
	 * Function to get Status of stock avilability in inventory 
	 */
	checkStockInInventory : function(productid,product_quantity){
		var pdata ={};
		pdata.module ='ProcessFlow'; 
		pdata.action = 'AjaxValidations';	
		pdata.mode = 'check_inventory';					 
		pdata.productid = productid;	 		 
		pdata.product_quantity = product_quantity; 

		AppConnector.request(pdata).then(
			function(data){ 						
			 
				if(data.success == true){ 			
					 				
					 return data.result;					
				}else{
					 
					bootbox.alert("Try again");				 
				}
			}
		); 
	},

	/**
	 * Function to register event for image delete
	 */
	registerEventForImageDelete : function(){
			var formElement = this.getForm();
			var recordId = formElement.find('input[name="record"]').val();
			formElement.find('.imageDelete').on('click',function(e){
					var element = jQuery(e.currentTarget);
					var parentTd = element.closest('td');
					var imageUploadElement = parentTd.find(':file');
					var fieldInfo = imageUploadElement.data('fieldinfo');
					var mandatoryStatus = fieldInfo.mandatory;
					var imageId = element.closest('div').find('img').data().imageId;
					element.closest('div').remove();
					var exisitingImages = parentTd.find('[name="existingImages"]');
					if(exisitingImages.length < 1 && mandatoryStatus){
							formElement.validationEngine('detach');
							imageUploadElement.attr('data-validation-engine','validate[required,funcCall[Vtiger_Base_Validator_Js.invokeValidation]]');
							formElement.validationEngine('attach');
					}

					if(formElement.find('[name=imageid]').length != 0) {
							var imageIdValue = JSON.parse(formElement.find('[name=imageid]').val());
							imageIdValue.push(imageId);
							formElement.find('[name=imageid]').val(JSON.stringify(imageIdValue));
					} else {
							var imageIdJson = [];
							imageIdJson.push(imageId);
							formElement.append('<input type="hidden" name="imgDeleted" value="true" />');
							formElement.append('<input type="hidden" name="imageid" value="'+JSON.stringify(imageIdJson)+'" />');
					}
			});
	},
	abortBatch : function(sentdata){
		AppConnector.request(sentdata).then(
			function(data){ 						
			 
				if(data.result.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate('Abort Batch'),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);
					setTimeout(location.reload.bind(location), 3000);
								
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		);
	},
	nextUnitProcess : function(sentdata,p_name){
		AppConnector.request(sentdata).then(
			function(data){ 						
			 
				if(data.result.success == true){ 								
					var params = { 
						title : app.vtranslate('JS_MESSAGE'),
						text: app.vtranslate('<b>'+p_name+'</b><br> Process Ended,Next Process Started.'),
						animation: 'show',
						type: 'info'
					};
					Vtiger_Helper_Js.showPnotify(params);
					setTimeout(location.reload.bind(location), 3000);
								
				}else{
					this.disabled = false;
					bootbox.alert("Try again");				 
				}
			}
		);
	},

	registerSubmitEvent: function() {
		var form = jQuery('#EditView');
		form.on('submit',function(e) {
			if(form.data('submit') == 'true' && form.data('performCheck') == 'true') {
				return true;
			} else {
				form.data('submit', 'true');
			}
		});
		var editViewForm = this.getForm();
		editViewForm.submit(function(e){
			if((editViewForm.find('[name="existingImages"]').length >= 1) || (editViewForm.find('[name="imagename[]"]').length > 1)){
				jQuery.fn.MultiFile.disableEmpty(); // before submiting the form - See more at: http://www.fyneworks.com/jquery/multiple-file-upload/#sthash.UTGHmNv3.dpuf
			}
		});
	},

   registerEventForCkEditor : function(){
		var form = this.getForm();
		form.find('textarea.richtext').each(function(){
    		var inputname=jQuery(this).attr('name');
			var elem=jQuery(this).data('fieldinfo');
			var noteContentElement=jQuery(this);
			var fieldUIType = elem.fielduitype;
			if(fieldUIType==540){
				if(noteContentElement.length > 0){
					noteContentElement.removeAttr('data-validation-engine').addClass('ckEditorSource');
					var ckEditorInstance = new Vtiger_CkEditor_Js();
					ckEditorInstance.loadCkEditor(noteContentElement);
				}
			}
			
		});
	},
	
	registerEvents : function(){
		this._super();
	},

	registerBasicEvents : function(container) {
		this._super(container);
		this.registerEventForCkEditor();
		this.registerOnLoad();
	}
});

 

var path = "";
var vtRsPath = [];
var plparams ={};
var pickBlock = {};			// will hold the array of blockids assigned as pickblock for each picklist item
var vtDZ_pickBlocks = {};	// will hold the array of blockids that have been chosed as pickblocks for the picklist 
var plFieldId = {};			// will hold the fieldid of the picklist field
var plFieldName = {};		// will hold the fieldname of the picklist field
var plFieldBlockId = {};	// will hold the blockid of the picklist field, used to prevent selection as pickblock
var plFieldLabel2Name = {}; // will hold the field label as value of the picklist field, used to preload
var plFieldValue = {};		// will hold the field value of the picklist field, used to preload
var plModuleName = {};		// will hold the module name as value of the picklist field, used to preload

function plwalker(key, value) {
	var savepath = path;
	path = path ? (path + "::||::" + key) : key;
	if (key=="uitype" && (value=="15" || value=="16")){
		var fieldid=vtRsPath.pop();
		var blockid=vtRsPath.pop();
		vtRsPath.push(blockid);
		vtRsPath.push(fieldid);
		pllabel = vtRecordStructure[blockid][fieldid].label;
		plvalues = '';
		if(typeof vtRecordStructure[blockid][fieldid].fieldInfo != 'undefined'){
			plvalues = Object.keys(vtRecordStructure[blockid][fieldid].fieldInfo.picklistvalues);
		}
		plparams[pllabel] = plvalues;
		vtDZ_pickBlocks[pllabel] = [];
		plFieldBlockId[pllabel] = vtRecordStructure[blockid]["id"];
		plFieldId[pllabel] = vtRecordStructure[blockid][fieldid].id;
		plFieldName[pllabel] = vtRecordStructure[blockid][fieldid].name;
		plFieldLabel2Name[vtRecordStructure[blockid][fieldid].name] = pllabel;
		plFieldValue[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].fieldvalue;
		plModuleName[vtRecordStructure[blockid][fieldid].name] = vtRecordStructure[blockid][fieldid].modulename;
	}
	if (value !== null && typeof value === "object") {
		// Recurse into children
		vtRsPath.push(key);
		jQuery.each(value, plwalker);
		vtRsPath.pop();
	}
	path = savepath;
}

jQuery(document).ready(function() {
	if (typeof(vtRecordStructure) !== 'undefined') {
		// Implementation of Pickblocks in EditView
		jQuery.each(vtRecordStructure, plwalker);
		if (Object.keys(pickBlocks).length > 0) {
			jQuery.each(pickBlocks, function(index, value){
				pickkey = plFieldValue[index];
				selectedBlockLabel = "";
				jQuery.each(value, function(i,e){
					jQuery("th.blockHeader:contains('"+e[1]+"')").closest('table').hide();
					if (i == pickkey) {
						selectedBlockLabel=e[1];
					}
				});
				jQuery("th.blockHeader:contains('"+selectedBlockLabel+"')").closest('table').show();

				// set the onchange function
				jQuery("select[name='"+index+"']").change(function(){
					selectedBlockLabel = "";
					selectedKey = index;
					pickkey = jQuery("select[name='"+index+"']").next().find("a.chzn-single").find("span").first().text().trim();
					pickKeys = pickBlocks[selectedKey];
					jQuery.each(pickKeys, function(i,e){
						jQuery("th.blockHeader:contains('"+e[1]+"')").closest('table').hide();
						if (i == pickkey) {
							selectedBlockLabel=e[1];
						}
					});
					jQuery("th.blockHeader:contains('"+selectedBlockLabel+"')").closest('table').show();
				}); // end on change registration
			});
		}
	}
});
