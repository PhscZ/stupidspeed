import subprocess, re, io, os, shutil
BASE = r"C:\stupidspeed\exec\ats"
CYG = r"C:\cygwin64\bin"
env = dict(os.environ); env["PATH"] = CYG + ";" + env["PATH"]
tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
exp = {"01_branches":"33333334 13333333 7619048 45714285","02_switch_case":"7500000075000000",
 "03_func_sum":"100000000","04_array_sum":"499999500000","05_alloc_churn":"1274991808",
 "06_char_count":"10000000","07_string_append":"250000","08_average":"0.498046875",
 "09_fib_recursive":"102334155","10_pi":"4470","11_parallel_sum":"7500000075000000",
 "12_matrix_add":"999000000","13_matrix_mul":"599995000","14_file_read":"2389704704","15_file_write":"52428800"}
data_src = r"C:\stupidspeed\data.bin"
ok=0; bad=[]
for t in tasks:
    d = os.path.join(BASE, t)
    if t=="14_file_read" and (not os.path.exists(os.path.join(d,"data.bin")) or not os.path.samefile(data_src, os.path.join(d,"data.bin"))): shutil.copy(data_src, os.path.join(d,"data.bin"))
    if t=="15_file_write":
        op = os.path.join(d,"out.bin")
        if os.path.exists(op): os.remove(op)
    try:
        r = subprocess.run([os.path.join(d,"prog.exe")], capture_output=True, text=True, cwd=d, env=env, timeout=300)
        out = r.stdout.strip()
        tm = re.search(r"TIME_MS=([\d.]+)", r.stderr)
        tm = float(tm.group(1)) if tm else None
        good = (out == exp[t])
        # task 15: also confirm out.bin written
        if t=="15_file_write": good = good and os.path.exists(os.path.join(d,"out.bin"))
        if good: ok+=1
        else: bad.append(t)
        print("%-20s %s  TIME_MS=%s" % (t, "OK" if good else "FAIL(got %r)"%out[:40], tm), flush=True)
    except subprocess.TimeoutExpired:
        bad.append(t); print("%-20s TIMEOUT" % t, flush=True)
print("ATS PASS %d/15" % ok, flush=True)
if bad: print("FAILED:", bad)
