<?php
// task 12 matrix_add — expected output: 999000000
// build: none (interpreted)    run: php 12_matrix_add.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 12_matrix_add.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.
// SplFixedArray packs a million elements into 16 bytes each; a plain PHP array would cost
// several times that. Flat indexing with i * n + j, as the spec allows.

$__t0 = hrtime(true);
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

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo $total, "\n";
