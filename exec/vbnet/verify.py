#!/usr/bin/env python3
"""Row verifier for the vbnet row -- VB.NET, one project per task, .NET 8 SDK.

One cell per task: `dotnet build -c Release` in the task's own directory (the
.NET SDK cannot hold several projects in one directory), then
`dotnet bin/Release/net8.0/<task>.dll` from that directory.  This verifier runs
the built assembly and checks the three things every row's verifier checks:
stdout equals the task's own `expected output:` line (read from the source
header, so a source edit cannot leave the check behind), a TIME_MS value reached
stderr, and task 15 left out.bin behind at its full 52428800 bytes.

    python exec/vbnet/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "vbnet"
SRC = os.path.join(ROOT, "sources", "vbnet")
RUN = os.path.join(ROOT, "exec", "vbnet", "dotnet")
DOTNET = os.path.join(ROOT, "tools", "dotnet8", "dotnet.exe")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task, task + ".vb"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def check(task):
    want = expected_output(task)
    cwd = os.path.join(RUN, task)
    dll = os.path.join(cwd, "bin", "Release", "net8.0", task + ".dll")
    if not os.path.exists(dll):
        return False, "missing artifact %s (run exec/vbnet/build_all.bat)" % dll
    if task == "14_file_read" and not os.path.exists(os.path.join(cwd, "data.bin")):
        return False, "missing fixture data.bin in %s" % cwd
    out_bin = os.path.join(cwd, "out.bin")
    if task == "15_file_write":
        # The reset the harness does before every run: a stale out.bin must not
        # be read as this run's answer.
        try:
            os.remove(out_bin)
        except OSError:
            pass
    env = dict(os.environ)
    env["DOTNET_CLI_TELEMETRY_OPTOUT"] = "1"
    env["DOTNET_NOLOGO"] = "1"
    try:
        p = subprocess.run([DOTNET, os.path.join("bin", "Release", "net8.0", task + ".dll")],
                           cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT, env=env)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    got = p.stdout.replace("\r\n", "\n").strip().lstrip("\ufeff")
    if got != want:
        return False, ("stdout %r != expected %r (stderr tail %r)"
                       % (got[:120], want[:120], p.stderr[-200:]))
    m = None
    for m in re.finditer(r"TIME_MS=([0-9.]+)", p.stderr):
        pass
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
        ok, detail = check(task)
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", detail), flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
