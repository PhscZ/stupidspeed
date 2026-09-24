// task 05 alloc_churn — expected output: 1274991808
// build: none    run: node 05_alloc_churn.js | bun 05_alloc_churn.js | deno run 05_alloc_churn.js

let total = 0;
const slots = new Array(256);
for (let i = 0; i < 10000000; i++) {
  const buf = new Uint8Array(64);
  buf[0] = i % 256;
  total += buf[0];
  slots[i % 256] = buf;
}
console.log(total);
