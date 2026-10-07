// task 15 file_write — expected output: 52428800
// build: none (interpreted)    run: qjs.exe --std 15_file_write.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: the buffer is the 1 MiB pattern 0,1,2,...,255 repeated 4096 times, written 50
//       times to out.bin. QuickJS's FILE has no fsync, so durability is obtained the way
//       the spec allows: flush() pushes the stdio buffer out and close() releases the
//       handle, which is the strongest flush the runtime offers.

import * as std from "qjs:std";

const __t0 = performance.now();

const CHUNK = 1048576;
const buf = new Uint8Array(CHUNK);
for (let i = 0; i < CHUNK; i++) {
    buf[i] = i % 256;
}

const f = std.open("out.bin", "wb");
let written = 0;
for (let pass = 0; pass < 50; pass++) {
    let off = 0;
    while (off < CHUNK) {
        const n = f.write(buf.buffer, off, CHUNK - off);
        if (n <= 0) {
            throw new Error("write failed: " + f.error());
        }
        off += n;
        written += n;
    }
}
f.flush();
f.close();

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(written + "\n");
