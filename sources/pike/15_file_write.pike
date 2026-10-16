// task 15 file_write — expected output: 419430400
// build: none (interpreted)    run: pike 15_file_write.pike (Pike 8.0.1956 win32)
// Pike compiles the program to its own bytecode every time it is started, but that compile
// runs before the first statement of the program, so it is outside the measured region --
// exactly as in the lua row, where the timer is the first executed statement.  What the
// timer brackets is the task's own work and nothing else.  The interpreter is the official
// Pike 8.0.1956 win32 MSI build plus the four-byte CPUID stack fix in
// tools/pike/patch_pike.py; see exec/pike/build_all.bat.
// Buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 50 times per pass
// over 8 passes, each pass reopening out.bin at offset 0.
// Stdio.File in this build exposes neither sync() nor flush() -- the C class is compiled
// without an fsync wrapper on Windows -- so the file is closed, which flushes it.

int write_all(object f, string data) {
    int off = 0;
    int len = sizeof(data);
    while (off < len) {
        int n = f->write(data[off..]);
        if (n <= 0) {
            return off;
        }
        off = off + n;
    }
    return off;
}

int main() {
    int __t0 = gethrtime(1);
    string part = "";
    for (int i = 0; i < 256; i++) {
        part = part + sprintf("%c", i);
    }
    string buf = part * 4096;

    int written = 0;
    for (int pass = 0; pass < 8; pass++) {
        object f = Stdio.File("out.bin", "wcb");
        for (int i = 0; i < 50; i++) {
            written = written + write_all(f, buf);
        }
        f->close();
    }

    int __t1 = gethrtime(1);
    // gethrtime() alone counts microseconds; gethrtime(1) counts nanoseconds, which is what
    // its own documentation says and what System.REAL_TIME_RESOLUTION=100 here allows.
    werror("TIME_MS=%.3f\n", (__t1 - __t0) / 1000000.0);
    write("%d\n", written);
    return 0;
}
