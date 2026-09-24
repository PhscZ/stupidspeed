<?php
// task 04 array_sum — expected output: 499999500000
// build: none (interpreted)    run: php 04_array_sum.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 04_array_sum.php (zend + jit)

$n = 1000000;

$array = array_fill(0, $n, 0);
for ($i = 0; $i < $n; $i++) {
    $array[$i] = $i;
}

$total = 0;
for ($i = 0; $i < $n; $i++) {
    $total += $array[$i];
}

echo $total, "\n";
