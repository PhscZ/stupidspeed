"""Terra row verifier.

Runs each of the fifteen tasks with tools\\terra\\bin\\terra.exe from its own
exec\\terra\\terra\\<task>\\ directory (terra JIT-compiles in-process, so the compile is
inside the measured number) and checks:

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present -- Terra's stdio has no stderr handle, so the row uses the
     contract's time.txt fallback and the value is read from time.txt in the working
     directory;
  3. task 15 additionally leaves out.bin beside the program.

The environment is the row's documented one: VCINSTALLDIR must be non-nil or terralib
aborts before it opens any file ("Can't find windows SDK version 8.1 or 10!"), and INCLUDE
points at the C sysroot every task's terralib.includec("stdio.h") needs.

Prints one line per task and a final `TERRA PASS n/15`.
"""
import os
import re
import shutil
import subprocess

ROOT = r"C:\stupidspeed"
D = os.path.join(ROOT, "exec", "terra", "terra")
TERRA = os.path.join(ROOT, "tools", "terra", "bin", "terra.exe")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 900  # RUN.md documents task 10 as slow (176-454 s); the row is JIT-per-run

ENV = dict(os.environ)
ENV["VCINSTALLDIR"] = "C:/fake/vc"
ENV["INCLUDE"] = os.path.join(ROOT, "tools", "llvm-mingw", "include")

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
    for f in ("time.txt", "out.bin"):
        p = os.path.join(d, f)
        if os.path.exists(p):
            os.remove(p)
    if t == "14_file_read":
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))

    try:
        r = subprocess.run([TERRA, t + ".t"], capture_output=True, text=True,
                           cwd=d, timeout=TIMEOUT, env=ENV)
    except subprocess.TimeoutExpired:
        bad.append(t)
        print("%-20s FAIL (timeout after %ds)" % (t, TIMEOUT), flush=True)
        continue

    out = r.stdout.strip()
    tm = None
    tf = os.path.join(d, "time.txt")
    if os.path.exists(tf):
        m = re.search(r"TIME_MS=([\d.]+)", open(tf, encoding="utf-8", errors="replace").read())
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

print("TERRA PASS %d/15%s" % (ok, "  FAILED: " + ",".join(bad) if bad else ""), flush=True)
