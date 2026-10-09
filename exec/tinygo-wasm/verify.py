#!/usr/bin/env python3
"""Verifier for the tinygo-wasm (wasip1) row.

Runs every task built by exec/tinygo-wasm/build_all.bat under wasmtime 46.0.3 and under
wasmer 4.3.7's three code generators, and checks
  1. stripped stdout == the task's `expected output:` line from sources/tinygo-wasm/<task>.go
  2. a TIME_MS value on stderr
  3. task 15 additionally leaves out.bin in its preopened directory

Tasks 14 and 15 run with `--dir=.` from the directory holding data.bin; TinyGo links wasi-libc,
which registers the "." preopen under the empty prefix, so the relative names resolve.

The wasmer cells run the same prog.wasm with `--cranelift`, `--llvm` or `--singlepass`.
Threads are on by default there, so task 11 -- which TinyGo answers serially, because Go's
wasip1 port has no thread support -- needs no flags.  Tasks 14 and 15 use
`--mapdir /:<host dir>` instead of `--dir=.`, because wasmer's `--dir=.` preopens an empty
root and the relative name does not resolve.

Task 15 is a capability boundary under wasmer, not a failed cell: wasmer 4.3.7's WASIX
filesystem overlays the host directory read-only, so a file the program *creates* lives in an
in-memory layer that is discarded at exit.  Writing to a file that already exists does reach
the host, which is why task 14 (read data.bin) is fine and task 15 cannot leave out.bin.
"""
import os
import re
import subprocess
import sys

ROW = "tinygo-wasm"
TOOLCHAIN = "wasip1"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", ROW)
OUT = os.path.join(HERE, TOOLCHAIN)
WASMTIME = os.path.join(ROOT, "tools", "wasmtime46", "wasmtime.exe")
WASMER = os.path.join(ROOT, "tools", "wasmer437", "bin", "wasmer.exe")
TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]
TIMEOUT = 900
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")
# wasmer cannot create a new file on the host filesystem (see the module docstring).
WASMER_EXCEPT = {"15_file_write"}

def expected(task):
    with open(os.path.join(SRC, task + ".go"), encoding="utf-8") as fh:
        for line in fh:
            m = re.search(r"expected output:\s*(.*?)\s*$", line)
            if m:
                return m.group(1)
    raise SystemExit("no expected-output line in " + task)

def cmd_for(task):
    cmd = [WASMTIME, "run"]
    if task in ("14_file_read", "15_file_write"):
        cmd += ["--dir=."]
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

def wasmer_cmd(comp, task, d):
    cmd = [WASMER, "run", "--" + comp]
    if task in ("14_file_read", "15_file_write"):
        cmd += ["--mapdir", "/:" + d]
    cmd.append("prog.wasm")
    return cmd

def check(task, d, exp, p):
    got = p.stdout.decode("utf-8", "replace").strip()
    err = p.stderr.decode("utf-8", "replace")
    why = []
    if got != exp:
        why.append("stdout %r != expected %r" % (got, exp))
    m = TIME_RE.search(err)
    if not m:
        why.append("no TIME_MS on stderr")
    if p.returncode != 0:
        why.append("exit code %d" % p.returncode)
    if task == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
        why.append("out.bin missing")
    return m, why, err

def main():
    passed = 0
    for task in TASKS:
        d = os.path.join(OUT, task)
        exp = expected(task)
        out_bin = os.path.join(d, "out.bin")
        saved = snapshot_out(d)
        if task == "15_file_write" and os.path.exists(out_bin):
            os.remove(out_bin)
        try:
            p = subprocess.run(cmd_for(task), cwd=d, capture_output=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            restore_out(saved)
            print("%s FAIL (timeout after %ds)" % (task, TIMEOUT))
            continue
        except OSError as exc:
            restore_out(saved)
            print("%s FAIL (cannot run wasmtime: %s)" % (task, exc))
            continue
        m, why, err = check(task, d, exp, p)
        restore_out(saved)
        if why:
            print("%s FAIL" % task)
            for w in why:
                print("    %s" % w)
            tail = "\n".join(err.strip().splitlines()[-5:])
            if tail:
                print("    stderr tail: %s" % tail.replace("\n", " | "))
        else:
            print("%s OK TIME_MS=%s" % (task, m.group(1)))
            passed += 1
    print("%s PASS %d/15" % (ROW, passed))

    for comp in ("cranelift", "llvm", "singlepass"):
        wpass = 0
        for task in TASKS:
            d = os.path.join(OUT, task)
            exp = expected(task)
            if task in WASMER_EXCEPT:
                print("%s SKIP [wasmer %s] capability boundary" % (task, comp))
                continue
            out_bin = os.path.join(d, "out.bin")
            saved = snapshot_out(d)
            if task == "15_file_write" and os.path.exists(out_bin):
                os.remove(out_bin)
            try:
                p = subprocess.run(wasmer_cmd(comp, task, d), cwd=d, capture_output=True, timeout=TIMEOUT)
            except subprocess.TimeoutExpired:
                restore_out(saved)
                print("%s FAIL (timeout after %ds) [wasmer %s]" % (task, TIMEOUT, comp))
                continue
            except OSError as exc:
                restore_out(saved)
                print("%s FAIL (cannot run wasmer: %s)" % (task, exc))
                continue
            m, why, err = check(task, d, exp, p)
            restore_out(saved)
            if why:
                print("%s FAIL [wasmer %s]" % (task, comp))
                for w in why:
                    print("    %s" % w)
                tail = "\n".join(err.strip().splitlines()[-5:])
                if tail:
                    print("    stderr tail: %s" % tail.replace("\n", " | "))
            else:
                print("%s OK TIME_MS=%s [wasmer %s]" % (task, m.group(1), comp))
                wpass += 1
        print("%s wasmer (%s) PASS %d/15 (task 15 excepted)" % (ROW, comp, wpass))
    return 0

if __name__ == "__main__":
    sys.exit(main())
