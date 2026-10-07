// task 10 pi — expected output: 4470
// build: none (interpreted)    run: C:\stupidspeed\tools\spidermonkey\js.exe 10_pi.js
// note: Gibbons' unbounded spigot on the shell's native BigInt; only the digit sum is printed.

var __t0 = performance.now();
var DIGITS = 1000;

/* BigInt division truncates toward zero; the spigot's quotients are floor divisions. */
function floorDiv(a, b) {
  var q = a / b;
  var rem = a % b;
  return rem !== 0n && (rem < 0n) !== (b < 0n) ? q - 1n : q;
}

var q = 1n;
var r = 0n;
var t = 1n;
var k = 1n;
var n = 3n;
var l = 3n;

var sum = 0;
var emitted = 0;
while (emitted < DIGITS) {
  if (4n * q + r - t < n * t) {
    /* n is the next digit of pi. */
    sum += Number(n);
    emitted += 1;
    var nq = 10n * q;
    var nr = 10n * (r - n * t);
    var nn = floorDiv(10n * (3n * q + r), t) - 10n * n;
    q = nq;
    r = nr;
    n = nn;
  } else {
    var nq2 = q * k;
    var nr2 = (2n * q + r) * l;
    var nt = t * l;
    var nn2 = floorDiv(q * (7n * k + 2n) + r * l, nt);
    var nl = l + 2n;
    q = nq2;
    r = nr2;
    t = nt;
    n = nn2;
    l = nl;
    k = k + 1n;
  }
}
printErr("TIME_MS=" + (performance.now() - __t0));
print(sum);
