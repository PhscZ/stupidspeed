// task 04 array_sum — expected output: 599999940000000
// build: none (interpreted)    run: pike 04_array_sum.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.

int main() {
    int __t0 = gethrtime(1);
    array(int) values = allocate(10000000);

    for (int i = 0; i < 10000000; i++) {
        values[i] = i;
    }

    int total = 0;
    for (int r = 0; r < 12; r++) {
        for (int i = 0; i < 10000000; i++) {
            total = total + values[i];
        }
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", total);
    return 0;
}
