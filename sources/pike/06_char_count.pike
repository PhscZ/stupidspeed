// task 06 char_count — expected output: 25000000
// build: none (interpreted)    run: pike 06_char_count.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
// The 250 MB text is built once with string repetition, then scanned one character at a
// time; indexing a Pike string yields the character code as an int.

int main() {
    int __t0 = gethrtime(1);
    string text = "abcdefghij" * 25000000;
    int len = sizeof(text);
    int count = 0;

    for (int i = 0; i < len; i++) {
        int ch = text[i];
        if (ch == 'a') {
            continue;
        } else if (ch == 'e') {
            continue;
        } else if (ch == 'h') {
            count = count + 1;
        }
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", count);
    return 0;
}
