// task 14 file_read — expected output: 2389704704
// build: none (interpreted)    run: qjs.exe --std 14_file_read.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: data.bin (50 MiB: the bytes 0..255 repeating) must sit in the working directory.
//       std.open(path,"rb") gives a binary FILE; read() fills a Uint8Array's ArrayBuffer
//       and returns the byte count, so NUL bytes survive (a string-based reader would not).
//       Read in 1 MiB chunks and sum every raw byte.

import * as std from "qjs:std";

const __t0 = performance.now();

const CHUNK = 1048576;
const buf = new Uint8Array(CHUNK);
const f = std.open("data.bin", "rb");

let total = 0;
for (;;) {
    const n = f.read(buf.buffer, 0, CHUNK);
    if (n <= 0) {
        break;
    }
    for (let i = 0; i < n; i++) {
        total += buf[i];
    }
}
f.close();

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts((total % 4294967296) + "\n");
