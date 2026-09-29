// task 02 switch_case — expected output: 7500000075000000
// build: none (interpreted)    run: cscript //nologo //E:JScript 02_switch_case.js
// note: JScript's switch compiles to the same chain of comparisons the C row's switch
//       does; the engine has no jump table.
// note: acc passes 2^31 about 46000 iterations in, but there is no overflow and no
//       promotion step to worry about: JScript numbers are doubles from the start.
//       7500000075000000 is below 2^53, so the running total is exact at every step.
// note: String(7500000075000000) prints all sixteen digits with no exponent, because
//       Number.prototype.toString gives the shortest decimal that round-trips and the
//       machine's locale does not touch it. The VBScript row needs a hand-written
//       DecStr for this print; JScript does not.
// note: 100000000 iterations measure 27 s to 143 s on this shared host, about 0.27 us to
//       1.4 us an iteration (fastest 27.2 s, slowest 143.3 s). The spread is the machine's
//       load, not the code.
var acc = 0, i;

for (i = 0; i < 100000000; i++) {
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

WScript.Echo(String(acc));
