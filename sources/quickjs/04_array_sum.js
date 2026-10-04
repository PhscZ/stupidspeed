// task 04 array_sum — expected output: 499999500000
// build: none (interpreted)    run: qjs.exe --std 04_array_sum.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: Int32Array is used so the million integers live in one contiguous block of
//       memory, which is what this task measures. The total (5e11) is below 2^53 and is
//       accumulated in an ordinary JS number, so it is exact.

import * as std from "qjs:std";

const __t0 = performance.now();

const n = 1000000;
const array = new Int32Array(n);

for (let i = 0; i < n; i++) {
    array[i] = i;
}

let total = 0;
for (let i = 0; i < n; i++) {
    total += array[i];
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(total + "\n");
