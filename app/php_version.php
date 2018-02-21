<?php

if ($_SERVER['SERVER_ADDR'] !== $_SERVER['REMOTE_ADDR']) {
    header('HTTP/1.1 401 Unauthorized');
    exit();
}

echo "Version: " . PHP_VERSION . PHP_EOL;
echo "SAPI:    " . PHP_SAPI    . PHP_EOL;
