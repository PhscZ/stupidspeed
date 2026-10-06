<?php
// task 07 string_append — expected output: 250000
// build: none (interpreted)    run: php 07_string_append.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 07_string_append.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.
// `$text = $text . 'x'` is PHP's plain concatenation: ZEND_CONCAT allocates a fresh string
// every iteration. `.=` would be the in-place grow path (zend_string_extend), which is a
// different task and would not be comparable with the other languages.

$__t0 = hrtime(true);
$text = '';

for ($i = 0; $i < 250000; $i++) {
    $text = $text . 'x';
}

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo strlen($text), "\n";
