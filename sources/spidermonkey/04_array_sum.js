// task 04 array_sum — expected output: 499999500000
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 04_array_sum.js

var __t0 = performance.now();
var n = 1000000;
var array = new Int32Array(n);
for (var i = 0; i < n; i++) {
  array[i] = i;
}

var total = 0;
for (var i = 0; i < n; i++) {
  total += array[i];
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(total);
