<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="libraries/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="libraries/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
  </head>
  <body> 
  <body > 
  <tr>
  <br>
  <div style="text-align:right;" >
  <b><td>Help</td></b> <td  ><a style="text-align:right;" href="https://demo.theracanncorp.com/Faqdetail.php">FAQ</a></td></tr>
   
	
	</div>
<?php

 
  $site_link = (isset($_SERVER['HTTPS']) ? "https" : "http") . "://$_SERVER[HTTP_HOST]/" ;
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
   #$adb->setDebug(true); 

	#current User
	$user = new Users();
	$current_user = $user->retrieveCurrentUserInfoFromFile(Users::getActiveAdminId());
	
  $module=$_REQUEST['module'];

 $fileres = $adb->pquery("select vtiger_attachments.type  FileType,crm2.modifiedtime lastmodified,vtiger_crmentity.modifiedtime,
    vtiger_seattachmentsrel.attachmentsid attachmentsid, vtiger_crmentity.smownerid smownerid, vtiger_notes.notesid crmid,
    vtiger_notes.notecontent description,vtiger_notes.*
    from vtiger_notes
    inner join vtiger_senotesrel on vtiger_senotesrel.notesid= vtiger_notes.notesid
    left join vtiger_notescf ON vtiger_notescf.notesid= vtiger_notes.notesid
    inner join vtiger_crmentity on vtiger_crmentity.crmid= vtiger_notes.notesid and vtiger_crmentity.deleted=0
    inner join vtiger_crmentity crm2 on crm2.crmid=vtiger_senotesrel.crmid
    LEFT JOIN vtiger_groups
    ON vtiger_groups.groupid = vtiger_crmentity.smownerid
    left join vtiger_seattachmentsrel  on vtiger_seattachmentsrel.crmid =vtiger_notes.notesid
    left join vtiger_attachments on vtiger_seattachmentsrel.attachmentsid = vtiger_attachments.attachmentsid
    left join vtiger_users on vtiger_crmentity.smownerid= vtiger_users.id
    where crm2.setype = '$module'");
				if ($adb->num_rows($fileres) > 0) {
					$data=$data.'<table>';
					
					$i=0;
						while ($fieldnamesrow=$adb->fetch_array($fileres)) 
						
						{ $i++;
							$fieldname = $fieldnamesrow['filename'];
							$notesid = $fieldnamesrow['notesid'];
							  $data=$data."<tr><td>".$i."</td>";
						 $fileQuery = $adb->pquery("select vs.attachmentsid,path,type,name from vtiger_seattachmentsrel vs,vtiger_attachments vt where vt.attachmentsid=vs.attachmentsid and crmid = ?",array($notesid));
							
								$attachmentsid = $adb->query_result($fileQuery,0,'attachmentsid');
								$filepath = @$adb->query_result($fileQuery,0,'path');
								 $type =$adb->query_result($fileQuery,0,'type');
								$name = $adb->query_result($fileQuery,0,'name');
								$name = html_entity_decode($name, ENT_QUOTES, $default_charset);
								$saved_filename = $attachmentsid."_".$name;
						 $completepath=$site_link.$filepath.$saved_filename;
								 $divname="div".$attachmentsid;
								
							   $data=$data."<td>". $fieldname ."</td></tr><tr><td><div id='topBar'><a href =$completepath>View</a></div></td>";
							 $data=$data." <td><div id=\"$divname\"></div></td></tr>";
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