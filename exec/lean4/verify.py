#!/usr/bin/env python3
"""Row verifier for the lean4 row -- Lean 4, `lean -c` to C then `leanc` to an exe.

The artifact is exec\\lean4\\lean4\\<task>\\prog.exe: `lean -c <task>.c <task>.lean`
compiles the module to C and `leanc -O2 -o prog <task>.c` links it with the clang,
lld and Lean runtime the toolchain ships, and the cell runs that executable with
cwd = its own directory.  This verifier runs all fifteen and checks the three
things every row's verifier checks: stdout equals the task's own `expected
output:` line (read from the source header, so a source edit cannot leave the check
behind), a TIME_MS value reached stderr (`IO.eprintln`), and task 15 left out.bin
behind at its full 52428800 bytes.  out.bin is cleared before every run, the way
the harness clears it.

    python exec/lean4/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "lean4"
SRC = os.path.join(ROOT, "sources", "lean4")
RUN = os.path.join(ROOT, "exec", "lean4", "lean4")
TIMEOUT = 900
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, task + ".lean"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    prog = os.path.join(cwd, "prog.exe")
    if not os.path.exists(prog):
        return False, "missing artifact %s" % prog
    out_bin = os.path.join(cwd, "out.bin")
    try:
        os.remove(out_bin)
    except OSError:
        pass
    try:
        p = subprocess.run([prog], cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s, stderr tail %r)" % (
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
    passed = 0
    for task in TASKS:
        ok, detail = check(task)
        passed += 1 if ok else 0
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1

if __name__ == "__main__":
    sys.exit(main())
