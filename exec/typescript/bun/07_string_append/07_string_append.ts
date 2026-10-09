// task 07 string_append — expected output: 250000
// build: none    run: bun 07_string_append.ts | deno run 07_string_append.ts

const __t0: number = performance.now();

const ITERATIONS: number = 250000;

let text: string = "";
for (let i: number = 0; i < ITERATIONS; i++) {
  text = text + "x";
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(text.length);
