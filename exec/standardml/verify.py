#!/usr/bin/env python3
"""Verify the Standard ML (Poly/ML) row: 15 tasks, each prints one expected
stdout line and a TIME_MS=<ms> line on stderr.  Task 15 must leave out.bin."""
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))          # C:\stupidspeed
SRC = os.path.join(ROOT, "sources", "standardml")
BUILD = os.path.join(HERE, "polyml")

TASKS = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum",
         "05_alloc_churn", "06_char_count", "07_string_append", "08_average",
         "09_fib_recursive", "10_pi", "11_parallel_sum", "12_matrix_add",
         "13_matrix_mul", "14_file_read", "15_file_write"]

TIMEOUT = 900


def expected(task):
    with open(os.path.join(SRC, task + ".sml"), "r", encoding="utf-8", errors="replace") as f:
        first = f.readline()
    m = re.search(r"expected output:\s*(.*?)\s*\*\)\s*$", first)
    return m.group(1).strip()


def main():
    passed = 0
    for task in TASKS:
        d = os.path.join(BUILD, task)
        exe = os.path.join(d, task + ".exe")
        exp = expected(task)
        if not os.path.exists(exe):
            print(f"{task} FAIL (no {task}.exe)")
            continue
        try:
            # -H 256 is the row's documented run line: Poly/ML's initial heap in MB. An
            # exported image otherwise grows its heap on demand and dies with "Run out of
            # store - interrupting threads" when that growth fails under memory pressure.
            p = subprocess.run([exe, "-H", "256"], cwd=d, capture_output=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print(f"{task} FAIL (timeout {TIMEOUT}s)")
            continue
        out = p.stdout.decode("utf-8", "replace").strip()
        err = p.stderr.decode("utf-8", "replace")
        m = re.search(r"TIME_MS=([0-9.]+)", err)
        if out != exp:
            print(f"{task} FAIL (stdout {out!r} != {exp!r})")
            tail = err.strip().splitlines()[-5:]
            if tail:
                print("  stderr tail: " + " | ".join(tail))
            continue
        if not m:
            print(f"{task} FAIL (no TIME_MS on stderr); stderr={err.strip()!r}")
            continue
        if task == "15_file_write":
            outbin = os.path.join(d, "out.bin")
            if not os.path.exists(outbin):
                print(f"{task} FAIL (out.bin missing)")
                continue
        passed += 1
        print(f"{task} OK TIME_MS={m.group(1)}")
    print(f"standardml PASS {passed}/15")
    return 0 if passed == 15 else 1


if __name__ == "__main__":
    sys.exit(main())
