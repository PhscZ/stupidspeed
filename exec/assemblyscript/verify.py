#!/usr/bin/env python3
"""Row verifier for the assemblyscript row -- one `asc` module, six runtimes.

Fifteen hand-written AssemblyScript programs are compiled by asc into one WASI
module per task, `exec\\assemblyscript\\<task>\\prog.wasm`, and the same bytes are
then executed by six different runtimes -- exactly the entries `exec/cells.json`
registers for the row:

    asc (wasip1)         wasmtime run -C compiler=cranelift
    wasmtime (winch)     wasmtime run -C compiler=winch
    iwasm                tools\\wamr\\iwasm.exe
    node (wasip1)        node --no-warnings exec\\wasi-run.js prog.wasm .
    wasmer (cranelift)   wasmer run --cranelift --mapdir /:<dir>
    wasmer (llvm)        wasmer run --llvm --mapdir /:<dir>

Task 11 adds `-S threads=y -W threads=y -W shared-memory=y` on the two wasmtime
cells; tasks 14 and 15 add `--dir=.` there and on iwasm, and Wasmer already gets
the directory through `--mapdir`.  Wasmer is a WASIX host: a file the guest
*creates* stays in an in-memory overlay and never reaches the host, so the
registry marks those two entries `create_out` and task 15's `out.bin` is staged
empty first -- the module then truncates and overwrites it, which does reach the
host.  This verifier does the same.

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot
leave the check behind), a TIME_MS value reached stderr, and task 15 left out.bin
behind at its full 52428800 bytes.

    python exec/assemblyscript/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "assemblyscript"
SRC = os.path.join(ROOT, "sources", "assemblyscript")
RUN = os.path.join(ROOT, "exec", "assemblyscript")
WASMTIME = os.path.join(ROOT, "tools", "wasmtime46", "wasmtime.exe")
IWASM = os.path.join(ROOT, "tools", "wamr", "iwasm.exe")
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")
WASI_RUN = os.path.join(ROOT, "exec", "wasi-run.js")
WASMER = os.path.join(ROOT, "tools", "wasmer437", "bin", "wasmer.exe")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

TOOLCHAINS = [
    "asc (wasip1)", "wasmtime (winch)", "iwasm", "node (wasip1)",
    "wasmer (cranelift)", "wasmer (llvm)",
]
THREADS = ["-S", "threads=y", "-W", "threads=y", "-W", "shared-memory=y"]

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".ts"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def command(toolchain, task, cwd):
    """The argv `exec/cells.json` registers for this toolchain and task."""
    threads = task == "11_parallel_sum"
    files = task in ("14_file_read", "15_file_write")
    if toolchain == "asc (wasip1)":
        cmd = [WASMTIME, "run", "-C", "compiler=cranelift"]
        if threads:
            cmd += THREADS
        elif files:
            cmd += ["--dir=."]
        return cmd + ["prog.wasm"]
    if toolchain == "wasmtime (winch)":
        cmd = [WASMTIME, "run", "-C", "compiler=winch"]
        if threads:
            cmd += THREADS
        elif files:
            cmd += ["--dir=."]
        return cmd + ["prog.wasm"]
    if toolchain == "iwasm":
        return [IWASM] + (["--dir=."] if files else []) + ["prog.wasm"]
    if toolchain == "node (wasip1)":
        return [NODE, "--no-warnings", WASI_RUN, "prog.wasm", "."]
    if toolchain == "wasmer (cranelift)":
        return [WASMER, "run", "--cranelift", "--mapdir", "/:" + cwd, "prog.wasm"]
    if toolchain == "wasmer (llvm)":
        return [WASMER, "run", "--llvm", "--mapdir", "/:" + cwd, "prog.wasm"]
    raise SystemExit("unknown toolchain %r" % toolchain)


def check(toolchain, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    module = os.path.join(cwd, "prog.wasm")
    if not os.path.exists(module):
        return False, "missing artifact %s" % module
    out_bin = os.path.join(cwd, "out.bin")
    # The harness's own reset: a stale out.bin would be read as this run's answer.
    if task == "15_file_write" and os.path.exists(out_bin):
        os.remove(out_bin)
    # Wasmer's WASIX filesystem can overwrite a file it can see but cannot create
    # one, so those two cells get an empty out.bin to truncate and overwrite.
    if task == "15_file_write" and toolchain.startswith("wasmer"):
        with open(out_bin, "wb"):
            pass
    try:
        p = subprocess.run(command(toolchain, task, cwd), cwd=cwd, capture_output=True,
                           text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s, stderr tail: %r)" % (
            out[:120], want[:120], p.returncode, p.stderr[-160:])
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
    for toolchain in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(toolchain, task)
            total += 1
            passed += 1 if ok else 0
            print("%-19s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
    print("%s %s %d/%d" % (ROW, "PASS" if passed == total else "FAIL", passed, total))
    return 0 if passed == total else 1


if __name__ == "__main__":
    sys.exit(main())
