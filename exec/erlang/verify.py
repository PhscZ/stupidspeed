#!/usr/bin/env python3
"""Row verifier for the erlang row -- OTP's escript, no build step.

`tools/erlang/bin/escript.exe <task>.erl` compiles the script to BEAM bytecode
and runs it, with `exec/erlang` as the working directory for every task (that is
what exec/cells.json records), so tasks 14 and 15 find data.bin there and task 15
leaves out.bin there.

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot
leave the check behind), a TIME_MS value reached stderr, and task 15 left out.bin
behind at its full 52428800 bytes.

    python exec/erlang/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "erlang"
SRC = os.path.join(ROOT, "sources", "erlang")
RUN = os.path.join(ROOT, "exec", "erlang")
ESCRIPT = os.path.join(ROOT, "tools", "erlang", "bin", "escript.exe")
# The BEAM pays about half a second of start-up per cell; the slowest cell
# (task 13) measured 14.5 s, so 600 s is a generous per-task cap.
TIMEOUT = 600
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?(?:[eE][+-]?[0-9]+)?)")


def expected_output(task):
    with open(os.path.join(SRC, task + ".erl"), encoding="utf-8", errors="replace") as fh:
        for line in fh:
            m = EXPECTED.search(line)
            if m:
                return m.group(1)
    raise SystemExit("%s: no `expected output:` line in the source header" % task)


def check(task):
    want = expected_output(task)
    script = os.path.join(RUN, task + ".erl")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    try:
        p = subprocess.run([ESCRIPT, task + ".erl"], cwd=RUN, capture_output=True,
                           text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s, stderr tail %r)" % (
            out[:120], want[:120], p.returncode, p.stderr[-200:])
    m = TIME_RE.search(p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        out_bin = os.path.join(RUN, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


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
