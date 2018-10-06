<?php

$languageStrings = array(
    'once_day' => 'Once a Day',
    'once_week' => 'Every week',
    'once_two_weeks' => 'Every two weeks',
    'once_month' => 'Once a Month',
    'backup_edit_info' => 'Please set your backup information.',
    'backup_settings' => 'VGS Backup Settings',
    'backup_folder' => 'Comma separated list of the folders to backup',
    'local_settings' => 'Local ',
    'local_information' => 'If enabled, this option allows you to write a compressed copy of your Theracann build to a folder on the server.',
    'enable' => 'Enable',
    'fecuency' => 'Backup Frecuency',
    'backup-number' => 'Number of Backup to keep',
    'path' => 'Full directory path',
    'ftp-settings' => 'FTP Remote Server Settings',
    'ftp-settings-info' => 'If enabled, this option allows will transfer you backup into a remote server over FTP or SFTP.',
    'ftp-server' => 'FTP Server',
    'ftp-user' => 'FTP User',
    'ftp-pass' => 'FTP Password',
    'amazon-settings' => 'Amazon S3 Remote Backup',
    'amazon-info' => 'If enabled, this option allows will transfer you backup into your amazon S3 bucket',
    'amazon-key' => 'Amazon Access Key',
    'amazon-secret' => 'Secret Access Key',
    'amazon-bucket' => 'Bucket Name',
    'VGSBackUp-Module'=>'VGS Automatic Backup Module',
    'notify_emails' => 'List of emails to be notify of backup issues. Separate by :: <br/> Example: mail1@example.com::mail2@example.com',
    'notice'=>'<p> <b>Notice:</b> Even if the module will backup your files & databases. 
                            Is recomdable to test your recovery process to make sure you 
                            are backing up all your important data. We cant provide any warranty that you are doing it. Once you finish setting up the backup
                please perform a test recovery process just be sure you have set up the option correctly</p>
                <p><b>Support, Helps & FAQs:</b></br> Please read the module documentation <a href="index.php?module=VGSBackUp&amp;view=Help">Helps & FAQs</a> page for more 
                    information about how to set up your backups</p>
                    <p><b>Terms & Conditions:</b></br>By using this module you are accepting it´s  <a href="index.php?module=VGSBackUp&amp;view=Help">Terms of use</a></p>',
    'connection_works' => 'Its Works! Run Theracann cron and make sure the files are backuping correctly',
    'ftp_connection_failed' => 'We couldnt connect to your FTP server, please double check the server information or enable debug mode for more information',
    's3_connection_failed' => 'We couldnt connect to your amazon s3 account. Please check your credentials or enable debug mode for more information',
    'email_subject' => 'Theracann Backups Failed - ', //Please leave space at the end. We will add the more text after
    'local_failed' => 'Hi, <br> This is a quick email to let you that your local Theracann backups are not running as expected. Please check your setup.<br>Thanks',
    'ftp_failed' => 'Hi, <br> This is a quick email to let you that your FTP Theracann backups are not running as expected. Please check your setup.<br>Thanks',
    'amazon_failed' => 'Hi, <br> This is a quick email to let you that your Amazon Theracann backups are not running as expected. Please check your setup.<br>Thanks',
    'test-connection' => 'Test Connection',
    'run_now' => 'Run Backup Now',
    'js_run_now' => 'You are about to run a backup of your Theracann install. This might take a few minutes. Would you like to procced?'
    
    

    
);
