// task 12 matrix_add — expected output: 999000000
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 12_matrix_add.js

var __t0 = performance.now();
var n = 1000;
var size = n * n;

var A = new Int32Array(size);
var B = new Int32Array(size);
var C = new Int32Array(size);

for (var i = 0; i < n; i++) {
  for (var j = 0; j < n; j++) {
    A[i * n + j] = i + j;
    B[i * n + j] = i - j;
  }
}

for (var idx = 0; idx < size; idx++) {
  C[idx] = A[idx] + B[idx];
}

var sum = 0;
for (var idx2 = 0; idx2 < size; idx2++) {
  sum += C[idx2];
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(sum);
