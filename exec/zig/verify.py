#!/usr/bin/env python3
"""Verifier for the zig (native) row.

The row has two toolchains over the same fifteen sources, built by
exec/zig/build_all.bat: `zig`, which goes through LLVM, and `zig (self-hosted
x86-64)`, which is the same front end with `-fno-llvm`.  For each of them, every
task is checked for

  1. stripped stdout == the task's `expected output:` line from sources/zig/<task>.zig
  2. a TIME_MS value on stderr
  3. task 15 additionally leaves out.bin

Both toolchains must pass all fifteen for the row to pass.  The binaries are
built with `-mcpu=x86_64_v2`: Zig's default CPU model is the build machine's, and
a binary built that way carries AVX2 and dies with 0xC000001D on a CPU without
it, which is a defect that only shows on the machine that runs it.
"""
import os
import re
import subprocess
import sys

ROW = "zig"
TOOLCHAINS = ["zig", "selfhosted"]
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", ROW)
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

def check(toolchain):
    passed = 0
    out_dir = os.path.join(HERE, toolchain)
    for task in TASKS:
        d = os.path.join(out_dir, task)
        exp = expected(task)
        out_bin = os.path.join(d, "out.bin")
        if task == "15_file_write" and os.path.exists(out_bin):
            os.remove(out_bin)
        exe = os.path.join(d, "prog.exe")
        try:
            p = subprocess.run([exe], cwd=d, capture_output=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print("%s %s FAIL (timeout after %ds)" % (toolchain, task, TIMEOUT))
            continue
        except OSError as exc:
            print("%s %s FAIL (cannot run %s: %s)" % (toolchain, task, exe, exc))
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
            print("%s %s FAIL" % (toolchain, task))
            for w in why:
                print("    %s" % w)
            tail = "\n".join(err.strip().splitlines()[-5:])
            if tail:
                print("    stderr tail: %s" % tail.replace("\n", " | "))
        else:
            print("%s %s OK TIME_MS=%s" % (toolchain, task, m.group(1)))
            passed += 1
    print("%s PASS %d/15" % (toolchain, passed))
    return passed

def main():
    bad = 0
    for toolchain in TOOLCHAINS:
        if check(toolchain) != len(TASKS):
            bad += 1
    return 0 if bad == 0 else 1

if __name__ == "__main__":
    sys.exit(main())
