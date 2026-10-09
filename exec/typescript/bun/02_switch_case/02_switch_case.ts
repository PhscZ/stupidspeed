// task 02 switch_case — expected output: 7500000075000000
// build: none    run: bun 02_switch_case.ts | deno run 02_switch_case.ts

const __t0: number = performance.now();

const LIMIT: number = 100000000;

let acc: number = 0;
for (let i: number = 0; i < LIMIT; i++) {
  switch (i % 4) {
    case 0:
      acc += 1;
      break;
    case 1:
      acc += i;
      break;
    case 2:
      acc += 2 * i;
      break;
    case 3:
      acc += 3 * i;
      break;
  }
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(acc);
