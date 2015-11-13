#!/usr/bin/php
<?php
if(!isset($argv[1]) || !is_writable($file = __DIR__ . '/' . $argv[1])){
    die('Please specify a file name as the first argument');
}

date_default_timezone_set("UTC");

$content = file_get_contents($file);
$tempFile = tempnam(sys_get_temp_dir(), 'adblock');

file_put_contents($tempFile, $content);

printf("\n Backing up old content to %s", $tempFile);

$content = preg_replace('/^.*Version\s*:.*$/mi', sprintf("! Version: %s", date('YmdHi')), $content);
$content = preg_replace('/^.*Last Modified\s*:.*$/mi', sprintf("! Last Modified: %s", date('d M Y H:i e')), $content);

$handle = fopen($file, "w");
fwrite($handle, $content);
fclose($handle);

print_r("\n Done. \n");