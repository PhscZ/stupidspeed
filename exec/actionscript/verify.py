#!/usr/bin/env python3
"""Row verifier for the actionscript row -- AIR 51.4.1, amxmlc + adt.

Runs all fifteen packaged programs and checks the three things every row's
verifier checks, with this row's two documented differences:

  * stdout -- every AIR process writes a fixed 2354-byte ASCII-art banner before
    the program's own output, so the answer is the last line of stdout rather
    than all of it;
  * TIME_MS -- AIR has no stderr, so the programs write it to `time.txt` in
    `File.applicationStorageDirectory`, and task 15's `out.bin` lands there too:
    `%APPDATA%\\stupidspeed.actionscript\\Local Store\\`.

    python exec/actionscript/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "actionscript"
SRC = os.path.join(ROOT, "sources", "actionscript")
RUN = os.path.join(ROOT, "exec", "actionscript")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800
BANNER = 2354

STORE = os.path.join(os.environ.get("APPDATA", ""), "stupidspeed.actionscript",
                     "Local Store")
TIME_FILE = os.path.join(STORE, "time.txt")
OUT_FILE = os.path.join(STORE, "out.bin")

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, "_" + task + ".as"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def clear():
    for path in (TIME_FILE, OUT_FILE):
        if os.path.exists(path):
            try:
                os.remove(path)
            except OSError:
                pass


def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    exe = os.path.join(cwd, "out", "prog.exe")
    if not os.path.exists(exe):
        return False, "missing artifact %s" % exe
    try:
        p = subprocess.run([exe], cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n")
    lines = [ln.strip() for ln in out.splitlines() if ln.strip()]
    if not lines or lines[-1] != want:
        return False, "stdout %r != expected %r (exit %s)" % (
            lines[-1][:120] if lines else out[:120], want[:120], p.returncode)
    if not os.path.exists(TIME_FILE):
        return False, "no time.txt at %s (exit %s)" % (TIME_FILE, p.returncode)
    with open(TIME_FILE, encoding="utf-8", errors="replace") as fh:
        m = re.search(r"TIME_MS=([0-9.]+)", fh.read())
    if not m:
        return False, "no TIME_MS in %s" % TIME_FILE
    if task == "15_file_write":
        size = os.path.getsize(OUT_FILE) if os.path.exists(OUT_FILE) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    passed = 0
    for task in TASKS:
        clear()
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
    clear()
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
