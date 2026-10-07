"""Verify the quickjs row: 15 tasks, each run with `qjs.exe --std <task>.js`.

Checks (per temp/row_contract.md):
  1. stripped stdout == the task's expected output line;
  2. a TIME_MS value on stderr (QuickJS-ng writes it with std.err.puts);
  3. task 15 additionally leaves out.bin in the task directory.
"""
import subprocess, re, os, shutil, sys

ROW = "quickjs"
D = os.path.join(r"C:\stupidspeed\exec\quickjs\quickjs")
QJS = r"C:\stupidspeed\tools\quickjs\qjs.exe"
DATA = r"C:\stupidspeed\data.bin"
TIMEOUT = 900  # qjs is a bytecode interpreter: task 01 measured ~24 s, task 09 more

TASKS = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]

EXP = {"01_branches": "33333334 13333333 7619048 45714285", "02_switch_case": "7500000075000000",
       "03_func_sum": "100000000", "04_array_sum": "499999500000", "05_alloc_churn": "1274991808",
       "06_char_count": "10000000", "07_string_append": "250000", "08_average": "0.498046875",
       "09_fib_recursive": "102334155", "10_pi": "4470", "11_parallel_sum": "7500000075000000",
       "12_matrix_add": "999000000", "13_matrix_mul": "599995000", "14_file_read": "2389704704",
       "15_file_write": "52428800"}

ok = 0
bad = []
for t in TASKS:
    d = os.path.join(D, t)
    if t in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
    if t == "15_file_write":
        op = os.path.join(d, "out.bin")
        if os.path.exists(op):
            os.remove(op)
    try:
        r = subprocess.run([QJS, "--std", t + ".js"], capture_output=True, text=True,
                           cwd=d, timeout=TIMEOUT)
        out = r.stdout.strip()
        tm = re.search(r"TIME_MS=([\d.]+)", r.stderr)
        good = (out == EXP[t]) and (tm is not None)
        if t == "15_file_write":
            good = good and os.path.exists(os.path.join(d, "out.bin"))
        if good:
            ok += 1
            print("%-20s OK TIME_MS=%s" % (t, tm.group(1)), flush=True)
        else:
            bad.append(t)
            print("%-20s FAIL expected=%r actual=%r rc=%d TIME_MS=%s"
                  % (t, EXP[t], out[:80], r.returncode, tm.group(1) if tm else None), flush=True)
            if r.stderr.strip():
                print("    stderr tail: %r" % r.stderr.strip()[-400:], flush=True)
    except subprocess.TimeoutExpired:
        bad.append(t)
        print("%-20s TIMEOUT (>%ds)" % (t, TIMEOUT), flush=True)

print("QUICKJS PASS %d/15" % ok, flush=True)
if bad:
    print("FAILED:", bad, flush=True)
sys.exit(0 if ok == 15 else 1)
