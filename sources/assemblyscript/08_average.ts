// task 08 average — expected output: 0.498046875
// build: asc 08_average.ts -O2 --outFile prog.wasm --runtime incremental --use abort=08_average/abortImpl
// run: wasmtime run prog.wasm
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: every reading is a multiple of 1/256 and the total stays under 2^53, so the sum is
//       exact and the nine-decimal form is printed without any rounding.

@external("wasi_snapshot_preview1", "fd_write")
declare function fd_write(fd: i32, iovs: usize, iovsLen: i32, nwritten: usize): i32;

const out = memory.data(64);
const outIov = memory.data(8);
const outNw = memory.data(4);
let outPos: usize = 0;

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

/* fixed point with exactly nine fractional digits, like printf("%.9f") */
function emitFixed9(v: f64): void {
  const scaled: i64 = <i64>(v * 1000000000.0 + 0.5);
  emitI64(scaled / 1000000000);
  emit(46);
  let frac: i64 = scaled % 1000000000;
  let div: i64 = 100000000;
  while (div > 0) {
    emit(48 + <i32>((frac / div) % 10));
    div = div / 10;
  }
}

function flushOut(): void {
  store<u32>(outIov, out);
  store<u32>(outIov + 4, <u32>outPos);
  fd_write(1, outIov, 1, outNw);
  outPos = 0;
}

export function abortImpl(m: usize, f: usize, l: u32, c: u32): void {}

export function _start(): void {
  let total: f64 = 0.0;

  for (let i: i64 = 0; i < 100000000; i++) {
    const reading: f64 = <f64>(i % 256) / 256.0;
    total += reading;
  }

  emitFixed9(total / 100000000.0); emit(10);
  flushOut();
}
