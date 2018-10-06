<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
<?php
$opts = array(
  'https'=>array(
    'method'=>"GET",
    'header'=>"Accept-language: en\r\n" .
              "Cookie: foo=bar\r\n"
  )
);
  
$livekey = 'pb_ixUVElJwP1qPXQosUrVpGVTNfeLpvxb8';
$Sandboxkey = 'pb_test_xWW2uDUQdrmaFSOVUfkeQXP2XlN';

$api_key = $Sandboxkey;

$data['api_key'] = $api_key;
echo "<pre>";
//Linked Acounts
echo "<br/>--------------------------Heart Beat----------------------<br/>";
$context = stream_context_create($opts); 
	$data_string = json_encode($data);
	$result = file_get_contents(
	"https://testing.phylosbioscience.com/partner/api/v1/heartbeat?api_key=$api_key", null, $context);
print_r(json_decode($result));

//Linked Acounts
echo "<br/>--------------------------Linked Acounts----------------------<br/>";

$context = stream_context_create($opts);
	 
	$data_string = json_encode($data);
	$result = file_get_contents(
	"https://testing.phylosbioscience.com/partner/api/v1/linked-accounts?api_key=$api_key", null, $context);

print_r(json_decode($result));
$linklist = json_decode($result);
print_r($linklist);
//$accesskey = $linklist->data->id_123456789;
$accesskey = $linklist->data->USERID;


echo "<br/>--------------------------Kit List----------------------<br/>";
$context = stream_context_create($opts);
	 
	$data_string = json_encode($data);
	$result = file_get_contents(
	"https://testing.phylosbioscience.com/partner/api/v1/kits?api_key=$api_key&phylos_user_token=$accesskey", null, $context);

print_r(json_decode($result));
?>