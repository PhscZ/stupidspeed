// task 07 string_append — expected output: 250000
// build: none    run: bun 07_string_append.js | deno run 07_string_append.js

const __t0 = performance.now();

let text = '';
for (let i = 0; i < 250000; i++) {
  text = text + 'x';
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(text.length);
