// task 13 matrix_mul — expected output: 599995000
// build: none (interpreted)    run: pike 13_matrix_mul.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.

int main() {
    int __t0 = gethrtime(1);
    int n = 500;
    array(array(int)) a = allocate(n);
    array(array(int)) b = allocate(n);

    for (int i = 0; i < n; i++) {
        array(int) ra = allocate(n);
        array(int) rb = allocate(n);
        for (int j = 0; j < n; j++) {
            ra[j] = (i + j) % 7;
            rb[j] = (i * j) % 5;
        }
        a[i] = ra;
        b[i] = rb;
    }

    int total = 0;
    for (int i = 0; i < n; i++) {
        array(int) ra = a[i];
        for (int j = 0; j < n; j++) {
            int sum = 0;
            for (int k = 0; k < n; k++) {
                sum = sum + ra[k] * b[k][j];
            }
            total = total + sum;
        }
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", total);
    return 0;
}
