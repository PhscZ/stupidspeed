// task 10 pi — expected output: 4470
// build: asc 10_pi.ts -O2 --outFile prog.wasm --runtime incremental --use abort=10_pi/abortImpl
// run: wasmtime run prog.wasm
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: Gibbons' unbounded spigot needs arbitrary-precision integers and AssemblyScript has no
//       bignum library, so the state is hand-written sign-magnitude, little-endian base-1e9
//       limbs with add, subtract, multiply by a small integer, and a quotient that comes out of
//       repeated subtraction, because the spigot only ever asks for one decimal digit at a
//       time. Only the sum of the 1000 digits is printed.
// note: 2048 limbs is more than the ~1250 a 1000-digit run needs, and the limb * small product
//       stays under 2^64 (small < 2^32), so no 128-bit arithmetic is used.

@external("wasi_snapshot_preview1", "fd_write")
declare function fd_write(fd: i32, iovs: usize, iovsLen: i32, nwritten: usize): i32;

@external("wasi_snapshot_preview1", "clock_time_get")
declare function clock_time_get(id: i32, precision: i64, time: usize): i32;

const out = memory.data(64);
const outIov = memory.data(8);
const outNw = memory.data(4);
let outPos: usize = 0;

const ssTimeBuf = memory.data(8);
let ss_t0: u64 = 0;
let ss_t1: u64 = 0;

function ssNow(): u64 {
  clock_time_get(1, 1000, ssTimeBuf);
  return load<u64>(ssTimeBuf);
}
function ssStart(): void { ss_t0 = ssNow(); }
function ssStop(): void { ss_t1 = ssNow(); }
function ssReport(): void {
  const ns: u64 = ss_t1 - ss_t0;
  const ms: u64 = ns / 1000000;
  const frac: u64 = (ns % 1000000) / 1000;
  emit(84); emit(73); emit(77); emit(69); emit(95); emit(77); emit(83); emit(61);
  emitU64(ms);
  emit(46);
  emit(48 + <i32>((frac / 100) % 10));
  emit(48 + <i32>((frac / 10) % 10));
  emit(48 + <i32>(frac % 10));
  emit(10);
  store<u32>(outIov, out);
  store<u32>(outIov + 4, <u32>outPos);
  fd_write(2, outIov, 1, outNw);
  outPos = 0;
}

function emit(c: i32): void {
  store<u8>(out + outPos, c);
  outPos++;
}

function emitU64(v: u64): void {
  if (v == 0) { emit(48); return; }
  let d: u64 = 1;
  while (v / d >= 10) d = d * 10;
  while (d > 0) {
    emit(48 + <i32>((v / d) % 10));
    d = d / 10;
  }
}

function emitI64(v: i64): void {
  if (v < 0) { emit(45); emitU64(<u64>(-v)); }
  else emitU64(<u64>v);
}

function flushOut(): void {
  store<u32>(outIov, out);
  store<u32>(outIov + 4, <u32>outPos);
  fd_write(1, outIov, 1, outNw);
  outPos = 0;
}

export function abortImpl(m: usize, f: usize, l: u32, c: u32): void {}

const BASE: u64 = 1000000000;
const CAP: i32 = 2048;

class Big {
  limb: Uint64Array;
  n: i32;
  neg: i32;
  constructor() {
    this.limb = new Uint64Array(CAP);
    this.n = 0;
    this.neg = 0;
  }
}

function bigTrim(x: Big): void {
  while (x.n > 0 && x.limb[x.n - 1] == 0) {
    x.n--;
  }
  if (x.n == 0) {
    x.neg = 0;
  }
}

function bigSet(x: Big, v: u64): void {
  x.n = 0;
  x.neg = 0;
  while (v > 0) {
    x.limb[x.n++] = v % BASE;
    v /= BASE;
  }
}

function bigCopy(dst: Big, src: Big): void {
  for (let i = 0; i < src.n; i++) {
    dst.limb[i] = src.limb[i];
  }
  dst.n = src.n;
  dst.neg = src.neg;
}

function bigCmpMag(a: Big, b: Big): i32 {
  if (a.n != b.n) {
    return a.n < b.n ? -1 : 1;
  }
  for (let i = a.n - 1; i >= 0; i--) {
    if (a.limb[i] != b.limb[i]) {
      return a.limb[i] < b.limb[i] ? -1 : 1;
    }
  }
  return 0;
}

function bigCmp(a: Big, b: Big): i32 {
  if (a.neg != b.neg) {
    return a.neg != 0 ? -1 : 1;
  }
  const c = bigCmpMag(a, b);
  return a.neg != 0 ? -c : c;
}

function bigAddMag(r: Big, a: Big, b: Big): void {
  const n = a.n > b.n ? a.n : b.n;
  let carry: u64 = 0;
  for (let i = 0; i < n; i++) {
    let s = carry;
    if (i < a.n) {
      s += a.limb[i];
    }
    if (i < b.n) {
      s += b.limb[i];
    }
    if (s >= BASE) {
      s -= BASE;
      carry = 1;
    } else {
      carry = 0;
    }
    r.limb[i] = s;
  }
  r.limb[n] = carry;
  r.n = n + (carry != 0 ? 1 : 0);
  r.neg = 0;
}

/* requires a >= b >= 0 */
function bigSubMag(r: Big, a: Big, b: Big): void {
  let borrow: u64 = 0;
  for (let i = 0; i < a.n; i++) {
    const bi: u64 = (i < b.n ? b.limb[i] : 0) + borrow;
    if (a.limb[i] >= bi) {
      r.limb[i] = a.limb[i] - bi;
      borrow = 0;
    } else {
      r.limb[i] = a.limb[i] + BASE - bi;
      borrow = 1;
    }
  }
  r.n = a.n;
  r.neg = 0;
  bigTrim(r);
}

function bigAdd(r: Big, a: Big, b: Big): void {
  const an = a.neg, bn = b.neg;
  if (an == bn) {
    bigAddMag(r, a, b);
    r.neg = an;
  } else if (bigCmpMag(a, b) >= 0) {
    bigSubMag(r, a, b);
    r.neg = an;
  } else {
    bigSubMag(r, b, a);
    r.neg = bn;
  }
  bigTrim(r);
}

/* r = a - b */
function bigSub(r: Big, a: Big, b: Big): void {
  const an = a.neg, bn = b.neg;
  if (an != bn) {
    bigAddMag(r, a, b);
    r.neg = an;
  } else if (bigCmpMag(a, b) >= 0) {
    bigSubMag(r, a, b);
    r.neg = an;
  } else {
    bigSubMag(r, b, a);
    r.neg = an == 0 ? 1 : 0;
  }
  bigTrim(r);
}

function bigMulSmall(r: Big, a: Big, m: u64): void {
  if (m == 0 || a.n == 0) {
    r.n = 0;
    r.neg = 0;
    return;
  }
  let carry: u64 = 0;
  for (let i = 0; i < a.n; i++) {
    const p = a.limb[i] * m + carry;
    r.limb[i] = p % BASE;
    carry = p / BASE;
  }
  let n = a.n;
  while (carry > 0) {
    r.limb[n++] = carry % BASE;
    carry /= BASE;
  }
  r.n = n;
  r.neg = a.neg;
  bigTrim(r);
}

/* floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of one
   decimal digit, so counting how many times b fits into a is enough. */
function bigQuot(a: Big, b: Big, work: Big): u64 {
  let q: u64 = 0;
  if (a.neg != 0 || b.neg != 0 || b.n == 0) {
    return 0;
  }
  bigCopy(work, b);
  while (bigCmp(a, work) >= 0) {
    q++;
    bigAddMag(work, work, b);
  }
  return q;
}

export function _start(): void {
  ssStart();
  const q = new Big();
  const r = new Big();
  const t = new Big();
  const u = new Big();
  const v = new Big();
  const w = new Big();

  bigSet(q, 1);
  bigSet(r, 0);
  bigSet(t, 1);

  let k: u64 = 1, l: u64 = 3, n: u64 = 3;
  let sum: u64 = 0;

  for (let produced = 0; produced < 1000; ) {
    bigMulSmall(u, q, 4);
    bigAdd(u, u, r);              /* u = 4q + r */
    bigMulSmall(v, t, n + 1);     /* v = (n + 1)t */

    if (bigCmp(u, v) < 0) {
      /* the digit n is settled */
      sum += n;
      produced++;

      bigMulSmall(u, q, 3);
      bigAdd(u, u, r);
      bigMulSmall(u, u, 10);            /* u = 10(3q + r) */
      const next = bigQuot(u, t, w) - 10 * n;

      bigMulSmall(v, t, n);             /* v = n t */
      bigSub(v, r, v);                  /* v = r - n t */
      bigMulSmall(r, v, 10);            /* r = 10(r - n t) */
      bigMulSmall(q, q, 10);            /* q = 10q, t is unchanged */

      n = next;
    } else {
      /* not settled yet: widen the state by one more term */
      bigMulSmall(u, q, 7 * k + 2);
      bigMulSmall(v, r, l);
      bigAdd(u, u, v);                  /* u = q(7k + 2) + r l */
      bigMulSmall(v, t, l);             /* v = t l */
      const next = bigQuot(u, v, w);

      bigMulSmall(u, q, 2);
      bigAdd(u, u, r);
      bigMulSmall(u, u, l);             /* u = (2q + r) l */
      bigCopy(r, u);
      bigMulSmall(q, q, k);
      bigMulSmall(t, t, l);

      k++;
      l += 2;
      n = next;
    }
  }

  emitU64(sum); emit(10);
  ssStop();
  flushOut();
  ssReport();
}
