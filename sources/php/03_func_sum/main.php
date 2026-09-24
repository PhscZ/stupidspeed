<?php
// task 03 func_sum — expected output: 100000000
// build: none (interpreted)    run: php main.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M main.php (zend + jit)
// opcache and the JIT may inline add_one; the loop still makes 100000000 calls either way.

function add_one(int $n): int
{
    return $n + 1;
}

$value = 0;

for ($i = 0; $i < 100000000; $i++) {
    $value = add_one($value);
}

echo $value, "\n";
