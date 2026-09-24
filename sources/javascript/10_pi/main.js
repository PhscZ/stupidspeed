// task 10 pi — expected output: 44889
// build: none    run: node main.js | bun main.js | deno run main.js
// note: Gibbons' unbounded spigot on native BigInt; only the digit sum is printed.

const DIGITS = 10000;

// BigInt division truncates toward zero; the spigot's quotients are floor divisions.
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
console.log(sum);
