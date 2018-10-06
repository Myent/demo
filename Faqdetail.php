<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="libraries/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="libraries/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
  </head>
  <body> 
  <tr>
  <td></td>
  </tr>
   <div class="container">
	
	</div>
<?php

  $site_link = (isset($_SERVER['HTTPS']) ? "https" : "http") . "://$_SERVER[HTTP_HOST]/";
include_once dirname(__FILE__) . '/config.inc.php';
include_once dirname(__FILE__) . '/include/utils/utils.php';
include_once dirname(__FILE__) . '/includes/runtime/BaseModel.php';
include_once dirname(__FILE__) . '/includes/runtime/Globals.php';
include_once dirname(__FILE__) . '/includes/Loader.php';
include_once dirname(__FILE__) . '/includes/http/Request.php';
include_once dirname(__FILE__) . '/modules/Vtiger/models/Record.php';
include_once dirname(__FILE__) . '/modules/Users/models/Record.php';
include_once dirname(__FILE__) . '/includes/runtime/LanguageHandler.php';
include_once dirname(__FILE__) . '/modules/Users/Users.php';



    global $adb, $current_user;
// $adb->setDebug(true); 
 echo $module=$_REQUEST['module'];
	#current User
	$user = new Users();
	$current_user = $user->retrieveCurrentUserInfoFromFile(Users::getActiveAdminId());
 $result = $adb->pquery("SELECT question, answer FROM vtiger_faq ");


$count=$adb->num_rows($result);

if($count >0){
	$data=$data.'<table> ';
	
	
	while ($row = $adb->fetch_array($result)){
		
		$question = $row['question'];
		$answer = $row['answer'];
			$data=$data."<tr><td>".$i."</tr></td>";
			$data=$data."<tr ><td>". $question ."</td></tr>";
			$data=$data."<tr><td>". $answer ."</td></tr>";
	 
	}
	$data=$data."</table>";
}	
else{
	$data="No Records found.";
}
echo $data;
?>

</table>

  </div> 
</div>
    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="libraries/bootstrap/js/bootstrap.min.js"></script>
	<script>
	$(document).ready(function(){
		 
	});
	</script>
  </body>
</html>