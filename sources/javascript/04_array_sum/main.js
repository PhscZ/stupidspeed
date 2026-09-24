// task 04 array_sum — expected output: 499999500000
// build: none    run: node main.js | bun main.js | deno run main.js

const n = 1000000;
const array = new Int32Array(n);
for (let i = 0; i < n; i++) {
  array[i] = i;
}

let total = 0;
for (let i = 0; i < n; i++) {
  total += array[i];
}
console.log(total);
