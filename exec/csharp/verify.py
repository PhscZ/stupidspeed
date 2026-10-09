import subprocess, re, os, shutil

# The row's own directory: <root>/exec/csharp.  Derive the root from it so the
# file works from wherever the checkout lives.
D = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(D))
MONO = os.path.join(ROOT, r"tools\mono\Mono\bin\mono.exe")
DATA = os.path.join(ROOT, "data.bin")

tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
exp = {"01_branches":"33333334 13333333 7619048 45714285","02_switch_case":"7500000075000000",
 "03_func_sum":"100000000","04_array_sum":"499999500000","05_alloc_churn":"1274991808",
 "06_char_count":"10000000","07_string_append":"250000","08_average":"0.498046875",
 "09_fib_recursive":"102334155","10_pi":"4470","11_parallel_sum":"7500000075000000",
 "12_matrix_add":"999000000","13_matrix_mul":"599995000","14_file_read":"2389704704","15_file_write":"52428800"}

# toolchain name -> directory under exec/csharp.  The two Mono entries share one
# compiler (mcs) and differ only in what executes the assembly: the JIT, or the
# native module `mono --aot=full` produced, run with the JIT switched off.
TOOLCHAINS = [("coreclr", "coreclr"), ("nativeaot", "nativeaot"),
              ("mono", "mono"), ("mono (aot)", "mono-aot")]

def exe_for(folder, t):
    d = os.path.join(D, folder, t)
    if folder == "coreclr": return (d, os.path.join(d,"bin","Release","net8.0",t+".exe"), [], None)
    if folder == "nativeaot": return (d, os.path.join(d,"bin","Release","net8.0","win-x64","publish",t+".exe"), [], None)
    if folder == "mono-aot": return (d, os.path.join(d,t+".exe"), [MONO,"--full-aot"], os.path.join(d,t+".exe.dll"))
    return (d, os.path.join(d,t+".exe"), [MONO], None)  # mono: the same exe under the JIT

for tc, folder in TOOLCHAINS:
    ok=0; bad=[]
    for t in tasks:
        d, exe, prefix, aot = exe_for(folder, t)
        if t=="14_file_read" and (not os.path.exists(os.path.join(d,"data.bin")) or not os.path.samefile(DATA, os.path.join(d,"data.bin"))): shutil.copy(DATA, os.path.join(d,"data.bin"))
        if t=="15_file_write":
            op=os.path.join(d,"out.bin")
            if os.path.exists(op): os.remove(op)
        try:
            r=subprocess.run(prefix+[exe],capture_output=True,text=True,cwd=d,timeout=900)
            out=r.stdout.strip()
            good=(out==exp[t]) and re.search(r"TIME_MS=[0-9]", r.stderr) is not None
            # mono (aot) additionally has to have the native module it runs.
            if aot: good = good and os.path.exists(aot)
            if t=="15_file_write": good = good and os.path.exists(os.path.join(d,"out.bin"))
            if good: ok+=1
            else: bad.append((t,out[:40],r.stderr.strip().splitlines()[:1]))
        except subprocess.TimeoutExpired:
            bad.append((t,"TIMEOUT",""))
    print("CSHARP/%-11s PASS %d/15"%(tc,ok), "FAILED:"+str(bad) if bad else "", flush=True)
