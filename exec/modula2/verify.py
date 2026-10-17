#!/usr/bin/env python3
"""Row verifier for the modula2 row -- ADW's ISO Modula-2 compiler.

The fifteen tasks are compiled to exec/modula2/<task>/prog.exe and run from that
directory, which is what the registry's `artifact`, `cmd` and `cwd` name.

Two things about this row differ from the common shape:

  * ADW exposes no stderr handle, so the sources write their `TIME_MS=` line to
    `time.txt` in the working directory instead -- the header says so and
    exec/cells.json carries no `time_file`, because the fallback is in the cell's
    own directory.  A stale `time.txt` would be read as this run's number, so it
    is deleted before every run, exactly as exec/harness.py's reset() does.
  * the clock is ISO `SysClock.GetClock`, local time of day in whole seconds
    plus `SysClock.fractions`, so a cell that finishes inside one second is read
    in whole seconds.  That is the row's clock, not this verifier's business.

Each task is checked the three ways the row contract asks: stdout, stripped,
equals the task's own `expected output:` line read from the source header; a
TIME_MS value is present in time.txt; and task 15 left out.bin at 52428800 bytes.

    python exec/modula2/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "modula2"
SRC = os.path.join(ROOT, "sources", "modula2")
OUT = os.path.join(ROOT, "exec", "modula2")

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# Task 07 appends 750000 times and measured 48 s on an idle host; the registry
# gives the cell no explicit timeout, so the harness's default applies.  Here it
# gets a wide bound for the shared 8-core box.
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*\*\)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".mod"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    cwd = os.path.join(OUT, task)
    prog = os.path.join(cwd, "prog.exe")
    if not os.path.exists(prog):
        return False, "missing artifact %s" % prog
    time_file = os.path.join(cwd, "time.txt")
    try:
        os.remove(time_file)
    except OSError:
        pass
    # ADW's SeqFile.OpenWrite is create-new, so task 15 fails on a stale out.bin
    # exactly as a C row's exclusive-create task would. exec/harness.py's reset()
    # removes it before every cell; this mirrors that.
    if task == "15_file_write":
        try:
            os.remove(os.path.join(cwd, "out.bin"))
        except OSError:
            pass
    try:
        # The absolute path, not the bare name: Windows resolves a bare
        # executable name against the *parent's* working directory and PATH, not
        # against subprocess's `cwd`, so `["prog.exe"]` is not found here.
        p = subprocess.run([prog], cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    except OSError as exc:
        return False, "cannot start %s: %s" % (prog, exc)
    out = p.stdout.replace("\r\n", "\n").strip()
    want = expected_output(task)
    if out != want:
        return False, "stdout %r != expected %r" % (out[:120], want[:120])
    try:
        with open(time_file, encoding="utf-8", errors="replace") as fh:
            timing = fh.read()
    except OSError:
        return False, "no time.txt (stdout was %r)" % out[:120]
    m = re.search(r"TIME_MS=([0-9.]+)", timing)
    if not m:
        return False, "no TIME_MS in time.txt (%r)" % timing[:120]
    if task == "15_file_write":
        out_bin = os.path.join(cwd, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, m.group(1)


def main():
    passed = 0
    for task in TASKS:
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL",
                               ("TIME_MS=" + detail) if ok else detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
