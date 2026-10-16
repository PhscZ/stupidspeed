// task 04 array_sum — expected output: 599999940000000
// build: none (interpreted)    run: cscript //nologo //E:JScript 04_array_sum.js
// note: the array is a plain 10000000-element JScript array. A JScript array element is
//       a tagged value rather than the C row's 8-byte int64, so the storage is larger
//       than the C row's; it is still one contiguous block walked in order.
// note: total passes 2^31, but JScript numbers are doubles from the start, so there is
//       no overflow and no promotion step. 599999940000000 is below 2^53 and exact, and
//       String() prints it as plain digits.
// note: the whole task measures 10000000 indexed stores and twelve passes of 10000000
//       indexed reads, plus process start-up.

// timing: new Date().getTime() is the WSH clock in milliseconds (the system timer, so about
//         15 ms resolution); TIME_MS goes to stderr with WScript.StdErr and stdout is unchanged.
var ssT0 = new Date().getTime();
function ssReport() {
    WScript.StdErr.Write("TIME_MS=" + (new Date().getTime() - ssT0) + "\r\n");
}
var n = 10000000, arr = new Array(n), i, pass, total = 0;

for (i = 0; i < n; i++) {
    arr[i] = i;
}

for (pass = 0; pass < 12; pass++) {
    for (i = 0; i < n; i++) {
        total += arr[i];
    }
}

ssReport();
WScript.Echo(String(total));
