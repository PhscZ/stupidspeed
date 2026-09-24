// task 06 char_count — expected output: 10000000
// build: none    run: node main.js | bun main.js | deno run main.js

const text = 'abcdefghij'.repeat(10000000);
let count = 0;
for (let i = 0; i < text.length; i++) {
  const ch = text.charCodeAt(i);
  if (ch === 97) continue; // 'a'
  else if (ch === 101) continue; // 'e'
  else if (ch === 104) count += 1; // 'h'
}
console.log(count);
