#!/usr/bin/env python3
"""Verifier for the zig-wasm (wasm32-wasip1) row.

Runs every task built by exec/zig-wasm/build_all.bat under wasmtime 46.0.3 and checks
  1. stripped stdout == the task's `expected output:` line from sources/zig-wasm/<task>.zig
  2. a TIME_MS value on stderr
  3. task 15 additionally leaves out.bin in its preopened directory

Task 11 adds the wasi-threads flags; tasks 14 and 15 run with --dir=. from the directory
holding data.bin.

The wasmer cells are a different story, and the row records it rather than pretending
otherwise.  Fourteen of the fifteen modules do not run under wasmer 4.3.7 at all: Zig 0.16's
`std.Io.Threaded` event loop waits on `poll_oneoff` with an *absolute* clock subscription,
and wasmer's implementation of that panics with

    thread 'main' panicked at library\\core\\src\\time.rs:930:31:
    overflow when subtracting durations

(wasmer computes the wait as a `Duration` from the current instant to the supplied deadline,
which the WASI wall-clock value overflows).  Other runs instead stop earlier with

    error: failed to init preopens: OutOfMemory

because wasmer reports three preopens (two aliased to `/` and one to `.`) where wasmtime
reports one, and Zig's preopen scan trips over that.  Either way the module hangs or dies
before `main`; a 300 s timeout never produced an answer.  Task 11 is the exception: it uses
raw WASI `clock_time_get` and `fd_write` imports and instantiates no `std.Io`, so it runs
under all three wasmer code generators.

Task 15 is a second, independent wasmer boundary even where a module does run: wasmer 4.3.7's
WASIX filesystem overlays the host directory read-only, so a file the program *creates* lives
in an in-memory layer that is discarded at exit, and out.bin never appears.  Writing to a file
that already exists does reach the host, which is why task 14 (read data.bin) is fine.

Run:  python exec\\zig-wasm\\verify.py
"""
import os
import re
import subprocess
import sys

ROW = "zig-wasm"
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
# Only task 11 runs under wasmer; the other fourteen hang in Zig's poll_oneoff-based
# std.Io.Threaded startup (see the module docstring).  The blocked ones are still
# attempted, with a short deadline: a hang or the preopen failure shows up immediately,
# and waiting the full TIMEOUT on each of them would cost hours.
WASMER_TASKS = ["11_parallel_sum"]
BLOCKED_TIMEOUT = 15

def expected(task):
    with open(os.path.join(SRC, task + ".zig"), encoding="utf-8") as fh:
        for line in fh:
            m = re.search(r"expected output:\s*(.*?)\s*$", line)
            if m:
                return m.group(1)
    raise SystemExit("no expected-output line in " + task)

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

    if not os.path.exists(WASMER):
        print("%s FAIL no runtime at %s" % (ROW, WASMER))
        return 1
    for comp in ("cranelift", "llvm", "singlepass"):
        wpass = 0
        wblocked = []
        for task in TASKS:
            d = os.path.join(OUT, task)
            exp = expected(task)
            out_bin = os.path.join(d, "out.bin")
            saved = snapshot_out(d)
            if task == "15_file_write" and os.path.exists(out_bin):
                os.remove(out_bin)
            if task not in WASMER_TASKS:
                # Attempt it anyway, with a short deadline, so the boundary is an
                # observation and not an assumption.
                try:
                    p = subprocess.run(wasmer_cmd(comp, task, d), cwd=d,
                                       capture_output=True, timeout=BLOCKED_TIMEOUT)
                    note = "exit %d, stderr %r" % (p.returncode, p.stderr.decode("utf-8", "replace").strip()[-160:])
                except subprocess.TimeoutExpired:
                    note = "no answer within %ds" % BLOCKED_TIMEOUT
                restore_out(saved)
                print("%s BLOCKED [wasmer %s]: %s" % (task, comp, note))
                wblocked.append(task)
                continue
            try:
                p = subprocess.run(wasmer_cmd(comp, task, d), cwd=d, capture_output=True, timeout=TIMEOUT)
            except subprocess.TimeoutExpired:
                restore_out(saved)
                print("%s FAIL (timeout after %ds) [wasmer %s]" % (task, TIMEOUT, comp))
                wblocked.append(task)
                continue
            except OSError as exc:
                restore_out(saved)
                print("%s FAIL (cannot run wasmer: %s)" % (task, exc))
                wblocked.append(task)
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
                wblocked.append(task)
            else:
                print("%s OK TIME_MS=%s [wasmer %s]" % (task, m.group(1), comp))
                wpass += 1
        print("%s wasmer (%s) PASS %d/15; %d blocked: %s"
              % (ROW, comp, wpass, len(wblocked), " ".join(wblocked)))
    return 0 if passed == 15 else 1

if __name__ == "__main__":
    sys.exit(main())
