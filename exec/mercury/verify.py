#!/usr/bin/env python3
r"""Row verifier for the mercury row -- Mercury 22.01.9 (mmc -> C -> MSYS2 UCRT64 gcc).

    exec\mercury\mmc\<task>\m<task>.exe     artifact, run as `m<task>.exe`

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot leave
the check behind), a TIME_MS value reached stderr, and task 15 left out.bin behind
at its full 52428800 bytes.  The hlc grades link against the MSYS2 UCRT64 runtime,
so the programs run with ucrt64\bin and tools\mercury\bin on PATH -- the same env
exec/cells.json records for the mmc toolchain.

    python exec/mercury/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "mercury"
SRC = os.path.join(ROOT, "sources", "mercury")
RUN = os.path.join(ROOT, "exec", "mercury", "mmc")
TIMEOUT = 3600   # the registry gives this cell 1800 s; the box is shared, so a run
                 # that measured 120 s can need 30x that when other rows are building
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, task + ".m"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def env_for():
    env = dict(os.environ)
    env["PATH"] = os.pathsep.join([
        os.path.join(ROOT, "tools", "msys64", "msys64", "ucrt64", "bin"),
        os.path.join(ROOT, "tools", "mercury", "bin"),
        env.get("PATH", ""),
    ])
    return env

def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    prog = os.path.join(cwd, "m" + task + ".exe")
    if not os.path.exists(prog):
        return False, "missing artifact %s" % prog
    try:
        p = subprocess.run([prog], cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT, env=env_for())
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s, stderr tail: %r)" % (
            out[:120], want[:120], p.returncode, p.stderr[-200:])
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
    passed = 0
    for task in TASKS:
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1

if __name__ == "__main__":
    sys.exit(main())
