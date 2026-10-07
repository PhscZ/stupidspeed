#!/usr/bin/env python3
"""Verify the perl row: no build step, run `perl <task>.pl` from exec/perl/perl/<task>/."""
import os
import re
import subprocess
import sys
import shutil

ROW = "perl"
TOOLCHAIN = "perl"
EXT = ".pl"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", ROW)
OUT = os.path.join(HERE, TOOLCHAIN)
PERL = os.path.join(ROOT, "tools", "perl", "bin", "perl.exe")

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# header documents task 09 (naive fib(40), ~331M calls) as taking a long time
TIMEOUTS = {"09_fib_recursive": 3600, "10_pi": 1800}
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

        try:
            proc = subprocess.run([PERL, task + EXT], cwd=workdir,
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
