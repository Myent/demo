<?php
require_once("db.php");
$date = Date('Y-m-d H:i:s');
//echo 1;

$loginquery = "SELECT logi.*, us.autologout_time, us.id as luser_id FROM vtiger_loginhistory as logi, vtiger_users as us  where logi.status='Signed in' and logi.user_name = us.user_name";
$oginresult = mysqli_query($link, $loginquery);
$oginnoOfRows = mysqli_num_rows($oginresult);
if($oginnoOfRows > 0){
    while($oginrow = mysqli_fetch_assoc($oginresult)){
        $login_id = $oginrow['login_id'];
        $login_time = $oginrow['login_time'];
        $user_name = $oginrow['user_name'];
        $luser_id = $oginrow['luser_id'];
        $autologout_time = preg_replace("/[^0-9,.]/", "", $oginrow['autologout_time']);
        $auto = $autologout_time*60;
        $day = strtotime($date);
        $urld ='';
       /* $uquery = "SELECT max(u.datetime) FROM vtiger_forensic_url as u where u.user_name = '$user_name' and u.datetime >= '$login_time'";
        $uresult = mysqli_query($link, $uquery);
        $unoOfRows = mysqli_num_rows($uresult);
        if($unoOfRows >0){
            $url_date = mysqli_fetch_assoc($uresult);
            if($url_date['datetime'] != Null || $url_date['datetime'] != ''){
                $urld = strtotime($url_date['datetime']);
            }
            else{
                $urld ='';
            }
        }
        else{
            $urld ='';
        }*/

        $mquery = "SELECT max(m.changedon) FROM vtiger_modtracker_basic as m where m.whodid=$luser_id and m.changedon >= '$login_time'";
        $mresult = mysqli_query($link, $mquery);
        $mnoOfRows = mysqli_num_rows($mresult);
        if($mnoOfRows >0){
            $basic_date = mysqli_fetch_assoc($mresult);
            if($basic_date['changedon'] != Null || $basic_date['changedon'] != ''){
                $basicd = strtotime($basic_date['changedon']);
            }
            else{
                $basicd ='';
            }
        }
        else{
            $basicd ='';
        }


        if($urld !='' && $basicd !=''){
            if($urld > $basicd){
                $check = $day - $urld;
                if($check > $auto){
                    $logid[] = $login_id;
                } 
            }
            else {
                $check = $day - $basicd;
                if($check > $auto){
                    $logid[] = $login_id;
                } 
            }
        }
        else if($urld !='' && $basicd ==''){
            $check = $day - $urld;
            if($check > $auto){
                $logid[] = $login_id;
            } 
        }

        else if($urld =='' && $basicd !=''){
            $check = $day - $basicd;
            if($check > $auto){
                $logid[] = $login_id;
            } 
        }
        else{
               $logintim = strtotime($login_time);
               $check = $day - $logintim;
                if($check > $auto){
                    $logid[] = $login_id;
                } 
        }

        

    }
}

$forrun = count($logid);
if($forrun > 0){
    //echo 'hi';
    $login_ids = implode(",",$logid);

    $update = "UPDATE vtiger_loginhistory SET login_time= '$date',status='Signed off' WHERE login_id in ($login_ids) ";
    $update_result = mysqli_query($link, $update);
    if($update_result){
        echo $login_ids;
    }
}

?>