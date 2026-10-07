"""Unicon row verifier.

Runs each of the fifteen tasks' self-contained <task>.exe from its own
exec\\unicon\\unicon\\<task>\\ directory and checks:

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present on stderr -- Unicon's &errout is the standard error stream,
     so this row needs no time.txt fallback;
  3. task 15 additionally leaves out.bin beside the program.

The executables read their own appended icode image through argv[0], so they are invoked
with a Windows-style backslash path (a forward-slash path dies with "can't read interpreter
file header").

Prints one line per task and a final `UNICON PASS n/15`.
"""
import os
import re
import shutil
import subprocess

ROOT = r"C:\stupidspeed"
D = os.path.join(ROOT, "exec", "unicon", "unicon")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 1800  # bytecode VM row: task 01 alone measures ~60 s on this host

TASKS = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]
EXPECTED = {
    "01_branches": "33333334 13333333 7619048 45714285",
    "02_switch_case": "7500000075000000",
    "03_func_sum": "100000000",
    "04_array_sum": "499999500000",
    "05_alloc_churn": "1274991808",
    "06_char_count": "10000000",
    "07_string_append": "250000",
    "08_average": "0.498046875",
    "09_fib_recursive": "102334155",
    "10_pi": "4470",
    "11_parallel_sum": "7500000075000000",
    "12_matrix_add": "999000000",
    "13_matrix_mul": "599995000",
    "14_file_read": "2389704704",
    "15_file_write": "52428800",
}

ok = 0
bad = []
for t in TASKS:
    d = os.path.join(D, t)
    exe = os.path.join(d, t + ".exe")
    for f in ("out.bin",):
        p = os.path.join(d, f)
        if os.path.exists(p):
            os.remove(p)
    if t == "14_file_read":
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))

    try:
        r = subprocess.run([exe], capture_output=True, text=True, cwd=d, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        bad.append(t)
        print("%-20s FAIL (timeout after %ds)" % (t, TIMEOUT), flush=True)
        continue

    out = r.stdout.strip()
    m = re.search(r"TIME_MS=(-?[\d.]+)", r.stderr)
    tm = m.group(1) if m else None

    good = (out == EXPECTED[t]) and (tm is not None)
    if t == "15_file_write":
        good = good and os.path.exists(os.path.join(d, "out.bin"))

    if good:
        ok += 1
        print("%-20s OK TIME_MS=%s" % (t, tm), flush=True)
    else:
        bad.append(t)
        print("%-20s FAIL" % t, flush=True)
        print("   expected=%r" % EXPECTED[t], flush=True)
        print("   actual  =%r" % out, flush=True)
        print("   TIME_MS =%r" % tm, flush=True)
        print("   stderr tail: %r" % r.stderr.strip()[-400:], flush=True)
        if t == "15_file_write":
            print("   out.bin present: %s" % os.path.exists(os.path.join(d, "out.bin")), flush=True)

print("UNICON PASS %d/15%s" % (ok, "  FAILED: " + ",".join(bad) if bad else ""), flush=True)
