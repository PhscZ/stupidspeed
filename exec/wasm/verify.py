#!/usr/bin/env python3
"""Row verifier for the wasm row -- hand-written WebAssembly text.

Four cells per task, all on the same sources:

  wasmtime (cranelift)   wasmtime run -C compiler=cranelift <task>.wat
  wasmtime (winch)       wasmtime run -C compiler=winch    <task>.wat
  wasmer (cranelift)     wasmer run --cranelift --mapdir /:<dir> prog.wasm
  wasmer (llvm)          wasmer run --llvm      --mapdir /:<dir> prog.wasm

wasmtime parses the .wat text form on every run, so the .wat is the artifact;
Wasmer cannot, so the same task also carries a `prog.wasm` assembled from it by
`exec/wasm/build_all.bat`.  Task 11 is a wasi-threads module, so its wasmtime
cells need `-S threads=y -W threads=y -W shared-memory=y` (Wasmer has threads on
by default).  Tasks 14 and 15 reach the cell directory through `--dir=.` on
wasmtime and `--mapdir /:<dir>` on Wasmer.

Wasmer is a WASIX host, so a file the program *creates* stays in an in-memory
overlay that is discarded at exit; the registry marks those cells `create_out`
and the harness pre-creates an empty `out.bin` after its reset, which the module
then truncates and overwrites.  This verifier does the same thing.

Checks, per cell: stdout equals the task's own `expected output:` line (read from
the source header, so a source edit cannot leave the check behind), a TIME_MS
value reached stderr, and task 15 left out.bin at its full 52428800 bytes.  A
task counts as passed only when all four of its cells pass.

    python exec/wasm/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "wasm"
SRC = os.path.join(ROOT, "sources", "wasm")
RUN = os.path.join(ROOT, "exec", "wasm", "wat")
WASMTIME = os.path.join(ROOT, "tools", "wasmtime46", "wasmtime.exe")
WASMER = os.path.join(ROOT, "tools", "wasmer437", "bin", "wasmer.exe")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800
THREAD_FLAGS = ["-S", "threads=y", "-W", "threads=y", "-W", "shared-memory=y"]

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".wat"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def cells(task, cwd):
    """(toolchain, argv, create_out) for one task, in registry order."""
    out = []
    for tc, compiler in (("wasmtime (cranelift)", "cranelift"), ("wasmtime (winch)", "winch")):
        argv = [WASMTIME, "run", "-C", "compiler=" + compiler]
        if task == "11_parallel_sum":
            argv += THREAD_FLAGS
        elif task in ("14_file_read", "15_file_write"):
            argv.append("--dir=.")
        argv.append(task + ".wat")
        out.append((tc, argv, False))
    for tc, gen in (("wasmer (cranelift)", "--cranelift"), ("wasmer (llvm)", "--llvm")):
        out.append((tc, [WASMER, "run", gen, "--mapdir", "/:" + cwd, "prog.wasm"], True))
    return out


def run_cell(tc, argv, cwd, task, create_out):
    """Run one cell and check it.  Returns (ok, detail)."""
    wat = os.path.join(cwd, task + ".wat")
    if not os.path.exists(wat):
        return False, "missing artifact %s" % wat
    if tc.startswith("wasmer") and not os.path.exists(os.path.join(cwd, "prog.wasm")):
        return False, "missing artifact %s" % os.path.join(cwd, "prog.wasm")
    if task == "14_file_read" and not os.path.exists(os.path.join(cwd, "data.bin")):
        return False, "missing fixture data.bin in %s" % cwd
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write":
        # The reset the harness does before every run: a stale out.bin would be
        # read as this run's answer (and several programs refuse to start).
        try:
            os.remove(out_bin)
        except OSError:
            pass
        if create_out:
            # WASIX cannot create a file in a mapped directory; it can overwrite
            # one it can already see on the host.
            open(out_bin, "wb").close()
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    want = expected_output(task)
    got = p.stdout.replace("\r\n", "\n").strip().lstrip("\ufeff")
    if got != want:
        return False, ("stdout %r != expected %r (stderr tail %r)"
                       % (got[:120], want[:120], p.stderr[-200:]))
    m = None
    for m in re.finditer(r"TIME_MS=([0-9.]+)", p.stderr):
        pass
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, m.group(1)


def main():
    passed = 0
    for task in TASKS:
        cwd = os.path.join(RUN, task)
        results, details = [], []
        for tc, argv, create_out in cells(task, cwd):
            ok, detail = run_cell(tc, argv, cwd, task, create_out)
            results.append((tc, ok, detail))
            if not ok:
                details.append("%s: %s" % (tc, detail))
        ok = all(r[1] for r in results)
        passed += 1 if ok else 0
        summary = " ".join("%s=%s" % (tc.split()[0].split("(")[0].strip(), d)
                           for tc, good, d in results if good)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", summary if ok else "; ".join(details)),
              flush=True)
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
