<?php
// task 06 char_count — expected output: 10000000
// build: none (interpreted)    run: php 06_char_count.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 06_char_count.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.
// The 100 MB text is built once with str_repeat; the scan is an index loop over its bytes.

$__t0 = hrtime(true);
$text = str_repeat('abcdefghij', 10000000);

$count = 0;
$len = strlen($text);

for ($i = 0; $i < $len; $i++) {
    $ch = $text[$i];
    if ($ch === 'a') {
        continue;
    } elseif ($ch === 'e') {
        continue;
    } elseif ($ch === 'h') {
        $count++;
    }
}

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo $count, "\n";
