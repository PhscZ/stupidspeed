"""Verify the four `dart` row toolchains: aot, jit, dart2js and dart2wasm.

Each cell must print its expected line on stdout and a TIME_MS=<number> line on
stderr.  The two web targets cannot run every task -- no isolates, no dart:io file
access, and dart2js has no Int64List -- so those tasks are listed as `except`
boundaries exactly as the registry lists them, and are reported here rather than run.
"""
import subprocess, re, os, shutil

HERE = os.path.dirname(os.path.abspath(__file__))          # exec/dart
ROOT = os.path.dirname(os.path.dirname(HERE))              # repo root
DART = os.path.join(ROOT, "tools", "dart", "bin", "dart.exe")
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")
WASM_RUNNER = os.path.join(HERE, "dart2wasm", "run.mjs")
ROOT_DATA = os.path.join(ROOT, "data.bin")

TASKS = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]

# The web targets compile sources/dart-web/, which has no 11, 14 or 15.
EXCEPT = {
    "dart2js": ["04_array_sum", "11_parallel_sum", "12_matrix_add", "13_matrix_mul",
                "14_file_read", "15_file_write"],
    "dart2wasm": ["11_parallel_sum", "14_file_read", "15_file_write"],
}

EXP = {"01_branches": "33333334 13333333 7619048 45714285", "02_switch_case": "7500000075000000",
       "03_func_sum": "100000000", "04_array_sum": "499999500000", "05_alloc_churn": "1274991808",
       "06_char_count": "10000000", "07_string_append": "250000", "08_average": "0.498046875",
       "09_fib_recursive": "102334155", "10_pi": "4470", "11_parallel_sum": "7500000075000000",
       "12_matrix_add": "999000000", "13_matrix_mul": "599995000", "14_file_read": "2389704704",
       "15_file_write": "52428800"}


def cell(mode, task):
    """(command, working directory) for one cell."""
    if mode == "aot":
        d = os.path.join(HERE, "aot", task)
        return [os.path.join(d, "prog.exe")], d
    if mode == "jit":
        d = os.path.join(HERE, "jit")
        return [DART, task + ".dart"], d
    if mode == "dart2js":
        d = os.path.join(HERE, "dart2js", task)
        return [NODE, "prog.js"], d
    if mode == "dart2wasm":
        d = os.path.join(HERE, "dart2wasm", task)
        return [NODE, WASM_RUNNER], d
    raise ValueError(mode)


def run(mode):
    ok = 0; bad = []; skipped = 0
    for t in TASKS:
        if t in EXCEPT.get(mode, ()):
            skipped += 1
            print("dart/%-8s %-20s EXCEPT (not run)" % (mode, t), flush=True)
            continue
        cmd, d = cell(mode, t)
        if t == "14_file_read":
            fixture = os.path.join(d, "data.bin")
            if not os.path.exists(fixture) or os.path.getsize(fixture) != os.path.getsize(ROOT_DATA):
                shutil.copy(ROOT_DATA, fixture)
        if t == "15_file_write":
            out = os.path.join(d, "out.bin")
            if os.path.exists(out):
                os.remove(out)
        try:
            r = subprocess.run(cmd, capture_output=True, text=True, cwd=d, timeout=900)
            got = r.stdout.strip()
            tm = re.search(r"TIME_MS=([\d.]+)", r.stderr)
            good = (got == EXP[t]) and (tm is not None)
            if t == "15_file_write":
                good = good and os.path.exists(os.path.join(d, "out.bin"))
            ok += good
            if not good:
                bad.append(t)
            print("dart/%-8s %-20s %s TIME_MS=%s" % (mode, t, "OK" if good else "FAIL",
                                                     tm.group(1) if tm else None), flush=True)
            if not good:
                print("   got=%r err=%r" % (got[:60], r.stderr.strip()[-120:]), flush=True)
        except subprocess.TimeoutExpired:
            bad.append(t)
            print("dart/%-8s %-20s TIMEOUT" % (mode, t), flush=True)
    print("DART/%s PASS %d/%d (%d except)" % (mode, ok, len(TASKS) - skipped, skipped), flush=True)
    return bad


if __name__ == "__main__":
    failed = []
    for m in ("aot", "jit", "dart2js", "dart2wasm"):
        failed += [(m, t) for t in run(m)]
    print("DART; FAILED", failed if failed else "none", flush=True)
    raise SystemExit(1 if failed else 0)