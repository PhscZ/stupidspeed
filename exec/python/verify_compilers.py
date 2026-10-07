#!/usr/bin/env python3
"""Verifier for the nuitka toolchain of the sources/python row.

Runs each of the 15 built executables in exec/python/nuitka/<task>/<task>.dist/<task>.exe and checks
  1. stripped stdout == that task's `expected output:` line (read from the source header);
  2. a TIME_MS value on stderr;
  3. task 15 leaves out.bin behind.
Prints one line per task and a final `python-nuitka PASS n/15`.

The cpython / pypy / graalpy toolchains of this row live in exec/python/verify.py.
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
SRC = os.path.join(ROOT, "sources", "python")
FIXTURE = os.path.join(ROOT, "data.bin")
ROW = "python-nuitka"

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

TIMEOUT = 900  # seconds, per task


def expected_output(task):
    path = os.path.join(SRC, task + ".py")
    with open(path, "r", encoding="utf-8") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("cannot parse expected output from " + path)
    return m.group(1)


def run(task):
    tdir = os.path.join(HERE, "nuitka", task, task + ".dist")
    exe = os.path.join(tdir, task + ".exe")
    if not os.path.isfile(exe):
        return False, "executable missing (build failed?)", ""

    if task in ("14_file_read", "15_file_write"):
        if not os.path.isfile(os.path.join(tdir, "data.bin")):
            if not os.path.exists(os.path.join(tdir, "data.bin")) or not os.path.samefile(FIXTURE, os.path.join(tdir, "data.bin")): shutil.copyfile(FIXTURE, os.path.join(tdir, "data.bin"))
    if task == "15_file_write":
        p = os.path.join(tdir, "out.bin")
        if os.path.exists(p):
            os.remove(p)

    try:
        proc = subprocess.run([exe], cwd=tdir, capture_output=True, text=True,
                              timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT, ""

    out = proc.stdout.strip()
    err = proc.stderr
    want = expected_output(task)

    if out != want:
        return False, "stdout mismatch: expected %r got %r" % (want, out), err

    m = re.search(r"TIME_MS=([0-9.]+)", err)
    if not m:
        return False, "no TIME_MS on stderr", err

    if task == "15_file_write":
        ob = os.path.join(tdir, "out.bin")
        if not os.path.isfile(ob):
            return False, "out.bin not left behind", err
        if os.path.getsize(ob) != 52428800:
            return False, "out.bin size %d != 52428800" % os.path.getsize(ob), err

    return True, m.group(1), err


def main():
    passed = 0
    for task in TASKS:
        ok, info, err = run(task)
        if ok:
            passed += 1
            print("%s OK TIME_MS=%s" % (task, info))
        else:
            print("%s FAIL" % task)
            print("    %s" % info)
            tail = "\n".join(err.strip().splitlines()[-8:])
            if tail:
                print("    stderr tail: %s" % tail.replace("\n", "\n    "))
    print("%s PASS %d/15" % (ROW, passed))
    return 0 if passed == 15 else 1


if __name__ == "__main__":
    sys.exit(main())
