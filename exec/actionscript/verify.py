#!/usr/bin/env python3
"""Verifier for the ActionScript (AIR) row.

Runs each task's packaged bundle, exec/actionscript/<task>/out/prog.exe, and checks

  1. stripped stdout after the AIR banner equals the task's `expected output:` line;
  2. a TIME_MS value is present in the row's time.txt;
  3. task 15 additionally leaves out.bin (52428800 bytes) behind.

Two things about this row are not like the others.

The AIR runtime prints a fixed 2354-byte ASCII-art banner to stdout before the program's
own output, so the answer is stdout[2354:] and nothing else. It is not a warning and it is
unconditional; the same fact is why RUN.md says a harness for `arc` must take the last
stderr line rather than the only one.

AIR has no stderr, so the contract's time.txt fallback applies and the file is not in the
working directory: it goes to File.applicationStorageDirectory, AIR's writable
per-application data directory, %APPDATA%\\stupidspeed.actionscript\\Local Store\\. That
directory is keyed by the application id in sources/actionscript/app.xml, so **all fifteen
tasks share one time.txt and one out.bin**. Both are deleted before each run so a stale
file from the previous task cannot be read as this task's answer.

Task 14 needs no staging: it reads data.bin from File.applicationDirectory, so the fixture
is packaged inside the bundle by build_all.bat. Task 15 cannot write there at all (AIR
refuses, SecurityError: fileWriteResource) and writes its out.bin into the same
application-storage directory as time.txt.

Run:  python exec\\actionscript\\verify.py
"""
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", "actionscript")
OUT = HERE
ROW = "actionscript"

# The AIR runtime's own stdout banner. Fixed size, documented in every source header.
BANNER = 2354
# File.applicationStorageDirectory for the id in sources/actionscript/app.xml.
STORE = os.path.join(os.environ.get("APPDATA", ""), "stupidspeed.actionscript", "Local Store")
TIME_TXT = os.path.join(STORE, "time.txt")
OUT_BIN = os.path.join(STORE, "out.bin")
OUT_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# The 100 M-iteration loops are seconds and the 1000-digit spigot is about 2.8 s, but the
# bundle also starts the AVM2 per run, so the ceiling is generous rather than tight.
TIMEOUT = 1800
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")


def expected(task):
    with open(os.path.join(SRC, "_" + task + ".as"), encoding="utf-8", errors="replace") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected-output line in " + task)
    return m.group(1).strip()


def main():
    if not os.path.isdir(STORE):
        print("%s FAIL no application storage directory: %s" % (ROW, STORE), flush=True)
        return 1
    passed = 0
    failed = []
    for task in TASKS:
        d = os.path.join(OUT, task)
        exe = os.path.join(d, "out", "prog.exe")
        exp = expected(task)
        if not os.path.exists(exe):
            print("%s FAIL (no out\\prog.exe; run build_all.bat)" % task, flush=True)
            failed.append(task)
            continue

        # The storage directory is shared by all fifteen tasks, so anything left over from
        # the previous task has to go before this one runs.
        for stale in (TIME_TXT, OUT_BIN):
            if os.path.exists(stale):
                os.remove(stale)

        try:
            p = subprocess.run([exe], cwd=d, capture_output=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print("%s FAIL timeout after %ss" % (task, TIMEOUT), flush=True)
            failed.append(task)
            continue

        problems = []
        raw = p.stdout.decode("utf-8", "replace")
        if len(raw) < BANNER:
            problems.append("stdout shorter than the %d-byte banner (%d bytes)" % (BANNER, len(raw)))
            got = ""
        else:
            got = raw[BANNER:].strip()
            if got != exp:
                problems.append("stdout mismatch: expected %r got %r" % (exp, got[:120]))

        ms = None
        if os.path.exists(TIME_TXT):
            with open(TIME_TXT, encoding="utf-8", errors="replace") as fh:
                m = TIME_RE.search(fh.read())
            ms = m.group(1) if m else None
        if ms is None:
            problems.append("no TIME_MS in %s" % TIME_TXT)
        if task == "15_file_write":
            if not os.path.exists(OUT_BIN):
                problems.append("out.bin missing from the application storage directory")
            elif os.path.getsize(OUT_BIN) != OUT_SIZE:
                problems.append("out.bin is %d bytes, expected %d" % (os.path.getsize(OUT_BIN), OUT_SIZE))

        if problems:
            failed.append(task)
            print("%s FAIL" % task, flush=True)
            for pr in problems:
                print("    %s" % pr, flush=True)
        else:
            passed += 1
            print("%s OK TIME_MS=%s" % (task, ms), flush=True)

    print("%s PASS %d/%d" % (ROW, passed, len(TASKS)), flush=True)
    if failed:
        print("%s FAILED: %s" % (ROW, " ".join(failed)), flush=True)
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
