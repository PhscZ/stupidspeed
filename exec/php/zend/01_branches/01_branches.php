<?php
// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: php 01_branches.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 01_branches.php (zend + jit)

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
