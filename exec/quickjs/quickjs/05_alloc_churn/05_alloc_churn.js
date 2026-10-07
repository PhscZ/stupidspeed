// task 05 alloc_churn — expected output: 1274991808
// build: none (interpreted)    run: qjs.exe --std 05_alloc_churn.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: each iteration allocates a fresh 64-byte Uint8Array; the 256-slot array keeps it
//       reachable and drops the buffer it replaces, so the old one becomes garbage for
//       QuickJS's reference-counted collector.

import * as std from "qjs:std";

const __t0 = performance.now();

let total = 0;
const slots = new Array(256);
for (let i = 0; i < 10000000; i++) {
    const buf = new Uint8Array(64);
    buf[0] = i % 256;
    total += buf[0];
    slots[i % 256] = buf;
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(total + "\n");
