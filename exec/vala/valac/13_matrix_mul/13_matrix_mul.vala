// task 13 matrix_mul — expected output: 599995000
// build: valac -X -O2 -o prog 13_matrix_mul.vala    run: ./prog
// note: build from the MSYS2 UCRT64 shell (tools/msys2.cmd, MSYSTEM=UCRT64). valac translates
//       the Vala to C and drives gcc, and -X -O2 is what hands -O2 to that gcc; without it
//       the generated C is compiled unoptimised.
// note: the binary calls GLib, so it needs the UCRT64 runtime DLLs on PATH when it runs —
//       C:\stupidspeed\tools\msys64\msys64\ucrt64\bin holds libglib-2.0-0.dll (and
//       libgobject-2.0-0.dll for task 10). The Objective-C row needs the GNUstep DLLs from
//       the same directory, so this is the same shape.
// note: plain i, j, k triple loop, in that order, on three flat row-major `int64[]` arrays of
//       250000 elements each. Reordering the loops would be faster, which is the point.

// timing: GLib.get_real_time() is GLib's monotonic clock in microseconds; TIME_MS goes
//         to stderr and stdout is unchanged.
static int64 ss_t0;
static void ss_report () {
    stderr.printf ("TIME_MS=%.3f\n", (GLib.get_real_time () - ss_t0) / 1000.0);
}

int main () {
    ss_t0 = GLib.get_real_time ();
    int64 n = 500;
    int64 elems = n * n;

    int64[] A = new int64[elems];
    int64[] B = new int64[elems];
    int64[] C = new int64[elems];

    for (int64 i = 0; i < n; i++) {
        for (int64 j = 0; j < n; j++) {
            A[i * n + j] = (i + j) % 7;
            B[i * n + j] = (i * j) % 5;
        }
    }

    for (int64 i = 0; i < n; i++) {
        for (int64 j = 0; j < n; j++) {
            int64 sum = 0;
            for (int64 k = 0; k < n; k++) {
                sum += A[i * n + k] * B[k * n + j];
            }
            C[i * n + j] = sum;
        }
    }

    int64 total = 0;
    for (int64 k = 0; k < elems; k++) {
        total += C[k];
    }

    ss_report ();
    stdout.printf ("%lld\n", total);
    return 0;
}
