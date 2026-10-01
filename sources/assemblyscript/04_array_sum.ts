// task 04 array_sum — expected output: 499999500000
// build: asc 04_array_sum.ts -O2 --outFile prog.wasm --runtime incremental --use abort=04_array_sum/abortImpl
// run: wasmtime run prog.wasm
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: the array is an Int64Array, matching the int64_t array in the C reference: fill it,
//       then walk it back.

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
  const n: i32 = 1000000;
  const array = new Int64Array(n);

  for (let i = 0; i < n; i++) {
    array[i] = i;
  }

  let total: i64 = 0;
  for (let i = 0; i < n; i++) {
    total += array[i];
  }

  emitI64(total); emit(10);
  flushOut();
}
