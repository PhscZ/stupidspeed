// task 10 pi — expected output: 4470
// build: none (interpreted)    run: qjs.exe --std 10_pi.js   (QuickJS-ng 0.11.0)
// timing: performance.now() (monotonic millisecond clock); TIME_MS=<ms> goes to stderr.
// note: QuickJS-ng 0.11.0 has native arbitrary-precision integers, so the Gibbons
//       unbounded spigot runs on BigInt exactly as in the javascript row — no hand-rolled
//       limbs. BigInt division truncates toward zero and the spigot needs floor division,
//       so floorDiv corrects the negative remainder. Only the digit sum is printed.

import * as std from "qjs:std";

const __t0 = performance.now();

const DIGITS = 1000;

function floorDiv(a, b) {
    const q = a / b;
    const rem = a % b;
    return rem !== 0n && (rem < 0n) !== (b < 0n) ? q - 1n : q;
}

let q = 1n;
let r = 0n;
let t = 1n;
let k = 1n;
let n = 3n;
let l = 3n;

let sum = 0;
let emitted = 0;
while (emitted < DIGITS) {
    if (4n * q + r - t < n * t) {
        // n is the next digit of pi.
        sum += Number(n);
        emitted += 1;
        const nq = 10n * q;
        const nr = 10n * (r - n * t);
        const nn = floorDiv(10n * (3n * q + r), t) - 10n * n;
        q = nq;
        r = nr;
        n = nn;
    } else {
        const nq = q * k;
        const nr = (2n * q + r) * l;
        const nt = t * l;
        const nn = floorDiv(q * (7n * k + 2n) + r * l, nt);
        const nl = l + 2n;
        q = nq;
        r = nr;
        t = nt;
        n = nn;
        l = nl;
        k = k + 1n;
    }
}

const __t1 = performance.now();
std.err.puts("TIME_MS=" + (__t1 - __t0) + "\n");
std.out.puts(sum + "\n");
