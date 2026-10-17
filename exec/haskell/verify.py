#!/usr/bin/env python3
"""Row verifier for the haskell row -- the same fifteen sources through ghc.

    ghc -> exec\\haskell\\ghc\\T<task>\\prog.exe

Built by exec\\haskell\\build_all.bat as `ghc -O2 -threaded -o prog T<task>.hs`.
Task 11 spawns four capabilities and is run as `prog +RTS -N4 -RTS`, which is the
second registry entry for this row and the only task that gets an RTS flag; the
other fourteen run bare.  Both entries resolve to the same executable, so the
row is verified once per task, with task 11 taking the RTS form.

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot
leave the check behind), a TIME_MS value reached stderr, and task 15 left out.bin
behind at its full 52428800 bytes.

    python exec/haskell/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "haskell"
SRC = os.path.join(ROOT, "sources", "haskell")
RUN = os.path.join(ROOT, "exec", "haskell", "ghc")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 3600
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    # The Haskell sources open with the LANGUAGE pragma, so the `expected output:`
    # line is the second one; the header comment block is scanned rather than a
    # single line so a pragma added above it cannot move the check off target.
    with open(os.path.join(SRC, "T" + task + ".hs"), encoding="utf-8", errors="replace") as fh:
        for _ in range(10):
            line = fh.readline()
            if not line:
                break
            m = EXPECTED.search(line)
            if m:
                return m.group(1)
    raise SystemExit("%s: no `expected output:` line in the source header" % task)


def stage(cwd, task):
    """Put the fixture where the program reads it, and clear a stale out.bin."""
    if task == "14_file_read":
        dest = os.path.join(cwd, "data.bin")
        try:
            fresh = os.path.getsize(dest) == os.path.getsize(DATA)
        except OSError:
            fresh = False
        if not fresh:
            shutil.copy(DATA, dest)


def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, "T" + task)
    prog = os.path.join(cwd, "prog.exe")
    if not os.path.exists(prog):
        return False, "missing artifact %s" % prog
    stage(cwd, task)
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write" and os.path.exists(out_bin):
        os.remove(out_bin)
    argv = [prog] + (["+RTS", "-N4", "-RTS"] if task == "11_parallel_sum" else [])
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s; stderr tail %r)" % (
            out[:120], want[:120], p.returncode, p.stderr[-200:])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    total = passed = 0
    for task in TASKS:
        ok, detail = check(task)
        total += 1
        passed += 1 if ok else 0
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
    print("%s %s %d/%d" % (ROW, "PASS" if passed == total else "FAIL", passed, total))
    return 0 if passed == total else 1


if __name__ == "__main__":
    sys.exit(main())
