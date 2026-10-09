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

const wasi = new WASI({
  version: "preview1",
  args: [path.basename(file)],
  env: process.env,
  preopens: { "/": path.resolve(dir || ".") },
  returnOnExit: true,
});

const module_ = new WebAssembly.Module(fs.readFileSync(file));
const instance = new WebAssembly.Instance(module_, wasi.getImportObject());
process.exit(wasi.start(instance) || 0);