// task 05 alloc_churn — expected output: 6374991808
// build: none (interpreted)    run: cscript //nologo //E:JScript 05_alloc_churn.js
// note: JScript has no byte buffer and no malloc, and this engine has no typed arrays
//       (typeof Uint8Array is undefined), so the allocation primitive is new Array(64),
//       a fresh 64-element array object per iteration, and buf[0] = i % 256 is the same
//       store the C row makes. A JScript array slot is a tagged value rather than a
//       byte, so 64 elements is not 64 bytes of memory; the VBScript row carries the
//       same disclosure for its 16-byte Variants.
// note: storing into slots keeps the buffer reachable and drops the one it replaces,
//       which is what makes the replaced array garbage for the engine's collector --
//       the same thing the C row's free(slots[slot]) does by hand.
// note: 50000000 iterations measure 65 s to 224 s on this shared host, about 1.3 us to
//       4.5 us an iteration (fastest 65.5 s, slowest 223.5 s).

// timing: new Date().getTime() is the WSH clock in milliseconds (the system timer, so about
//         15 ms resolution); TIME_MS goes to stderr with WScript.StdErr and stdout is unchanged.
var ssT0 = new Date().getTime();
function ssReport() {
    WScript.StdErr.Write("TIME_MS=" + (new Date().getTime() - ssT0) + "\r\n");
}
var slots = new Array(256), total = 0, i, buf, slot;

for (i = 0; i < 50000000; i++) {
    buf = new Array(64);
    buf[0] = i % 256;
    total += buf[0];
    slot = i % 256;
    slots[slot] = buf;
}

ssReport();
WScript.Echo(String(total));
