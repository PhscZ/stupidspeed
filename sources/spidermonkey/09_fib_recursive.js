// task 09 fib_recursive — expected output: 102334155
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 09_fib_recursive.js

var __t0 = performance.now();
function fib(n) {
  if (n < 2) return n;
  return fib(n - 1) + fib(n - 2);
}

var __answer = fib(40);
printErr("TIME_MS=" + (performance.now() - __t0));
print(__answer);
