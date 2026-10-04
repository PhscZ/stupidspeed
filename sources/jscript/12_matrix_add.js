// task 12 matrix_add — expected output: 999000000
// build: none (interpreted)    run: cscript //nologo //E:JScript 12_matrix_add.js
// note: JScript has no two-dimensional array type, only arrays of arrays, so the three
//       matrices are three flat 1000000-element arrays indexed i * n + j, which is the
//       same layout the C row uses.
// note: each array is allocated at full length and pre-filled with 0, so it is dense
//       from the start: a JScript array that has never been written is sparse, and a
//       hole reads back as undefined. The VBScript row's fixed-size Dim does the same
//       pre-fill.
// note: the running total is a double from the start; 999000000 is below 2^53 and
//       String() prints it as plain digits.
// note: the whole task measures 1.8 s to 5.3 s on this shared host.

// timing: new Date().getTime() is the WSH clock in milliseconds (the system timer, so about
//         15 ms resolution); TIME_MS goes to stderr with WScript.StdErr and stdout is unchanged.
var ssT0 = new Date().getTime();
function ssReport() {
    WScript.StdErr.Write("TIME_MS=" + (new Date().getTime() - ssT0) + "\r\n");
}
var n = 1000, N = 1000000, A, B, C, i, j, k, total = 0;

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
        A[i * n + j] = i + j;
        B[i * n + j] = i - j;
    }
}

for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
        C[i * n + j] = A[i * n + j] + B[i * n + j];
    }
}

for (k = 0; k < N; k++) {
    total += C[k];
}

ssReport();
WScript.Echo(String(total));
