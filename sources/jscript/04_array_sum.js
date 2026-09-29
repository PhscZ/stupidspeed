// task 04 array_sum — expected output: 499999500000
// build: none (interpreted)    run: cscript //nologo //E:JScript 04_array_sum.js
// note: the array is a plain 1000000-element JScript array. A JScript array element is
//       a tagged value rather than the C row's 8-byte int64, so the storage is larger
//       than the C row's; it is still one contiguous block walked in order.
// note: total passes 2^31, but JScript numbers are doubles from the start, so there is
//       no overflow and no promotion step. 499999500000 is below 2^53 and exact, and
//       String() prints it as plain digits.
// note: the whole task measures 1.1 s to 5.3 s on this shared host: 1000000 indexed stores
//       and 1000000 indexed reads, plus process start-up.
var n = 1000000, arr = new Array(n), i, total = 0;

for (i = 0; i < n; i++) {
    arr[i] = i;
}

for (i = 0; i < n; i++) {
    total += arr[i];
}

WScript.Echo(String(total));
