#!/usr/bin/env python3
"""Row verifier for the interpreter toolchains of the python row.

cpython, pypy and graalpy all run the fifteen sources unchanged, so "building"
one of their tasks is staging the script into the directory the harness runs it
from:

    exec/python/<toolchain>/<task>/<task>.py

The row's fourth toolchain, nuitka, is a compiler and is verified by
`verify_compilers.py`; `exec/python/verify.py` drives both.

Checks per task, as every row's verifier does: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot
leave the check behind), a TIME_MS value reached stderr, and task 15 left
out.bin behind at its full 52428800 bytes.

    python exec/python/verify_interpreters.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "python"
SRC = os.path.join(ROOT, "sources", ROW)
RUN = os.path.join(ROOT, "exec", ROW)
TIMEOUT = 900
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# The three interpreters, in the order exec/cells.json lists them.  The paths are
# the registry's own: the absolute CPython 3.13 the `cpython` cell names, and the
# two trees under tools/.
TOOLCHAINS = [
    ("cpython", os.path.join(os.path.expanduser("~"), "AppData", "Local", "Programs",
                             "Python", "Python313", "python.exe")),
    ("pypy", os.path.join(ROOT, "tools", "pypy", "pypy.exe")),
    ("graalpy", os.path.join(ROOT, "tools", "graalpy",
                             "graalpy-community3.13-25.4.4.1.1-windows-amd64",
                             "bin", "graalpy.exe")),
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".py"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(toolchain, exe, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, toolchain, task)
    script = os.path.join(cwd, task + ".py")
    if not os.path.exists(exe):
        return False, "missing interpreter %s" % exe
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    try:
        p = subprocess.run([exe, task + ".py"], cwd=cwd, capture_output=True,
                           text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r" % (out[:120], want[:120])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        out_bin = os.path.join(cwd, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    passed = {task: True for task in TASKS}
    for toolchain, exe in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(toolchain, exe, task)
            print("%-10s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
            passed[task] = passed[task] and ok
    n = sum(1 for task in TASKS if passed[task])
    print("%s interpreters %s %d/15" % (ROW, "PASS" if n == len(TASKS) else "FAIL", n))
    return passed


if __name__ == "__main__":
    ok = main()
    sys.exit(0 if all(ok.values()) else 1)
