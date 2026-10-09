// task 05 alloc_churn — expected output: 1274991808
// build: none    run: bun 05_alloc_churn.ts | deno run 05_alloc_churn.ts

const __t0: number = performance.now();

const ITERATIONS: number = 10000000;

let total: number = 0;
const slots: Uint8Array[] = new Array(256);
for (let i: number = 0; i < ITERATIONS; i++) {
  const buf: Uint8Array = new Uint8Array(64);
  buf[0] = i % 256;
  total += buf[0];
  slots[i % 256] = buf;
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(total);
