// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: qjs.exe --std 09_fib_recursive.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: naive fib(40), about 331 million calls; the interpreter has no tail-call
//       optimisation and none is wanted here — the call path itself is the benchmark.

import * as std from "qjs:std";

const __t0 = performance.now();

function fib(n) {
    if (n < 2) {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}

const result = fib(40);

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(result + "\n");
