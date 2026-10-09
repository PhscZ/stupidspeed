// task 14 file_read — expected output: 2389704704
// build: none    run: bun 14_file_read.ts | deno run --allow-read 14_file_read.ts

const __t0: number = performance.now();

import * as fs from "node:fs";

const CHUNK: number = 1048576;
const buf: Uint8Array = new Uint8Array(CHUNK);

const fd: number = fs.openSync("data.bin", "r");
let total: number = 0;
for (;;) {
  const bytes: number = fs.readSync(fd, buf, 0, CHUNK, null);
  if (bytes === 0) break;
  for (let i: number = 0; i < bytes; i++) {
    total += buf[i];
  }
}
fs.closeSync(fd);

console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(total % 4294967296);
