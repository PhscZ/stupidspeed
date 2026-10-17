#!/usr/bin/env python3
"""Row verifier for the c-wasm row -- one prog.wasm per task, six runtimes.

    clang (wasm32-wasip1) -> exec\\c-wasm\\<task>\\prog.wasm

The same fifteen modules are executed by six WASI hosts, exactly as
exec/cells.json records them: wasmtime with Cranelift and with Winch, WAMR's
iwasm, node's own WASI shim (exec/wasi-run.js), and Wasmer 4.3.7 with its
Cranelift and LLVM code generators.  Task 11 is the wasi-threads build, so every
run line carries the thread flags the registry gives it.

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot
leave the check behind), a TIME_MS value reached stderr, and task 15 left out.bin
behind at its full 52428800 bytes.  Wasmer is a WASIX host and never lets a file
the program *creates* reach the host filesystem, so its two cells get an empty
out.bin staged first -- the same `create_out` arrangement exec/harness.py uses.

    python exec/c-wasm/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "c-wasm"
SRC = os.path.join(ROOT, "sources", "c-wasm")
RUN = os.path.join(ROOT, "exec", "c-wasm")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 600
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

# (toolchain label, argv factory, create_out)
TOOLCHAINS = [
    ("wasmtime-cranelift",
     lambda cwd: [WASMTIME, "-C", "compiler=cranelift"] + THREAD_FLAGS + ["--dir", ".", "prog.wasm"],
     False),
    ("wasmtime-winch",
     lambda cwd: [WASMTIME, "-C", "compiler=winch"] + THREAD_FLAGS + ["--dir", ".", "prog.wasm"],
     False),
    ("iwasm",
     lambda cwd: [IWASM, "--dir=.", "prog.wasm"],
     False),
    ("node-wasip1",
     lambda cwd: [NODE, "--no-warnings", WASI_RUN, "prog.wasm", "."],
     False),
    ("wasmer-cranelift",
     lambda cwd: [WASMER, "run", "--cranelift", "--mapdir", "/:" + cwd, "prog.wasm"],
     True),
    ("wasmer-llvm",
     lambda cwd: [WASMER, "run", "--llvm", "--mapdir", "/:" + cwd, "prog.wasm"],
     True),
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".c"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def stage(cwd, task):
    """Put the fixture where the module reads it, and clear a stale out.bin."""
    if task == "14_file_read":
        dest = os.path.join(cwd, "data.bin")
        try:
            fresh = os.path.getsize(dest) == os.path.getsize(DATA)
        except OSError:
            fresh = False
        if not fresh:
            shutil.copy(DATA, dest)


def check(toolchain, argv_for, create_out, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    prog = os.path.join(cwd, "prog.wasm")
    if not os.path.exists(prog):
        return False, "missing artifact %s" % prog
    stage(cwd, task)
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write":
        if os.path.exists(out_bin):
            os.remove(out_bin)
        if create_out:
            with open(out_bin, "wb"):
                pass
    try:
        p = subprocess.run(argv_for(cwd), cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s; stderr tail %r)" % (
            out[:120], want[:120], p.returncode, p.stderr[-200:])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    total = passed = 0
    for label, argv_for, create_out in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(label, argv_for, create_out, task)
            total += 1
            passed += 1 if ok else 0
            print("%-17s %-16s %s %s" % (label, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
    print("%s %s %d/%d" % (ROW, "PASS" if passed == total else "FAIL", passed, total))
    return 0 if passed == total else 1


if __name__ == "__main__":
    sys.exit(main())
