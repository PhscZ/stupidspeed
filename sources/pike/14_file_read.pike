// task 14 file_read — expected output: 1937768448
// build: none (interpreted)    run: pike 14_file_read.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
// data.bin (50 MiB: the bytes 0..255 repeating) must sit in the working directory.
// Read in 1 MiB chunks, eight times over (reopened for each pass), then scan every byte;
// indexing a Pike string yields the byte.

int main() {
    int __t0 = gethrtime(1);
    int total = 0;

    for (int pass = 0; pass < 8; pass++) {
        object f = Stdio.File("data.bin", "rb");

        while (1) {
            string chunk = f->read(1048576);
            // read() returns "" at end of file, and in Pike only 0 and 0.0 are false -- an empty
            // string is true -- so the end has to be tested on the length, not on the value.
            if (sizeof(chunk) == 0) {
                break;
            }
            int len = sizeof(chunk);
            for (int i = 0; i < len; i++) {
                total = total + chunk[i];
            }
        }

        f->close();
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", total % 4294967296);
    return 0;
}
