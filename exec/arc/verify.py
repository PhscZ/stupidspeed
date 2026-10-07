#!/usr/bin/env python3
"""Verifier for the Arc (Anarki on Racket) row.

Runs each task with the Racket host from exec/arc/, which holds the fifteen sources flat
plus the 50 MiB fixture, and checks

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present on stderr;
  3. task 15 additionally leaves out.bin (52428800 bytes) in the working directory.

There is no build step: Arc is interpreted and there is no compiled form of the task file,
so the Racket host's own boot -- about 30-50 s on this machine, measured 46.9 s for task
04 -- is inside every measured run. That boot is also why the timeout is generous: the
floor under all fifteen cells is that boot, not the task.

**stderr carries two kinds of line.** The first is the host's unconditional banner,
`initializing arc.. (may take a minute)`, which is printed before the program runs. The
program's own TIME_MS line comes after it. The harness therefore scans for the TIME_MS
pattern anywhere on stderr rather than assuming the stream holds exactly one line, which
is the same rule RUN.md records for this row.

boot.rkt is passed by absolute path so the host finds its own libraries; the .arc file is
named relative to the working directory, which is what boot.rkt's command line does with
its <file> argument. Tasks 14 and 15 open "data.bin"/"out.bin" relative to that same
working directory.

Run:  python exec\\arc\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", "arc")
OUT = HERE
RACKET = os.path.join(ROOT, "tools", "racket", "Racket.exe")
BOOT = os.path.join(ROOT, "tools", "arc", "boot.rkt")
DATA = os.path.join(ROOT, "data.bin")
ROW = "arc"

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# The host boot is ~50 s and the 100 M-iteration tasks are minutes in an interpreter.
TIMEOUT = 3600
OUT_SIZE = 52428800
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")


def expected(task):
    with open(os.path.join(SRC, task + ".arc"), encoding="utf-8", errors="replace") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected-output line in " + task)
    return m.group(1).strip()


def main():
    for tool in (RACKET, BOOT):
        if not os.path.exists(tool):
            print("%s FAIL missing %s" % (ROW, tool), flush=True)
            return 1

    if not os.path.exists(os.path.join(OUT, "data.bin")) or not os.path.samefile(DATA, os.path.join(OUT, "data.bin")): shutil.copyfile(DATA, os.path.join(OUT, "data.bin"))
    passed = 0
    failed = []
    for task in TASKS:
        src = os.path.join(OUT, task + ".arc")
        exp = expected(task)
        if not os.path.exists(src):
            print("%s FAIL (no %s.arc)" % (task, task), flush=True)
            failed.append(task)
            continue
        if task == "15_file_write":
            outbin = os.path.join(OUT, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        argv = [RACKET, "-t", BOOT, "-e", "(anarki-windows-cli)", "--", task + ".arc"]
        try:
            p = subprocess.run(argv, cwd=OUT, capture_output=True, timeout=TIMEOUT)
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
