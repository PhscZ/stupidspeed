// Run a dart2wasm module on Node (V8).
//
//   node exec/dart/dart2wasm/run.mjs
//
// `dart compile wasm` emits a WasmGC module plus a JS "init file" that carries the
// host half of the module's imports (printToConsole and friends).  Node has no way to
// run the module on its own: it is not a WASI module -- wasmtime rejects it with
// "gc proposal must be enabled to use subtypes" -- so V8 is the runtime, and this
// twenty-line host is the runner.  `prog.mjs`/`prog.wasm` are read from the current
// directory, which is the task's own exec directory.
import { readFileSync } from 'node:fs';
import { pathToFileURL } from 'node:url';
import { resolve } from 'node:path';

const dir = process.cwd();
const { compile } = await import(pathToFileURL(resolve(dir, 'prog.mjs')).href);
const app = await compile(readFileSync(resolve(dir, 'prog.wasm')));
const instance = await app.instantiate({});
instance.invokeMain();