// task 07 string_append — expected output: 1000000
// build: none    run: node 07_string_append.js | bun 07_string_append.js | deno run 07_string_append.js

let text = '';
for (let i = 0; i < 1000000; i++) {
  text = text + 'x';
}
console.log(text.length);
