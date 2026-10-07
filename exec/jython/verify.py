import subprocess, re, os, shutil, sys

ROOT = r"C:\stupidspeed"
D = os.path.join(ROOT, r"exec\jython\jython")
JAVA = os.path.join(ROOT, r"tools\openj9\bin\java.exe")
JYTHON = os.path.join(ROOT, r"tools\jython\jython-standalone-2.7.4.jar")
DATA = os.path.join(ROOT, "data.bin")

tasks = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]

# expected stdout, taken from each source file's `expected output:` header line
exp = {
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
failures = []
for t in tasks:
    d = os.path.join(D, t)
    # tasks 14/15 read the 50 MiB fixture from their working directory
    if t in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
    if t == "15_file_write":
        outbin = os.path.join(d, "out.bin")
        if os.path.exists(outbin):
            os.remove(outbin)
    cmd = [JAVA, "-jar", JYTHON, t + ".py"]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, cwd=d, timeout=1800)
    except subprocess.TimeoutExpired:
        failures.append((t, "TIMEOUT", "", ""))
        print("%-18s FAIL (timeout)" % t, flush=True)
        continue

    out = r.stdout.strip()
    m = re.search(r"TIME_MS=([\d.]+)", r.stderr)
    good = (out == exp[t]) and (m is not None)
    if t == "15_file_write":
        good = good and os.path.exists(os.path.join(d, "out.bin"))

    if good:
        ok += 1
        print("%-18s OK TIME_MS=%s" % (t, m.group(1)), flush=True)
    else:
        failures.append((t, exp[t], out, r.stderr.strip()[-400:]))
        print("%-18s FAIL" % t, flush=True)
        print("   expected: %r" % exp[t], flush=True)
        print("   got     : %r" % out, flush=True)
        print("   stderr  : %r" % r.stderr.strip()[-400:], flush=True)

print("JYTHON PASS %d/15" % ok, flush=True)
if failures:
    print("FAILURES: %s" % [(f[0], "TIMEOUT" if f[1] == "TIMEOUT" else f[2]) for f in failures], flush=True)
    sys.exit(1)
