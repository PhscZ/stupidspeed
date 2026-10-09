// task 06 char_count — expected output: 10000000
// build: none    run: bun 06_char_count.ts | deno run 06_char_count.ts

const __t0: number = performance.now();

const text: string = "abcdefghij".repeat(10000000);
let count: number = 0;
for (let i: number = 0; i < text.length; i++) {
  const ch: number = text.charCodeAt(i);
  if (ch === 97) continue; // 'a'
  else if (ch === 101) continue; // 'e'
  else if (ch === 104) count += 1; // 'h'
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(count);
