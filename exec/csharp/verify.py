#!/usr/bin/env python3
"""Row verifier for the csharp row -- the same fifteen C# sources through four toolchains.

    coreclr    exec/csharp/coreclr/<task>/bin/Release/net8.0/<task>.exe
    nativeaot  exec/csharp/nativeaot/<task>/bin/Release/net8.0/win-x64/publish/<task>.exe
    mono       tools/mono/Mono/bin/mono.exe <task>.exe
    mono (aot) tools/mono/Mono/bin/mono.exe --full-aot <task>.exe   (loads <task>.exe.dll)

Every task is run from the cwd exec/csharp/<toolchain>/<task> that exec/cells.json
records, so `data.bin` (task 14) and `out.bin` (task 15) resolve there.

Checks, per the row contract: stdout equals the task's own `expected output:` line (read
from the source header, so a source edit cannot leave the check behind), a TIME_MS value
reached stderr, and task 15 left out.bin at its full 52428800 bytes.  A task counts as
passed only when all four toolchains pass it, so the final line is `<row> PASS n/15`.

    python exec/csharp/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "csharp"
SRC = os.path.join(ROOT, "sources", "csharp")
RUN = os.path.join(ROOT, "exec", "csharp")
MONO = os.path.join(ROOT, "tools", "mono", "Mono", "bin", "mono.exe")
TIMEOUT = 900
# task 07 rebuilds a 750k-character string one byte at a time (O(n^2) copying); it is the
# row's slow task and, on this shared box, can take far longer than the 900 s default.
SLOW = {"07_string_append": 3600}
OUT_BIN_SIZE = 52428800

TOOLCHAINS = ["coreclr", "nativeaot", "mono", "mono-aot"]

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, task, task + ".cs"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def command(toolchain, task):
    """The argv exec/cells.json records for this cell, relative to the task's cwd."""
    if toolchain == "coreclr":
        return [os.path.join("bin", "Release", "net8.0", task + ".exe")]
    if toolchain == "nativeaot":
        return [os.path.join("bin", "Release", "net8.0", "win-x64", "publish", task + ".exe")]
    if toolchain == "mono":
        return [MONO, task + ".exe"]
    return [MONO, "--full-aot", task + ".exe"]

def check(toolchain, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, toolchain, task)
    argv = command(toolchain, task)
    prog = argv[0] if os.path.isabs(argv[0]) else os.path.join(cwd, argv[0])
    if not os.path.exists(prog):
        return False, "missing artifact %s" % prog
    # CreateProcess on Windows does not resolve a relative program name against `cwd`,
    # so hand the child an absolute path while keeping cwd as the cell records it.
    argv = [os.path.abspath(prog)] + list(argv[1:])
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write" and os.path.exists(out_bin):
        os.remove(out_bin)
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True, timeout=SLOW.get(task, TIMEOUT))
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % SLOW.get(task, TIMEOUT)
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s, stderr tail: %r)" % (
            out[:120], want[:120], p.returncode, p.stderr[-200:])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)

def main():
    passed = 0
    for task in TASKS:
        all_ok = True
        for toolchain in TOOLCHAINS:
            ok, detail = check(toolchain, task)
            all_ok = all_ok and ok
            print("%-16s %-9s %s %s" % (task, toolchain, "OK  " if ok else "FAIL", detail),
                  flush=True)
        passed += 1 if all_ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1

if __name__ == "__main__":
    sys.exit(main())
