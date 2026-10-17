#!/usr/bin/env python3
"""Row verifier for the ocaml row -- one source set, two back ends.

Runs all fifteen tasks of both toolchains: `ocamlopt` (native, prog.exe) and `ocamlc`
(bytecode, prog.exe plus the OCaml runtime launcher). Each task is run from its own
directory -- the cwd the registry names -- with the MSYS2 UCRT64 bin directory first on
PATH and OCAMLLIB set to the Windows form of the stdlib, because the bytecode launcher
needs ocamlrun.exe and dllunixbyt.dll to resolve.

Checks, per the row contract: stdout equals the task's own `expected output:` line (read
from the source header), a TIME_MS value reached stderr, and task 15 left out.bin at its
full 52428800 bytes.

    python exec/ocaml/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "ocaml"
SRC = os.path.join(ROOT, "sources", "ocaml")
UCRT = os.path.join(ROOT, "tools", "msys64", "msys64", "ucrt64")
TOOLCHAINS = ["ocamlopt", "ocamlc"]
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*\*?\)?\s*$")


def expected_output(task):
    with open(os.path.join(SRC, "_" + task + ".ml"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def run_env():
    env = dict(os.environ)
    env["PATH"] = os.path.join(UCRT, "bin") + os.pathsep + env.get("PATH", "")
    env["OCAMLLIB"] = os.path.join(UCRT, "lib", "ocaml")
    return env


def check(toolchain, task, env):
    want = expected_output(task)
    cwd = os.path.join(ROOT, "exec", ROW, toolchain, task)
    exe = os.path.join(cwd, "prog.exe")
    if not os.path.exists(exe):
        return False, "missing artifact %s" % exe
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write" and os.path.exists(out_bin):
        os.remove(out_bin)
    try:
        p = subprocess.run([exe], cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT, env=env)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (stderr tail: %r)" % (out[:120], want[:120],
                                                                     p.stderr[-200:])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)


def main():
    env = run_env()
    passed = 0
    total = len(TASKS) * len(TOOLCHAINS)
    for toolchain in TOOLCHAINS:
        for task in TASKS:
            ok, detail = check(toolchain, task, env)
            print("%-10s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
            passed += 1 if ok else 0
    print("%s %s %d/%d" % (ROW, "PASS" if passed == total else "FAIL", passed, total))
    return 0 if passed == total else 1


if __name__ == "__main__":
    sys.exit(main())
