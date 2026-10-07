// task 02 switch_case — expected output: 7500000075000000
// build: none (interpreted)    run: qjs.exe --std 02_switch_case.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: this is a real `switch` statement, so the interpreter's own dispatch is measured.
//       The total is 7.5e15, below 2^53 (9.007e15), so it is exact in a double and
//       Number.prototype.toString prints all 16 digits without exponent notation.

import * as std from "qjs:std";

const __t0 = performance.now();

let acc = 0;
for (let i = 0; i < 100000000; i++) {
    switch (i % 4) {
        case 0:
            acc += 1;
            break;
        case 1:
            acc += i;
            break;
        case 2:
            acc += 2 * i;
            break;
        default:
            acc += 3 * i;
            break;
    }
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(acc + "\n");
