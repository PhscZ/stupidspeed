#!/usr/bin/env python3
"""Row verifier for the ada row -- the same fifteen Ada sources through two GNAT
front ends.

    gnat       -> exec\\ada\\<task>\\t<task>.exe        (gnatmake -O3, the GCC pipeline)
    gnat llvm  -> exec\\ada\\llvm\\<task>\\t<task>.exe   (llvm-gnatmake -O3, LLVM)

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot
leave the check behind), a TIME_MS value reached stderr, and task 15 left out.bin
behind at its full 52428800 bytes.

`gnat llvm` is a from-source build of AdaCore/gnat-llvm, installed here at
tools/gnat-llvm/llvm-interface/bin/llvm-gnatmake.exe (BUILD.md has the recipe and
the three source adjustments it needs).  A host without it still verifies the rest
of the row: the toolchain is reported as SKIP with the reason and left out of the
count, so the final line is 30/30 here and 15/15 there.

    python exec/ada/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "ada"
SRC = os.path.join(ROOT, "sources", "ada")
RUN = os.path.join(ROOT, "exec", "ada")
GNAT_LLVM = os.path.join(ROOT, "tools", "gnat-llvm", "llvm-interface", "bin",
                         "llvm-gnatmake.exe")
TIMEOUT = 600
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, "t" + task + ".adb"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def check(run_dir, task):
    want = expected_output(task)
    cwd = os.path.join(run_dir, task)
    exe = os.path.join(cwd, "t%s.exe" % task)
    if not os.path.exists(exe):
        return False, "missing artifact %s" % exe
    if task == "15_file_write":
        try:
            os.remove(os.path.join(cwd, "out.bin"))
        except OSError:
            pass
    try:
        p = subprocess.run([exe], cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
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
    # The row is two toolchains over one set of sources, so the count is cells:
    # 30 when both are installed, 15 when only gnat is (gnat llvm is a
    # from-source build, and a host without it still verifies the rest).
    passed = 0
    checked = 0
    for task in TASKS:
        ok, detail = check(RUN, task)
        print("%-9s %-16s %s %s" % ("gnat", task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
        checked += 1

    if os.path.exists(GNAT_LLVM):
        for task in TASKS:
            ok, detail = check(os.path.join(RUN, "llvm"), task)
            print("%-9s %-16s %s %s" % ("gnat llvm", task, "OK  " if ok else "FAIL", detail),
                  flush=True)
            passed += 1 if ok else 0
            checked += 1
    else:
        print("gnat llvm SKIP: toolchain not installed on this host (from-source "
              "AdaCore/gnat-llvm build; BUILD.md)", flush=True)

    print("%s %s %d/%d" % (ROW, "PASS" if passed == checked else "FAIL", passed, checked))
    return 0 if passed == checked else 1

if __name__ == "__main__":
    sys.exit(main())
