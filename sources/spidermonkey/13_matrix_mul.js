// task 13 matrix_mul — expected output: 599995000
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 13_matrix_mul.js

var n = 500;
var size = n * n;

var A = new Int32Array(size);
var B = new Int32Array(size);
var C = new Int32Array(size);

for (var i = 0; i < n; i++) {
  for (var j = 0; j < n; j++) {
    A[i * n + j] = (i + j) % 7;
    B[i * n + j] = (i * j) % 5;
  }
}

/* plain i, j, k triple loop, in that order */
for (var i2 = 0; i2 < n; i2++) {
  for (var j2 = 0; j2 < n; j2++) {
    var acc = 0;
    for (var k2 = 0; k2 < n; k2++) {
      acc += A[i2 * n + k2] * B[k2 * n + j2];
    }
    C[i2 * n + j2] = acc;
  }
}

var total = 0;
for (var idx = 0; idx < size; idx++) {
  total += C[idx];
}
print(total);
