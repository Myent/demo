jQuery.Class("PCMReports_NumberFormat_Js",{},{
	load_modal : function(x){		 
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
       return res.toFixed(2); 		
	},
	registerEvents : function() {
	  var thisInstance = this; 
	  $(".num_format").each(function(c, obj){		
		//console.log($(obj).text());
		  //$(obj).text(load_modal(parseFloat($(obj).text())));
	   });
	}
	
})


jQuery(document).ready(function() {
	var instance = new PCMReports_NumberFormat_Js();
	instance.registerEvents();	
	$('.paginate_button').click(function () {
		//alert('Next page from dashboard js file');
		instance.registerEvents();  //and in next click which gets for next tr
   });
	
})




