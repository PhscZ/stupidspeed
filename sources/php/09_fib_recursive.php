<?php
// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: php 09_fib_recursive.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit_buffer_size=64M 09_fib_recursive.php (zend + jit)

function fib(int $n): int
{
    if ($n < 2) {
        return $n;
    }
    return fib($n - 1) + fib($n - 2);
}

echo fib(40), "\n";
