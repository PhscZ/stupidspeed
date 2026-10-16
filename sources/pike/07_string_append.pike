// task 07 string_append — expected output: 750000
// build: none (interpreted)    run: pike 07_string_append.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
// Pike strings are immutable, so every append copies the whole string.  (String.Buffer is
// the type a Pike programmer would use for this; the task measures the plain append.)

int main() {
    int __t0 = gethrtime(1);
    string text = "";

    for (int i = 0; i < 750000; i++) {
        text = text + "x";
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", sizeof(text));
    return 0;
}
