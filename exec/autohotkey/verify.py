#!/usr/bin/env python3
"""Verifier for the AutoHotkey v2 row.

Runs each task with tools/autohotkey/AutoHotkey64.exe from exec/autohotkey/, which holds
the fifteen scripts flat plus the 50 MiB fixture, and checks

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present on stderr;
  3. task 15 additionally leaves out.bin (52428800 bytes) in the working directory.

There is no build step: AutoHotkey interprets the script on every run, so the parse is
inside the measured number. `/ErrorStdOut` is what sends the interpreter's own error text
to stderr instead of a message box, so a failing script reports rather than hanging.

TIME_MS goes to stderr through `FileAppend(..., "**")` and the answer to stdout through
`FileAppend(..., "*")`; the interpreter prints nothing on start-up, so stdout holds
exactly the one expected line and stderr holds exactly the timing line.

**tools/autohotkey must be on PATH**, not merely invoked by absolute path: task 11 is
four child processes rather than four threads (AutoHotkey has no thread library), and the
parent re-runs its own file -- A_ScriptFullPath -- by launching the interpreter by name.
Without the directory on PATH the four children never start and the task cannot answer.

Tasks 14 and 15 open "data.bin"/"out.bin" relative to the working directory, so the
fixture is copied into exec/autohotkey/ and those two tasks run from there. The clock is
A_TickCount, the interpreter's own GetTickCount millisecond clock, so its resolution is
about 15 ms -- the coarse-clock caveat RUN.md records for this row.

Run:  python exec\\autohotkey\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", "autohotkey")
OUT = HERE
AHK_DIR = os.path.join(ROOT, "tools", "autohotkey")
AHK = os.path.join(AHK_DIR, "AutoHotkey64.exe")
DATA = os.path.join(ROOT, "data.bin")
ROW = "autohotkey"

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# Task 09 is about 4.2 minutes (331 million interpreted calls) and the four
# 100-million-iteration loops are 30-50 s each.
TIMEOUT = 1800
OUT_SIZE = 52428800
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")

ENV = dict(os.environ)
ENV["PATH"] = AHK_DIR + os.pathsep + ENV.get("PATH", "")


def expected(task):
    with open(os.path.join(SRC, task + ".ahk"), encoding="utf-8", errors="replace") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected-output line in " + task)
    return m.group(1).strip()


def main():
    if not os.path.exists(AHK):
        print("%s FAIL no interpreter at %s" % (ROW, AHK), flush=True)
        return 1

    if not os.path.exists(os.path.join(OUT, "data.bin")) or not os.path.samefile(DATA, os.path.join(OUT, "data.bin")): shutil.copyfile(DATA, os.path.join(OUT, "data.bin"))
    passed = 0
    failed = []
    for task in TASKS:
        src = os.path.join(OUT, task + ".ahk")
        exp = expected(task)
        if not os.path.exists(src):
            print("%s FAIL (no %s.ahk)" % (task, task), flush=True)
            failed.append(task)
            continue
        if task == "15_file_write":
            outbin = os.path.join(OUT, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        argv = [AHK, "/ErrorStdOut", task + ".ahk"]
        try:
            p = subprocess.run(argv, cwd=OUT, capture_output=True, timeout=TIMEOUT, env=ENV)
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
