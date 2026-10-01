// task 06 char_count — expected output: 10000000
// build: asc 06_char_count.ts -O2 --outFile prog.wasm --runtime incremental --use abort=06_char_count/abortImpl
// run: wasmtime run prog.wasm
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: the 100 MB text is built up front block by block with memory.copy, then scanned one
//       byte at a time, so the build is not part of the timed loop.

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

const BLOCK_LEN: i32 = 10;
const REPEATS: i32 = 10000000;
const TEXT_LEN: i32 = 100000000;

export function _start(): void {
  const text = new Uint8Array(TEXT_LEN);

  /* "abcdefghij" as a static byte block, copied into place 10 million times */
  const block = memory.data(16);
  store<u8>(block + 0, 97);
  store<u8>(block + 1, 98);
  store<u8>(block + 2, 99);
  store<u8>(block + 3, 100);
  store<u8>(block + 4, 101);
  store<u8>(block + 5, 102);
  store<u8>(block + 6, 103);
  store<u8>(block + 7, 104);
  store<u8>(block + 8, 105);
  store<u8>(block + 9, 106);

  const base = text.dataStart;
  for (let i = 0; i < REPEATS; i++) {
    memory.copy(base + <usize>i * BLOCK_LEN, block, BLOCK_LEN);
  }

  let count: i64 = 0;
  for (let i = 0; i < TEXT_LEN; i++) {
    if (load<u8>(base + i) == 104) {   /* 'h' */
      count += 1;
    }
  }

  emitI64(count); emit(10);
  flushOut();
}
