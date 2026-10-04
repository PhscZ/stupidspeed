// task 13 matrix_mul — expected output: 599995000
// build: none (interpreted)    run: qjs.exe --std 13_matrix_mul.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: plain i, j, k triple loop in that order, no reordering, on flat Int32Array
//       buffers indexed i*n+j. A holds 0..6 and B holds 0..4, so each of the 500
//       products is tiny and the 500-term sums stay exact in an int32 accumulator.

import * as std from "qjs:std";

const __t0 = performance.now();

const n = 500;
const size = n * n;
const A = new Int32Array(size);
const B = new Int32Array(size);
const C = new Int32Array(size);

for (let i = 0; i < n; i++) {
    const row = i * n;
    for (let j = 0; j < n; j++) {
        A[row + j] = (i + j) % 7;
        B[row + j] = (i * j) % 5;
    }
}

for (let i = 0; i < n; i++) {
    const row = i * n;
    for (let j = 0; j < n; j++) {
        let sum = 0;
        for (let k = 0; k < n; k++) {
            sum += A[row + k] * B[k * n + j];
        }
        C[row + j] = sum;
    }
}

let total = 0;
for (let p = 0; p < size; p++) {
    total += C[p];
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(total + "\n");
