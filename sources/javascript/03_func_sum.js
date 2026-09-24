// task 03 func_sum — expected output: 100000000
// build: none    run: node 03_func_sum.js | bun 03_func_sum.js | deno run 03_func_sum.js
// note: a plain function is the closest JS equivalent; V8 will inline addOne anyway.

function addOne(n) {
  return n + 1;
}

let value = 0;
for (let i = 0; i < 100000000; i++) {
  value = addOne(value);
}
console.log(value);
