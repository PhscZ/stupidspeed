// task 13 matrix_mul — expected output: 599995000
// build: none    run: node main.js | bun main.js | deno run main.js

const n = 500;
const size = n * n;

const A = new Int32Array(size);
const B = new Int32Array(size);
const C = new Int32Array(size);

for (let i = 0; i < n; i++) {
  for (let j = 0; j < n; j++) {
    A[i * n + j] = (i + j) % 7;
    B[i * n + j] = (i * j) % 5;
  }
}

for (let i = 0; i < n; i++) {
  for (let j = 0; j < n; j++) {
    let sum = 0;
    for (let k = 0; k < n; k++) {
      sum += A[i * n + k] * B[k * n + j];
    }
    C[i * n + j] = sum;
  }
}

let total = 0;
for (let idx = 0; idx < size; idx++) {
  total += C[idx];
}
console.log(total);
