#!/usr/bin/env python3
"""Row verifier for the compiled toolchain of the python row: nuitka.

`nuitka --standalone <task>.py` turns the source into a directory of its own and
a standalone executable in it, and that is what the harness runs:

    exec/python/nuitka/<task>/<task>.dist/<task>.exe

so both the artifact the cell names and the working directory the cell runs in
are inside `<task>.dist`, which is also where tasks 14 and 15 need their
data.bin fixture.  The row's three interpreters are verified by
`verify_interpreters.py`; `exec/python/verify.py` drives both.

The three checks are the row contract's: stdout equals the task's own
`expected output:` line read from the source header, a TIME_MS value reached
stderr, and task 15 left out.bin behind at 52428800 bytes.

    python exec/python/verify_compilers.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "python"
SRC = os.path.join(ROOT, "sources", ROW)
RUN = os.path.join(ROOT, "exec", ROW, "nuitka")
TIMEOUT = 900
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".py"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task, task + ".dist")
    exe = os.path.join(cwd, task + ".exe")
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
    passed = {}
    for task in TASKS:
        ok, detail = check(task)
        print("%-10s %-16s %s %s" % ("nuitka", task, "OK  " if ok else "FAIL", detail),
              flush=True)
        passed[task] = ok
    n = sum(1 for task in TASKS if passed[task])
    print("%s compilers %s %d/15" % (ROW, "PASS" if n == len(TASKS) else "FAIL", n))
    return passed


if __name__ == "__main__":
    ok = main()
    sys.exit(0 if all(ok.values()) else 1)
