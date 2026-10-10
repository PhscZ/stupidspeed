#!/usr/bin/env python3
"""Verifier for the fortran row.

Three toolchains over the same fifteen sources, all reaching the same kind of
backend through different code generators:

  gfortran  C:\\mingw64\\bin\\gfortran.exe -O3 [-fopenmp]
  flang     tools/msys64/msys64/ucrt64/bin/flang.exe -O3 [-fopenmp]  (LLVM)
  ifx       Intel's Fortran compiler (LLVM, Intel's fork), via the MSVC environment

ifx is installed from Intel's conda channel rather than the oneAPI .exe installer
(see BUILD.md); it needs INCLUDE/LIB pointing at its own module and library trees
plus the MSVC environment, because it links with link.exe.
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
DATA = os.path.join(ROOT, "data.bin")
MSYSBIN = os.path.join(ROOT, "tools", "msys64", "msys64", "ucrt64", "bin")
IFX = os.path.join(ROOT, "tools", "ifx", "Library", "bin", "ifx.exe")

TASKS = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]
EXPECTED = {
    "01_branches": "33333334 13333333 7619048 45714285", "02_switch_case": "7500000075000000",
    "03_func_sum": "100000000", "04_array_sum": "499999500000", "05_alloc_churn": "1274991808",
    "06_char_count": "10000000", "07_string_append": "250000", "08_average": "0.498046875",
    "09_fib_recursive": "102334155", "10_pi": "4470", "11_parallel_sum": "7500000075000000",
    "12_matrix_add": "999000000", "13_matrix_mul": "599995000", "14_file_read": "2389704704",
    "15_file_write": "52428800"}
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")
TIMEOUT = 1800


def ifx_env():
    """The MSVC environment plus ifx's own INCLUDE and LIB."""
    env = dict(os.environ)
    out = subprocess.run([sys.executable, os.path.join(ROOT, "tools", "msvc_env.py")],
                         capture_output=True, text=True, check=True).stdout
    for line in out.splitlines():
        line = line.strip()
        if line.lower().startswith("set "):
            line = line[4:].strip()
        if "=" not in line:
            continue
        key, val = line.split("=", 1)
        env[key.strip().strip('"')] = val.strip().strip('"').replace("%PATH%", env.get("PATH", ""))
    env["PATH"] = os.path.dirname(IFX) + os.pathsep + env.get("PATH", "")
    env["INCLUDE"] = (os.path.join(ROOT, "tools", "ifx", "opt", "compiler", "include", "intel64")
                      + os.pathsep + env.get("INCLUDE", ""))
    env["LIB"] = os.path.join(ROOT, "tools", "ifx", "Library", "lib") + os.pathsep + env.get("LIB", "")
    return env


def run(toolchain, task):
    cell = os.path.join(HERE, toolchain, task)
    if task == "14_file_read":
        dest = os.path.join(cell, "data.bin")
        if not os.path.exists(dest) or not os.path.samefile(DATA, dest):
            shutil.copy(DATA, dest)
    out_bin = os.path.join(cell, "out.bin")
    if task == "15_file_write" and os.path.exists(out_bin):
        os.remove(out_bin)
    env = dict(os.environ)
    if toolchain == "flang":
        env["PATH"] = MSYSBIN + os.pathsep + env.get("PATH", "")
    if toolchain == "ifx":
        env = ifx_env()
    try:
        p = subprocess.run([os.path.join(cell, "prog.exe")], cwd=cell, env=env,
                           capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        print("%-10s %-18s FAIL (timeout after %ds)" % (toolchain, task, TIMEOUT))
        return False
    except OSError as exc:
        print("%-10s %-18s FAIL (cannot run: %s)" % (toolchain, task, exc))
        return False
    got = p.stdout.strip()
    why = []
    if got != EXPECTED[task]:
        why.append("stdout %r != expected %r" % (got[:60], EXPECTED[task]))
    m = TIME_RE.search(p.stderr)
    if not m:
        why.append("no TIME_MS on stderr")
    if task == "15_file_write" and not os.path.exists(out_bin):
        why.append("out.bin missing")
    if why:
        print("%-10s %-18s FAIL" % (toolchain, task))
        for w in why:
            print("    %s" % w)
        return False
    print("%-10s %-18s OK TIME_MS=%s" % (toolchain, task, m.group(1)))
    return True


def main():
    bad = 0
    for toolchain in ("gfortran", "flang", "ifx"):
        passed = sum(run(toolchain, task) for task in TASKS)
        print("FORTRAN/%-9s PASS %d/%d" % (toolchain, passed, len(TASKS)))
        if passed != len(TASKS):
            bad += 1
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
