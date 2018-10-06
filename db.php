<?php
 
session_start(); 
if(file_exists('config.inc.php')) { 
    require_once('config.inc.php');
} elseif(file_exists('../config.inc.php')){ 
    require_once('../config.inc.php');
 }

global $site_URL,$dbconfig;
            
$servername = $dbconfig['db_hostname'];
$servername = $dbconfig['db_server'];
$username = $dbconfig['db_username'];
$password = $dbconfig['db_password'];
$db_name	=	$dbconfig['db_name'];
$db_type 	= 	$dbconfig['db_type']; 


$link = mysqli_connect($servername, $username, $password, $db_name);
$_GLOBALS['link'] = $link;
 
// Check connection
if($link === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}
