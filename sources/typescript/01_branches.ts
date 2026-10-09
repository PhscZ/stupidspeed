// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none    run: bun 01_branches.ts | deno run 01_branches.ts

const __t0: number = performance.now();

const LIMIT: number = 100000000;

let a: number = 0;
let b: number = 0;
let c: number = 0;
let d: number = 0;
for (let i: number = 0; i < LIMIT; i++) {
  if (i % 3 === 0) {
    a += 1;
  } else if (i % 5 === 0) {
    b += 1;
  } else if (i % 7 === 0) {
    c += 1;
  } else {
    d += 1;
  }
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(a, b, c, d);
