<?php
// task 05 alloc_churn — expected output: 1274991808
// build: none (interpreted)    run: php 05_alloc_churn.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 05_alloc_churn.php (zend + jit)
// A PHP string is a mutable byte array, so each iteration allocates one 64-byte buffer;
// the slot store keeps it reachable and drops the buffer it replaces.

$total = 0;
$slots = array_fill(0, 256, '');

for ($i = 0; $i < 10000000; $i++) {
    $buf = str_repeat("\0", 64);
    $buf[0] = chr($i & 255);
    $total += ord($buf[0]);
    $slots[$i & 255] = $buf;
}

echo $total, "\n";
