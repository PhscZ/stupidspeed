// task 12 matrix_add — expected output: 999000000
// build: asc 12_matrix_add.ts -O2 --outFile prog.wasm --runtime incremental --use abort=12_matrix_add/abortImpl
// run: wasmtime run prog.wasm
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: three flat 1000x1000 Int64Arrays, eight megabytes each, so the task moves data rather
//       than fitting in cache.

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
  const n: i64 = 1000;
  const elems: i32 = 1000000;

  const A = new Int64Array(elems);
  const B = new Int64Array(elems);
  const C = new Int64Array(elems);

  for (let i: i64 = 0; i < n; i++) {
    for (let j: i64 = 0; j < n; j++) {
      A[<i32>(i * n + j)] = i + j;
      B[<i32>(i * n + j)] = i - j;
    }
  }

  for (let i: i64 = 0; i < n; i++) {
    for (let j: i64 = 0; j < n; j++) {
      C[<i32>(i * n + j)] = A[<i32>(i * n + j)] + B[<i32>(i * n + j)];
    }
  }

  let total: i64 = 0;
  for (let k = 0; k < elems; k++) {
    total += C[k];
  }

  emitI64(total); emit(10);
  flushOut();
}
