// task 05 alloc_churn — expected output: 6374991808
// build: none (interpreted)    run: pike 05_alloc_churn.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
// Pike strings are immutable, so the 64-byte buffer is built fresh each iteration with its
// first byte already in place, and read back through the string.  The slots array keeps it
// reachable and drops the buffer it replaces, as in the C version.

int main() {
    int __t0 = gethrtime(1);
    array slots = allocate(256);
    string zeros = "\0" * 63;
    int total = 0;

    for (int i = 0; i < 50000000; i++) {
        string buf = sprintf("%c", i % 256) + zeros;
        total = total + buf[0];
        slots[i % 256] = buf;
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", total);
    return 0;
}
