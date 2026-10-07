import subprocess, re, os, shutil
D = r"C:\stupidspeed\exec\vbnet\dotnet"
DOTNET = r"C:\stupidspeed\tools\dotnet8\dotnet.exe"
DATA = r"C:\stupidspeed\data.bin"
tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
exp = {"01_branches":"33333334 13333333 7619048 45714285","02_switch_case":"7500000075000000",
 "03_func_sum":"100000000","04_array_sum":"499999500000","05_alloc_churn":"1274991808",
 "06_char_count":"10000000","07_string_append":"250000","08_average":"0.498046875",
 "09_fib_recursive":"102334155","10_pi":"4470","11_parallel_sum":"7500000075000000",
 "12_matrix_add":"999000000","13_matrix_mul":"599995000","14_file_read":"2389704704","15_file_write":"52428800"}
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")

ok = 0; bad = []
for t in tasks:
    d = os.path.join(D, t)
    if t in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
    if t == "15_file_write":
        op = os.path.join(d, "out.bin")
        if os.path.exists(op):
            os.remove(op)
    dll = os.path.join("bin", "Release", "net8.0", t + ".dll")
    try:
        r = subprocess.run([DOTNET, dll], capture_output=True, text=True, cwd=d, timeout=600)
    except subprocess.TimeoutExpired:
        bad.append((t, "TIMEOUT after 600s")); print("%s FAIL TIMEOUT after 600s" % t, flush=True); continue
    out = r.stdout.strip()
    m = TIME_RE.search(r.stderr)
    problems = []
    if out != exp[t]:
        problems.append("stdout expected %r got %r" % (exp[t], out[:80]))
    if not m:
        problems.append("no TIME_MS on stderr (rc=%s); stderr tail: %r" % (r.returncode, r.stderr.strip()[-200:]))
    if t == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
        problems.append("out.bin missing")
    if problems:
        bad.append((t, "; ".join(problems)))
        print("%s FAIL %s" % (t, "; ".join(problems)), flush=True)
    else:
        ok += 1
        print("%s OK TIME_MS=%s" % (t, m.group(1)), flush=True)
print("VBNET PASS %d/15" % ok, flush=True)
if bad:
    print("FAILURES: " + repr(bad), flush=True)
