// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: asc 01_branches.ts -O2 --outFile prog.wasm --runtime incremental --use abort=01_branches/abortImpl
// run: wasmtime run prog.wasm
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: abortImpl is the program's abort handler, wired in with --use abort=..., so the module
//       imports nothing from env.

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

function flushOut(): void {
  store<u32>(outIov, out);
  store<u32>(outIov + 4, <u32>outPos);
  fd_write(1, outIov, 1, outNw);
  outPos = 0;
}

export function abortImpl(m: usize, f: usize, l: u32, c: u32): void {}

export function _start(): void {
  let a: i64 = 0, b: i64 = 0, c: i64 = 0, d: i64 = 0;

  for (let i: i64 = 0; i < 100000000; i++) {
    if (i % 3 == 0) {
      a += 1;
    } else if (i % 5 == 0) {
      b += 1;
    } else if (i % 7 == 0) {
      c += 1;
    } else {
      d += 1;
    }
  }

  emitI64(a); emit(32);
  emitI64(b); emit(32);
  emitI64(c); emit(32);
  emitI64(d); emit(10);
  flushOut();
}
