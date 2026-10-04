// task 09 fib_recursive — expected output: 102334155
// build: none    run: node 09_fib_recursive.js | bun 09_fib_recursive.js | deno run 09_fib_recursive.js

const __t0 = performance.now();

function fib(n) {
  if (n < 2) return n;
  return fib(n - 1) + fib(n - 2);
}

const __answer = fib(40);
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(__answer);
