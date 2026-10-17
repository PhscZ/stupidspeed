#!/usr/bin/env python3
"""Row verifier for the swipl row -- SWI-Prolog, interpreted, no build step.

"Building" a task is staging its source into the directory the harness runs it
from, so each cell is:

    exec\\swipl\\swipl\\<task>\\<task>.pl
    tools\\swipl\\bin\\swipl.exe -q -O -f none -g main -t halt <task>.pl   (cwd = that directory)

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot leave
the check behind), a TIME_MS value reached stderr (the programs print it with
format(user_error, ...)), and task 15 left out.bin behind at its full 52428800 bytes.
Tasks 14 and 15 run with data.bin staged in their working directory.

    python exec/swipl/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "swipl"
SRC = os.path.join(ROOT, "sources", "swipl")
RUN = os.path.join(ROOT, "exec", "swipl", "swipl")
SWIPL = os.path.join(ROOT, "tools", "swipl", "bin", "swipl.exe")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, task + ".pl"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def stage_fixture(cwd):
    """Task 14 reads data.bin from the working directory; keep it there."""
    dest = os.path.join(cwd, "data.bin")
    try:
        if os.path.getsize(dest) == os.path.getsize(DATA):
            return
    except OSError:
        pass
    shutil.copyfile(DATA, dest)

def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    script = os.path.join(cwd, task + ".pl")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    if task in ("14_file_read", "15_file_write"):
        stage_fixture(cwd)
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write" and os.path.exists(out_bin):
        try:
            os.remove(out_bin)
        except OSError:
            pass
    cmd = [SWIPL, "-q", "-O", "-f", "none", "-g", "main", "-t", "halt", task + ".pl"]
    try:
        p = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s)" % (out[:120], want[:120], p.returncode)
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
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1

if __name__ == "__main__":
    sys.exit(main())
