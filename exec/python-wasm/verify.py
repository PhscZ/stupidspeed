import subprocess, re, os, shutil, sys

# Row: sources/python-wasm, toolchain: wasip1 (cpython 3.12.2 cross-compiled to
# wasm32-wasip1-threads, run under wasmtime 46).
#
# The module (python.wasm) and its stdlib tree (lib/python3.12) live in this
# directory; each task's script is in <task>/<task>.py and is read through the
# WASI preopen that maps this directory to the guest root.  data.bin lives here
# too, so tasks 14 and 15 open it relative to the guest cwd ("/").

D = r"C:\stupidspeed\exec\python-wasm\wasip1"
WT = r"C:\stupidspeed\tools\wasmtime46\wasmtime.exe"
TIMEOUT = 900  # RUN.md records CPython wasm cells up to ~75 s; wasm is slower still.

tasks = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]

exp = {"01_branches": "33333334 13333333 7619048 45714285",
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
       "15_file_write": "52428800"}

if not os.path.exists(os.path.join(D, "python.wasm")):
    print("MISSING python.wasm in %s -- run build_all.bat first" % D)
    print("python-wasm PASS 0/15")
    sys.exit(1)

# Fixtures: 14 reads data.bin, 15 writes out.bin into the run directory.
if not os.path.exists(os.path.join(D, "data.bin")) or not os.path.samefile(r"C:\stupidspeed\data.bin", os.path.join(D, "data.bin")): shutil.copy(r"C:\stupidspeed\data.bin", os.path.join(D, "data.bin"))

ok = 0
bad = []
for t in tasks:
    if t == "15_file_write":
        op = os.path.join(D, "out.bin")
        if os.path.exists(op):
            os.remove(op)
    cmd = [WT, "-S", "threads=y", "-W", "threads=y", "-W", "shared-memory=y",
           "--dir", ".", "python.wasm", "%s/%s.py" % (t, t)]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, cwd=D, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        bad.append(t)
        print("%-16s FAIL (timeout %ds)" % (t, TIMEOUT), flush=True)
        continue
    out = r.stdout.strip()
    tm = re.search(r"TIME_MS=([\d.]+)", r.stderr)
    good = (out == exp[t]) and (tm is not None)
    if t == "15_file_write":
        good = good and os.path.exists(os.path.join(D, "out.bin"))
    if good:
        ok += 1
        print("%-16s OK TIME_MS=%s" % (t, tm.group(1)), flush=True)
    else:
        bad.append(t)
        print("%-16s FAIL" % t, flush=True)
        print("   expected=%r actual=%r time_ms=%r" % (exp[t], out[:80], tm.group(1) if tm else None), flush=True)
        tail = r.stderr.strip().splitlines()[-6:]
        if tail:
            print("   stderr tail: %s" % " | ".join(tail), flush=True)

print("python-wasm PASS %d/15" % ok, flush=True)
if bad:
    print("failed: %s" % ", ".join(bad), flush=True)
sys.exit(0 if ok == 15 else 1)
