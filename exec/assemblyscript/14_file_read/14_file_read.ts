// task 14 file_read — expected output: 2389704704
// build: asc 14_file_read.ts -O2 --outFile prog.wasm --runtime incremental --use abort=14_file_read/abortImpl
// run: wasmtime run --dir=. prog.wasm   (from a directory containing the 50 MiB data.bin)
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: the file is opened through the preopened directory with WASI path_open and read in
//       1 MiB chunks with fd_read, one pass over fifty megabytes, then reduced mod 2^32.

@external("wasi_snapshot_preview1", "fd_write")
declare function fd_write(fd: i32, iovs: usize, iovsLen: i32, nwritten: usize): i32;

@external("wasi_snapshot_preview1", "clock_time_get")
declare function clock_time_get(id: i32, precision: i64, time: usize): i32;

@external("wasi_snapshot_preview1", "fd_read")
declare function fd_read(fd: i32, iovs: usize, iovsLen: i32, nread: usize): i32;

@external("wasi_snapshot_preview1", "fd_prestat_get")
declare function fd_prestat_get(fd: i32, buf: usize): i32;

@external("wasi_snapshot_preview1", "path_open")
declare function path_open(fd: i32, dirflags: i32, path: usize, pathLen: i32, oflags: i32, rightsBase: u64, rightsInheriting: u64, fdflags: i32, retFd: usize): i32;

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

const iov = memory.data(8);
const nreadPtr = memory.data(4);
const prestat = memory.data(16);
const retFd = memory.data(4);

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

/* the first preopened directory is the --dir=. the runtime was given */
function preopenDir(): i32 {
  for (let fd = 3; fd < 16; fd++) {
    if (fd_prestat_get(fd, prestat) == 0) {
      return fd;
    }
  }
  return -1;
}

function openFile(name: string, oflags: i32, fdflags: i32): i32 {
  const dir = preopenDir();
  if (dir < 0) {
    return -1;
  }
  const path = String.UTF8.encode(name);
  const err = path_open(
    dir, 0, changetype<usize>(path), path.byteLength, oflags,
    RIGHTS, 0, fdflags, retFd
  );
  if (err != 0) {
    return -1;
  }
  return load<i32>(retFd);
}

const CHUNK: i32 = 1048576;   /* 1 MiB */
const RIGHTS: u64 = 2;        /* FD_READ */

export function _start(): void {
  ssStart();
  const fd = openFile("data.bin", 0, 0);

  const buf = new Uint8Array(CHUNK);
  const base = buf.dataStart;
  store<u32>(iov, base);
  store<u32>(iov + 4, CHUNK);

  let total: u64 = 0;
  if (fd >= 0) {
    while (true) {
      const err = fd_read(fd, iov, 1, nreadPtr);
      if (err != 0) {
        break;
      }
      const got = load<u32>(nreadPtr);
      if (got == 0) {
        break;
      }
      for (let i = 0; i < <i32>got; i++) {
        total += <u64>load<u8>(base + i);
      }
    }
  }

  emitU64(total % 4294967296); emit(10);
  ssStop();
  flushOut();
  ssReport();
}
