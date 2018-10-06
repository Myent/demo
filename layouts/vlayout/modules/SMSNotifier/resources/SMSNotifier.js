/*
$(document).ready(function() {
    var sel_mob_no = $('#sel_mob_no').val();
    alert(sel_mob_no);
    $('#sel_mob_no').change(function(e){
            alert('gi');
		
		});
});*/

function change_val(){
    var sel_mob_no = $('#sel_mob_no').val();
    var old = $('#mob_no').val();
    if(old != ''){
        var newb = old+sel_mob_no;
    }
    else{
        var newb = sel_mob_no;
    }
    
    $('#mob_no').val(newb);
    
}
function messchange(){
    var fild_name = $('#fild_name').val();
    var mold = $('#mess_box').val();
    if(mold != ''){
        var mnewb = mold+fild_name;
    }
    else{
        var mnewb = fild_name;
    }
    
    $('#mess_box').val(mnewb);
    
}
/*function validate(){
    var sel_mob_no = $('#mob_no').val();
    if(sel_mob_no == ''){
        alert('Select Mobile Number');
        return false;
        $('.blockPage').show();
    }
}*/