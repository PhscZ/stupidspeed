// task 07 string_append — expected output: 1000000
// build: none    run: node main.js | bun main.js | deno run main.js

let text = '';
for (let i = 0; i < 1000000; i++) {
  text = text + 'x';
}
console.log(text.length);
