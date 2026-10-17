#!/usr/bin/env python3
"""Row verifier for the rust-wasm row -- fifteen Rust sources, one wasip1 module each.

Every task is built once, into `exec/rust-wasm/wasip1/<task>/prog.wasm`, and that
same module is then executed by six registered runtimes, which is what the row's
thirteen registry entries say: wasmtime's Cranelift and Winch code generators,
WAMR's iwasm, V8 through `exec/wasi-run.js`, and Wasmer's Cranelift and LLVM
backends.  Task 11's module is built for `wasm32-wasip1-threads` (four real
threads), so the wasmtime cells run it with `-S threads=y -W threads=y
-W shared-memory=y`; tasks 14 and 15 get a directory preopen so the guest can
reach `data.bin` and write `out.bin`; and Wasmer needs the empty `out.bin`
staged, because its WASIX filesystem can overwrite a file it can see on the host
but cannot create one (the registry's `create_out`).

Checks per task: stripped stdout equals the task's own `expected output:` line
(read from the source header, so a source edit cannot leave the check behind),
a TIME_MS value on stderr, and task 15 left out.bin behind at 52428800 bytes.

    python exec/rust-wasm/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "rust-wasm"
SRC = os.path.join(ROOT, "sources", "rust-wasm")
RUN = os.path.join(ROOT, "exec", "rust-wasm", "wasip1")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 1200
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

WASMTIME = os.path.join(ROOT, "tools", "wasmtime46", "wasmtime.exe")
IWASM = os.path.join(ROOT, "tools", "wamr", "iwasm.exe")
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")
WASI_RUN = os.path.join(ROOT, "exec", "wasi-run.js")
WASMER = os.path.join(ROOT, "tools", "wasmer437", "bin", "wasmer.exe")

THREAD_FLAGS = ["-S", "threads=y", "-W", "threads=y", "-W", "shared-memory=y"]
WASMTIME_CG = ["-C", "compiler=cranelift"]
WASMTIME_WINCH = ["-C", "compiler=winch"]

# The six runtimes the registry names, in registry order.  `create_out` marks the
# WASIX filesystem, which needs an empty out.bin staged before task 15.
RUNTIMES = [
    "rustc (wasm32-wasip1)",
    "wasmtime (winch)",
    "iwasm",
    "node (wasip1)",
    "wasmer (cranelift)",
    "wasmer (llvm)",
]
CREATE_OUT = {"wasmer (cranelift)", "wasmer (llvm)"}

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".rs"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def argv_for(runtime, task, cwd):
    """The exact argv the registry gives for this runtime and task."""
    if runtime == "rustc (wasm32-wasip1)":
        if task == "11_parallel_sum":
            return [WASMTIME] + WASMTIME_CG + THREAD_FLAGS + ["prog.wasm"]
        if task in ("14_file_read", "15_file_write"):
            return [WASMTIME] + WASMTIME_CG + ["--dir", ".", "prog.wasm"]
        return [WASMTIME] + WASMTIME_CG + ["prog.wasm"]
    if runtime == "wasmtime (winch)":
        if task == "11_parallel_sum":
            return [WASMTIME] + WASMTIME_WINCH + THREAD_FLAGS + ["prog.wasm"]
        if task in ("14_file_read", "15_file_write"):
            return [WASMTIME] + WASMTIME_WINCH + ["--dir", ".", "prog.wasm"]
        return [WASMTIME] + WASMTIME_WINCH + ["prog.wasm"]
    if runtime == "iwasm":
        if task in ("14_file_read", "15_file_write"):
            return [IWASM, "--dir=.", "prog.wasm"]
        return [IWASM, "prog.wasm"]
    if runtime == "node (wasip1)":
        return [NODE, "--no-warnings", WASI_RUN, "prog.wasm", "."]
    if runtime == "wasmer (cranelift)":
        return [WASMER, "run", "--cranelift", "--mapdir", "/:" + cwd.replace("\\", "/"),
                "prog.wasm"]
    if runtime == "wasmer (llvm)":
        return [WASMER, "run", "--llvm", "--mapdir", "/:" + cwd.replace("\\", "/"),
                "prog.wasm"]
    raise SystemExit("unknown runtime %r" % runtime)


def check(runtime, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    module = os.path.join(cwd, "prog.wasm")
    if not os.path.exists(module):
        return False, "missing artifact %s" % module
    if task in ("14_file_read", "15_file_write"):
        dest = os.path.join(cwd, "data.bin")
        if not os.path.exists(dest) or os.path.getsize(dest) != os.path.getsize(DATA):
            shutil.copy(DATA, dest)
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write":
        if os.path.exists(out_bin):
            os.remove(out_bin)
        if runtime in CREATE_OUT:
            with open(out_bin, "wb"):
                pass
    try:
        p = subprocess.run(argv_for(runtime, task, cwd), cwd=cwd, capture_output=True,
                           text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (stderr tail: %r)" % (
            out[:120], want[:120], p.stderr[-200:])
    m = None
    for m in re.finditer(r"TIME_MS=([0-9.]+)", p.stderr):
        pass
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    primary_passed = None
    for runtime in RUNTIMES:
        passed = 0
        for task in TASKS:
            ok, detail = check(runtime, task)
            passed += 1 if ok else 0
            print("%-24s %-16s %s %s" % (runtime, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
        print("%s %s PASS %d/15" % (ROW, runtime, passed), flush=True)
        if primary_passed is None:
            primary_passed = passed
    print("%s %s %d/15" % (ROW, "PASS" if primary_passed == 15 else "FAIL", primary_passed))
    return 0 if primary_passed == 15 else 1


if __name__ == "__main__":
    sys.exit(main())
