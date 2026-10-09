// task 09 fib_recursive — expected output: 102334155
// build: none    run: bun 09_fib_recursive.ts | deno run 09_fib_recursive.ts

const __t0: number = performance.now();

function fib(n: number): number {
  if (n < 2) return n;
  return fib(n - 1) + fib(n - 2);
}

const __answer: number = fib(40);
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(__answer);
