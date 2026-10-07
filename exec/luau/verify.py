"""Luau row verifier.

Runs each of the fifteen tasks from its own exec\\luau\\luau\\<task>\\ directory and checks:

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present. Luau exposes no stderr, so the row uses the contract's
     time.txt fallback, which the scripts write through Lute's @lute/fs. The plain Luau CLI
     has no file I/O at all, so time.txt only exists for the three tasks the row header runs
     under Lute (11, 14, 15); those cells require it. For the twelve luau.exe cells the
     timing line is unreachable by design -- the header records it, the guarded require fails
     and the run is otherwise unchanged -- so they are checked on stdout alone and reported
     with TIME_MS=n/a;
  3. task 15 additionally leaves out.bin beside the program.

Prints one line per task and a final `LUAU PASS n/15`.
"""
import os
import re
import shutil
import subprocess

ROOT = r"C:\stupidspeed"
D = os.path.join(ROOT, "exec", "luau", "luau")
LUAU = os.path.join(ROOT, "tools", "luau", "luau.exe")
LUTE = os.path.join(ROOT, "tools", "lute", "lute.exe")
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 900

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

# The three cells the row header runs under Lute: 11 needs the process API, 14 and 15 need
# file I/O. Everything else runs under the plain Luau CLI.
NEEDS_LUTE = {"11_parallel_sum", "14_file_read", "15_file_write"}

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

    needs_lute = t in NEEDS_LUTE
    cmd = [LUTE, "run", t + ".luau"] if needs_lute else [LUAU, t + ".luau"]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, cwd=d, timeout=TIMEOUT)
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

    good = (out == EXPECTED[t])
    if needs_lute:
        good = good and (tm is not None)
    if t == "15_file_write":
        good = good and os.path.exists(os.path.join(d, "out.bin"))

    label = "lute" if needs_lute else "luau"
    if good:
        ok += 1
        print("%-20s %-4s OK TIME_MS=%s" % (t, label, tm if tm is not None else "n/a"), flush=True)
    else:
        bad.append(t)
        print("%-20s %-4s FAIL" % (t, label), flush=True)
        print("   expected=%r" % EXPECTED[t], flush=True)
        print("   actual  =%r" % out, flush=True)
        print("   TIME_MS =%r" % tm, flush=True)
        print("   stderr tail: %r" % r.stderr.strip()[-300:], flush=True)
        if t == "15_file_write":
            print("   out.bin present: %s" % os.path.exists(os.path.join(d, "out.bin")), flush=True)

print("LUAU PASS %d/15%s" % (ok, "  FAILED: " + ",".join(bad) if bad else ""), flush=True)
