// task 03 func_sum — expected output: 400000000
// build: none (interpreted)    run: pike 03_func_sum.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
// Pike has no no-inline marker, and an interpreted function call cannot be promised to stay
// a call, so nothing here forces the call to happen; the loop is what makes it 100M calls.

int add_one(int n) {
    return n + 1;
}

int main() {
    int __t0 = gethrtime(1);
    int value = 0;

    for (int i = 0; i < 400000000; i++) {
        value = add_one(value);
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", value);
    return 0;
}
