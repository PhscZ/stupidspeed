// task 02 switch_case — expected output: 8748000081000000
// build: none (interpreted)    run: pike 02_switch_case.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.

int main() {
    int __t0 = gethrtime(1);
    int acc = 0;

    for (int i = 0; i < 108000000; i++) {
        switch (i % 4) {
            case 0:
                acc = acc + 1;
                break;
            case 1:
                acc = acc + i;
                break;
            case 2:
                acc = acc + 2 * i;
                break;
            case 3:
                acc = acc + 3 * i;
                break;
        }
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", acc);
    return 0;
}
