// task 13 matrix_mul — expected output: 599995000
// build: none    run: bun 13_matrix_mul.ts | deno run 13_matrix_mul.ts

const __t0: number = performance.now();

const n: number = 500;
const size: number = n * n;

const A: Int32Array = new Int32Array(size);
const B: Int32Array = new Int32Array(size);
const C: Int32Array = new Int32Array(size);

for (let i: number = 0; i < n; i++) {
  for (let j: number = 0; j < n; j++) {
    A[i * n + j] = (i + j) % 7;
    B[i * n + j] = (i * j) % 5;
  }
}

for (let i: number = 0; i < n; i++) {
  for (let j: number = 0; j < n; j++) {
    let sum: number = 0;
    for (let k: number = 0; k < n; k++) {
      sum += A[i * n + k] * B[k * n + j];
    }
    C[i * n + j] = sum;
  }
}

let total: number = 0;
for (let idx: number = 0; idx < size; idx++) {
  total += C[idx];
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(total);
