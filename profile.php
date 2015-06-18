#!/usr/bin/env php
<?php
$profileDirectory = getenv('HOME').'/.switcher';
$fileSettings  = $profileDirectory . '/switcher.json' ;
if (!file_exists($fileSettings)) {
    return;
}
$settings = json_decode(file_get_contents($fileSettings), true);
if (!array_key_exists('current_profile', $settings)) {
    return;
}
echo $settings['current_profile'];
