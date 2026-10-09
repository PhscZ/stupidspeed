// task 08 average — expected output: 0.498046875
// build: none    run: bun 08_average.ts | deno run 08_average.ts

const __t0: number = performance.now();

const SAMPLES: number = 100000000;

let total: number = 0.0;
for (let i: number = 0; i < SAMPLES; i++) {
  const reading: number = (i % 256) / 256.0;
  total += reading;
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(total / SAMPLES);
