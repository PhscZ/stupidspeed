#!/usr/bin/env python3
"""Verifier for the haxe row.

The row has four toolchains over the same fifteen sources: `hxcpp` (Haxe's own C++
backend), `haxe (js)`, `haxe (jvm)` and `haxe (cs)`.  For each of them, every task is
checked for

  1. stripped stdout == the task's expected line
  2. a TIME_MS value on stderr
  3. task 15 additionally leaves out.bin

Three more targets were dropped on 2026-10-10 -- php, python and neko.  Each passed
the other fourteen tasks but task 10 cannot finish in a sane time on any of them,
because Haxe's `Int` is 32-bit there and `haxe.Int64` is therefore emulated: measured
2772 s under php and 6212 s under neko, against 1.0 s for hxcpp.  See BUILD.md.

`haxe (jvm)` and `haxe (cs)` need hxjava and hxcs at build time; they cannot be
rebuilt on a machine without them, but their committed artifacts are what this
verifier checks, and they run.
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
DATA = os.path.join(ROOT, "data.bin")
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")
MONO = os.path.join(ROOT, "tools", "mono", "Mono", "bin", "mono.exe")

MODS = {"01_branches": "T01_branches", "02_switch_case": "T02_switch_case",
        "03_func_sum": "T03_func_sum", "04_array_sum": "T04_array_sum",
        "05_alloc_churn": "T05_alloc_churn", "06_char_count": "T06_char_count",
        "07_string_append": "T07_string_append", "08_average": "T08_average",
        "09_fib_recursive": "T09_fib_recursive", "10_pi": "T10_pi",
        "11_parallel_sum": "T11_parallel_sum", "12_matrix_add": "T12_matrix_add",
        "13_matrix_mul": "T13_matrix_mul", "14_file_read": "T14_file_read",
        "15_file_write": "T15_file_write"}
EXPECTED = {
    "01_branches": "33333334 13333333 7619048 45714285", "02_switch_case": "7500000075000000",
    "03_func_sum": "100000000", "04_array_sum": "499999500000", "05_alloc_churn": "1274991808",
    "06_char_count": "10000000", "07_string_append": "250000", "08_average": "0.498046875",
    "09_fib_recursive": "102334155", "10_pi": "4470", "11_parallel_sum": "7500000075000000",
    "12_matrix_add": "999000000", "13_matrix_mul": "599995000", "14_file_read": "2389704704",
    "15_file_write": "52428800"}
TIMEOUT = 900
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")

def command(toolchain, cell, module):
    if toolchain == "hxcpp":
        return [os.path.join(cell, "out", module + ".exe")]
    if toolchain == "haxe (js)":
        return [NODE, os.path.join("js", module + ".js")]
    if toolchain == "haxe (jvm)":
        return ["java", "-jar", os.path.join("jvm", module + ".jar")]
    if toolchain == "haxe (cs)":
        return [MONO, os.path.join("cs", module + ".exe")]
    raise SystemExit("unknown toolchain " + toolchain)

def stage(task, cell):
    if task == "14_file_read":
        dest = os.path.join(cell, "data.bin")
        if not os.path.exists(dest) or not os.path.samefile(DATA, dest):
            shutil.copy(DATA, dest)
    if task == "15_file_write":
        out = os.path.join(cell, "out.bin")
        if os.path.exists(out):
            os.remove(out)

def check(toolchain):
    passed = 0
    for task, module in MODS.items():
        cell = os.path.join(HERE, module)
        stage(task, cell)
        argv = command(toolchain, cell, module)
        try:
            p = subprocess.run(argv, cwd=cell, capture_output=True, text=True,
                               timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print("%-14s %-18s FAIL (timeout after %ds)" % (toolchain, task, TIMEOUT))
            continue
        except OSError as exc:
            print("%-14s %-18s FAIL (cannot run %s: %s)" % (toolchain, task, argv[0], exc))
            continue
        out = p.stdout.strip()
        why = []
        if out != EXPECTED[task]:
            why.append("stdout %r != expected %r" % (out[:60], EXPECTED[task]))
        m = TIME_RE.search(p.stderr)
        if not m:
            why.append("no TIME_MS on stderr")
        if task == "15_file_write" and not os.path.exists(os.path.join(cell, "out.bin")):
            why.append("out.bin missing")
        if why:
            print("%-14s %-18s FAIL" % (toolchain, task))
            for w in why:
                print("    %s" % w)
            tail = "\n".join(p.stderr.strip().splitlines()[-3:])
            if tail:
                print("    stderr tail: %s" % tail.replace("\n", " | "))
        else:
            print("%-14s %-18s OK TIME_MS=%s" % (toolchain, task, m.group(1)))
            passed += 1
    print("HAXE/%-11s PASS %d/15" % (toolchain, passed))
    return passed

def main():
    bad = 0
    for toolchain in ("hxcpp", "haxe (js)", "haxe (jvm)", "haxe (cs)"):
        if check(toolchain) != len(MODS):
            bad += 1
    return 0 if bad == 0 else 1

if __name__ == "__main__":
    sys.exit(main())
