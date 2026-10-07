import os
import re
import shutil
import subprocess
import sys

ROW = "raku"
TOOL = "rakudo"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
DATA = os.path.join(ROOT, "data.bin")
RAKU = os.path.join(ROOT, "tools", "rakudo", "rakudo", "bin", "raku.exe")

# Raku is slow per operation. Task 02's `given`/`when` costs about 5.7 us per iteration and
# is the documented ~10 minute run; task 06's per-character substr scan is the other
# documented slow cell. The rest of the row is 1e8-iteration interpreter loops or a 10M
# buffer churn, so every task gets a generous allowance and none is aborted early.
TIMEOUT = 3600

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
        try:
            r = subprocess.run(
                [RAKU, t + ".raku"],
                cwd=d, capture_output=True, text=True, timeout=TIMEOUT,
            )
        except subprocess.TimeoutExpired:
            print("%s %s %s FAIL (timeout after %ds)" % (ROW, TOOL, t, TIMEOUT), flush=True)
            continue
        got = r.stdout.strip()
        m = re.search(r"TIME_MS=([0-9.eE+-]+)", r.stderr)
        problems = []
        if got != EXPECT[t]:
            problems.append("expected %r got %r" % (EXPECT[t], got))
        if not m:
            problems.append("no TIME_MS on stderr")
        if t == "15_file_write" and not os.path.exists(os.path.join(d, "out.bin")):
            problems.append("out.bin missing")
        if problems:
            print("%s %s %s FAIL %s" % (ROW, TOOL, t, "; ".join(problems)), flush=True)
            print("   stderr tail: %s" % r.stderr.strip()[-300:].replace("\n", " | "), flush=True)
        else:
            ok += 1
            print("%s %s %s OK TIME_MS=%s" % (ROW, TOOL, t, m.group(1)), flush=True)
    print("%s %s PASS %d/15" % (ROW, TOOL, ok), flush=True)
    return ok


def main():
    return 0 if run_tool() == 15 else 1


sys.exit(main())
