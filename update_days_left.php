<?php
//ini_set('display_errors','on'); version_compare(PHP_VERSION, '5.5.0') <= 0 ? error_reporting(E_WARNING & ~E_NOTICE & ~E_DEPRECATED) : error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT);
error_reporting (0);
require_once('include/utils/utils.php');
$adb = PearDatabase::getInstance();
$sql = "SELECT
            projectid,startdate
        FROM
            vtiger_project
        INNER JOIN vtiger_crmentity ON vtiger_project.projectid = vtiger_crmentity.crmid
        WHERE
            vtiger_crmentity.deleted = 0";
$res = $adb->pquery($sql, array());
if($adb->num_rows($res)> 0){
    $rows = $adb->num_rows($res);
    for($i=0; $i<$rows; $i++) {
        $this_row = $adb->query_result_rowdata($res, $i);
        $project_id = $this_row["projectid"];
        $start_date =  $this_row["startdate"];
        $days_left = subtract_dates($start_date);
        $sql_update="UPDATE vtiger_projectcf SET cf_952 = ? WHERE projectid =?";
        $update_row = $adb->pquery($sql_update,array($days_left,$project_id));
    }
}
function subtract_dates($start_date){
    $date1 = date_create_from_format("Y-m-d",$start_date);
    $date2 = date_create_from_format("Y-m-d",date("Y-m-d"));
    $diff = date_diff($date1,$date2);
    if($diff) return $diff->format("%R%a");
}