#!/usr/bin/env python3
"""Row verifier for the cpp-wasm row -- one C++ source per task, six WebAssembly runtimes.

    exec\\cpp-wasm\\<task>\\prog.wasm   the single artifact, built by the wasi-sdk clang++
    six runtime entries in exec/cells.json run those same bytes:
        clang++ (wasm32-wasip1)  wasmtime 46.0.3, Cranelift, with the threads flags
        wasmtime (winch)         wasmtime 46.0.3, Winch
        iwasm                    WAMR 2.4.5
        node (wasip1)            node 22 through the repository's own WASI shim
        wasmer (cranelift)       Wasmer 4.3.7 --cranelift
        wasmer (llvm)            Wasmer 4.3.7 --llvm

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot leave
the check behind), a TIME_MS value reached stderr, and task 15 left out.bin at its
full 52428800 bytes.  The Wasmer entries are `create_out` in the registry: WASIX can
overwrite a file it can see on the host but cannot create one, so an empty out.bin is
staged after the reset, exactly as exec/harness.py does it.

    python exec/cpp-wasm/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "cpp-wasm"
SRC = os.path.join(ROOT, "sources", "cpp-wasm")
RUN = os.path.join(ROOT, "exec", "cpp-wasm")
TIMEOUT = 600
OUT_BIN_SIZE = 52428800

WASMTIME = os.path.join(ROOT, "tools", "wasmtime46", "wasmtime.exe")
IWASM = os.path.join(ROOT, "tools", "wamr", "iwasm.exe")
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")
WASI_RUN = os.path.join(ROOT, "exec", "wasi-run.js")
WASMER = os.path.join(ROOT, "tools", "wasmer437", "bin", "wasmer.exe")

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# (label, argv builder, create_out)
TOOLCHAINS = [
    ("clang++ (wasm32-wasip1)", lambda cwd: [
        WASMTIME, "-C", "compiler=cranelift", "-S", "threads=y", "-W", "threads=y",
        "-W", "shared-memory=y", "--dir", ".", "prog.wasm"], False),
    ("wasmtime (winch)", lambda cwd: [
        WASMTIME, "-C", "compiler=winch", "-S", "threads=y", "-W", "threads=y",
        "-W", "shared-memory=y", "--dir", ".", "prog.wasm"], False),
    ("iwasm", lambda cwd: [IWASM, "--dir=.", "prog.wasm"], False),
    ("node (wasip1)", lambda cwd: [NODE, "--no-warnings", WASI_RUN, "prog.wasm", "."], False),
    ("wasmer (cranelift)", lambda cwd: [
        WASMER, "run", "--cranelift", "--mapdir", "/:" + cwd, "prog.wasm"], True),
    ("wasmer (llvm)", lambda cwd: [
        WASMER, "run", "--llvm", "--mapdir", "/:" + cwd, "prog.wasm"], True),
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".cpp"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def matches(got, want):
    """The harness's rule: the answer, or the last non-empty line of the stream."""
    got = got.lstrip("\ufeff").strip()
    if got == want:
        return True
    lines = [ln.strip().lstrip("\ufeff") for ln in got.splitlines() if ln.strip()]
    return bool(lines) and lines[-1] == want


def check(toolchain, argv_for, create_out, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    artifact = os.path.join(cwd, "prog.wasm")
    if not os.path.exists(artifact):
        return False, "missing artifact %s" % artifact
    if task == "14_file_read":
        fixture = os.path.join(cwd, "data.bin")
        if not os.path.exists(fixture) or os.path.getsize(fixture) != os.path.getsize(
                os.path.join(ROOT, "data.bin")):
            subprocess.run(["cmd", "/c", "copy", "/y", os.path.join(ROOT, "data.bin"),
                            fixture], capture_output=True)
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write":
        if os.path.exists(out_bin):
            try:
                os.remove(out_bin)
            except OSError:
                pass
        if create_out:
            with open(out_bin, "wb"):
                pass
    try:
        p = subprocess.run(argv_for(cwd), cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n")
    if not matches(out, want):
        return False, "stdout %r != expected %r (exit %s, stderr tail %r)" % (
            out.strip()[:120], want[:120], p.returncode, p.stderr.strip()[-160:])
    m = None
    for m in re.finditer(r"TIME_MS=([0-9.]+)", p.stderr):
        pass
    if not m:
        return False, "no TIME_MS on stderr (exit %s, stderr tail: %r)" % (
            p.returncode, p.stderr[-200:])
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    tasks_all_ok = [True] * len(TASKS)
    for label, argv_for, create_out in TOOLCHAINS:
        tc_passed = 0
        for i, task in enumerate(TASKS):
            ok, detail = check(label, argv_for, create_out, task)
            tc_passed += 1 if ok else 0
            if not ok:
                tasks_all_ok[i] = False
            print("%-22s %-16s %s %s" % (label, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
        print("--- %s %s %d/15" % (label, "PASS" if tc_passed == 15 else "FAIL", tc_passed),
              flush=True)
    good = sum(1 for ok in tasks_all_ok if ok)
    print("%s %s %d/15" % (ROW, "PASS" if good == 15 else "FAIL", good))
    return 0 if good == 15 else 1


if __name__ == "__main__":
    sys.exit(main())
