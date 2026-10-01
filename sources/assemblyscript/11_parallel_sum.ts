// task 11 parallel_sum — expected output: 7500000075000000
// build: asc 11_parallel_sum.ts -O2 --outFile prog.wasm --runtime incremental --use abort=11_parallel_sum/abortImpl --enable threads --importMemory --sharedMemory --maximumMemory 1024
// run: wasmtime run -S threads=y -W threads=y -W shared-memory=y prog.wasm
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: four real wasi threads, one per quarter of task 02's range. The memory is imported and
//       shared, so every worker writes into the same memory the parent reads back; the partials
//       go into shared memory and an atomic counter tells the parent when all four are done.

@external("wasi_snapshot_preview1", "fd_write")
declare function fd_write(fd: i32, iovs: usize, iovsLen: i32, nwritten: usize): i32;

@external("wasi", "thread-spawn")
declare function thread_spawn(arg: i32): i32;

const out = memory.data(64);
const outIov = memory.data(8);
const outNw = memory.data(4);
let outPos: usize = 0;

/* shared between the four workers and the parent */
const results = memory.data(64);    /* four i64 partials */
const doneCount = memory.data(8);   /* i32 counter, bumped atomically */

const THREADS: i32 = 4;
const SPAN: i64 = 25000000;

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

function work_range(t: i32): i64 {
  let acc: i64 = 0;
  const lo: i64 = <i64>t * SPAN;
  const hi: i64 = lo + SPAN;

  for (let i: i64 = lo; i < hi; i++) {
    switch (<i32>(i % 4)) {
      case 0: acc += 1; break;
      case 1: acc += i; break;
      case 2: acc += 2 * i; break;
      case 3: acc += 3 * i; break;
    }
  }
  return acc;
}

export function wasi_thread_start(tid: i32, arg: i32): void {
  const t = arg;
  store<i64>(results + (<usize>t << 3), work_range(t));
  atomic.add<i32>(doneCount, 1);
  atomic.notify(doneCount, 1);
}

export function _start(): void {
  store<i32>(doneCount, 0);

  for (let t = 0; t < THREADS; t++) {
    thread_spawn(t);
  }

  while (atomic.load<i32>(doneCount) < THREADS) {
    atomic.wait<i32>(doneCount, atomic.load<i32>(doneCount), -1);
  }

  let total: i64 = 0;
  for (let t = 0; t < THREADS; t++) {
    total += load<i64>(results + (<usize>t << 3));
  }

  emitI64(total); emit(10);
  flushOut();
}
