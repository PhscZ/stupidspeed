// task 03 func_sum — expected output: 100000000
// build: none (interpreted)    run: cscript //nologo //E:JScript 03_func_sum.js
// note: the helper lives in its own file, 03_func_sum_add_one.js, and is loaded with
//       eval(fso.OpenTextFile(...).ReadAll()) because Windows Script Host JScript has
//       no include directive. The call therefore crosses a file boundary: the function
//       object does not exist until the caller has read and evaluated that file.
// note: the engine does have an optimizer, so this is measured rather than assumed. In one
//       process: 10 million calls through the helper loaded from its file 4.67 s, 10
//       million calls to the same helper declared in the calling file 4.24 s, and 10
//       million inline increments of the same accumulator 1.90 s. The call costs about 2.5
//       times an inline iteration and the file boundary adds about 10 per cent, so the call
//       really happens.
// note: value ends at 100000000, far below 2^53, so every step is exact.
// note: the full 100000000 calls measure 36 s to 147 s on this shared host, about 0.36 us
//       to 1.5 us a call (fastest 35.7 s, slowest 146.6 s). The spread is the machine's
//       load, not the code.

// timing: new Date().getTime() is the WSH clock in milliseconds (the system timer, so about
//         15 ms resolution); TIME_MS goes to stderr with WScript.StdErr and stdout is unchanged.
var ssT0 = new Date().getTime();
function ssReport() {
    WScript.StdErr.Write("TIME_MS=" + (new Date().getTime() - ssT0) + "\r\n");
}
var fso, file, src, value, i;

fso = new ActiveXObject("Scripting.FileSystemObject");
file = fso.OpenTextFile(fso.BuildPath(fso.GetParentFolderName(WScript.ScriptFullName), "03_func_sum_add_one.js"), 1);
src = file.ReadAll();
file.Close();
eval(src);

value = 0;
for (i = 1; i <= 100000000; i++) {
    value = add_one(value);
}

ssReport();
WScript.Echo(String(value));
