// task 04 array_sum — expected output: 599999940000000
// build: none    run: bun 04_array_sum.js | deno run 04_array_sum.js

const __t0 = performance.now();

const n = 10000000;
const array = new Int32Array(n);
for (let i = 0; i < n; i++) {
  array[i] = i;
}

let total = 0;
for (let pass = 0; pass < 12; pass++) {
  for (let i = 0; i < n; i++) {
    total += array[i];
  }
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(total);
