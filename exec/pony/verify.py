import subprocess, re, os, shutil

D = r"C:\stupidspeed\exec\pony\ponyc"
DATA = r"C:\stupidspeed\data.bin"

tasks = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]
exp = {"01_branches": "33333334 13333333 7619048 45714285", "02_switch_case": "7500000075000000",
       "03_func_sum": "100000000", "04_array_sum": "499999500000", "05_alloc_churn": "1274991808",
       "06_char_count": "10000000", "07_string_append": "250000", "08_average": "0.498046875",
       "09_fib_recursive": "102334155", "10_pi": "4470", "11_parallel_sum": "7500000075000000",
       "12_matrix_add": "999000000", "13_matrix_mul": "599995000", "14_file_read": "2389704704",
       "15_file_write": "52428800"}

# task 11's header run line fixes the scheduler pool: 11_parallel_sum.exe --ponymaxthreads=4 --ponynoscale
runargs = {"11_parallel_sum": ["--ponymaxthreads=4", "--ponynoscale"]}

TIMEOUT = 600

ok = 0
fails = []
for t in tasks:
    d = os.path.join(D, t)
    exe = os.path.join(d, t + ".exe")
    if not os.path.exists(exe):
        fails.append(t)
        print("%-18s FAIL missing %s (run build_all.bat)" % (t, exe), flush=True)
        continue
    if t in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
    if t == "15_file_write":
        op = os.path.join(d, "out.bin")
        if os.path.exists(op):
            os.remove(op)
    try:
        r = subprocess.run([exe] + runargs.get(t, []), capture_output=True, text=True,
                           cwd=d, timeout=TIMEOUT)
        out = r.stdout.strip()
        tm = re.search(r"TIME_MS=([\d.]+)", r.stderr)
        good = (out == exp[t]) and (tm is not None)
        if t == "15_file_write":
            good = good and os.path.exists(os.path.join(d, "out.bin"))
        if good:
            ok += 1
            print("%-18s OK TIME_MS=%s" % (t, tm.group(1)), flush=True)
        else:
            fails.append(t)
            why = []
            if out != exp[t]:
                why.append("stdout expected %r got %r" % (exp[t], out[:80]))
            if tm is None:
                why.append("no TIME_MS on stderr")
            if t == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
                why.append("out.bin missing")
            print("%-18s FAIL %s" % (t, "; ".join(why)), flush=True)
            tail = "\n".join((r.stderr or "").strip().splitlines()[-6:])
            if tail:
                print("    stderr tail: %s" % tail.replace("\n", "\n    "), flush=True)
    except subprocess.TimeoutExpired:
        fails.append(t)
        print("%-18s FAIL timeout after %ss" % (t, TIMEOUT), flush=True)

print("PONY PASS %d/15" % ok, flush=True)
if fails:
    print("PONY FAILED: %s" % " ".join(fails), flush=True)
