#!/usr/bin/env python3
"""Verifier for the AssemblyScript (wasip1) row.

Runs each task's module, exec/assemblyscript/<task>/prog.wasm, under wasmtime 46.0.3 and
under wasmer 4.3.7's three code generators, and checks

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present on stderr;
  3. task 15 additionally leaves out.bin (52428800 bytes) in its preopened directory.

There is no build step at run time: the module is a WASI command that exports _start and
writes its answer to fd 1 with fd_write, and its timing line to fd 2 the same way, so
stdout and stderr are both the program's own streams with no runtime banner on either.

Task 11 needs three flags and they are not optional under wasmtime: `-S threads=y` turns on
the threads proposal in the runtime, and `-W threads=y -W shared-memory=y` allow the
module's own imports, because it imports a shared memory and calls wasi::thread-spawn.
Without them instantiation fails rather than the task answering slowly.  Wasmer has the
threads proposal on by default, so its cells need no flags.

Tasks 14 and 15 run with `--dir=.` from the directory holding data.bin under wasmtime. The
module opens the fixture through the preopened directory with WASI path_open and reads it in
1 MiB chunks, so the preopen is what makes the relative name resolve.  The wasmer cells use
`--mapdir /:<host dir>` instead, because wasmer's `--dir=.` preopens an empty root.

Task 15 is a capability boundary under wasmer, not a failed cell: wasmer 4.3.7's WASIX
filesystem overlays the host directory read-only, so a file the program *creates* lives in an
in-memory layer that is discarded at exit.  Writing to a file that already exists does reach
the host, which is why task 14 (read data.bin) is fine and task 15 cannot leave out.bin.

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
WASMER = os.path.join(ROOT, "tools", "wasmer437", "bin", "wasmer.exe")
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
# wasmer cannot create a new file on the host filesystem (see the module docstring).
WASMER_EXCEPT = {"15_file_write"}

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

def wasmer_cmd(comp, task, d):
    cmd = [WASMER, "run", "--" + comp]
    if task in ("14_file_read", "15_file_write"):
        cmd += ["--mapdir", "/:" + d]
    cmd.append("prog.wasm")
    return cmd

def snapshot_out(d):
    """Remember task 15's out.bin, which is a committed artifact.

    A verification run must leave exec/ exactly as it found it, so whatever the
    cell wrote is put back once the cell has been checked -- the same thing
    exec/harness.py does around every run.
    """
    p = os.path.join(d, "out.bin")
    try:
        with open(p, "rb") as fh:
            return (p, fh.read())
    except OSError:
        return (p, None)

def restore_out(saved):
    p, blob = saved
    try:
        if blob is None:
            if os.path.exists(p):
                os.remove(p)
        else:
            with open(p, "wb") as fh:
                fh.write(blob)
    except OSError:
        pass

def stage(task, d):
    if task in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")):
            shutil.copyfile(DATA, os.path.join(d, "data.bin"))
    if task == "15_file_write":
        outbin = os.path.join(d, "out.bin")
        if os.path.exists(outbin):
            os.remove(outbin)

def problems_for(task, d, exp, p):
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
    return m, problems, err

def report(task, label, m, problems, err):
    if problems:
        print("%s FAIL%s" % (task, label), flush=True)
        for pr in problems:
            print("    %s" % pr, flush=True)
        if err.strip():
            print("    stderr tail: %s" % " | ".join(err.strip().splitlines()[-4:]), flush=True)
        return False
    print("%s OK TIME_MS=%s%s" % (task, m.group(1), label), flush=True)
    return True

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
        saved = snapshot_out(d)
        stage(task, d)
        try:
            p = subprocess.run(cmd_for(task), cwd=d, capture_output=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            restore_out(saved)
            print("%s FAIL timeout after %ss" % (task, TIMEOUT), flush=True)
            failed.append(task)
            continue
        m, problems, err = problems_for(task, d, exp, p)
        restore_out(saved)
        if report(task, "", m, problems, err):
            passed += 1
        else:
            failed.append(task)

    print("%s PASS %d/%d" % (ROW, passed, len(TASKS)), flush=True)
    if failed:
        print("%s FAILED: %s" % (ROW, " ".join(failed)), flush=True)

    if not os.path.exists(WASMER):
        print("%s FAIL no runtime at %s" % (ROW, WASMER), flush=True)
        return 1
    for comp in ("cranelift", "llvm", "singlepass"):
        wpass = 0
        wfail = []
        for task in TASKS:
            d = os.path.join(OUT, task)
            exp = expected(task)
            if task in WASMER_EXCEPT:
                print("%s SKIP [wasmer %s] capability boundary" % (task, comp), flush=True)
                continue
            saved = snapshot_out(d)
            stage(task, d)
            try:
                p = subprocess.run(wasmer_cmd(comp, task, d), cwd=d, capture_output=True, timeout=TIMEOUT)
            except subprocess.TimeoutExpired:
                restore_out(saved)
                print("%s FAIL timeout after %ss [wasmer %s]" % (task, TIMEOUT, comp), flush=True)
                wfail.append(task)
                continue
            m, problems, err = problems_for(task, d, exp, p)
            restore_out(saved)
            if report(task, " [wasmer %s]" % comp, m, problems, err):
                wpass += 1
            else:
                wfail.append(task)
        print("%s wasmer (%s) PASS %d/%d (task 15 excepted)" % (ROW, comp, wpass, len(TASKS)), flush=True)
        if wfail:
            print("%s wasmer (%s) FAILED: %s" % (ROW, comp, " ".join(wfail)), flush=True)
    return 0 if passed == len(TASKS) else 1

if __name__ == "__main__":
    sys.exit(main())
