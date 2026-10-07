#!/usr/bin/env python3
"""Verifier for the Assembly (x86-64 nasm) row.

Runs each task's freestanding PE program, exec/assembly/<task>/prog.exe, and checks

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present on stderr;
  3. task 15 additionally leaves out.bin (52428800 bytes) beside the program.

Each task has its own directory because the build writes prog.exe, and the source lives
beside it. There is no runtime: the executable is a PE32+ console program that imports
only kernel32.dll, so nothing has to be installed and nothing has to be on PATH.

TIME_MS is written to stderr by the program's own report_time routine, through
GetStdHandle(STD_ERROR_HANDLE) and WriteFile -- there is no libc here and no printf, so
the number is formatted by hand. stdout carries only the answer line.

Tasks 14 and 15 use CreateFileA with a relative name, so "data.bin" is copied in for task
14 and out.bin appears in the same directory for task 15. Task 11 is four real kernel
threads made with CreateThread and joined with WaitForSingleObject; it needs no flag and
no extra staging.

Run:  python exec\\assembly\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", "assembly")
OUT = HERE
DATA = os.path.join(ROOT, "data.bin")
ROW = "assembly"

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

TIMEOUT = 900
OUT_SIZE = 52428800
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")


def expected(task):
    with open(os.path.join(SRC, task + ".asm"), encoding="utf-8", errors="replace") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected-output line in " + task)
    return m.group(1).strip()


def main():
    passed = 0
    failed = []
    for task in TASKS:
        d = os.path.join(OUT, task)
        exe = os.path.join(d, "prog.exe")
        exp = expected(task)
        if not os.path.exists(exe):
            print("%s FAIL (no prog.exe; run build_all.bat)" % task, flush=True)
            failed.append(task)
            continue

        if task == "14_file_read":
            if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copyfile(DATA, os.path.join(d, "data.bin"))
        if task == "15_file_write":
            outbin = os.path.join(d, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        try:
            p = subprocess.run([exe], cwd=d, capture_output=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print("%s FAIL timeout after %ss" % (task, TIMEOUT), flush=True)
            failed.append(task)
            continue

        out = p.stdout.decode("utf-8", "replace").strip()
        err = p.stderr.decode("utf-8", "replace")
        m = TIME_RE.search(err)
        problems = []
        if out != exp:
            problems.append("stdout mismatch: expected %r got %r" % (exp, out[:120]))
        if not m:
            problems.append("no TIME_MS on stderr")
        if task == "15_file_write":
            outbin = os.path.join(d, "out.bin")
            if not os.path.exists(outbin):
                problems.append("out.bin missing")
            elif os.path.getsize(outbin) != OUT_SIZE:
                problems.append("out.bin is %d bytes, expected %d" % (os.path.getsize(outbin), OUT_SIZE))
        if p.returncode != 0 and not problems:
            problems.append("exit code %s" % p.returncode)

        if problems:
            failed.append(task)
            print("%s FAIL" % task, flush=True)
            for pr in problems:
                print("    %s" % pr, flush=True)
        else:
            passed += 1
            print("%s OK TIME_MS=%s" % (task, m.group(1)), flush=True)

    print("%s PASS %d/%d" % (ROW, passed, len(TASKS)), flush=True)
    if failed:
        print("%s FAILED: %s" % (ROW, " ".join(failed)), flush=True)
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
