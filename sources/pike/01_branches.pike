// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: pike 01_branches.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.

int main() {
    int __t0 = gethrtime(1);
    int a = 0, b = 0, c = 0, d = 0;

    for (int i = 0; i < 100000000; i++) {
        if (i % 3 == 0) {
            a = a + 1;
        } else if (i % 5 == 0) {
            b = b + 1;
        } else if (i % 7 == 0) {
            c = c + 1;
        } else {
            d = d + 1;
        }
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d %d %d %d\n", a, b, c, d);
    return 0;
}
