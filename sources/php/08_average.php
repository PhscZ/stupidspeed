<?php
// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: php 08_average.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 08_average.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.
// Every reading is a multiple of 1/256 and the total stays under 2^53, so the sum is exact.
// PHP prints floats with precision=14, which gives the 9 significant digits of 0.498046875.

$__t0 = hrtime(true);
$total = 0.0;

for ($i = 0; $i < 100000000; $i++) {
    $reading = ($i % 256) / 256.0;
    $total += $reading;
}

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo $total / 100000000, "\n";
