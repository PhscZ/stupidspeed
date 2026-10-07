import subprocess, re, os, shutil, sys

# Objective-C row: MSYS2 UCRT64 clang 22 + GNUstep runtime.
#  - ucrt64\bin must be on PATH for gnustep-base-1_31.dll, libobjc-4.6.dll, libwinpthread,
#    gnutls, icu, ... ; the matching libstdc++-6.dll is copied next to each exe by
#    build_all.bat (the tree's GCC 16.2 libstdc++ is missing symbols gnustep-base imports).
#  - TIME_MS goes to stderr, stdout carries the task result.
D = r"C:\stupidspeed\exec\objectivec\clang"
SRC = r"C:\stupidspeed\sources\objectivec"
UCRT = r"C:\stupidspeed\tools\msys64\msys64\ucrt64\bin"
DATA = r"C:\stupidspeed\data.bin"

tasks = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]

env = dict(os.environ)
env["PATH"] = UCRT + os.pathsep + env.get("PATH", "")


def expected(task):
    """The expected stdout line is the `expected output:` field of the source header."""
    with open(os.path.join(SRC, task + ".m"), encoding="utf-8", errors="replace") as f:
        for line in f:
            m = re.search(r"expected output:\s*(.+?)\s*$", line)
            if m:
                return m.group(1)
    raise SystemExit("no expected output in " + task + ".m")


ok = 0
for t in tasks:
    d = os.path.join(D, t)
    exp = expected(t)
    if t in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
    if t == "15_file_write":
        op = os.path.join(d, "out.bin")
        if os.path.exists(op):
            os.remove(op)
    try:
        r = subprocess.run([os.path.join(d, "prog.exe")], capture_output=True, text=True,
                           cwd=d, env=env, timeout=600)
    except subprocess.TimeoutExpired:
        print("%-16s FAIL  timeout after 600s" % t, flush=True)
        continue

    out = r.stdout.strip()
    m = re.search(r"TIME_MS=([0-9.]+)", r.stderr)
    problems = []
    if out != exp:
        problems.append("stdout: expected %r got %r" % (exp, out))
    if not m:
        problems.append("no TIME_MS on stderr")
    if r.returncode != 0:
        problems.append("exit code %d" % r.returncode)
    if t == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
        problems.append("out.bin missing")

    if problems:
        print("%-16s FAIL  %s" % (t, "; ".join(problems)), flush=True)
        tail = (r.stderr or "").strip().splitlines()[-5:]
        if tail:
            print("    stderr tail: " + " | ".join(tail), flush=True)
    else:
        ok += 1
        print("%-16s OK TIME_MS=%s" % (t, m.group(1)), flush=True)

print("objectivec PASS %d/15" % ok, flush=True)
sys.exit(0 if ok == 15 else 1)
