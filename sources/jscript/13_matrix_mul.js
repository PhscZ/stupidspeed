// task 13 matrix_mul — expected output: 599995000
// build: none (interpreted)    run: cscript //nologo //E:JScript 13_matrix_mul.js
// note: the matrices are flat 250000-element arrays indexed i * n + j, the layout the C
//       row uses; JScript has no two-dimensional array type. Each is pre-filled with 0
//       so that it is dense rather than sparse.
// note: the loop order is the plain i, j, k the spec asks for, so B is walked down a
//       column at a time. Reordering it would be faster and that is the point of the
//       task, so it is left alone.
// note: each element of C is a sum of 500 terms of at most 6 * 4 = 24, so it is small;
//       the grand total, 599995000, is far below 2^53, so every value is exact.
// note: the whole task measures 73 s to 303 s on this shared host, about 0.59 us to 2.4 us
//       for each of the 125 million inner iterations (fastest 73.4 s, slowest 303.1 s).

// timing: new Date().getTime() is the WSH clock in milliseconds (the system timer, so about
//         15 ms resolution); TIME_MS goes to stderr with WScript.StdErr and stdout is unchanged.
var ssT0 = new Date().getTime();
function ssReport() {
    WScript.StdErr.Write("TIME_MS=" + (new Date().getTime() - ssT0) + "\r\n");
}
var n = 500, N = 250000, A, B, C, i, j, k, sum, total = 0;

A = new Array(N);
B = new Array(N);
C = new Array(N);

for (k = 0; k < N; k++) {
    A[k] = 0;
    B[k] = 0;
    C[k] = 0;
}

for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
        A[i * n + j] = (i + j) % 7;
        B[i * n + j] = (i * j) % 5;
    }
}

for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
        sum = 0;
        for (k = 0; k < n; k++) {
            sum += A[i * n + k] * B[k * n + j];
        }
        C[i * n + j] = sum;
    }
}

for (k = 0; k < N; k++) {
    total += C[k];
}

ssReport();
WScript.Echo(String(total));
