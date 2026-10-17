#!/usr/bin/env python3
"""Row verifier for the haxe row -- one source directory, four Haxe targets.

    exec\\haxe\\T<task>\\out\\T<task>.exe   hxcpp  -> haxe -cpp, hxcpp drives g++/windres
    exec\\haxe\\T<task>\\js\\T<task>.js     js     -> haxe --js, run by tools\\nodejs\\node.exe
    exec\\haxe\\T<task>\\jvm\\T<task>.jar   jvm    -> haxe --jvm, run by `java -jar`
    exec\\haxe\\T<task>\\cs\\T<task>.exe    cs     -> haxe --cs + Mono's csc, run by mono

Every toolchain runs with the task directory as its working directory, exactly as
exec/cells.json records, so tasks 14 and 15 find data.bin there and task 15 leaves
out.bin there.

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot leave
the check behind), a TIME_MS value reached stderr, and task 15 left out.bin behind
at its full 52428800 bytes.

    python exec/haxe/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "haxe"
SRC = os.path.join(ROOT, "sources", "haxe")
RUN = os.path.join(ROOT, "exec", "haxe")
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")
MONO = os.path.join(ROOT, "tools", "mono", "Mono", "bin", "mono.exe")
# The row's slowest cells measured 26 s (hxcpp 07) and 86 s (cs 07); the js task 10
# took 22 s.  Under a loaded 8-core box those inflate several-fold, so the cap is
# deliberately far above them rather than near them.
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

TOOLCHAINS = ["hxcpp", "haxe (js)", "haxe (jvm)", "haxe (cs)"]

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?(?:[eE][+-]?[0-9]+)?)")


def expected_output(task):
    with open(os.path.join(SRC, "T" + task + ".hx"), encoding="utf-8", errors="replace") as fh:
        for line in fh:
            m = EXPECTED.search(line)
            if m:
                return m.group(1)
    raise SystemExit("%s: no `expected output:` line in the source header" % task)


def command(toolchain, task):
    """The artifact path and the argv exec/cells.json records for this cell."""
    if toolchain == "hxcpp":
        return os.path.join(RUN, "T" + task, "out", "T" + task + ".exe")
    if toolchain == "haxe (js)":
        return [NODE, "js/T%s.js" % task]
    if toolchain == "haxe (jvm)":
        return ["java", "-jar", "jvm/T%s.jar" % task]
    if toolchain == "haxe (cs)":
        return [MONO, "cs/T%s.exe" % task]
    raise SystemExit("unknown toolchain %r" % toolchain)


def artifact_path(toolchain, task):
    cwd = os.path.join(RUN, "T" + task)
    if toolchain == "hxcpp":
        return os.path.join(cwd, "out", "T" + task + ".exe")
    if toolchain == "haxe (js)":
        return os.path.join(cwd, "js", "T%s.js" % task)
    if toolchain == "haxe (jvm)":
        return os.path.join(cwd, "jvm", "T%s.jar" % task)
    return os.path.join(cwd, "cs", "T%s.exe" % task)


def check(toolchain, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, "T" + task)
    artifact = artifact_path(toolchain, task)
    if not os.path.exists(artifact):
        return False, "missing artifact %s" % artifact
    argv = command(toolchain, task)
    if isinstance(argv, str):
        argv = [argv]
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT)
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
        out_bin = os.path.join(cwd, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    results = {}
    for toolchain in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(toolchain, task)
            results[(toolchain, task)] = ok
            print("%-10s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
        good = sum(1 for t in TASKS if results[(toolchain, t)])
        print("%s/%s %s %d/15" % (ROW, toolchain, "PASS" if good == len(TASKS) else "FAIL", good),
              flush=True)
    # a task counts only when it passed on every toolchain of the row
    passed = sum(1 for t in TASKS if all(results[(tc, t)] for tc in TOOLCHAINS))
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed), flush=True)
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
