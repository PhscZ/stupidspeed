// task 04 array_sum — expected output: 499999500000
// build: none    run: bun 04_array_sum.ts | deno run 04_array_sum.ts

const __t0: number = performance.now();

/** A flat, 32-bit-wide integer buffer — the only array shape this row needs. */
type IntBuffer = Int32Array;

const n: number = 1000000;
const array: IntBuffer = new Int32Array(n);
for (let i: number = 0; i < n; i++) {
  array[i] = i;
}

let total: number = 0;
for (let i: number = 0; i < n; i++) {
  total += array[i];
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(total);
