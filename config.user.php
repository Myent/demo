<?php

$failed_logins_criteria = '7';   // 0 = No check for failed login
      // 1 = IP Check
      // 2 = Calendar Check
      // 3 = Calendar and IP Check
      // 4 = Password Check
      // 5 = PW and IP Check
      // 6 = PW and Calendar Check
       // 7 = PW, Calendar and IP Check


$max_login_attempts = '5';   // maximum sequential failed attempts
// success resets to zero
 


//holidays 	yyyy-mm-dd, or ideally follows sans yy  
$Holidays = '{"New Year Day":"2017-01-01","diwali":"2017-10-16"}';

$UC_NAME_ONE = 'vtigress';
$UC_EMAIL_ID_ONE = 'crmvtigress@gmail.com';

$UC_NAME_TWO = 'lavanya';
$UC_EMAIL_ID_TWO = 'mahankali.lavanya2@gmail.com';



$Working_Hours_start = '1:00:00';
$Working_Hours_end = '23:50:00';
$working_week_days = 'Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';

$TERMS_AND_CONDITIONS = 'Terms & Conditions	';
?>