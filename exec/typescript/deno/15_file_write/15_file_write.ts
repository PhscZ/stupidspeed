// task 15 file_write — expected output: 52428800
// build: none    run: bun 15_file_write.ts | deno run --allow-write 15_file_write.ts

const __t0: number = performance.now();

import * as fs from "node:fs";

const CHUNK: number = 1048576;
const PASSES: number = 50;
const buf: Uint8Array = new Uint8Array(CHUNK);
for (let i: number = 0; i < CHUNK; i++) {
  buf[i] = i % 256;
}

const fd: number = fs.openSync("out.bin", "w");
let written: number = 0;
for (let pass: number = 0; pass < PASSES; pass++) {
  let offset: number = 0;
  while (offset < CHUNK) {
    const bytes: number = fs.writeSync(fd, buf, offset, CHUNK - offset, null);
    offset += bytes;
    written += bytes;
  }
}
fs.fsyncSync(fd);
fs.closeSync(fd);

console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(written);
