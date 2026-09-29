// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: none (interpreted)    run: cscript //nologo //E:JScript 01_branches.js
// note: the engine Windows Script Host maps .js to is the one that runs this file. On
//       this host it is JScript9Legacy, which reports ScriptEngine "JScript"
//       11.0.16384; classic JScript 5.8 is not what runs. The row stays inside the ES3
//       subset both engines accept — var, function, for, switch, % and charCodeAt —
//       because this one has no JSON, no let/const, no typed arrays and no
//       String.prototype.repeat.
// note: every number in JScript is an IEEE double. The four counters top out at
//       45714285, so they are exact integers throughout and String(x) prints them as
//       plain digits. WScript.Echo is never handed a number, only a string, so the
//       engine's own VARIANT formatting cannot reach the output.
// note: the engine does have an optimizer: a loop whose result is never observed is
//       removed (measured, the same loop inside a function that discards its locals
//       took 1 ms for 10 million iterations). Every task in this row prints its
//       result, so no loop here is dead.
// note: 100000000 iterations measure 27 s to 148 s on this shared host, about 0.27 us to
//       1.5 us an iteration (fastest 27.1 s, slowest 148.1 s). The spread is the machine's
//       load, not the code: it is the same file every time.
var a = 0, b = 0, c = 0, d = 0, i;

for (i = 0; i < 100000000; i++) {
    if (i % 3 === 0) {
        a++;
    } else if (i % 5 === 0) {
        b++;
    } else if (i % 7 === 0) {
        c++;
    } else {
        d++;
    }
}

WScript.Echo(String(a) + " " + String(b) + " " + String(c) + " " + String(d));
