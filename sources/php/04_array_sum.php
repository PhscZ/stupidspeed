<?php
// task 04 array_sum — expected output: 499999500000
// build: none (interpreted)    run: php 04_array_sum.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 04_array_sum.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.

$__t0 = hrtime(true);
$n = 1000000;

$array = array_fill(0, $n, 0);
for ($i = 0; $i < $n; $i++) {
    $array[$i] = $i;
}

$total = 0;
for ($i = 0; $i < $n; $i++) {
    $total += $array[$i];
}

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo $total, "\n";
