"""Verify the `java` row: one JVM, four code-generator configurations.

The row's sources are compiled once, by `build_all.bat`, into
`exec/java/openjdk/<task>/_<task>.class`.  All four toolchains run those same
class files; what differs is which code generator HotSpot is allowed to use:

  openjdk          the default: tiered compilation, C1 then C2
  openjdk (interp) -Xint: the template interpreter, no JIT at all
  openjdk (c1)     -XX:TieredStopAtLevel=1: C1 only, the C2 tier never runs
  openjdk (c2)     -XX:-TieredCompilation: C2 only, no C1 profiling tier

That makes the row a controlled comparison of the JVM's own backends, in the
same shape as wasmtime's Cranelift/Winch pair and the wasm rows' five runtimes:
identical bytecode, one variable.  `RUN.md` carries the flags and the
`bytecode-vm`/`native-jit` kinds they land in.
"""
import os
import re
import shutil
import subprocess
import sys

ROW = "java"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
DATA = os.path.join(ROOT, "data.bin")
TIMEOUT = 600

# toolchain -> (backend id, the JVM flags that select it).  The class files live
# in the `openjdk` tree for every one of them, because javac's output is the same.
TOOLS = [
    ("openjdk", "hotspot", []),
    ("openjdk (interp)", "hotspot-interp", ["-Xint"]),
    ("openjdk (c1)", "hotspot-c1", ["-XX:TieredStopAtLevel=1"]),
    ("openjdk (c2)", "hotspot-c2", ["-XX:-TieredCompilation"]),
]

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

JAVA = "java"  # system HotSpot JDK, as the row header specifies


def run_tool(tool, flags):
    exe = os.path.join(HERE, "openjdk")
    ok = 0
    for t in TASKS:
        d = os.path.join(exe, t)
        if t in ("14_file_read", "15_file_write"):
            if not os.path.exists(os.path.join(d, "data.bin")) \
                    or not os.path.samefile(DATA, os.path.join(d, "data.bin")):
                shutil.copy(DATA, os.path.join(d, "data.bin"))
        if t == "15_file_write":
            out = os.path.join(d, "out.bin")
            if os.path.exists(out):
                os.remove(out)
        try:
            r = subprocess.run(
                [JAVA] + flags + ["-cp", ".", "_" + t],
                cwd=d, capture_output=True, text=True, timeout=TIMEOUT,
            )
        except subprocess.TimeoutExpired:
            print("%s %s FAIL (timeout after %ds)" % (tool, t, TIMEOUT), flush=True)
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
            print("%s %s FAIL %s" % (tool, t, "; ".join(problems)), flush=True)
            print("   stderr tail: %s" % r.stderr.strip()[-200:].replace("\n", " | "), flush=True)
        else:
            ok += 1
            print("%s %s OK TIME_MS=%s" % (tool, t, m.group(1)), flush=True)
    print("%s PASS %d/15" % (tool, ok), flush=True)
    return ok


def main():
    if not os.path.isdir(os.path.join(HERE, "openjdk")):
        print("no built classes; run build_all.bat first", flush=True)
        return 1
    worst = 15
    for tool, _backend, flags in TOOLS:
        print("########## %s%s" % (tool, (" " + " ".join(flags)) if flags else ""), flush=True)
        worst = min(worst, run_tool(tool, flags))
    return 0 if worst == 15 else 1


sys.exit(main())
