// task 15 file_write — expected output: 52428800
// build: asc 15_file_write.ts -O2 --outFile prog.wasm --runtime incremental --use abort=15_file_write/abortImpl
// run: wasmtime run --dir=. prog.wasm   (writes out.bin in the current directory)
// note: written by hand in AssemblyScript with no compiler in the toolchain; the module is a
//       WASI command that exports _start and writes its own answer to stdout (fd 1).
// note: the file is created through the preopened directory with WASI path_open and written in
//       1 MiB chunks with fd_write, fifty of them, then flushed with fd_sync.

@external("wasi_snapshot_preview1", "fd_write")
declare function fd_write(fd: i32, iovs: usize, iovsLen: i32, nwritten: usize): i32;

@external("wasi_snapshot_preview1", "fd_prestat_get")
declare function fd_prestat_get(fd: i32, buf: usize): i32;

@external("wasi_snapshot_preview1", "path_open")
declare function path_open(fd: i32, dirflags: i32, path: usize, pathLen: i32, oflags: i32, rightsBase: u64, rightsInheriting: u64, fdflags: i32, retFd: usize): i32;

@external("wasi_snapshot_preview1", "fd_sync")
declare function fd_sync(fd: i32): i32;

@external("wasi_snapshot_preview1", "fd_close")
declare function fd_close(fd: i32): i32;

const out = memory.data(64);
const outIov = memory.data(8);
const outNw = memory.data(4);
let outPos: usize = 0;

const iov = memory.data(8);
const nwPtr = memory.data(4);
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
const REPEATS: i32 = 50;
const O_CREAT: i32 = 1;
const O_TRUNC: i32 = 8;
const RIGHTS: u64 = 64 | 16;   /* FD_WRITE | FD_SYNC */

export function _start(): void {
  const buf = new Uint8Array(CHUNK);
  const base = buf.dataStart;
  for (let i = 0; i < CHUNK; i++) {
    store<u8>(base + i, <u8>(i % 256));
  }

  const fd = openFile("out.bin", O_CREAT | O_TRUNC, 0);

  let written: i64 = 0;
  if (fd >= 0) {
    for (let r = 0; r < REPEATS; r++) {
      let off = 0;
      while (off < CHUNK) {
        store<u32>(iov, base + off);
        store<u32>(iov + 4, CHUNK - off);
        const err = fd_write(fd, iov, 1, nwPtr);
        if (err != 0) {
          break;
        }
        const n = load<u32>(nwPtr);
        if (n == 0) {
          break;
        }
        off += <i32>n;
        written += <i64>n;
      }
    }
    fd_sync(fd);
    fd_close(fd);
  }

  emitI64(written); emit(10);
  flushOut();
}
