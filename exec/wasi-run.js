// Run a wasip1 WebAssembly module on Node's own WASI implementation.
//
//   node --no-warnings exec/wasi-run.js <module.wasm> [<preopen-dir>]
//
// The `node (wasip1)` cells of the eight WebAssembly rows run their committed
// `prog.wasm` through this shim, so the V8 column of those rows is V8 executing
// the same bytes every other runtime gets.
//
// Node's WASI is a plain WASI preview1 host and it provides no `env` import
// object: a module that imports its memory — the `wasi-threads` task 11 — cannot
// be instantiated here at all.  That is a registry `except` boundary on those
// rows, not a failed cell.  The exact error is
//
//   TypeError: WebAssembly.Instance(): Import #0 module="env": module is not an
//   object or function
//
// `<preopen-dir>` is mapped to `/`, so a module that opens a relative path finds
// the cell's working directory — the same access the wasmtime rows get from
// `--dir`.  Measured on `c-wasm` task 14: 49 ms, and 258 ms on task 15.
//
// `PWD` is dropped from the guest environment.  Node's WASI uses that variable
// as the guest's working directory, and the host's `PWD` is a path outside the
// preopen, so a module that resolves a relative name against the working
// directory — Go's wasip1 runtime does — cannot find its file.  Measured on
// `go-wasm` task 14 with the host `PWD` set: `panic: open data.bin: No such file
// or directory`.  With it removed, the same module answers in 520 ms.  Every
// other row's libc resolves the same relative name against the preopen and is
// unaffected either way.
//
// The file is part of the repository rather than of `tools/` on purpose: it is
// the row's run recipe, not a third-party toolchain, and `tools/` is not
// committed.
const fs = require("node:fs");
const path = require("node:path");
const { WASI } = require("node:wasi");

const [, , file, dir] = process.argv;
if (!file) {
  console.error("usage: node wasi-run.js <module.wasm> [<preopen-dir>]");
  process.exit(2);
}

// The preopen maps `<preopen-dir>` to `/`; `PWD` is dropped so node does not
// adopt the host's working directory as the guest's (see the note above).
const env = { ...process.env };
delete env.PWD;

const wasi = new WASI({
  version: "preview1",
  args: [path.basename(file)],
  env,
  preopens: { "/": path.resolve(dir || ".") },
  returnOnExit: true,
});

const module_ = new WebAssembly.Module(fs.readFileSync(file));
const instance = new WebAssembly.Instance(module_, wasi.getImportObject());
process.exit(wasi.start(instance) || 0);