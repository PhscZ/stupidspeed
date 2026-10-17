#!/usr/bin/env python3
"""Row verifier for the llvm-ir row -- hand-written LLVM IR through llc.

One toolchain: `llc -O2 -filetype=obj` lowers each `.ll` to a COFF object and
`clang -O2 -fuse-ld=lld` links it against the MSVC libraries, so the artifact the
registry names is the linked `exec/llvm-ir/llc/{task}/prog.exe` and the working
directory is that task's own directory.  `build_all.bat` stages the `.ll` source
beside it; tasks 14 and 15 need `data.bin` there and task 15 leaves `out.bin`.

    python exec/llvm-ir/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "llvm-ir"
SRC = os.path.join(ROOT, "sources", "llvm-ir")
RUN = os.path.join(ROOT, "exec", "llvm-ir", "llc")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 900
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".ll"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    exe = os.path.join(cwd, "prog.exe")
    if not os.path.exists(exe):
        return False, "missing artifact %s" % exe
    if task in ("14_file_read", "15_file_write"):
        dest = os.path.join(cwd, "data.bin")
        if not os.path.exists(dest) or os.path.getsize(dest) != os.path.getsize(DATA):
            import shutil
            shutil.copy(DATA, dest)
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
    passed = 0
    for task in TASKS:
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
