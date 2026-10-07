import subprocess, re, os, shutil
D = r"C:\stupidspeed\exec\commonlisp"
tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
exp = {"01_branches":"33333334 13333333 7619048 45714285","02_switch_case":"7500000075000000",
 "03_func_sum":"100000000","04_array_sum":"499999500000","05_alloc_churn":"1274991808",
 "06_char_count":"10000000","07_string_append":"250000","08_average":"0.498046875",
 "09_fib_recursive":"102334155","10_pi":"4470","11_parallel_sum":"7500000075000000",
 "12_matrix_add":"999000000","13_matrix_mul":"599995000","14_file_read":"2389704704","15_file_write":"52428800"}
ok=0; bad=[]
for t in tasks:
    d=os.path.join(D,t)
    if t=="14_file_read" and (not os.path.exists(os.path.join(d,"data.bin")) or not os.path.samefile(r"C:\stupidspeed\data.bin", os.path.join(d,"data.bin"))): shutil.copy(r"C:\stupidspeed\data.bin", os.path.join(d,"data.bin"))
    if t=="15_file_write":
        op=os.path.join(d,"out.bin")
        if os.path.exists(op): os.remove(op)
    try:
        r=subprocess.run([os.path.join(d,"prog.exe")],capture_output=True,text=True,cwd=d,timeout=900)
        out=r.stdout.strip()
        tm=re.search(r"TIME_MS=([\d.]+)", r.stderr)
        good=(out==exp[t])
        if t=="15_file_write": good = good and os.path.exists(os.path.join(d,"out.bin"))
        if good: ok+=1
        else: bad.append((t,out[:50]))
        print("%-20s %s TIME_MS=%s"%(t,"OK" if good else "FAIL", tm.group(1) if tm else None), flush=True)
        if not good: print("   got=%r err=%r"%(out[:70],r.stderr.strip()[-120:]), flush=True)
    except subprocess.TimeoutExpired:
        bad.append((t,"TIMEOUT")); print("%-20s TIMEOUT"%t, flush=True)
print("SBCL PASS %d/15"%ok, flush=True)
