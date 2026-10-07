import subprocess, re, os, shutil
ROW = "odin"
D = r"C:\stupidspeed\exec\odin\odin"
DATA = r"C:\stupidspeed\data.bin"
tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
exp = {"01_branches":"33333334 13333333 7619048 45714285","02_switch_case":"7500000075000000",
 "03_func_sum":"100000000","04_array_sum":"499999500000","05_alloc_churn":"1274991808",
 "06_char_count":"10000000","07_string_append":"250000","08_average":"0.498046875",
 "09_fib_recursive":"102334155","10_pi":"4470","11_parallel_sum":"7500000075000000",
 "12_matrix_add":"999000000","13_matrix_mul":"599995000","14_file_read":"2389704704",
 "15_file_write":"52428800"}
ok = 0
for t in tasks:
    d = os.path.join(D, t)
    if t in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
    if t == "15_file_write":
        op = os.path.join(d, "out.bin")
        if os.path.exists(op):
            os.remove(op)
    exe = os.path.join(d, "prog.exe")
    try:
        r = subprocess.run([exe], capture_output=True, text=True, cwd=d, timeout=900,
                           errors="replace")
        out = (r.stdout or "").replace("\r", "").strip()
        m = re.search(r"TIME_MS=([\d.]+)", r.stderr or "")
        good = (out == exp[t]) and (m is not None)
        if t == "15_file_write":
            good = good and os.path.exists(os.path.join(d, "out.bin"))
        if good:
            ok += 1
        print("%-20s %s TIME_MS=%s" % (t, "OK" if good else "FAIL",
                                       m.group(1) if m else None), flush=True)
        if not good:
            print("   expected=%r" % exp[t], flush=True)
            print("   actual  =%r" % out, flush=True)
            print("   stderr  =%r" % ((r.stderr or "").strip()[-200:]), flush=True)
    except subprocess.TimeoutExpired:
        print("%-20s TIMEOUT" % t, flush=True)
print("%s PASS %d/15" % (ROW, ok), flush=True)
