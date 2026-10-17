<?php
// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: php 09_fib_recursive.php (zend) | php -d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M 09_fib_recursive.php (zend + jit)
// note: `-d opcache.jit=tracing` is required here. PHP 8.5 changed the default of
//       `opcache.jit` to `disable`, so the older `-d opcache.jit_buffer_size=64M`
//       alone leaves the JIT off (opcache_get_status() reports jit.on=false and
//       buffer_size=0) and the row would measure only opcache bytecode caching.

$__t0 = hrtime(true);
function fib(int $n): int
{
    if ($n < 2) {
        return $n;
    }
    return fib($n - 1) + fib($n - 2);
}

$__result = fib(40);
$__t1 = hrtime(true);
fwrite(STDERR, sprintf("TIME_MS=%.3f\n", ($__t1 - $__t0) / 1e6));
echo $__result, "\n";
