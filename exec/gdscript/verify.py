#!/usr/bin/env python3
"""Row verifier for the gdscript row -- GDScript, run by `godot --headless`.

There is no build step: each task is a `.gd` script that `extends SceneTree` and
does its work in `_initialize()`, and the registry runs it from `exec/gdscript`
with `--script <task>.gd`, so the scripts and the shared `project.godot` (whose
`[application] run/print_header=false` keeps the engine banner off stdout) are
staged flat into that one directory.

Runs each of the fifteen tasks and checks the three things every row's verifier
checks: stripped stdout equals the task's own `expected output:` line (read from
the source header, so a source edit cannot leave the check behind), a TIME_MS
value reached stderr, and task 15 left out.bin behind at 52428800 bytes.

    python exec/gdscript/verify.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "gdscript"
SRC = os.path.join(ROOT, "sources", "gdscript")
RUN = os.path.join(ROOT, "exec", "gdscript")
GODOT = os.path.join(ROOT, "tools", "godot",
                     "Godot_v4.7.2-stable_win64_console.exe")
DATA = os.path.join(ROOT, "data.bin")
# BUILD.md and RUN.md both call this the slowest row in the matrix, and the
# registry gives the cell 1800 s; the verifier is a little more generous than the
# cell so that a correct-but-slow run on a loaded machine is reported as slow
# rather than as wrong.
TIMEOUT = 3600
OUT_BIN_SIZE = 52428800

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".gd"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def stage(task):
    """Put the task's script, the shared project and the fixture in place.

    `build_all.bat` does this; the verifier repeats it so a run after a hand-edited
    source still tests what the source says.  Task 15 writes out.bin into this same
    directory, so a stale one from an earlier run is cleared first -- exactly what
    exec/harness.py clears before every run.
    """
    shutil.copyfile(os.path.join(SRC, task + ".gd"), os.path.join(RUN, task + ".gd"))
    shutil.copyfile(os.path.join(SRC, "project.godot"),
                    os.path.join(RUN, "project.godot"))
    if task in ("14_file_read", "15_file_write"):
        dest = os.path.join(RUN, "data.bin")
        if not (os.path.exists(dest)
                and os.path.getsize(dest) == os.path.getsize(DATA)):
            shutil.copyfile(DATA, dest)
    if task == "15_file_write":
        out_bin = os.path.join(RUN, "out.bin")
        if os.path.exists(out_bin):
            os.remove(out_bin)


def check(task):
    want = expected_output(task)
    script = os.path.join(RUN, task + ".gd")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    stage(task)
    try:
        p = subprocess.run([GODOT, "--headless", "--script", task + ".gd"], cwd=RUN,
                           capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r" % (out[:120], want[:120])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        out_bin = os.path.join(RUN, "out.bin")
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
