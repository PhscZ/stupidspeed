<?php
// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: php main.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M main.php (zend + jit)
// Every reading is a multiple of 1/256 and the total stays under 2^53, so the sum is exact.
// PHP prints floats with precision=14, which gives the 9 significant digits of 0.498046875.

$total = 0.0;

for ($i = 0; $i < 100000000; $i++) {
    $reading = ($i % 256) / 256.0;
    $total += $reading;
}

echo $total / 100000000, "\n";
