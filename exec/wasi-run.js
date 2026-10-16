// Run a wasip1 WebAssembly module on Node's own WASI implementation.
//
//   node --no-warnings exec/wasi-run.js <module.wasm> [<preopen-dir>]
//
// The `node (wasip1)` cells of the eight WebAssembly rows run their committed
// `prog.wasm` through this shim, so the V8 column of those rows is V8 executing
// the same bytes every other runtime gets.
//
// `<preopen-dir>` is mapped to `/`, so a module that opens a relative path finds
// the cell's working directory — the same access the wasmtime rows get from
// `--dir`.  Measured on `c-wasm` task 14: 49 ms, and 258 ms on task 15.
//
// `PWD` is dropped from the guest environment.  Node's WASI uses that variable
// as the guest's working directory, and the host's `PWD` is a path outside the
// preopen, so a module that resolves a relative name against the working
// directory cannot find its file.  This was measured on the `go-wasm` row's
// task 14 while that row existed: with the host `PWD` set it panicked with
// `panic: open data.bin: No such file or directory`, and with `PWD` removed the
// same module answered in 520 ms.  The row was removed on 2026-10-10, but the
// drop is kept because it is correct for any module that reads `PWD`: every
// other row's libc resolves the relative name against the preopen and is
// unaffected either way.
//
// `wasi-threads` (task 11) is implemented here rather than excepted.  Node's
// `WASI` provides no `env` import object and no `wasi.thread-spawn`, which is
// why this shim used to record task 11 as a runtime capability boundary:
//
//   TypeError: WebAssembly.Instance(): Import #0 module="env": module is not an
//   object or function
//
// A `wasi-threads` module is built with `-Wl,--import-memory`, so the *host*
// must create the linear memory — that is what the ABI requires, not an
// accident of the build: defining the memory in the module instead makes every
// runtime fail inside `wasi_thread_start`, measured on wasmtime.  The import
// carries the shared-memory limits, and `WebAssembly.Module.imports()` reports
// names and kinds but not limits, so the import section is parsed for the
// `env.memory` min/max.  The memory is then created shared, `wasi.thread-spawn`
// is answered by starting a `node:worker_threads` Worker on this same file with
// the memory in `workerData`, and each Worker instantiates its own copy of the
// module against that one memory and enters `wasi_thread_start(tid, arg)`.
// `Memory` objects are transferable, so the workers share the same buffer.
//
// Measured on `c-wasm` task 11: 2297 ms against wasmtime's 157 ms — V8 is
// slower here, and the number is a real one rather than a boundary.  All eight
// rows that have task 11 answer 7500000075000000 through this path.
//
// The file is part of the repository rather than of `tools/` on purpose: it is
// the row's run recipe, not a third-party toolchain, and `tools/` is not
// committed.
const fs = require("node:fs");
const path = require("node:path");
const { WASI } = require("node:wasi");
const { Worker, isMainThread, workerData } = require("node:worker_threads");

// Read `env.memory`'s declared limits out of the module's import section.
function readMemoryLimits(buf) {
  let i = 8;
  const leb = () => {
    let n = 0;
    let s = 0;
    let b;
    do {
      b = buf[i++];
      n |= (b & 0x7f) << s;
      s += 7;
    } while (b & 0x80);
    return n;
  };
  while (i < buf.length) {
    const id = buf[i++];
    const size = leb();
    const end = i + size;
    if (id === 2) {
      const n = leb();
      for (let k = 0; k < n; k++) {
        const ml = leb();
        const mod = buf.toString("utf8", i, i + ml);
        i += ml;
        const nl = leb();
        const nm = buf.toString("utf8", i, i + nl);
        i += nl;
        const kind = buf[i++];
        if (kind === 0) {
          leb();
        } else if (kind === 1) {
          i++;
          const f = leb();
          leb();
          if (f & 1) leb();
        } else if (kind === 2) {
          const f = leb();
          const min = leb();
          let max = null;
          if (f & 1) max = leb();
          if (mod === "env" && nm === "memory") return { min, max };
        } else if (kind === 3) {
          i++;
          const f = leb();
          leb();
          if (f & 1) leb();
        }
      }
    }
    i = end;
  }
  return null;
}

// A WASI context and its import object, with `env.memory` supplied when the
// module asks for it.  The context is returned too, because `start()` is only
// valid on the instance that produced the import object.
function buildWasi(file, dir, memory) {
  const env = { ...process.env };
  delete env.PWD;
  const wasi = new WASI({
    version: "preview1",
    args: [path.basename(file)],
    env,
    preopens: { "/": path.resolve(dir || ".") },
    returnOnExit: true,
  });
  const io = wasi.getImportObject();
  if (memory) io.env = { memory };
  return { wasi, io };
}

if (!isMainThread && workerData && workerData.tid !== undefined) {
  // ---- thread side: one wasi-threads worker, then exit ----
  const { file, dir, memory, tid, startArg } = workerData;
  const { io } = buildWasi(file, dir, memory);
  io.wasi = {
    "thread-spawn": () => {
      throw new Error("wasi-threads: a spawned thread cannot spawn another");
    },
  };
  const mod = new WebAssembly.Module(fs.readFileSync(file));
  const inst = new WebAssembly.Instance(mod, io);
  inst.exports.wasi_thread_start(tid, startArg);
} else {
  const [, , file, dir] = process.argv;
  if (!file) {
    console.error("usage: node wasi-run.js <module.wasm> [<preopen-dir>]");
    process.exit(2);
  }
  const bytes = fs.readFileSync(file);
  const mod = new WebAssembly.Module(bytes);
  const imports = WebAssembly.Module.imports(mod);
  const wantsMemory = imports.some((i) => i.module === "env" && i.name === "memory");
  const wantsThreads = imports.some((i) => i.module === "wasi" && i.name === "thread-spawn");

  let memory = null;
  if (wantsMemory) {
    const lim = readMemoryLimits(bytes) || { min: 2, max: null };
    memory = new WebAssembly.Memory({
      initial: lim.min,
      maximum: lim.max === null ? undefined : lim.max,
      shared: true,
    });
  }

  const { wasi, io } = buildWasi(file, dir, memory);
  if (wantsThreads) {
    let nextTid = 1;
    io.wasi = {
      "thread-spawn": (startArg) => {
        const tid = nextTid++;
        new Worker(__filename, { workerData: { file, dir, memory, tid, startArg } });
        return tid;
      },
    };
  }

  const inst = new WebAssembly.Instance(mod, io);
  process.exitCode = wasi.start(inst) || 0;
}
