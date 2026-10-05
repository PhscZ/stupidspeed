// task 07 string_append — expected output: 250000
// build: asc 07_string_append.ts -O2 --outFile prog.wasm --runtime incremental --use abort=07_string_append/abortImpl
// run: wasmtime run prog.wasm
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: AssemblyScript strings are immutable, so text = text + "x" allocates a fresh string
//       and copies the whole thing every time. The loop is quadratic on purpose, the same as
//       the C reference's realloc + strcat.

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

export function _start(): void {
  ssStart();
  let text = "";

  for (let i = 0; i < 250000; i++) {
    text = text + "x";
  }

  emitI64(text.length); emit(10);
  ssStop();
  flushOut();
  ssReport();
}
