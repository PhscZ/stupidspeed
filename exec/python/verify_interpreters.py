import os
import re
import shutil
import subprocess
import sys

ROW = "python"
HERE = os.path.dirname(os.path.abspath(__file__))
DATA = r"C:\stupidspeed\data.bin"
TIMEOUT = 600

# toolchain -> interpreter executable (as the row header / assignment specifies)
TOOLS = {
    "cpython": r"C:\Users\pz020\AppData\Local\Programs\Python\Python313\python.exe",
    "pypy": r"C:\stupidspeed\tools\pypy\pypy.exe",
    "graalpy": r"C:\stupidspeed\tools\graalpy\graalpy-community3.13-25.4.4.1.1-windows-amd64\bin\graalpy.exe",
}

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


def run_tool(tool, interp):
    print("########## %s (%s)" % (tool, interp), flush=True)
    exec_dir = os.path.join(HERE, tool)
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
                [interp, t + ".py"],
                cwd=d, capture_output=True, text=True, timeout=TIMEOUT,
            )
        except subprocess.TimeoutExpired:
            print("%s FAIL (timeout after %ds)" % (t, TIMEOUT), flush=True)
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
            print("%s FAIL %s" % (t, "; ".join(problems)), flush=True)
            print("   stderr tail: %s" % r.stderr.strip()[-300:].replace("\n", " | "), flush=True)
        else:
            ok += 1
            print("%s OK TIME_MS=%s" % (t, m.group(1)), flush=True)
    print("%s/%s PASS %d/15" % (ROW, tool, ok), flush=True)
    return ok


def main():
    total = 0
    for tool, interp in TOOLS.items():
        if not os.path.exists(interp):
            print("%s/%s FAIL interpreter not found: %s" % (ROW, tool, interp), flush=True)
            continue
        total += run_tool(tool, interp)
    return 0 if total == 45 else 1


sys.exit(main())
