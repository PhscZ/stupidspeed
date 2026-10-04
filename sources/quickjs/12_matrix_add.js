// task 12 matrix_add — expected output: 999000000
// build: none (interpreted)    run: qjs.exe --std 12_matrix_add.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: A, B and C are flat Int32Array buffers indexed i*n+j, so each is one contiguous
//       eight-megabyte block — too big for cache, which is what the task measures.

import * as std from "qjs:std";

const __t0 = performance.now();

const n = 1000;
const size = n * n;
const A = new Int32Array(size);
const B = new Int32Array(size);
const C = new Int32Array(size);

for (let i = 0; i < n; i++) {
    const row = i * n;
    for (let j = 0; j < n; j++) {
        A[row + j] = i + j;
        B[row + j] = i - j;
    }
}

for (let p = 0; p < size; p++) {
    C[p] = A[p] + B[p];
}

let total = 0;
for (let p = 0; p < size; p++) {
    total += C[p];
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(total + "\n");
