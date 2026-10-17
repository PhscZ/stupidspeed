#!/usr/bin/env python3
"""Row verifier for the java row -- one javac build, four HotSpot configurations.

    openjdk         ->  java                        -cp . _<task>     (tiered C1+C2)
    openjdk (interp) -> java -Xint                  -cp . _<task>     (template interpreter)
    openjdk (c1)     -> java -XX:TieredStopAtLevel=1 -cp . _<task>    (C1 only)
    openjdk (c2)     -> java -XX:-TieredCompilation -cp . _<task>     (C2 only)

All four run the *same* class files out of exec\\java\\openjdk\\<task>, which is the
artifact exec/cells.json names for each of them; only the JVM flags differ.  Checks
the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot leave
the check behind), a TIME_MS value reached stderr, and task 15 left out.bin behind
at its full 52428800 bytes.

    python exec/java/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "java"
SRC = os.path.join(ROOT, "sources", "java")
RUN = os.path.join(ROOT, "exec", "java", "openjdk")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

# (toolchain, extra JVM flags before -cp)
TOOLCHAINS = [
    ("openjdk", []),
    ("openjdk (interp)", ["-Xint"]),
    ("openjdk (c1)", ["-XX:TieredStopAtLevel=1"]),
    ("openjdk (c2)", ["-XX:-TieredCompilation"]),
]

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, "_" + task + ".java"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def check(toolchain, flags, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    cls = os.path.join(cwd, "_%s.class" % task)
    if not os.path.exists(cls):
        return False, "missing artifact %s" % cls
    try:
        p = subprocess.run(["java"] + flags + ["-cp", ".", "_" + task], cwd=cwd,
                           capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s)" % (out[:120], want[:120], p.returncode)
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
    total = passed = 0
    for toolchain, flags in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(toolchain, flags, task)
            total += 1
            passed += 1 if ok else 0
            print("%-17s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
    print("%s %s %d/%d" % (ROW, "PASS" if passed == total else "FAIL", passed, total))
    return 0 if passed == total else 1

if __name__ == "__main__":
    sys.exit(main())
