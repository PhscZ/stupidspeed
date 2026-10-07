#!/usr/bin/env python3
"""Verify the SQLite row: 15 tasks, each run as
    sqlite3.exe :memory: ".read <task>.sql"
and each printing one expected stdout line plus a TIME_MS=<ms> line on
stderr.  Task 15 must leave out.bin.  Task 11 spawns four child sqlite3
processes and finds the executable on PATH."""
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))          # C:\stupidspeed
SRC = os.path.join(ROOT, "sources", "sqlite")
BUILD = os.path.join(HERE, "sqlite3")
SQLITE_DIR = os.path.join(ROOT, "tools", "sqlite")
SQLITE = os.path.join(SQLITE_DIR, "sqlite3.exe")

TASKS = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum",
         "05_alloc_churn", "06_char_count", "07_string_append", "08_average",
         "09_fib_recursive", "10_pi", "11_parallel_sum", "12_matrix_add",
         "13_matrix_mul", "14_file_read", "15_file_write"]

# Task 10 is documented as ~4 minutes at 1000 digits; this host is slower.
TIMEOUT = 1800


def expected(task):
    with open(os.path.join(SRC, task + ".sql"), "r", encoding="utf-8", errors="replace") as f:
        first = f.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    return m.group(1).strip()


def main():
    env = dict(os.environ)
    env["PATH"] = SQLITE_DIR + os.pathsep + env.get("PATH", "")
    passed = 0
    for task in TASKS:
        d = os.path.join(BUILD, task)
        sql = os.path.join(d, task + ".sql")
        exp = expected(task)
        if not os.path.exists(sql):
            print(f"{task} FAIL (no {task}.sql)")
            continue
        try:
            p = subprocess.run([SQLITE, ":memory:", f".read {task}.sql"],
                               cwd=d, env=env, capture_output=True, timeout=TIMEOUT)
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
            if not os.path.exists(os.path.join(d, "out.bin")):
                print(f"{task} FAIL (out.bin missing)")
                continue
        passed += 1
        print(f"{task} OK TIME_MS={m.group(1)}")
    print(f"sqlite PASS {passed}/15")
    return 0 if passed == 15 else 1


if __name__ == "__main__":
    sys.exit(main())
