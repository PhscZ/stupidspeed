<?php
// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: php 01_branches.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 01_branches.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.

$__t0 = hrtime(true);
$a = 0;
$b = 0;
$c = 0;
$d = 0;

for ($i = 0; $i < 100000000; $i++) {
    if ($i % 3 === 0) {
        $a++;
    } elseif ($i % 5 === 0) {
        $b++;
    } elseif ($i % 7 === 0) {
        $c++;
    } else {
        $d++;
    }
}

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo "$a $b $c $d\n";
