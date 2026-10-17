#!/usr/bin/env python3
r"""Row verifier for the clojure row -- Clojure 1.12 on clojure.main (HotSpot).

Clojure has no build step: clojure.main loads the file and compiles it to
bytecode as it runs, so the compile time is inside the measured number.  The
fifteen staged scripts live directly in the run directory:

    exec\clojure\<task>.clj     artifact, run as
      java -cp <three jars> clojure.main <task>.clj      (cwd exec\clojure)

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot leave
the check behind), a TIME_MS value reached stderr, and task 15 left out.bin behind
at its full 52428800 bytes.

    python exec/clojure/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "clojure"
SRC = os.path.join(ROOT, "sources", "clojure")
RUN = os.path.join(ROOT, "exec", "clojure")
JARS = [
    os.path.join(ROOT, "tools", "clojure", "clojure-1.12.0.jar"),
    os.path.join(ROOT, "tools", "clojure", "spec.alpha-0.5.238.jar"),
    os.path.join(ROOT, "tools", "clojure", "core.specs.alpha-0.4.74.jar"),
]
TIMEOUT = 1800   # task 07 measured 18 s alone and 558 s on this shared 8-core box
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, task + ".clj"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def check(task):
    want = expected_output(task)
    script = os.path.join(RUN, task + ".clj")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    cmd = ["java", "-cp", os.pathsep.join(JARS), "clojure.main", task + ".clj"]
    try:
        p = subprocess.run(cmd, cwd=RUN, capture_output=True, text=True, timeout=TIMEOUT)
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
