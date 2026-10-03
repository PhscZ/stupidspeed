// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 09_fib_recursive.js

function fib(n) {
  if (n < 2) return n;
  return fib(n - 1) + fib(n - 2);
}

print(fib(40));
