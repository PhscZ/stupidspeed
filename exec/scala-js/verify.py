#!/usr/bin/env python3
"""Row verifier for the scala-js row -- scala-cli packages the Scala source to
JavaScript and node runs the one emitted file.

The build is `scala-cli --power package <task>.scala --js -o prog.js --force
--jvm system`, so the artifact is exec/scala-js/<task>/prog.js and the run line
is `node prog.js` from that directory, which is what the registry names.

Each task is checked the three ways the row contract asks: stdout, stripped,
equals the task's own `expected output:` line read from the source header
(sources/scala-js/<task>.scala); a TIME_MS value reached stderr; and task 15
left out.bin at 52428800 bytes.  Tasks 14 and 15 need data.bin in the working
directory, which build_all.bat puts there.

    python exec/scala-js/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "scala-js"
SRC = os.path.join(ROOT, "sources", "scala-js")
OUT = os.path.join(ROOT, "exec", "scala-js")
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# Node is the whole runtime here, so the registry's 600 s cell timeout is
# generous; it is kept, with headroom for the shared 8-core host.
TIMEOUT = 900
OUT_BIN_SIZE = 52428800

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".scala"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    cwd = os.path.join(OUT, task)
    prog = os.path.join(cwd, "prog.js")
    if not os.path.exists(prog):
        return False, "missing artifact %s" % prog
    try:
        p = subprocess.run([NODE, "prog.js"], cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    want = expected_output(task)
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
    return True, m.group(1)


def main():
    passed = 0
    for task in TASKS:
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL",
                               ("TIME_MS=" + detail) if ok else detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
