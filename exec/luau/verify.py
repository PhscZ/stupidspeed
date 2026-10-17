#!/usr/bin/env python3
"""Row verifier for the luau row -- Luau, interpreted, no build step.

The row is one toolchain over two engines.  Tasks 01-10, 12 and 13 run under the
plain Luau CLI (`tools/luau/luau.exe`); tasks 11, 14 and 15 need **Lute**
(`tools/lute/lute.exe run`), because the plain CLI exposes no file I/O and no
process API at all.  Which engine runs a cell is the registry's business, and
`exec/cells.json` splits the one toolchain accordingly.

Timing is the awkward part of this row: Luau has no reachable stderr, and the
plain CLI has no file I/O either, so the `time.txt` fallback the sources write
through Lute's `@lute/fs` lands only on the three Lute cells.  The twelve
`luau.exe` cells produce no timing line anywhere -- exactly what RUN.md records
-- so those are timed end to end by the verifier itself, the way the harness
times them.

Checks per task: stripped stdout equals the task's own `expected output:` line
(read from the source header, so a source edit cannot leave the check behind),
a TIME_MS value is present (stderr, or time.txt, or measured here), and task 15
left out.bin behind at its full 52428800 bytes.

    python exec/luau/verify.py
"""
import os
import re
import shutil
import subprocess
import sys
import time

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "luau"
SRC = os.path.join(ROOT, "sources", "luau")
RUN = os.path.join(ROOT, "exec", "luau", "luau")
LUAU = os.path.join(ROOT, "tools", "luau", "luau.exe")
LUTE = os.path.join(ROOT, "tools", "lute", "lute.exe")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

# Tasks the plain Luau CLI cannot run: they need Lute.
LUTE_TASKS = {"11_parallel_sum", "14_file_read", "15_file_write"}

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".luau"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    script = os.path.join(cwd, task + ".luau")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    if task in ("14_file_read", "15_file_write"):
        dest = os.path.join(cwd, "data.bin")
        if not os.path.exists(dest) or os.path.getsize(dest) != os.path.getsize(DATA):
            shutil.copy(DATA, dest)
    # A stale time.txt would be read as this run's number.
    time_file = os.path.join(cwd, "time.txt")
    if os.path.exists(time_file):
        os.remove(time_file)
    if task == "15_file_write" and os.path.exists(os.path.join(cwd, "out.bin")):
        os.remove(os.path.join(cwd, "out.bin"))

    if task in LUTE_TASKS:
        argv = [LUTE, "run", task + ".luau"]
    else:
        argv = [LUAU, task + ".luau"]
    t0 = time.perf_counter()
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    wall_ms = (time.perf_counter() - t0) * 1000.0

    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r" % (out[:120], want[:120])

    m = None
    for m in re.finditer(r"TIME_MS=([0-9.]+)", p.stderr):
        pass
    source = "stderr"
    if not m:
        source = "time.txt"
        if os.path.exists(time_file):
            with open(time_file, encoding="utf-8", errors="replace") as fh:
                text = fh.read()
            for m in re.finditer(r"TIME_MS=([0-9.]+)", text):
                pass
    if m:
        detail = "TIME_MS=%s" % m.group(1)
    else:
        # The twelve luau.exe cells have no timing line anywhere: Luau exposes no
        # stderr and the CLI no file I/O.  They are timed here, end to end, the
        # way the harness times them.
        source = "wall"
        detail = "TIME_MS=%.3f (wall)" % wall_ms

    if task == "15_file_write":
        out_bin = os.path.join(cwd, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "%s [%s]" % (detail, source)


def main():
    passed = 0
    for task in TASKS:
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
