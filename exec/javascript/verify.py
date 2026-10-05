import subprocess, re, os, shutil
D = r"D:\Users\pedro.cardoso\stupidspeed\exec\javascript"
NODE = r"D:\Users\pedro.cardoso\node\node.exe"
BUN = r"D:\Users\pedro.cardoso\.bun\bin\bun.exe"
DENO = r"D:\Users\pedro.cardoso\stupidspeed\tools\deno\deno.exe"
tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
exp = {"01_branches":"33333334 13333333 7619048 45714285","02_switch_case":"7500000075000000",
 "03_func_sum":"100000000","04_array_sum":"499999500000","05_alloc_churn":"1274991808",
 "06_char_count":"10000000","07_string_append":"250000","08_average":"0.498046875",
 "09_fib_recursive":"102334155","10_pi":"4470","11_parallel_sum":"7500000075000000",
 "12_matrix_add":"999000000","13_matrix_mul":"599995000","14_file_read":"2389704704","15_file_write":"52428800"}
# deno denies fs by default and refuses CommonJS without the flag; the other two need nothing.
# Task 11's Worker re-reads the script file, so it needs read access too.
def deno_args(t):
    a=[DENO,"run","--unstable-detect-cjs"]
    if t in ("11_parallel_sum","14_file_read"): a.append("--allow-read")
    if t=="15_file_write": a.append("--allow-write")
    return a+[t+".js"]
runtimes = {"node": lambda t: [NODE,t+".js"],
            "bun":  lambda t: [BUN,t+".js"],
            "deno": deno_args}
for rt, cmd in runtimes.items():
    ok=0; bad=[]
    for t in tasks:
        if t=="14_file_read": shutil.copy(r"D:\Users\pedro.cardoso\stupidspeed\data.bin", os.path.join(D,"data.bin"))
        if t=="15_file_write":
            op=os.path.join(D,"out.bin")
            if os.path.exists(op): os.remove(op)
        try:
            r=subprocess.run(cmd(t),capture_output=True,text=True,cwd=D,timeout=900)
            out=r.stdout.strip()
            tm=re.search(r"TIME_MS=([\d.]+)", r.stderr)
            good=(out==exp[t])
            if t=="15_file_write": good = good and os.path.exists(os.path.join(D,"out.bin"))
            if good: ok+=1
            else: bad.append((t,out[:50]))
            print("%-9s %-20s %s TIME_MS=%s"%(rt,t,"OK" if good else "FAIL", tm.group(1) if tm else None), flush=True)
            if not good: print("   got=%r err=%r"%(out[:60],r.stderr.strip()[-140:]), flush=True)
        except subprocess.TimeoutExpired:
            bad.append((t,"TIMEOUT")); print("%-9s %-20s TIMEOUT"%(rt,t), flush=True)
    print("JAVASCRIPT/%-4s PASS %d/15"%(rt,ok), "FAILED:"+str(bad) if bad else "", flush=True)
