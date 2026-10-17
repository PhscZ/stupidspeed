#!/usr/bin/env python3
"""Row verifier for the dart row -- two toolchains over the same fifteen sources.

    exec\\dart\\aot\\<task>\\prog.exe   `dart compile exe -o prog` (dart-aot)
    exec\\dart\\jit\\<task>.dart        `dart <task>.dart` (dart-jit)

The `jit` toolchain has no build step and runs every task from the one directory
`exec\\dart\\jit`, which is where the registry puts its cwd -- so tasks 14 and 15
read/write `data.bin`/`out.bin` there rather than in a per-task directory.

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header), a TIME_MS value reached
stderr, and task 15 left out.bin at its full 52428800 bytes.

    python exec/dart/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "dart"
SRC = os.path.join(ROOT, "sources", "dart")
RUN = os.path.join(ROOT, "exec", "dart")
DART = os.path.join(ROOT, "tools", "dart", "bin", "dart.exe")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 600
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".dart"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def matches(got, want):
    """The harness's rule: the answer, or the last non-empty line of the stream."""
    got = got.lstrip("\ufeff").strip()
    if got == want:
        return True
    lines = [ln.strip().lstrip("\ufeff") for ln in got.splitlines() if ln.strip()]
    return bool(lines) and lines[-1] == want


def stage_fixture(cwd):
    dest = os.path.join(cwd, "data.bin")
    try:
        fresh = os.path.getsize(dest) == os.path.getsize(DATA)
    except OSError:
        fresh = False
    if not fresh:
        shutil.copy(DATA, dest)


def check(toolchain, task):
    want = expected_output(task)
    if toolchain == "aot":
        cwd = os.path.join(RUN, "aot", task)
        argv = [os.path.join(cwd, "prog.exe")]
        artifact = argv[0]
    else:
        cwd = os.path.join(RUN, "jit")
        argv = [DART, task + ".dart"]
        artifact = os.path.join(cwd, task + ".dart")
    if not os.path.exists(artifact):
        return False, "missing artifact %s" % artifact
    if task == "14_file_read":
        stage_fixture(cwd)
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write" and os.path.exists(out_bin):
        try:
            os.remove(out_bin)
        except OSError:
            pass
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n")
    if not matches(out, want):
        return False, "stdout %r != expected %r (exit %s, stderr tail %r)" % (
            out.strip()[:120], want[:120], p.returncode, p.stderr.strip()[-160:])
    m = None
    for m in re.finditer(r"TIME_MS=([0-9.]+)", p.stderr):
        pass
    if not m:
        return False, "no TIME_MS on stderr (exit %s, stderr tail: %r)" % (
            p.returncode, p.stderr[-200:])
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    tasks_all_ok = [True] * len(TASKS)
    for toolchain in ("aot", "jit"):
        tc_passed = 0
        for i, task in enumerate(TASKS):
            ok, detail = check(toolchain, task)
            tc_passed += 1 if ok else 0
            if not ok:
                tasks_all_ok[i] = False
            print("%-4s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
        print("--- %s %s %d/15" % (toolchain, "PASS" if tc_passed == 15 else "FAIL", tc_passed),
              flush=True)
    good = sum(1 for ok in tasks_all_ok if ok)
    print("%s %s %d/15" % (ROW, "PASS" if good == 15 else "FAIL", good))
    return 0 if good == 15 else 1


if __name__ == "__main__":
    sys.exit(main())
