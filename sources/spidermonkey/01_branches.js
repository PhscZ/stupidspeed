// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 01_branches.js

var __t0 = performance.now();
var a = 0;
var b = 0;
var c = 0;
var d = 0;
for (var i = 0; i < 100000000; i++) {
  if (i % 3 === 0) {
    a += 1;
  } else if (i % 5 === 0) {
    b += 1;
  } else if (i % 7 === 0) {
    c += 1;
  } else {
    d += 1;
  }
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(a, b, c, d);
