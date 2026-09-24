// task 15 file_write — expected output: 104857600
// build: none    run: node 15_file_write.js | bun 15_file_write.js | deno run --allow-write 15_file_write.js

const fs = require('node:fs');

const CHUNK = 1048576;
const buf = new Uint8Array(CHUNK);
for (let i = 0; i < CHUNK; i++) {
  buf[i] = i % 256;
}

const fd = fs.openSync('out.bin', 'w');
let written = 0;
for (let pass = 0; pass < 100; pass++) {
  let offset = 0;
  while (offset < CHUNK) {
    const bytes = fs.writeSync(fd, buf, offset, CHUNK - offset, null);
    offset += bytes;
    written += bytes;
  }
}
fs.fsyncSync(fd);
fs.closeSync(fd);

console.log(written);
