// task 06 char_count — expected output: 10000000
// build: none (interpreted)    run: qjs.exe --std 06_char_count.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: the 100 MB text is built once by repeating the whole ten-character block
//       (String.prototype.repeat), never by appending in a loop, so the build is not the
//       benchmark. The scan walks it one character at a time with charCodeAt; QuickJS
//       keeps an ASCII string like this as one byte per character.

import * as std from "qjs:std";

const __t0 = performance.now();

const text = "abcdefghij".repeat(10000000);

let count = 0;
for (let i = 0; i < text.length; i++) {
    const ch = text.charCodeAt(i);
    if (ch === 97) {          // 'a': skip
    } else if (ch === 101) {  // 'e': skip
    } else if (ch === 104) {  // 'h': count
        count += 1;
    }
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(count + "\n");
