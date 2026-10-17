#!/usr/bin/env python3
"""Row verifier for the lua-wasm row -- PUC Lua 5.4.8 cross-compiled to
wasm32-wasip1, run by wasmtime 46.

One toolchain, no per-task build: the interpreter module is staged once as
`exec/lua-wasm/lua.wasm` and each task's script beside it, so the artifact path
`exec/lua-wasm/{task}.lua` is also the script wasmtime is handed.  The working
directory is the row root for every task, and `--dir .` preopens it, which is
why `data.bin` (tasks 14 and 15) and task 15's `out.bin` live there too.

    python exec/lua-wasm/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "lua-wasm"
SRC = os.path.join(ROOT, "sources", "lua-wasm")
RUN = os.path.join(ROOT, "exec", "lua-wasm")
WASMTIME = os.path.join(ROOT, "tools", "wasmtime46", "wasmtime.exe")
WASM = "lua.wasm"
# 600 s would be too tight on this box: the row measured 29.5 s per task when it
# was validated idle, and several agents build at once here.
TIMEOUT = 900
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".lua"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    want = expected_output(task)
    script = os.path.join(RUN, task + ".lua")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    if task == "15_file_write":
        try:
            os.remove(os.path.join(RUN, "out.bin"))
        except OSError:
            pass
    try:
        p = subprocess.run(
            [WASMTIME, "-W", "exceptions=y", "--dir", ".", WASM, task + ".lua"],
            cwd=RUN, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r" % (out[:120], want[:120])
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
