import subprocess, re, io, glob, os
os.chdir(r"C:\stupidspeed\exec\dyalog")
DYA = r"C:\stupidspeed\tools\dyalog\tree\ProgramFiles64Folder\Dyalog\Dyalog APL-64 20.0 Unicode\dyascript.exe"
tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
ok=0; bad=[]
for t in tasks:
    exp = re.search(r"expected output:\s*(.+)", io.open(t+".dyalog",encoding="utf-8").readline()).group(1).strip()
    try:
        r = subprocess.run([DYA,"-script",t+".dyalog"], capture_output=True, text=True, timeout=1200)
        out = r.stdout.strip()
        tm = None
        try:
            tm = float(re.search(r"TIME_MS=([\d.]+)", io.open("time.txt",encoding="utf-8").read()).group(1))
            os.remove("time.txt")
        except Exception:
            tm = None
        good = (out==exp) and (tm is not None)
        if good: ok+=1
        else: bad.append((t,exp,out[:80]))
        print("%-20s %s  TIME_MS=%s" % (t, "OK" if good else "FAIL", tm), flush=True)
        if not good: print("   exp=%s got=%s" % (exp, out[:90]), flush=True)
    except subprocess.TimeoutExpired:
        bad.append((t,exp,"TIMEOUT"))
        print("%-20s TIMEOUT" % t, flush=True)
print("DYALOG PASS %d/15" % ok, flush=True)
