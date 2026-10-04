// task 03 func_sum — expected output: 100000000
// build: none (interpreted)    run: qjs.exe --std 03_func_sum.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: no no-inline marker is needed and no separate file is used, because QuickJS-ng
//       0.11.0 is a plain bytecode interpreter with no JIT and no inliner — a call to a
//       plain function is a real call in every one of the 100,000,000 iterations.

import * as std from "qjs:std";

const __t0 = performance.now();

function addOne(n) {
    return n + 1;
}

let value = 0;
for (let i = 0; i < 100000000; i++) {
    value = addOne(value);
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(value + "\n");
