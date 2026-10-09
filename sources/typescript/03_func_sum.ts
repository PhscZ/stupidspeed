// task 03 func_sum — expected output: 100000000
// build: none    run: bun 03_func_sum.ts | deno run 03_func_sum.ts
// note: a plain typed function is the closest equivalent; both engines inline addOne.

const __t0: number = performance.now();

const LIMIT: number = 100000000;

function addOne(n: number): number {
  return n + 1;
}

let value: number = 0;
for (let i: number = 0; i < LIMIT; i++) {
  value = addOne(value);
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(value);
