#!/usr/bin/env python3
"""Row verifier for the go row -- the same fifteen Go programs through two compilers.

    gc      (go 1.26)  -> exec\\go\\gc\\<task>\\prog.exe      from sources\\go\\
    tinygo  (0.42)     -> exec\\go\\tinygo\\<task>\\prog.exe  from sources\\tinygo\\

The two halves build different source directories: TinyGo's Windows target has no
fsync, so sources/tinygo/15_file_write.go flushes by closing instead.  Expected
output is read from the header of the source file that toolchain actually built.

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line, a TIME_MS value reached stderr, and task 15 left out.bin
behind at its full 52428800 bytes.

    python exec/go/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "go"
RUN = os.path.join(ROOT, "exec", "go")
DATA = os.path.join(ROOT, "data.bin")
# The box is shared, so wall times run far above the recorded speeds: task 07 is
# the long cell on both halves (11.9 s for gc, 62 s for tinygo when idle), and a
# 600 s limit cut the gc cell off mid-run.  Both halves get 1800 s.
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# toolchain label -> source directory it was built from
TOOLCHAINS = [
    ("gc", os.path.join(ROOT, "sources", "go")),
    ("tinygo", os.path.join(ROOT, "sources", "tinygo")),
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(src, task):
    with open(os.path.join(src, task + ".go"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def stage(cwd, task):
    """Put the fixture where task 14 reads it (task 15 reads nothing)."""
    if task == "14_file_read":
        dest = os.path.join(cwd, "data.bin")
        try:
            fresh = os.path.getsize(dest) == os.path.getsize(DATA)
        except OSError:
            fresh = False
        if not fresh:
            shutil.copy(DATA, dest)

def check(toolchain, src, task):
    want = expected_output(src, task)
    cwd = os.path.join(RUN, toolchain, task)
    prog = os.path.join(cwd, "prog.exe")
    if not os.path.exists(prog):
        return False, "missing artifact %s" % prog
    stage(cwd, task)
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write" and os.path.exists(out_bin):
        os.remove(out_bin)
    try:
        p = subprocess.run([prog], cwd=cwd, capture_output=True, text=True,
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
    for toolchain, src in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(toolchain, src, task)
            total += 1
            passed += 1 if ok else 0
            print("%-8s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
    print("%s %s %d/%d" % (ROW, "PASS" if passed == total else "FAIL", passed, total))
    return 0 if passed == total else 1

if __name__ == "__main__":
    sys.exit(main())
