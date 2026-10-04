// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: qjs.exe --std 01_branches.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> is written to
//         stderr with std.err.puts and stdout carries only the answer.
// note: QuickJS-ng has no `std`/`os` globals — they are ES modules and must be imported
//       (the module specifier is `qjs:std`). The interpreter is a bytecode interpreter
//       with no inliner, so every iteration of the loop really runs.

import * as std from "qjs:std";

const __t0 = performance.now();

let a = 0, b = 0, c = 0, d = 0;
for (let i = 0; i < 100000000; i++) {
    if (i % 3 === 0) {
        a += 1;
    } else if (i % 5 === 0) {
        b += 1;
    } else if (i % 7 === 0) {
        c += 1;
    } else {
        d += 1;
    }
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(a + " " + b + " " + c + " " + d + "\n");
