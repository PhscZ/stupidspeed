#!/usr/bin/env python3
r"""Row verifier for the kotlin row -- two toolchains, one shared task directory.

    jvm  exec\kotlin\<task>\prog.jar   run `java -jar prog.jar`
    js   exec\kotlin\<task>\prog.js    run `tools\nodejs\node.exe prog.js`

Both are run with cwd = exec\kotlin\<task>\ , exactly as exec\cells.json names them.
For every task and every toolchain it checks the three things each row checks:

  * stripped stdout equals the task's own `expected output:` line, read from the
    source header (sources\kotlin\ for jvm, sources\kotlin-js\ for js), so a source
    edit cannot leave the check behind;
  * a TIME_MS value reached stderr;
  * task 15 left out.bin behind at its full 52428800 bytes.

    python exec\kotlin\verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "kotlin"
OUT = os.path.join(ROOT, "exec", "kotlin")
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")
# The js toolchain is the slow half of this row: task 01 alone measured 302 s on an
# idle box, and eight agents share this one.  A generous per-task cap keeps a busy
# machine from being read as a hung program.
TIMEOUT = 3600
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# (toolchain, source dir, artifact, argv, extra env)
TOOLCHAINS = [
    ("jvm", "kotlin", "prog.jar", ["java", "-jar", "prog.jar"]),
    ("js", "kotlin-js", "prog.js", [NODE, "prog.js"]),
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(srcdir, task):
    with open(os.path.join(ROOT, "sources", srcdir, task + ".kt"),
              encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s/%s.kt: no `expected output:` line in the source header"
                         % (srcdir, task))
    return m.group(1)


def check(toolchain, srcdir, artifact, argv, task):
    want = expected_output(srcdir, task)
    cwd = os.path.join(OUT, task)
    if not os.path.exists(os.path.join(cwd, artifact)):
        return False, "missing artifact %s" % os.path.join(cwd, artifact)
    if task == "15_file_write":
        stale = os.path.join(cwd, "out.bin")
        if os.path.exists(stale):
            os.remove(stale)
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (stderr tail: %r)" % (
            out[:120], want[:120], p.stderr[-200:])
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
    results = {}
    for toolchain, srcdir, artifact, argv in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(toolchain, srcdir, artifact, argv, task)
            results[(toolchain, task)] = ok
            print("%-16s %-4s %s %s" % (task, toolchain, "OK  " if ok else "FAIL", detail),
                  flush=True)
        good = sum(1 for t in TASKS if results[(toolchain, t)])
        print("%s/%s %s %d/15" % (ROW, toolchain, "PASS" if good == len(TASKS) else "FAIL", good),
              flush=True)
    # a task counts only when it passed on every toolchain of the row
    passed = sum(1 for t in TASKS
                 if all(results[(tc, t)] for tc, _src, _art, _argv in TOOLCHAINS))
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed), flush=True)
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
