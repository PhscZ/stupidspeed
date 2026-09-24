<?php
// task 12 matrix_add — expected output: 999000000
// build: none (interpreted)    run: php 12_matrix_add.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 12_matrix_add.php (zend + jit)
// SplFixedArray packs a million elements into 16 bytes each; a plain PHP array would cost
// several times that. Flat indexing with i * n + j, as the spec allows.

$n = 1000;
$size = $n * $n;

$a = new SplFixedArray($size);
$b = new SplFixedArray($size);
$c = new SplFixedArray($size);

for ($i = 0; $i < $n; $i++) {
    for ($j = 0; $j < $n; $j++) {
        $idx = $i * $n + $j;
        $a[$idx] = $i + $j;
        $b[$idx] = $i - $j;
    }
}

for ($idx = 0; $idx < $size; $idx++) {
    $c[$idx] = $a[$idx] + $b[$idx];
}

$total = 0;
for ($idx = 0; $idx < $size; $idx++) {
    $total += $c[$idx];
}

echo $total, "\n";
