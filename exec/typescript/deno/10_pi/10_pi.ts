// task 10 pi — expected output: 4470
// build: none    run: bun 10_pi.ts | deno run 10_pi.ts
// note: Gibbons' unbounded spigot on native BigInt; only the digit sum is printed.

const __t0: number = performance.now();

const DIGITS: number = 1000;

// BigInt division truncates toward zero; the spigot's quotients are floor divisions.
function floorDiv(a: bigint, b: bigint): bigint {
  const q: bigint = a / b;
  const rem: bigint = a % b;
  return rem !== 0n && (rem < 0n) !== (b < 0n) ? q - 1n : q;
}

let q: bigint = 1n;
let r: bigint = 0n;
let t: bigint = 1n;
let k: bigint = 1n;
let n: bigint = 3n;
let l: bigint = 3n;

let sum: number = 0;
let emitted: number = 0;
while (emitted < DIGITS) {
  if (4n * q + r - t < n * t) {
    // n is the next digit of pi.
    sum += Number(n);
    emitted += 1;
    const nq: bigint = 10n * q;
    const nr: bigint = 10n * (r - n * t);
    const nn: bigint = floorDiv(10n * (3n * q + r), t) - 10n * n;
    q = nq;
    r = nr;
    n = nn;
  } else {
    const nq: bigint = q * k;
    const nr: bigint = (2n * q + r) * l;
    const nt: bigint = t * l;
    const nn: bigint = floorDiv(q * (7n * k + 2n) + r * l, nt);
    const nl: bigint = l + 2n;
    q = nq;
    r = nr;
    t = nt;
    n = nn;
    l = nl;
    k = k + 1n;
  }
}
console.error(`TIME_MS=${performance.now() - __t0}`);
console.log(sum);
