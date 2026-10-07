// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: qjs.exe --std 08_average.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: every reading is a multiple of 1/256 and the sum stays well below 2^53, so the
//       accumulation is exact in a double and the printed digits do not depend on the
//       order of the additions. 0.498046875 is exactly representable, so the default
//       Number-to-string conversion prints it in full.

import * as std from "qjs:std";

const __t0 = performance.now();

let total = 0.0;
for (let i = 0; i < 100000000; i++) {
    const reading = (i % 256) / 256.0;
    total = total + reading;
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts((total / 100000000) + "\n");
