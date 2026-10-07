#!/usr/bin/env python3
"""Verifier for the AssemblyScript (wasip1) row.

Runs each task's module, exec/assemblyscript/<task>/prog.wasm, under wasmtime 46.0.3 and
checks

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present on stderr;
  3. task 15 additionally leaves out.bin (52428800 bytes) in its preopened directory.

There is no build step at run time: the module is a WASI command that exports _start and
writes its answer to fd 1 with fd_write, and its timing line to fd 2 the same way, so
stdout and stderr are both the program's own streams with no runtime banner on either.

Task 11 needs three flags and they are not optional: `-S threads=y` turns on the threads
proposal in the runtime, and `-W threads=y -W shared-memory=y` allow the module's own
imports, because it imports a shared memory and calls wasi::thread-spawn. Without them
instantiation fails rather than the task answering slowly.

Tasks 14 and 15 run with `--dir=.` from the directory holding data.bin. The module opens
the fixture through the preopened directory with WASI path_open and reads it in 1 MiB
chunks, so the preopen is what makes the relative name resolve.

Run:  python exec\\assemblyscript\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", "assemblyscript")
OUT = HERE
WASMTIME = os.path.join(ROOT, "tools", "wasmtime46", "wasmtime.exe")
DATA = os.path.join(ROOT, "data.bin")
ROW = "assemblyscript"

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

TIMEOUT = 900
OUT_SIZE = 52428800
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")


def expected(task):
    with open(os.path.join(SRC, task + ".ts"), encoding="utf-8", errors="replace") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected-output line in " + task)
    return m.group(1).strip()


def cmd_for(task):
    cmd = [WASMTIME, "run"]
    if task == "11_parallel_sum":
        cmd += ["-S", "threads=y", "-W", "threads=y", "-W", "shared-memory=y"]
    if task in ("14_file_read", "15_file_write"):
        cmd += ["--dir=."]
    cmd.append("prog.wasm")
    return cmd


def main():
    if not os.path.exists(WASMTIME):
        print("%s FAIL no runtime at %s" % (ROW, WASMTIME), flush=True)
        return 1
    passed = 0
    failed = []
    for task in TASKS:
        d = os.path.join(OUT, task)
        wasm = os.path.join(d, "prog.wasm")
        exp = expected(task)
        if not os.path.exists(wasm):
            print("%s FAIL (no prog.wasm; run build_all.bat)" % task, flush=True)
            failed.append(task)
            continue
        if task in ("14_file_read", "15_file_write"):
            if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copyfile(DATA, os.path.join(d, "data.bin"))
        if task == "15_file_write":
            outbin = os.path.join(d, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        try:
            p = subprocess.run(cmd_for(task), cwd=d, capture_output=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print("%s FAIL timeout after %ss" % (task, TIMEOUT), flush=True)
            failed.append(task)
            continue

        out = p.stdout.decode("utf-8", "replace").strip()
        err = p.stderr.decode("utf-8", "replace")
        m = TIME_RE.search(err)
        problems = []
        if out != exp:
            problems.append("stdout mismatch: expected %r got %r" % (exp, out[:120]))
        if not m:
            problems.append("no TIME_MS on stderr")
        if task == "15_file_write":
            outbin = os.path.join(d, "out.bin")
            if not os.path.exists(outbin):
                problems.append("out.bin missing")
            elif os.path.getsize(outbin) != OUT_SIZE:
                problems.append("out.bin is %d bytes, expected %d" % (os.path.getsize(outbin), OUT_SIZE))

        if problems:
            failed.append(task)
            print("%s FAIL" % task, flush=True)
            for pr in problems:
                print("    %s" % pr, flush=True)
            if err.strip():
                print("    stderr tail: %s" % " | ".join(err.strip().splitlines()[-4:]), flush=True)
        else:
            passed += 1
            print("%s OK TIME_MS=%s" % (task, m.group(1)), flush=True)

    print("%s PASS %d/%d" % (ROW, passed, len(TASKS)), flush=True)
    if failed:
        print("%s FAILED: %s" % (ROW, " ".join(failed)), flush=True)
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
