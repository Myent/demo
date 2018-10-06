jQuery.Class("PCMReports_DashBoardView_Js",{},{
	load_modal : function(){
		jQuery('#idReportDataTable').find('.vk_modal_open').on('click',function(e){  
			e.preventDefault();
			var element = jQuery(e.currentTarget);
			var crmist=element.data('crmlist');
			var modaltitle=element.data('modaltitle');
			/// Load modal
				var progressInstance = jQuery.progressIndicator();
			    var params = {};
			    params['module'] = 'PCMReports';
			    params['view'] = 'DashBoard';
			    params['mode'] = 'ViewEntities';
				params['crmist'] =crmist;
				params['modaltitle'] =modaltitle;
			    AppConnector.request(params).then(
			function(data) {
			
			var callBackFunction = function(data) { }
			var params1 = {};
			params1.data = data ;
			params1.css = {'width':'60%','text-align':'left','left':'1.5%','max-height':'500px','overflow-y':'scroll'};
			progressInstance.progressIndicator({'mode' : 'hide'});
			
				app.showModalWindow(data,function(data){
					if(typeof callBackFunction == 'function'){
						callBackFunction(data);
					}
				}, {'width':'60%','text-align':'left','left':'1.5%','max-height':'500px','overflow-y':'scroll'});
			
			},
			function(error) {
			progressInstance.progressIndicator({'mode' : 'hide'});
			//TODO : Handle error
			aDeferred.reject(error);
			}
			);
				/// Load modal
		})
	},
	registerEvents : function() {
	  var thisInstance = this;
	 // thisInstance.load_modal();
	  $('#idReportDataTable').on('click', '.vk_modal_open', function(e){
   			///  Popup
			  
			e.preventDefault();
			var element = jQuery(e.currentTarget);
			var crmist=element.data('crmlist');
			var modaltitle=element.data('modaltitle');
			/// Load modal
				var progressInstance = jQuery.progressIndicator();
			    var params = {};
			    params['module'] = 'PCMReports';
			    params['view'] = 'DashBoard';
			    params['mode'] = 'ViewEntities';
				params['crmist'] =crmist;
				params['modaltitle'] =modaltitle;
			    AppConnector.request(params).then(
			function(data) { 
			
			var callBackFunction = function(data) { }
			var params1 = {};
			params1.data = data ;
			params1.css = {'width':'60%','text-align':'left','left':'1.5%','max-height':'500px','overflow-y':'scroll'};
			progressInstance.progressIndicator({'mode' : 'hide'});
			
				app.showModalWindow(data,function(data){
					if(typeof callBackFunction == 'function'){
						callBackFunction(data);
					}
				}, {'width':'60%','text-align':'left','left':'1.5%','max-height':'500px','overflow-y':'scroll'});
			
			},
			function(error) {
			progressInstance.progressIndicator({'mode' : 'hide'});
			//TODO : Handle error
			aDeferred.reject(error);
			}
			);
				/// Load modal
		
			// Popup
		});
	  
	}
	
})


jQuery(document).ready(function() {
	var instance = new PCMReports_DashBoardView_Js();
	instance.registerEvents();
	/*$('.paginate_button').click(function () {
		alert('Next page from dashboard js file');
		instance.registerEvents();  //and in next click which gets for next tr
   });*/
	
	
})




