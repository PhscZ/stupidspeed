// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 08_average.js

var __t0 = performance.now();
var total = 0.0;
for (var i = 0; i < 100000000; i++) {
  var reading = (i % 256) / 256.0;
  total += reading;
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(total / 100000000);
