// task 14 file_read — expected output: 484442112
// build: none    run: node 14_file_read.js | bun 14_file_read.js | deno run --allow-read 14_file_read.js

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

console.log(total % 4294967296);
