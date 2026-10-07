// task 06 char_count — expected output: 10000000
// build: none    run: node 06_char_count.js | bun 06_char_count.js | deno run 06_char_count.js

const __t0 = performance.now();

const text = 'abcdefghij'.repeat(10000000);
let count = 0;
for (let i = 0; i < text.length; i++) {
  const ch = text.charCodeAt(i);
  if (ch === 97) continue; // 'a'
  else if (ch === 101) continue; // 'e'
  else if (ch === 104) count += 1; // 'h'
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(count);
