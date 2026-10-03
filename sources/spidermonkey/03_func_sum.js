// task 03 func_sum — expected output: 100000000
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 03_func_sum.js
// note: a plain function is the closest JavaScript has to a real call — the language has no
//       no-inline annotation, so the shell's JIT may inline it anyway, as the JavaScript row's
//       file already records.

function addOne(n) {
  return n + 1;
}

var value = 0;
for (var i = 0; i < 100000000; i++) {
  value = addOne(value);
}
print(value);
