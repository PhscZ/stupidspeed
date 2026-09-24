<?php
// task 02 switch_case — expected output: 7500000075000000
// build: none (interpreted)    run: php 02_switch_case.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 02_switch_case.php (zend + jit)

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

echo $acc, "\n";
