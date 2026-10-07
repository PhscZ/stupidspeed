#!/usr/bin/env python3
"""Verifier for the zig (native) row.

Runs every task built by exec/zig/build_all.bat and checks
  1. stripped stdout == the task's `expected output:` line from sources/zig/<task>.zig
  2. a TIME_MS value on stderr
  3. task 15 additionally leaves out.bin
"""
import os
import re
import subprocess
import sys

ROW = "zig"
TOOLCHAIN = "zig"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", ROW)
OUT = os.path.join(HERE, TOOLCHAIN)
TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]
TIMEOUT = 900
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")


def expected(task):
    with open(os.path.join(SRC, task + ".zig"), encoding="utf-8") as fh:
        for line in fh:
            m = re.search(r"expected output:\s*(.*?)\s*$", line)
            if m:
                return m.group(1)
    raise SystemExit("no expected-output line in " + task)


def main():
    passed = 0
    for task in TASKS:
        d = os.path.join(OUT, task)
        exp = expected(task)
        out_bin = os.path.join(d, "out.bin")
        if task == "15_file_write" and os.path.exists(out_bin):
            os.remove(out_bin)
        exe = os.path.join(d, "prog.exe")
        try:
            p = subprocess.run([exe], cwd=d, capture_output=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print("%s FAIL (timeout after %ds)" % (task, TIMEOUT))
            continue
        except OSError as exc:
            print("%s FAIL (cannot run %s: %s)" % (task, exe, exc))
            continue
        got = p.stdout.decode("utf-8", "replace").strip()
        err = p.stderr.decode("utf-8", "replace")
        why = []
        if got != exp:
            why.append("stdout %r != expected %r" % (got, exp))
        m = TIME_RE.search(err)
        if not m:
            why.append("no TIME_MS on stderr")
        if p.returncode != 0:
            why.append("exit code %d" % p.returncode)
        if task == "15_file_write" and not os.path.exists(out_bin):
            why.append("out.bin missing")
        if why:
            print("%s FAIL" % task)
            for w in why:
                print("    %s" % w)
            tail = "\n".join(err.strip().splitlines()[-5:])
            if tail:
                print("    stderr tail: %s" % tail.replace("\n", " | "))
        else:
            print("%s OK TIME_MS=%s" % (task, m.group(1)))
            passed += 1
    print("%s PASS %d/15" % (ROW, passed))
    return 0 if passed == 15 else 1


if __name__ == "__main__":
    sys.exit(main())
