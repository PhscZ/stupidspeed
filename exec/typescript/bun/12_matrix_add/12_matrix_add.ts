// task 12 matrix_add — expected output: 999000000
// build: none    run: bun 12_matrix_add.ts | deno run 12_matrix_add.ts

const __t0: number = performance.now();

const n: number = 1000;
const size: number = n * n;

const A: Int32Array = new Int32Array(size);
const B: Int32Array = new Int32Array(size);
const C: Int32Array = new Int32Array(size);

for (let i: number = 0; i < n; i++) {
  for (let j: number = 0; j < n; j++) {
    A[i * n + j] = i + j;
    B[i * n + j] = i - j;
  }
}

for (let idx: number = 0; idx < size; idx++) {
  C[idx] = A[idx] + B[idx];
}

let sum: number = 0;
for (let idx: number = 0; idx < size; idx++) {
  sum += C[idx];
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(sum);
