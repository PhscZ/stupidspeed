import subprocess, re, os, shutil, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
ROW = os.path.basename(HERE)                       # "kotlin-native"
SRC = os.path.join(ROOT, "sources", ROW)
DATA = os.path.join(ROOT, "data.bin")

TASKS = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]


def expected(task):
    with open(os.path.join(SRC, task + ".kt"), encoding="utf-8") as f:
        first = f.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no 'expected output:' header in %s" % task)
    return m.group(1)


def run(task):
    d = os.path.join(HERE, task)
    if task in ("14_file_read", "15_file_write") and os.path.exists(DATA):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
    out_bin = os.path.join(d, "out.bin")
    if task == "15_file_write" and os.path.exists(out_bin):
        os.remove(out_bin)
    cmd = [os.path.join(d, "prog.exe")]
    r = subprocess.run(cmd, capture_output=True, text=True, cwd=d, timeout=900)
    return r


ok = 0
bad = []
for t in TASKS:
    try:
        r = run(t)
    except subprocess.TimeoutExpired:
        print("%-20s FAIL (timeout)" % t, flush=True)
        bad.append(t)
        continue
    out = r.stdout.strip()
    tm = re.search(r"TIME_MS=([\d.]+)", r.stderr)
    good = (out == expected(t)) and (tm is not None)
    if t == "15_file_write":
        good = good and os.path.exists(os.path.join(HERE, t, "out.bin"))
    if good:
        ok += 1
        print("%-20s OK TIME_MS=%s" % (t, tm.group(1)), flush=True)
    else:
        bad.append(t)
        print("%-20s FAIL" % t, flush=True)
        print("    expected=%r" % expected(t), flush=True)
        print("    actual  =%r" % out[:120], flush=True)
        print("    stderr  =%r" % r.stderr.strip()[-200:], flush=True)
print("%s PASS %d/15" % (ROW, ok), flush=True)
if bad:
    sys.exit(1)
