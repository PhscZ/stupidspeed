<?php
// task 03 func_sum — expected output: 100000000
// build: none (interpreted)    run: php 03_func_sum.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 03_func_sum.php (zend + jit)
// opcache and the JIT may inline add_one; the loop still makes 100000000 calls either way.

$__t0 = hrtime(true);
function add_one(int $n): int
{
    return $n + 1;
}

$value = 0;

for ($i = 0; $i < 100000000; $i++) {
    $value = add_one($value);
}

$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo $value, "\n";
