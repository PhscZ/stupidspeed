<?php
// task 11 parallel_sum — expected output: 7500000075000000
// build: none (interpreted; this task needs the PECL parallel extension)    run: php 11_parallel_sum.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 11_parallel_sum.php (zend + jit)
// PHP's standard library has no threads: `pecl install parallel` is the sanctioned mechanism,
// and it needs a ZTS build of PHP. Four parallel\Runtime workers, one range each. The closure
// captures nothing but its argument, and the whole loop lives inside it because the worker
// threads share no userland functions.

$runtimes = [];
$futures = [];

for ($t = 0; $t < 4; $t++) {
    $runtime = new parallel\Runtime();
    $runtimes[] = $runtime;
    $futures[] = $runtime->run(function (int $t): int {
        $acc = 0;
        $start = $t * 25000000;
        $end = ($t + 1) * 25000000;
        for ($i = $start; $i < $end; $i++) {
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
        return $acc;
    }, [$t]);
}

$total = 0;
foreach ($futures as $future) {
    $total += $future->value();
}

foreach ($runtimes as $runtime) {
    $runtime->close();
}

echo $total, "\n";
