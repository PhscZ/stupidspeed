import subprocess, re, os, shutil, sys

ROOT = r"C:\stupidspeed"
D = os.path.join(ROOT, "exec", "swift")
BIN = os.path.join(D, "swiftc")
SWIFT = os.path.join(ROOT, "tools", "swift")
RUNTIME = os.path.join(SWIFT, "Toolchains", "6.4.0+NoAsserts", "usr", "bin")
RUNTIME2 = os.path.join(SWIFT, "Runtimes", "6.4.0", "usr", "bin")

tasks = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]

# The expected stdout line is the `expected output:` field of each source header.
exp = {}
for t in tasks:
    with open(os.path.join(ROOT, "sources", "swift", t + ".swift"), encoding="utf8") as f:
        head = f.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", head)
    exp[t] = m.group(1) if m else None

env = dict(os.environ)
env["PATH"] = RUNTIME + os.pathsep + RUNTIME2 + os.pathsep + env.get("PATH", "")

ok = 0
bad = []
for t in tasks:
    d = os.path.join(BIN, t)
    exe = os.path.join(d, "prog.exe")
    if not os.path.exists(exe):
        bad.append(t)
        print("%-20s FAIL(no exe)" % t, flush=True)
        continue
    if t in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(os.path.join(ROOT, "data.bin"), os.path.join(d, "data.bin")): shutil.copy(os.path.join(ROOT, "data.bin"), os.path.join(d, "data.bin"))
    if t == "15_file_write":
        out = os.path.join(d, "out.bin")
        if os.path.exists(out):
            os.remove(out)
    try:
        r = subprocess.run([exe], capture_output=True, text=True, cwd=d, timeout=600, env=env)
    except subprocess.TimeoutExpired:
        bad.append(t)
        print("%-20s TIMEOUT" % t, flush=True)
        continue
    got = r.stdout.strip()
    tm = re.search(r"TIME_MS=([\d.]+)", r.stderr)
    good = (got == exp[t]) and (tm is not None)
    if t == "15_file_write":
        good = good and os.path.exists(os.path.join(d, "out.bin"))
    if good:
        ok += 1
        print("%-20s OK TIME_MS=%s" % (t, tm.group(1)), flush=True)
    else:
        bad.append(t)
        why = []
        if got != exp[t]:
            why.append("stdout expected %r got %r" % (exp[t], got[:80]))
        if tm is None:
            why.append("no TIME_MS on stderr; stderr tail: %r" % r.stderr.strip()[-200:])
        if t == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
            why.append("out.bin missing")
        print("%-20s FAIL (%s)" % (t, "; ".join(why)), flush=True)

print("SWIFT PASS %d/15" % ok, flush=True)
if bad:
    print("FAILED:", bad, flush=True)
