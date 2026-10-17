#!/usr/bin/env python3
"""Row verifier for the nim row -- one front end over three code generators.

Runs each of the fifteen built programs of every toolchain (nim: C/gcc,
nim (cpp): C++/g++, nim (clang): C/LLVM clang) and checks the three things every
row's verifier checks: stdout equals the task's own `expected output:` line (read
from the source header, so a source edit cannot leave the check behind), a
TIME_MS value reached stderr, and task 15 left out.bin behind at its full
52428800 bytes.

    python exec/nim/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "nim"
SRC = os.path.join(ROOT, "sources", "nim")
RUN = os.path.join(ROOT, "exec", "nim")
TOOLCHAINS = ["nim", "cpp", "clang"]
TIMEOUT = 600
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, "_" + task + ".nim"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def check(toolchain, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, toolchain, task)
    exe = os.path.join(cwd, "prog.exe")
    if not os.path.exists(exe):
        return False, "missing artifact %s" % exe
    try:
        p = subprocess.run([exe], cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r" % (out[:120], want[:120])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        out_bin = os.path.join(cwd, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)

def main():
    passed = 0
    total = len(TASKS) * len(TOOLCHAINS)
    for toolchain in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(toolchain, task)
            print("%-6s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail), flush=True)
            passed += 1 if ok else 0
    print("%s %s %d/%d" % (ROW, "PASS" if passed == total else "FAIL", passed, total))
    return 0 if passed == total else 1

if __name__ == "__main__":
    sys.exit(main())
