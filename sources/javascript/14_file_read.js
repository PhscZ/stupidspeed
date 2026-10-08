// task 14 file_read — expected output: 2389704704
// build: none    run: bun 14_file_read.js | deno run --allow-read 14_file_read.js

const __t0 = performance.now();

const fs = require('node:fs');

const CHUNK = 1048576;
const buf = new Uint8Array(CHUNK);

const fd = fs.openSync('data.bin', 'r');
let total = 0;
for (;;) {
  const bytes = fs.readSync(fd, buf, 0, CHUNK, null);
  if (bytes === 0) break;
  for (let i = 0; i < bytes; i++) {
    total += buf[i];
  }
}
fs.closeSync(fd);

console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(total % 4294967296);
