// task 12 matrix_add — expected output: 63984000000
// build: none (interpreted)    run: pike 12_matrix_add.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
// A Pike matrix is an array of rows, each row an array(int) of n values.

int main() {
    int __t0 = gethrtime(1);
    int n = 4000;
    array(array(int)) a = allocate(n);
    array(array(int)) b = allocate(n);
    array(array(int)) c = allocate(n);

    for (int i = 0; i < n; i++) {
        array(int) ra = allocate(n);
        array(int) rb = allocate(n);
        for (int j = 0; j < n; j++) {
            ra[j] = i + j;
            rb[j] = i - j;
        }
        a[i] = ra;
        b[i] = rb;
    }

    for (int i = 0; i < n; i++) {
        array(int) ra = a[i];
        array(int) rb = b[i];
        array(int) rc = allocate(n);
        for (int j = 0; j < n; j++) {
            rc[j] = ra[j] + rb[j];
        }
        c[i] = rc;
    }

    int total = 0;
    for (int i = 0; i < n; i++) {
        array(int) rc = c[i];
        for (int j = 0; j < n; j++) {
            total = total + rc[j];
        }
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", total);
    return 0;
}
