// task 09 fib_recursive — expected output: 102334155
// build: none    run: node 09_fib_recursive.js | bun 09_fib_recursive.js | deno run 09_fib_recursive.js

function fib(n) {
  if (n < 2) return n;
  return fib(n - 1) + fib(n - 2);
}

console.log(fib(40));
