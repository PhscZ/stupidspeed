<?php
// task 14 file_read — expected output: 2389704704
// build: none (interpreted)    run: php 14_file_read.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 14_file_read.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.
// Reads data.bin (52428800 bytes: the bytes 0..255 repeating) from the working directory in
// 1 MiB chunks, never one byte per syscall, and sums every byte.

$__t0 = hrtime(true);
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

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo $total % 4294967296, "\n";
