#!/usr/bin/env python3
"""Verifier for the Algol 68 Genie row.

Runs each task with tools/a68g/bin/a68g.exe from exec/algol68/, which holds the fifteen
sources flat, and checks

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present on stderr;
  3. task 15 additionally leaves out.bin (52428800 bytes) in the working directory.

a68g is a compiler-interpreter, so there is no build step and the "build" and the "run"
are the same command; the parse and the tree-walk are both inside the measured region.

Three things about this row are load-bearing at run time.

The interpreter is a **Cygwin** build, so C:\\cygwin64\\bin has to be on PATH or the
process dies before main with STATUS_DLL_NOT_FOUND (0xC0000135) and prints nothing at
all. The tree is not inside tools/ because it was built from source under the machine's
own Cygwin installation.

Task 06 runs as `a68g --heap 1900000000 06_char_count.a68`. A CHAR is 16 bytes in this
interpreter (a status word plus the value), so the default 65 MB heap cannot hold the
100-million-character text and the task dies with a heap-exhaustion message without the
flag. It is the only task that needs it.

Task 10 is the slowest cell in the whole matrix. The row hand-writes the base-1e9 limbs
(its own arbitrary-precision mode is unusable here) and the interpreter walks the tree
instead of compiling, so the 1000-digit run is roughly **7.5 minutes**; the timeout below
allows for a contended machine on top of that.

Tasks 14 and 15 open "data.bin"/"out.bin" relative to the working directory, so the
fixture is copied into exec/algol68/ and those two tasks run from there.

Run:  python exec\\algol68\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", "algol68")
OUT = HERE
A68G = os.path.join(ROOT, "tools", "a68g", "bin", "a68g.exe")
CYGWIN_BIN = r"C:\cygwin64\bin"
DATA = os.path.join(ROOT, "data.bin")
ROW = "algol68"

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

TIMEOUT = 900
SLOW = {"10_pi": 5400, "02_switch_case": 1800, "11_parallel_sum": 1800}
OUT_SIZE = 52428800
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")

# Task 06's heap: a CHAR is 16 bytes here and the text is 100 million characters.
HEAP = {"06_char_count": "1900000000"}

ENV = dict(os.environ)
ENV["PATH"] = CYGWIN_BIN + os.pathsep + ENV.get("PATH", "")


def expected(task):
    with open(os.path.join(SRC, task + ".a68"), encoding="utf-8", errors="replace") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*#\s*$", first)
    if not m:
        m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected-output line in " + task)
    return m.group(1).strip()


def main():
    if not os.path.exists(A68G):
        print("%s FAIL no interpreter at %s" % (ROW, A68G), flush=True)
        return 1
    if not os.path.isdir(CYGWIN_BIN):
        print("%s FAIL no Cygwin runtime at %s" % (ROW, CYGWIN_BIN), flush=True)
        return 1

    if not os.path.exists(os.path.join(OUT, "data.bin")) or not os.path.samefile(DATA, os.path.join(OUT, "data.bin")): shutil.copyfile(DATA, os.path.join(OUT, "data.bin"))
    passed = 0
    failed = []
    for task in TASKS:
        src = os.path.join(OUT, task + ".a68")
        exp = expected(task)
        if not os.path.exists(src):
            print("%s FAIL (no %s.a68)" % (task, task), flush=True)
            failed.append(task)
            continue
        if task == "15_file_write":
            outbin = os.path.join(OUT, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        argv = [A68G]
        if task in HEAP:
            argv += ["--heap", HEAP[task]]
        argv.append(task + ".a68")

        timeout = SLOW.get(task, TIMEOUT)
        try:
            p = subprocess.run(argv, cwd=OUT, capture_output=True, timeout=timeout, env=ENV)
        except subprocess.TimeoutExpired:
            print("%s FAIL timeout after %ss" % (task, timeout), flush=True)
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
            outbin = os.path.join(OUT, "out.bin")
            if not os.path.exists(outbin):
                problems.append("out.bin missing")
            elif os.path.getsize(outbin) != OUT_SIZE:
                problems.append("out.bin is %d bytes, expected %d" % (os.path.getsize(outbin), OUT_SIZE))

        if problems:
            failed.append(task)
            print("%s FAIL" % task, flush=True)
            for pr in problems:
                print("    %s" % pr, flush=True)
            if err.strip():
                print("    stderr tail: %s" % " | ".join(err.strip().splitlines()[-4:]), flush=True)
        else:
            passed += 1
            print("%s OK TIME_MS=%s" % (task, m.group(1)), flush=True)

    print("%s PASS %d/%d" % (ROW, passed, len(TASKS)), flush=True)
    if failed:
        print("%s FAILED: %s" % (ROW, " ".join(failed)), flush=True)
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
