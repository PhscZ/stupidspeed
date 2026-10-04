// task 11 parallel_sum — expected output: 7500000075000000
// build: none (interpreted)    run: cscript //nologo //E:JScript 11_parallel_sum.js
// note: JScript has no threads and no thread library, so this is four child processes
//       rather than four threads. The parent starts four copies of this same file with
//       WScript.Shell.Exec, each one given a worker index as an argument, and each child
//       computes one quarter of task 02's range and prints its partial sum. Reading a
//       child's StdOut blocks until that child closes it, which is the join, and the
//       parent adds the four partials.
// note: this is the same mechanism the VBScript row uses and the COBOL row's
//       CBL_GC_FORK: the benchmark accepts it as "pass, but with processes rather than
//       threads". Unlike the R and COBOL rows it is real parallelism on Windows.
// note: each worker owns a fixed quarter, so which one finishes first cannot change the
//       answer. The partials are read back with parseFloat, which is exact because every
//       partial is an integer below 2^53, and the total is printed with String().
// note: the child inherits nothing but its argument. The script's own full path is
//       passed to it, so the parent can be started from any working directory.
// note: the whole task measures 2.8 s to 13.7 s on this shared host, against 27 s to 143 s
//       for task 02 on the same machine. The gap is bigger than four cores are worth, and
//       not all of it is parallelism: a child runs its quarter inside a function while
//       task 02's loop is global code, and this engine does not treat the two alike. An
//       in-process A/B of the same 5-million-iteration switch loop measured 0.28 s inside
//       a function against 0.78 s at top level, so the four-process figure is not a clean
//       4x over task 02.

// timing: new Date().getTime() is the WSH clock in milliseconds (the system timer, so about
//         15 ms resolution); TIME_MS goes to stderr with WScript.StdErr and stdout is unchanged.
var ssT0 = new Date().getTime();
function ssReport() {
    WScript.StdErr.Write("TIME_MS=" + (new Date().getTime() - ssT0) + "\r\n");
}
var shell, kids, t, total, cmd;

if (WScript.Arguments.length === 1) {
    // child: compute one quarter and print it
    WScript.Echo(String(workRange(parseInt(WScript.Arguments(0), 10))));
    WScript.Quit(0);
}

shell = new ActiveXObject("WScript.Shell");
kids = new Array(4);

for (t = 0; t < 4; t++) {
    cmd = "cscript.exe //nologo //E:JScript \"" + WScript.ScriptFullName + "\" " + t;
    kids[t] = shell.Exec(cmd);
}

total = 0;
for (t = 0; t < 4; t++) {
    total += parseFloat(kids[t].StdOut.ReadAll());
}

ssReport();
WScript.Echo(String(total));

function workRange(t) {
    var acc = 0, i, lo, hi;

    lo = t * 25000000;
    hi = lo + 25000000;
    for (i = lo; i < hi; i++) {
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
    return acc;
}
