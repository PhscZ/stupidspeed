<?php
// task 02 switch_case — expected output: 7500000075000000
// build: none (interpreted)    run: php 02_switch_case.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 02_switch_case.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.

$__t0 = hrtime(true);
$acc = 0;

for ($i = 0; $i < 100000000; $i++) {
    switch ($i % 4) {
        case 0:
            $acc += 1;
            break;
        case 1:
            $acc += $i;
            break;
        case 2:
            $acc += 2 * $i;
            break;
        case 3:
            $acc += 3 * $i;
            break;
    }
}

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo $acc, "\n";
