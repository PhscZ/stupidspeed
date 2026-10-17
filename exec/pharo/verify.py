#!/usr/bin/env python3
"""Row verifier for the pharo row -- Pharo 13, a prebuilt image.

One toolchain and no build step: `build_all.bat` stages each `.st` script into
`exec/pharo/pharo/{task}/`, which is also the working directory the registry runs
it from, so the artifact path `exec/pharo/pharo/{task}/{task}.st` is both the
source and the file the VM is handed.  The image and the console executable are
given as absolute paths, which is what the registry does too: Pharo writes its
`.changes` log and `PharoDebug.log` into the *process* working directory, so
running from a task directory keeps them out of the repository root.

    python exec/pharo/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "pharo"
SRC = os.path.join(ROOT, "sources", "pharo")
RUN = os.path.join(ROOT, "exec", "pharo", "pharo")
CONSOLE = os.path.join(ROOT, "tools", "pharo", "PharoConsole.exe")
IMAGE = os.path.join(ROOT, "tools", "pharo", "Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image")
DATA = os.path.join(ROOT, "data.bin")
# The registry's own budget: 600 s for the row, 1800 s for 09 and 1200 s for 11.
TIMEOUTS = {"09_fib_recursive": 1800, "11_parallel_sum": 1200}
TIMEOUT = 600
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".st"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    script = os.path.join(cwd, task + ".st")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    if task in ("14_file_read", "15_file_write"):
        dest = os.path.join(cwd, "data.bin")
        if not os.path.exists(dest) or os.path.getsize(dest) != os.path.getsize(DATA):
            shutil.copy(DATA, dest)
    if task == "15_file_write":
        try:
            os.remove(os.path.join(cwd, "out.bin"))
        except OSError:
            pass
    cmd = [CONSOLE, "--headless", IMAGE, "st", "--quit", "--no-source", task + ".st"]
    try:
        p = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUTS.get(task, TIMEOUT))
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUTS.get(task, TIMEOUT)
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (stderr tail: %r)" % (
            out[:120], want[:120], p.stderr[-160:])
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
