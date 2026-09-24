<?php
// task 13 matrix_mul — expected output: 599995000
// build: none (interpreted)    run: php main.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M main.php (zend + jit)
// SplFixedArray for the three 250000-element matrices, flat indexing i * n + j, and the plain
// i, j, k triple loop in that order — no reordering, no library multiply.

$n = 500;
$size = $n * $n;

$a = new SplFixedArray($size);
$b = new SplFixedArray($size);
$c = new SplFixedArray($size);

for ($i = 0; $i < $n; $i++) {
    for ($j = 0; $j < $n; $j++) {
        $idx = $i * $n + $j;
        $a[$idx] = ($i + $j) % 7;
        $b[$idx] = ($i * $j) % 5;
    }
}

for ($i = 0; $i < $n; $i++) {
    for ($j = 0; $j < $n; $j++) {
        $sum = 0;
        for ($k = 0; $k < $n; $k++) {
            $sum += $a[$i * $n + $k] * $b[$k * $n + $j];
        }
        $c[$i * $n + $j] = $sum;
    }
}

$total = 0;
for ($idx = 0; $idx < $size; $idx++) {
    $total += $c[$idx];
}

echo $total, "\n";
