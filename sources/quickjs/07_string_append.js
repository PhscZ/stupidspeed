// task 07 string_append — expected output: 250000
// build: none (interpreted)    run: qjs.exe --std 07_string_append.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: 250,000 appends, as the spec requires. QuickJS strings are immutable, so
//       `text + "x"` builds a new string; the interpreter keeps ropes for short operands,
//       which is exactly the property this task probes.

import * as std from "qjs:std";

const __t0 = performance.now();

let text = "";
for (let i = 0; i < 250000; i++) {
    text = text + "x";
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(text.length + "\n");
