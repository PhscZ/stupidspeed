// task 12 matrix_add — expected output: 999000000
// build: none    run: node main.js | bun main.js | deno run main.js

const n = 1000;
const size = n * n;

const A = new Int32Array(size);
const B = new Int32Array(size);
const C = new Int32Array(size);

for (let i = 0; i < n; i++) {
  for (let j = 0; j < n; j++) {
    A[i * n + j] = i + j;
    B[i * n + j] = i - j;
  }
}

for (let idx = 0; idx < size; idx++) {
  C[idx] = A[idx] + B[idx];
}

let sum = 0;
for (let idx = 0; idx < size; idx++) {
  sum += C[idx];
}
console.log(sum);
