#!/usr/bin/env python3
"""Verify the MASM x64 row.

Each task is a freestanding PE64 console executable in
exec/masm/masm/<task>/<task>.exe.  For every task this script

  1. runs the executable from its own directory (so tasks 14/15 see data.bin
     there and task 15 writes out.bin there),
  2. checks the stripped stdout equals the task's `expected output:` line,
  3. checks a TIME_MS=<v> value was written to stderr,
  4. for task 15 also checks that out.bin was left behind.

The expected line is read from the first comment line of the corresponding
sources/masm/<task>.asm, which is authoritative.
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))  # ...\stupidspeed
ROW = "masm"
SRC = os.path.join(ROOT, "sources", ROW)
EXEC = os.path.join(ROOT, "exec", ROW, ROW)
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 600

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum",
    "05_alloc_churn", "06_char_count", "07_string_append", "08_average",
    "09_fib_recursive", "10_pi", "11_parallel_sum", "12_matrix_add",
    "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED_RE = re.compile(r"expected output:\s*(.+?)\s*$")
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")


def expected_for(task):
    with open(os.path.join(SRC, task + ".asm"), "r", encoding="utf-8",
              errors="replace") as fh:
        for line in fh:
            if "expected output:" in line:
                return EXPECTED_RE.search(line).group(1)
            if not line.lstrip().startswith(";"):
                break
    raise RuntimeError("no `expected output:` line in %s.asm" % task)


def main():
    ok = 0
    failures = []
    for task in TASKS:
        exe = os.path.join(EXEC, task, task + ".exe")
        cwd = os.path.dirname(exe)
        exp = expected_for(task)

        if not os.path.exists(exe):
            print("%-20s FAIL (missing %s)" % (task, exe), flush=True)
            failures.append((task, exp, "<no executable>", "executable not built"))
            continue

        if task in ("14_file_read", "15_file_write"):
            if not os.path.exists(os.path.join(cwd, "data.bin")) or not os.path.samefile(DATA, os.path.join(cwd, "data.bin")): shutil.copy(DATA, os.path.join(cwd, "data.bin"))
        outbin = os.path.join(cwd, "out.bin")
        if task == "15_file_write" and os.path.exists(outbin):
            os.remove(outbin)

        try:
            r = subprocess.run([exe], capture_output=True, cwd=cwd,
                               timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print("%-20s FAIL (timeout %ds)" % (task, TIMEOUT), flush=True)
            failures.append((task, exp, "<timeout>", "no stderr"))
            continue

        out = r.stdout.decode("utf-8", "replace").strip()
        err = r.stderr.decode("utf-8", "replace")
        m = TIME_RE.search(err)

        good = (out == exp)
        problems = []
        if not good:
            problems.append("stdout %r != expected %r" % (out, exp))
        if m is None:
            problems.append("no TIME_MS= on stderr")
        if task == "15_file_write":
            if not os.path.exists(outbin):
                problems.append("out.bin not left behind")
            else:
                sz = os.path.getsize(outbin)
                if sz != 52428800:
                    problems.append("out.bin size %d != 52428800" % sz)

        if good and not problems:
            ok += 1
            print("%-20s OK TIME_MS=%s" % (task, m.group(1)), flush=True)
        else:
            print("%-20s FAIL" % task, flush=True)
            for p in problems:
                print("    %s" % p, flush=True)
            tail = "\n".join(err.strip().splitlines()[-5:])
            if tail:
                print("    stderr tail: %s" % tail.replace("\n", "\n                 "),
                      flush=True)
            failures.append((task, exp, out, err.strip()[-300:]))

    print("%s PASS %d/15" % (ROW.upper(), ok), flush=True)
    return 0 if ok == 15 else 1


if __name__ == "__main__":
    sys.exit(main())
