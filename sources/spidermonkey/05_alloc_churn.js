// task 05 alloc_churn — expected output: 1274991808
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 05_alloc_churn.js

var __t0 = performance.now();
var total = 0;
var slots = new Array(256);
for (var i = 0; i < 10000000; i++) {
  var buf = new Uint8Array(64);
  buf[0] = i % 256;
  total += buf[0];
  slots[i % 256] = buf;   /* keeping buf reachable stops the JIT deleting the allocation */
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(total);
