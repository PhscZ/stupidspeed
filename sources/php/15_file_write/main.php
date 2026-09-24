<?php
// task 15 file_write — expected output: 104857600
// build: none (interpreted)    run: php main.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M main.php (zend + jit)
// Writes out.bin: the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 100 times,
// then flushed and fsynced. Prints the number of bytes the writes reported.

$pattern = '';
for ($i = 0; $i < 256; $i++) {
    $pattern .= chr($i);
}
$buffer = str_repeat($pattern, 4096);

$handle = fopen('out.bin', 'wb');

$written = 0;
for ($i = 0; $i < 100; $i++) {
    $written += fwrite($handle, $buffer);
}

fflush($handle);
fsync($handle);
fclose($handle);

echo $written, "\n";
