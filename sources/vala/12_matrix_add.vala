// task 12 matrix_add — expected output: 999000000
// build: valac -X -O2 -o prog 12_matrix_add.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: three flat `int64[]` arrays of a million elements each — eight megabytes apiece, too
//       big for cache, so this measures memory traffic. Row-major indexing, as in the
//       reference: A[i * n + j]. Negative B entries are fine, the sum of C is positive.

int main () {
    int64 n = 1000;
    int64 elems = n * n;

    int64[] A = new int64[elems];
    int64[] B = new int64[elems];
    int64[] C = new int64[elems];

    for (int64 i = 0; i < n; i++) {
        for (int64 j = 0; j < n; j++) {
            A[i * n + j] = i + j;
            B[i * n + j] = i - j;
        }
    }

    for (int64 i = 0; i < n; i++) {
        for (int64 j = 0; j < n; j++) {
            C[i * n + j] = A[i * n + j] + B[i * n + j];
        }
    }

    int64 total = 0;
    for (int64 k = 0; k < elems; k++) {
        total += C[k];
    }

    stdout.printf ("%lld\n", total);
    return 0;
}
