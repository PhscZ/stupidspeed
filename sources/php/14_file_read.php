<?php
// task 14 file_read — expected output: 484442112
// build: none (interpreted)    run: php 14_file_read.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 14_file_read.php (zend + jit)
// Reads data.bin (104857600 bytes: the bytes 0..255 repeating) from the working directory in
// 1 MiB chunks, never one byte per syscall, and sums every byte.

$handle = fopen('data.bin', 'rb');

$total = 0;

while (!feof($handle)) {
    $chunk = fread($handle, 1048576);
    if ($chunk === false || $chunk === '') {
        break;
    }
    $len = strlen($chunk);
    for ($i = 0; $i < $len; $i++) {
        $total += ord($chunk[$i]);
    }
}

fclose($handle);

echo $total % 4294967296, "\n";
