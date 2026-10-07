#!/usr/bin/env python3
"""Verifier for the javascript row.

Toolchains: node, bun, deno.  No build step: each task directory holds the source
staged by build_all.bat (plus data.bin for tasks 14/15).

Checks per task:
  1. stripped stdout == the task's `expected output:` line (read from sources/javascript);
  2. a TIME_MS value is present on stderr;
  3. task 15 leaves out.bin (52428800 bytes) in its working directory.

Run:  python exec\\javascript\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))          # exec/javascript
REPO = os.path.dirname(os.path.dirname(HERE))              # C:\stupidspeed
SRC = os.path.join(REPO, "sources", "javascript")
DATA = os.path.join(REPO, "data.bin")
ROW = "javascript"

TOOLCHAINS = ["node", "bun", "deno"]

# Exact executables (the assignment names these rather than trusting PATH).  The deno
# entry is an npm .cmd shim, which CreateProcess runs directly.
EXE = {
    "node": r"C:\Program Files\nodejs\node.exe",
    "bun": r"C:\Users\pz020\.bun\bin\bun.exe",
    "deno": r"C:\Users\pz020\AppData\Roaming\npm\deno.cmd",
}

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

TIMEOUT = 600          # seconds per task (javascript tasks are all fast)
OUT_SIZE = 52428800


def expected(task):
    with open(os.path.join(SRC, task + ".js"), "r", encoding="utf-8", errors="replace") as f:
        first = f.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected output line in %s.js" % task)
    return m.group(1)


def command(tool, task, script):
    if tool == "node":
        return [EXE["node"], script]
    if tool == "bun":
        return [EXE["bun"], script]
    if tool == "deno":
        # deno 2.1.9 needs --unstable-detect-cjs to load these CommonJS sources
        # (require()/__filename); workers (11) and the file fixture (14) need read
        # access, task 15 needs write access.
        cmd = [EXE["deno"], "run", "--unstable-detect-cjs"]
        if task in ("11_parallel_sum", "14_file_read"):
            cmd.append("--allow-read")
        if task == "15_file_write":
            cmd.append("--allow-write")
        cmd.append(script)
        return cmd
    raise ValueError(tool)


def tail(text, n=600):
    text = text.strip()
    return text[-n:] if len(text) > n else text


def run_one(tool, task):
    d = os.path.join(HERE, tool, task)
    exp = expected(task)
    if task in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copyfile(DATA, os.path.join(d, "data.bin"))
    if task == "15_file_write":
        ob = os.path.join(d, "out.bin")
        if os.path.exists(ob):
            os.remove(ob)
    cmd = command(tool, task, task + ".js")
    try:
        p = subprocess.run(cmd, cwd=d, capture_output=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT, ""

    out = p.stdout.decode("utf-8", "replace").strip()
    err = p.stderr.decode("utf-8", "replace")
    problems = []
    if out != exp:
        problems.append("expected %r got %r" % (exp, out))
    m = re.search(r"TIME_MS=([0-9.]+)", err)
    time_ms = m.group(1) if m else None
    if time_ms is None:
        problems.append("no TIME_MS on stderr")
    if task == "15_file_write":
        ob = os.path.join(d, "out.bin")
        if not os.path.exists(ob):
            problems.append("out.bin missing")
        elif os.path.getsize(ob) != OUT_SIZE:
            problems.append("out.bin size %d != %d" % (os.path.getsize(ob), OUT_SIZE))
    if p.returncode != 0:
        problems.append("exit code %d" % p.returncode)
    if problems:
        return False, "; ".join(problems) + "\n    stderr tail: " + tail(err), time_ms
    return True, "", time_ms


def main():
    overall = 0
    for tool in TOOLCHAINS:
        print("=== %s/%s ===" % (ROW, tool))
        passed = 0
        for task in TASKS:
            ok, msg, time_ms = run_one(tool, task)
            if ok:
                passed += 1
                print("%s OK TIME_MS=%s" % (task, time_ms))
            else:
                print("%s FAIL" % task)
                print("    " + msg.replace("\n", "\n    "))
        print("%s/%s PASS %d/15" % (ROW, tool, passed))
        overall += passed
    print("%s TOTAL PASS %d/45" % (ROW, overall))
    return 0 if overall == len(TASKS) * len(TOOLCHAINS) else 1


if __name__ == "__main__":
    sys.exit(main())
