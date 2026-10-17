#!/usr/bin/env python3
"""Row verifier for the gforth row -- gforth 0.7.9, interpreted, no build step.

Runs each of the fifteen staged scripts and checks the three things every row's
verifier checks: stdout equals the task's own `expected output:` line (read from
the source header, so a source edit cannot leave the check behind), a TIME_MS
value reached stderr, and task 15 left out.bin behind at its full 52428800 bytes.

The scripts live flat in exec/gforth (the registry's cwd), because gforth.exe
finds its image gforth.fi beside the executable and the working directory only
has to hold the data.bin fixture for tasks 14 and 15.

    python exec/gforth/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "gforth"
SRC = os.path.join(ROOT, "sources", "gforth")
RUN = os.path.join(ROOT, "exec", "gforth")
GFORTH = os.path.join(ROOT, "tools", "gforth", "gforth.exe")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, task + ".fs"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def check(task):
    want = expected_output(task)
    script = os.path.join(RUN, task + ".fs")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    try:
        p = subprocess.run([GFORTH, task + ".fs"], cwd=RUN, capture_output=True,
                           text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r" % (out[:120], want[:120])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        out_bin = os.path.join(RUN, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)

def main():
    passed = 0
    for task in TASKS:
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1

if __name__ == "__main__":
    sys.exit(main())
