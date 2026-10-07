import subprocess, re, os, shutil
D = r"C:\stupidspeed\exec\csharp"
MONO = r"C:\stupidspeed\tools\mono\Mono\bin\mono.exe"
tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
exp = {"01_branches":"33333334 13333333 7619048 45714285","02_switch_case":"7500000075000000",
 "03_func_sum":"100000000","04_array_sum":"499999500000","05_alloc_churn":"1274991808",
 "06_char_count":"10000000","07_string_append":"250000","08_average":"0.498046875",
 "09_fib_recursive":"102334155","10_pi":"4470","11_parallel_sum":"7500000075000000",
 "12_matrix_add":"999000000","13_matrix_mul":"599995000","14_file_read":"2389704704","15_file_write":"52428800"}
def exe_for(tc, t):
    d=os.path.join(D,tc,t)
    if tc=="coreclr": return (d, os.path.join(d,"bin","Release","net8.0",t+".exe"), [])
    if tc=="nativeaot": return (d, os.path.join(d,"bin","Release","net8.0","win-x64","publish",t+".exe"), [])
    return (d, os.path.join(d,t+".exe"), [MONO])  # mono: run exe under mono
for tc in ["coreclr","nativeaot","mono"]:
    ok=0; bad=[]
    for t in tasks:
        d, exe, prefix = exe_for(tc,t)
        if t=="14_file_read" and (not os.path.exists(os.path.join(d,"data.bin")) or not os.path.samefile(r"C:\stupidspeed\data.bin", os.path.join(d,"data.bin"))): shutil.copy(r"C:\stupidspeed\data.bin", os.path.join(d,"data.bin"))
        if t=="15_file_write":
            op=os.path.join(d,"out.bin")
            if os.path.exists(op): os.remove(op)
        try:
            r=subprocess.run(prefix+[exe],capture_output=True,text=True,cwd=d,timeout=900)
            out=r.stdout.strip()
            good=(out==exp[t])
            if t=="15_file_write": good = good and os.path.exists(os.path.join(d,"out.bin"))
            if good: ok+=1
            else: bad.append((t,out[:40]))
        except subprocess.TimeoutExpired:
            bad.append((t,"TIMEOUT"))
    print("CSHARP/%-9s PASS %d/15"%(tc,ok), "FAILED:"+str(bad) if bad else "", flush=True)
