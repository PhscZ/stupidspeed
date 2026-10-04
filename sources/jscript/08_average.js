// task 08 average — expected output: 0.498046875
// build: none (interpreted)    run: cscript //nologo //E:JScript 08_average.js
// note: (i % 256) / 256.0 is the same expression the C row evaluates. Every reading is
//       a multiple of 1/256 and the running total never passes 5 * 10^7, so every
//       partial sum is exact in binary and the answer does not depend on the order of
//       the additions.
// note: String(0.498046875) prints "0.498046875": Number.prototype.toString always uses
//       a period whatever the machine locale is, so unlike the VBScript row this needs
//       no hand-written Fixed9. The value is exactly representable as a double, so the
//       shortest decimal that round-trips is the exact one.
// note: 100000000 iterations measure 26 s to 101 s on this shared host, about 0.26 us to
//       1.0 us an iteration (fastest 25.7 s, slowest 101.1 s).

// timing: new Date().getTime() is the WSH clock in milliseconds (the system timer, so about
//         15 ms resolution); TIME_MS goes to stderr with WScript.StdErr and stdout is unchanged.
var ssT0 = new Date().getTime();
function ssReport() {
    WScript.StdErr.Write("TIME_MS=" + (new Date().getTime() - ssT0) + "\r\n");
}
var total = 0.0, i, reading;

for (i = 0; i < 100000000; i++) {
    reading = (i % 256) / 256.0;
    total += reading;
}

ssReport();
WScript.Echo(String(total / 100000000.0));
