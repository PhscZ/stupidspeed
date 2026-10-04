// task 02 switch_case — expected output: 7500000075000000
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 02_switch_case.js

var __t0 = performance.now();
var acc = 0;
for (var i = 0; i < 100000000; i++) {
  switch (i % 4) {
    case 0:
      acc += 1;
      break;
    case 1:
      acc += i;
      break;
    case 2:
      acc += 2 * i;
      break;
    case 3:
      acc += 3 * i;
      break;
  }
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(acc);
