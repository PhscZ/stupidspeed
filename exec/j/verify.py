#!/usr/bin/env python3
"""Verifier for the j row (J 9.7, jconsole).

Toolchains: j9.7.  No build step: each task directory holds the source staged by
build_all.bat (plus AddOne.ijs for task 03 and data.bin for tasks 14/15).

Run line (per the source header):  jconsole.exe <task>.ijs
`-jprofile` must NOT be used: it skips the profile that loads the standard library,
so stdout/LF/exit are undefined.

Checks per task:
  1. stripped stdout == the task's `expected output:` line (read from sources/j);
  2. a TIME_MS value is present on stderr;
  3. task 15 leaves out.bin (52428800 bytes) in its working directory.

Run:  python exec\\j\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))          # exec/j
REPO = os.path.dirname(os.path.dirname(HERE))              # C:\stupidspeed
SRC = os.path.join(REPO, "sources", "j")
DATA = os.path.join(REPO, "data.bin")
ROW = "j"

TOOLCHAINS = ["j9.7"]

EXE = {
    "j9.7": r"C:\stupidspeed\tools\j9.7\bin\jconsole.exe",
}

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# J is a pure interpreter: task 09 is ~331M interpreted calls, task 11 runs four
# interpreted workers.  Generous ceiling.
TIMEOUT = 7200
OUT_SIZE = 52428800


def expected(task):
    with open(os.path.join(SRC, task + ".ijs"), "r", encoding="utf-8", errors="replace") as f:
        first = f.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected output line in %s.ijs" % task)
    return m.group(1)


def tail(text, n=600):
    text = text.strip()
    return text[-n:] if len(text) > n else text


def run_one(tool, task):
    d = os.path.join(HERE, tool, task)
    exp = expected(task)
    if task in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copyfile(DATA, os.path.join(d, "data.bin"))
    if task == "15_file_write":
        ob = os.path.join(d, "out.bin")
        if os.path.exists(ob):
            os.remove(ob)
    cmd = [EXE[tool], task + ".ijs"]
    try:
        p = subprocess.run(cmd, cwd=d, capture_output=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT, ""

    out = p.stdout.decode("utf-8", "replace").strip()
    err = p.stderr.decode("utf-8", "replace")
    problems = []
    if out != exp:
        problems.append("expected %r got %r" % (exp, out))
    m = re.search(r"TIME_MS=([0-9.]+)", err)
    time_ms = m.group(1) if m else None
    if time_ms is None:
        problems.append("no TIME_MS on stderr")
    if task == "15_file_write":
        ob = os.path.join(d, "out.bin")
        if not os.path.exists(ob):
            problems.append("out.bin missing")
        elif os.path.getsize(ob) != OUT_SIZE:
            problems.append("out.bin size %d != %d" % (os.path.getsize(ob), OUT_SIZE))
    if problems:
        return False, "; ".join(problems) + "\n    stderr tail: " + tail(err), time_ms
    return True, "", time_ms


def main():
    overall = 0
    for tool in TOOLCHAINS:
        print("=== %s/%s ===" % (ROW, tool))
        passed = 0
        for task in TASKS:
            ok, msg, time_ms = run_one(tool, task)
            if ok:
                passed += 1
                print("%s OK TIME_MS=%s" % (task, time_ms), flush=True)
            else:
                print("%s FAIL" % task, flush=True)
                print("    " + msg.replace("\n", "\n    "), flush=True)
        print("%s/%s PASS %d/15" % (ROW, tool, passed), flush=True)
        overall += passed
    print("%s TOTAL PASS %d/15" % (ROW, overall), flush=True)
    return 0 if overall == len(TASKS) * len(TOOLCHAINS) else 1


if __name__ == "__main__":
    sys.exit(main())
