import subprocess, re, os, shutil
D = r"C:\stupidspeed\exec\go-wasm"
WT = r"C:\stupidspeed\tools\wasmtime46\wasmtime.exe"
WS = r"C:\stupidspeed\tools\wasmer437\bin\wasmer.exe"
NODE = r"C:\stupidspeed\tools\nodejs\node.exe"
WASI_SHIM = r"C:\stupidspeed\exec\wasi-run.js"
IWASM = r"C:\stupidspeed\tools\wamr\iwasm.exe"
WASMEDGE = r"C:\stupidspeed\tools\wasmedge\bin\wasmedge.exe"
DATA = r"C:\stupidspeed\data.bin"
tasks = ["01_branches","02_switch_case","03_func_sum","04_array_sum","05_alloc_churn",
         "06_char_count","07_string_append","08_average","09_fib_recursive","10_pi",
         "11_parallel_sum","12_matrix_add","13_matrix_mul","14_file_read","15_file_write"]
exp = {"01_branches":"33333334 13333333 7619048 45714285","02_switch_case":"7500000075000000",
 "03_func_sum":"100000000","04_array_sum":"499999500000","05_alloc_churn":"1274991808",
 "06_char_count":"10000000","07_string_append":"250000","08_average":"0.498046875",
 "09_fib_recursive":"102334155","10_pi":"4470","11_parallel_sum":"7500000075000000",
 "12_matrix_add":"999000000","13_matrix_mul":"599995000","14_file_read":"2389704704","15_file_write":"52428800"}
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")

def snapshot_out(d):
    """Remember task 15's out.bin, which is a committed artifact.

    A verification run must leave exec/ exactly as it found it, so whatever the
    cell wrote is put back once the cell has been checked -- the same thing
    exec/harness.py does around every run.
    """
    p = os.path.join(d, "out.bin")
    try:
        with open(p, "rb") as fh:
            return (p, fh.read())
    except OSError:
        return (p, None)

def restore_out(saved):
    p, blob = saved
    try:
        if blob is None:
            if os.path.exists(p):
                os.remove(p)
        else:
            with open(p, "wb") as fh:
                fh.write(blob)
    except OSError:
        pass

def stage(t, d):
    # data.bin is a committed fixture only in the 14_file_read directory of this
    # row (task 15 only writes), so it is staged there and nowhere else.
    if t == "14_file_read":
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")):
            shutil.copy(DATA, os.path.join(d, "data.bin"))
    if t == "15_file_write":
        op = os.path.join(d, "out.bin")
        if os.path.exists(op):
            os.remove(op)

def run(args, d, t, label):
    try:
        r = subprocess.run(args, capture_output=True, text=True, cwd=d, timeout=900)
    except subprocess.TimeoutExpired:
        print("%s FAIL TIMEOUT [%s]" % (t, label), flush=True)
        return False
    out = r.stdout.strip()
    m = TIME_RE.search(r.stderr)
    problems = []
    if out != exp[t]:
        problems.append("stdout expected %r got %r" % (exp[t], out[:80]))
    if not m:
        problems.append("no TIME_MS on stderr (rc=%s); stderr tail: %r" % (r.returncode, r.stderr.strip()[-200:]))
    if t == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
        problems.append("out.bin missing")
    if problems:
        print("%s FAIL [%s] %s" % (t, label, "; ".join(problems)), flush=True)
        return False
    print("%s OK TIME_MS=%s [%s]" % (t, m.group(1), label), flush=True)
    return True

# ---------------------------------------------------------------- wasmtime
# Go's wasip1 runtime resolves a relative name against a preopen only when that
# preopen's guest name is an absolute path, so `--dir .` fails with EBADF and
# the host dir has to be mapped to guest "/".
ok = 0; bad = []
for t in tasks:
    d = os.path.join(D, t)
    saved = snapshot_out(d)
    stage(t, d)
    good = run([WT, "--dir=%s::/" % d, "prog.wasm"], d, t, "wasmtime")
    restore_out(saved)
    if good:
        ok += 1
    else:
        bad.append(t)
print("GO-WASM PASS %d/15" % ok, flush=True)
if bad:
    print("GO-WASM FAILURES: %s" % repr(bad), flush=True)

# ---------------------------------------------------------------- wasmer
# Same prog.wasm under wasmer 4.3.7's three code generators.  Threads are on by
# default, so task 11 (which Go answers serially -- its wasip1 port has no
# thread support) needs no flags.  Tasks 14 and 15 map the host directory to the
# guest root with --mapdir /:<dir>, which is the same absolute-guest-name
# arrangement the wasmtime cell needs.
#
# Task 15 is a capability boundary, not a failed cell: wasmer 4.3.7's WASIX
# filesystem overlays the host directory read-only, so a file the program
# *creates* lives in an in-memory layer that is discarded at exit.  Writing to a
# file that already exists does reach the host, which is why task 14 (read
# data.bin) is fine and task 15 cannot leave out.bin.
WEXCEPT = {"15_file_write"}
for comp in ("cranelift", "llvm", "singlepass"):
    w_ok = 0; w_bad = []
    for t in tasks:
        d = os.path.join(D, t)
        if t in WEXCEPT:
            print("%s SKIP [wasmer %s] capability boundary" % (t, comp), flush=True)
            continue
        saved = snapshot_out(d)
        stage(t, d)
        args = [WS, "run", "--" + comp]
        if t in ("14_file_read", "15_file_write"):
            args += ["--mapdir", "/:" + d]
        args.append("prog.wasm")
        good = run(args, d, t, "wasmer " + comp)
        restore_out(saved)
        if good:
            w_ok += 1
        else:
            w_bad.append(t)
    print("GO-WASM wasmer (%s) PASS %d/15" % (comp, w_ok), flush=True)
    if w_bad:
        print("GO-WASM wasmer (%s) FAILURES: %s" % (comp, repr(w_bad)), flush=True)

# ---------------------------------------------- WAMR, WasmEdge, node (V8)
# The same prog.wasm on the three other runtimes the registry lists.  Each needs
# the preopen's *guest* name to be absolute, because Go's wasip1 runtime resolves
# a relative name against a preopen only when the preopen is a path such as "/":
# WAMR takes --map-dir=/::. rather than --dir=., WasmEdge --dir /:. rather than
# --dir .:., and node's WASI shim maps its preopen to "/" but also has to drop
# PWD from the guest environment, which the shim itself now does.
def runtime_cells():
    """The three other runtimes the registry lists, with their run lines."""
    return [
        ("WAMR", [IWASM, "--map-dir=/::.", "prog.wasm"]),
        ("WasmEdge", [WASMEDGE, "--log-level", "off", "--run-mode=jit",
                      "--dir", "/:.", "prog.wasm"]),
        ("node (V8)", [NODE, "--no-warnings", WASI_SHIM, "prog.wasm", "."]),
    ]

for label, argv in runtime_cells():
    r_ok = 0; r_bad = []
    for t in tasks:
        d = os.path.join(D, t)
        saved = snapshot_out(d)
        stage(t, d)
        good = run(argv, d, t, label)
        restore_out(saved)
        if good:
            r_ok += 1
        else:
            r_bad.append(t)
    print("GO-WASM %s PASS %d/15" % (label, r_ok), flush=True)
    if r_bad:
        print("GO-WASM %s FAILURES: %s" % (label, repr(r_bad)), flush=True)
