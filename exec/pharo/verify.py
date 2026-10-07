#!/usr/bin/env python3
"""Verify the pharo row: no build step, run PharoConsole --headless <image> st --quit --no-source <task>.st."""
import os
import re
import subprocess
import sys
import shutil

ROW = "pharo"
TOOLCHAIN = "pharo"
EXT = ".st"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", ROW)
OUT = os.path.join(HERE, TOOLCHAIN)
PHARO = os.path.join(ROOT, "tools", "pharo", "PharoConsole.exe")
IMAGE = os.path.join(ROOT, "tools", "pharo", "Pharo13.0-SNAPSHOT-64bit-d7c6f761d5.image")

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# task 09 is the ~331M-send naive fib, task 11 forks four green Processes
TIMEOUTS = {"09_fib_recursive": 1800, "11_parallel_sum": 1200}
DEFAULT_TIMEOUT = 600

TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")


def expected_output(task):
    with open(os.path.join(SRC, task + EXT), encoding="utf-8") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*[\}\"]?\s*$", first)
    if not m:
        raise RuntimeError("no expected output in header of " + task)
    return m.group(1).strip()


def main():
    passed = 0
    for task in TASKS:
        workdir = os.path.join(OUT, task)
        exp = expected_output(task)
        timeout = TIMEOUTS.get(task, DEFAULT_TIMEOUT)

        if task in ("14_file_read", "15_file_write"):
            fixture = os.path.join(workdir, "data.bin")
            if not os.path.exists(fixture):
                if not os.path.exists(fixture) or not os.path.samefile(os.path.join(ROOT, "data.bin"), fixture): shutil.copyfile(os.path.join(ROOT, "data.bin"), fixture)
        if task == "15_file_write":
            outbin = os.path.join(workdir, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        cmd = [PHARO, "--headless", IMAGE, "st", "--quit", "--no-source", task + EXT]
        try:
            proc = subprocess.run(cmd, cwd=workdir,
                                  capture_output=True, text=True, errors="replace",
                                  timeout=timeout)
            rc, stdout, stderr = proc.returncode, proc.stdout, proc.stderr
        except subprocess.TimeoutExpired as exc:
            rc, stdout, stderr = None, exc.stdout or "", exc.stderr or ""
            if isinstance(stdout, bytes):
                stdout = stdout.decode("utf-8", "replace")
            if isinstance(stderr, bytes):
                stderr = stderr.decode("utf-8", "replace")

        problems = []
        got = stdout.strip()
        if got != exp:
            problems.append("stdout mismatch: expected %r got %r" % (exp, got))
        m = TIME_RE.search(stderr)
        if not m:
            problems.append("no TIME_MS on stderr")
        if task == "15_file_write":
            outbin = os.path.join(workdir, "out.bin")
            if not os.path.exists(outbin) or os.path.getsize(outbin) == 0:
                problems.append("out.bin missing or empty")
        if rc not in (0, None) and not problems:
            problems.append("exit code %s" % rc)

        if problems:
            print("%s FAIL" % task)
            for p in problems:
                print("    %s" % p)
            if stderr.strip():
                tail = stderr.strip().splitlines()[-8:]
                print("    stderr tail:")
                for line in tail:
                    print("      %s" % line)
        else:
            print("%s OK TIME_MS=%s" % (task, m.group(1)))
            passed += 1

    print("%s PASS %d/%d" % (ROW, passed, len(TASKS)))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
