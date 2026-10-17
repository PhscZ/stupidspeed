#!/usr/bin/env python3
"""Row verifier for the spidermonkey row -- the JavaScript shell, interpreted.

`tools/spidermonkey/js.exe <task>.js`, run from the task's own directory, which
is where the harness runs it too.  The shell is the whole runtime: no build step,
no installer, no `require`, no `worker_threads` (task 11 uses `evalInWorker` and
a registered `SharedArrayBuffer`, which the source header records).

Checks per task: stripped stdout equals the task's own `expected output:` line
(read from the source header, so a source edit cannot leave the check behind),
a TIME_MS value on stderr, and task 15's out.bin at its full 52428800 bytes.

    python exec/spidermonkey/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "spidermonkey"
SRC = os.path.join(ROOT, "sources", "spidermonkey")
RUN = os.path.join(ROOT, "exec", "spidermonkey", "spidermonkey")
JS = os.path.join(ROOT, "tools", "spidermonkey", "js.exe")
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
    with open(os.path.join(SRC, task + ".js"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    script = os.path.join(cwd, task + ".js")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    if task in ("14_file_read", "15_file_write"):
        dest = os.path.join(cwd, "data.bin")
        if not os.path.exists(dest) or os.path.getsize(dest) != os.path.getsize(DATA):
            shutil.copy(DATA, dest)
    if task == "15_file_write" and os.path.exists(os.path.join(cwd, "out.bin")):
        os.remove(os.path.join(cwd, "out.bin"))
    try:
        p = subprocess.run([JS, task + ".js"], cwd=cwd, capture_output=True,
                           text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (stderr tail: %r)" % (
            out[:120], want[:120], p.stderr[-200:])
    m = None
    for m in re.finditer(r"TIME_MS=([0-9.]+)", p.stderr):
        pass
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
    for task in TASKS:
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
