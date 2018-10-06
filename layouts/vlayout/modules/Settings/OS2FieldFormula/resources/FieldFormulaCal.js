jQuery(document).ready(function () {
    var current_module = getUrlVars()["module"];
    var current_view = getUrlVars()["view"];
    var current_record = getUrlVars()["record"];
	
    function getUrlVars()
	{
		var vars = [], hash;
		var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
		for(var i = 0; i < hashes.length; i++)
		{
			hash = hashes[i].split('=');
			vars.push(hash[0]);
			vars[hash[0]] = hash[1];
		}
		return vars;
	}
	if(current_view == "Detail"){
		var aDeferred = jQuery.Deferred();
		var params = {};
		params['module'] = 'OS2FieldFormula';
		params['parent'] = 'Settings';
		params['action'] = 'ActionAjax';//VTFieldFormulaUpdate
		params['current_module'] = current_module;
		var formData = jQuery("#EditView").serializeFormData();
		AppConnector.request(params).then(
			function(data){
				if(data.result != 0){
					 jQuery(document).on('change', '#detailView input', function() {
						var field_name = jQuery(this).attr('name');
						if(this.value != ''){
							ExecuteCalculationDetailView();
						}
					});
					jQuery(document).on('change', '#detailView select', function() {
						var field_name = jQuery(this).attr('name');
						if(this.value != ''){
							ExecuteCalculationDetailView();
						}
					});
					jQuery(document).on('change', '#detailView textarea', function() {
						var field_name = jQuery(this).attr('name');
						if(this.value != ''){
							ExecuteCalculationDetailView();
						}
					});
				}
			}, 
			function(error, err) 
			{
				
			}
		);
		return aDeferred.promise();
	}
    if(current_view == "Edit"){
		var aDeferred = jQuery.Deferred();
		var params = {};
		params['module'] = 'OS2FieldFormula';
		params['parent'] = 'Settings';
		params['action'] = 'ActionAjax';//VTFieldFormulaUpdate
		params['current_module'] = current_module;
		var formData = jQuery("#EditView").serializeFormData();
		AppConnector.request(params).then(
			function(data){
				if(data.result != 0){
					jQuery('#EditView input').change(function(){
						var field_name = jQuery(this).attr('name');
						if(this.value != ''){
							ExecuteCalculation();
						}
					});
					jQuery('#EditView select').change(function(){
						var field_name = jQuery(this).attr('name');
						if(this.value != ''){
							ExecuteCalculation();
						}
					});
					jQuery('#EditView textarea').change(function(){
						var field_name = jQuery(this).attr('name');
						if(this.value != ''){
							ExecuteCalculation();
						}
					});
				}
			}, 
			function(error, err) 
			{
				
			}
		);
		return aDeferred.promise();
	}
	
function ExecuteCalculation(){
   var aDeferred = jQuery.Deferred();
		var params = {};
		params['module'] = 'OS2FieldFormula';
		params['parent'] = 'Settings';
		params['action'] = 'OS2FieldFormulaUpdate';//VTFieldFormulaUpdate
		params['current_module'] = current_module;
		var formData = jQuery("#EditView").serializeFormData();
		params['formdata'] = formData;
		 String.prototype.replaceAll = function (find, replace) {
			var str = this;
			return str.replace(new RegExp(find, 'g'), replace);
		};
		AppConnector.request(params).then(
			function(data){
				if(data.result){
					var fieldformulas = data.result
					var basicformulas = '';
					if (typeof fieldformulas.BaseFormulas !== "undefined") {
						var basicformulas = fieldformulas.BaseFormulas;
					}
					jQuery.each(fieldformulas,function(k,v){
						if(k != 'BaseFormulas'){
							jQuery('#'+current_module+'_editView_fieldName_'+k);
							jQuery('#'+current_module+'_editView_fieldName_'+k).val(v);
						}
					});
					//Basic Formula Calculations Satrted Here::
					if(basicformulas != ''){
						jQuery.each(basicformulas,function(formula_field,formula){
							jQuery("#EditView input").each(function(){
								var input_field_name = jQuery(this).attr('name');
								if(jQuery(this).is( ":text" )){
									if(formula.indexOf(input_field_name)!== -1){
										var input_val=jQuery('#'+current_module+'_editView_fieldName_'+input_field_name).val();
										if(input_val == '' || isNaN(input_val) || typeof input_val == 'undefined') {
											input_val=0;
										}else{
											input_val = input_val.replace(",",'');
										}										
										var finalfield = "#"+input_field_name;
										formula = formula.replaceAll(finalfield,input_val);
									}
								}
							});
							var new_formula_field = eval(formula);
							formula_field = formula_field.replace("#","");
							if(typeof new_formula_field == 'number'){
								new_formula_field = new_formula_field;
							}else{
								new_formula_field = new_formula_field.toFixed(2);
							}
							jQuery('#'+current_module+'_editView_fieldName_'+formula_field).val(new_formula_field);
						});
					}
				}
			},
			function(error, err) 
			{
				
			}
		);
		return aDeferred.promise();
}

//To Do Modifications in DV
function ExecuteCalculationDetailView(){
	 var aDeferred = jQuery.Deferred();
		var params = {};
		params['module'] = 'OS2FieldFormula';
		params['module'] = 'OS2FieldFormula';
		params['parent'] = 'Settings';
		params['mode'] = 'Detail';
		params['record'] = jQuery('#recordId').val();
		params['action'] = 'OS2FieldFormulaUpdate';//VTFieldFormulaUpdate
		params['current_module'] = current_module;
		var formData = jQuery("#detailView").serializeFormData();
		params['formdata'] = formData;
		 String.prototype.replaceAll = function (find, replace) {
			var str = this;
			return str.replace(new RegExp(find, 'g'), replace);
		};
		AppConnector.request(params).then(
			function(data){
				if(data.result){
					var fieldformulas = data.result
					var basicformulas = '';
				
					if (typeof fieldformulas.BaseFormulas !== "undefined") {
					
						var basicformulas = fieldformulas.BaseFormulas;
					}
					jQuery.each(fieldformulas,function(k,v){
						if(k != 'BaseFormulas'){
							var next = {};
							next['value']= v;
							next['field']= k;
							next['record']=jQuery('#recordId').val();
							next['module'] = current_module;
							next['action']='SaveAjax';
							AppConnector.request(next).then(
								function(data){
									 var requestMode = getUrlVars()["requestMode"];
									 if(requestMode == 'summary'){
										 jQuery.each(jQuery(".fieldname"),function(jk,kl){										
											  if(k == kl.value){
													jQuery(this).closest('td').find('.value').text(v);
												 }
										 });								
									 }else{
										jQuery("#"+current_module+"_detailView_fieldValue_"+k).find('.value').text(v);
									 }
									
								}
							);
						}
					});
					//Basic Formula Calculations Satrted Here::
					if(basicformulas != ''){
						jQuery.each(basicformulas,function(formula_field,formula){
							
							jQuery("#detailView input").each(function(){
								var input_field_name = jQuery(this).attr('name');
								if(jQuery(this).is( ":text" ) && input_field_name != '__vtrftk'){
										if(formula.indexOf(input_field_name)!== -1){
											var input_val=jQuery('#detailView').find('#'+current_module+'_editView_fieldName_'+input_field_name).val();
											if(input_val == '' || isNaN(input_val) || typeof input_val == 'undefined') {
												input_val=0;
											}else{
												input_val = input_val.replace(",",'');
											}
											
											var finalfield = "#"+input_field_name;
											formula = formula.replaceAll(finalfield,input_val);
										}
								}
							});
							var new_formula_field = eval(formula);
							formula_field = formula_field.replace("#","");
							if(typeof new_formula_field == 'number'){
								new_formula_field = new_formula_field;
							}else{
								new_formula_field = new_formula_field.toFixed(2);
							}
							var next = {};
							next['value']= new_formula_field;
							next['field']= formula_field;
							next['record']=jQuery('#recordId').val();
							next['module'] = current_module;
							next['action']='SaveAjax';
							AppConnector.request(next).then(
								function(data){
									 var requestMode = getUrlVars()["requestMode"];
									 if(requestMode == 'summary'){
										 jQuery.each(jQuery(".fieldname"),function(jk,kl){										
											  if(formula_field == kl.value){
													jQuery(this).closest('td').find('.value').text(new_formula_field);
												 }
										 });								
									 }else{
										jQuery("#"+current_module+"_detailView_fieldValue_"+formula_field).find('.value').text(new_formula_field);
									 }
								}
							);
							
						});
					}
				}
			},
			function(error, err) 
			{
				
			}
		);
		return aDeferred.promise();

}
	
});

$(window).error(function(e){
    e.preventDefault();
});

