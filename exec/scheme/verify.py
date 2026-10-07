import os
import re
import shutil
import subprocess
import sys

ROW = "scheme"
TOOL = "chez"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
DATA = os.path.join(ROOT, "data.bin")
SCHEME = os.path.join(ROOT, "tools", "chez", "bin", "ta6nt", "scheme.exe")

# Chez compiles the script on every run and the boot-file load plus the compile are inside
# the measured time. Task 07 is the documented slow cell (250000 immutable-string appends
# copy about 3.1e10 bytes), so it gets a larger allowance than the rest.
TIMEOUT = 900
SLOW = {"07_string_append": 3600, "06_char_count": 1200, "01_branches": 1200,
        "02_switch_case": 1200, "11_parallel_sum": 1200}

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]
EXPECT = {
    "01_branches": "33333334 13333333 7619048 45714285",
    "02_switch_case": "7500000075000000",
    "03_func_sum": "100000000",
    "04_array_sum": "499999500000",
    "05_alloc_churn": "1274991808",
    "06_char_count": "10000000",
    "07_string_append": "250000",
    "08_average": "0.498046875",
    "09_fib_recursive": "102334155",
    "10_pi": "4470",
    "11_parallel_sum": "7500000075000000",
    "12_matrix_add": "999000000",
    "13_matrix_mul": "599995000",
    "14_file_read": "2389704704",
    "15_file_write": "52428800",
}


def run_tool():
    exec_dir = os.path.join(HERE, TOOL)
    ok = 0
    for t in TASKS:
        d = os.path.join(exec_dir, t)
        if t in ("14_file_read", "15_file_write"):
            if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copy(DATA, os.path.join(d, "data.bin"))
        if t == "15_file_write":
            out = os.path.join(d, "out.bin")
            if os.path.exists(out):
                os.remove(out)
        timefile = os.path.join(d, "time.txt")
        if os.path.exists(timefile):
            os.remove(timefile)
        timeout = SLOW.get(t, TIMEOUT)
        try:
            r = subprocess.run(
                [SCHEME, "--optimize-level", "3", "--script", t + ".ss"],
                cwd=d, capture_output=True, text=True, timeout=timeout,
            )
        except subprocess.TimeoutExpired:
            print("%s %s %s FAIL (timeout after %ds)" % (ROW, TOOL, t, timeout), flush=True)
            continue
        got = r.stdout.strip()
        # The header says TIME_MS goes to time.txt, not stderr: Chez's console-error-port is
        # the console and this host sends the console to stdout when it is redirected.
        ms = None
        if os.path.exists(timefile):
            with open(timefile) as f:
                m = re.search(r"TIME_MS=([0-9.eE+-]+)", f.read())
                if m:
                    ms = m.group(1)
        if ms is None:
            m = re.search(r"TIME_MS=([0-9.eE+-]+)", r.stderr)
            if m:
                ms = m.group(1)
        problems = []
        if got != EXPECT[t]:
            problems.append("expected %r got %r" % (EXPECT[t], got))
        if ms is None:
            problems.append("no TIME_MS in time.txt or on stderr")
        if t == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
            problems.append("out.bin missing")
        if problems:
            print("%s %s %s FAIL %s" % (ROW, TOOL, t, "; ".join(problems)), flush=True)
            print("   stderr tail: %s" % r.stderr.strip()[-300:].replace("\n", " | "), flush=True)
        else:
            ok += 1
            print("%s %s %s OK TIME_MS=%s" % (ROW, TOOL, t, ms), flush=True)
    print("%s %s PASS %d/15" % (ROW, TOOL, ok), flush=True)
    return ok


def main():
    return 0 if run_tool() == 15 else 1


sys.exit(main())
