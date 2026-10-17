#!/usr/bin/env python3
"""Row verifier for the scheme row -- Chez Scheme, `scheme --script`, no build step.

The artifact is the staged script itself (exec\\scheme\\chez\\<task>\\<task>.ss) and
the cell runs it with cwd = that directory, because task 03 `load`s
03_func_sum_add_one.ss through the working directory.  This verifier runs all
fifteen tasks with the argv exec/cells.json records and checks the three things
every row's verifier checks: stdout equals the task's own `expected output:` line
(read from the source header, so a source edit cannot leave the check behind), a
TIME_MS value was produced, and task 15 left out.bin behind at its full 52428800
bytes.

This row has no reachable stderr -- Chez's console-error-port is the console, and
this host sends the console to stdout when it is redirected -- so TIME_MS goes to
time.txt in the task directory, which is why the registry's `clean` list names
time.txt.  It is deleted before every run, the way the harness deletes it, so a
stale number can never be read as this run's.

    python exec/scheme/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "scheme"
SRC = os.path.join(ROOT, "sources", "scheme")
RUN = os.path.join(ROOT, "exec", "scheme", "chez")
SCHEME = os.path.join(ROOT, "tools", "chez", "bin", "ta6nt", "scheme.exe")
OUT_BIN_SIZE = 52428800

# Per-task timeouts, the ones exec/cells.json registers for this row.
TIMEOUTS = {"01_branches": 1200, "02_switch_case": 1200, "06_char_count": 1200,
            "07_string_append": 3600, "11_parallel_sum": 1200}
DEFAULT_TIMEOUT = 600

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, task + ".ss"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def remove(path):
    try:
        os.remove(path)
    except OSError:
        pass

def check(task):
    want = expected_output(task)
    timeout = TIMEOUTS.get(task, DEFAULT_TIMEOUT)
    cwd = os.path.join(RUN, task)
    script = os.path.join(cwd, task + ".ss")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    time_txt = os.path.join(cwd, "time.txt")
    out_bin = os.path.join(cwd, "out.bin")
    remove(time_txt)
    remove(out_bin)
    try:
        p = subprocess.run([SCHEME, "--optimize-level", "3", "--script", task + ".ss"],
                           cwd=cwd, capture_output=True, text=True, timeout=timeout)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % timeout
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s, stderr tail %r)" % (
            out[:120], want[:120], p.returncode, p.stderr[-200:])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m and os.path.exists(time_txt):
        with open(time_txt, encoding="utf-8", errors="replace") as fh:
            m = re.search(r"TIME_MS=([0-9.]+)", fh.read())
    if not m:
        return False, "no TIME_MS in time.txt or on stderr (stderr tail %r)" % p.stderr[-200:]
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
