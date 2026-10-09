"""Verify the `kotlin` row: one language, three backends.

Kotlin 2.4.20 ships three compilers in the same distribution, and the row runs
all three:

  jvm   kotlinc       -> prog.jar,  executed by HotSpot (java -jar prog.jar)
  js    kotlinc-js    -> prog.js,   executed by node 22 (V8)
  wasm  kotlinc-wasm  -> prog.wasm, executed by wasmtime 46 (Cranelift)

Each toolchain has its own source directory -- sources/kotlin/, sources/kotlin-js/
and sources/kotlin-wasm/ -- because the two web targets cannot express everything
the JVM can.  The jvm and js trees hold all fifteen tasks; the wasm tree holds
twelve, and the three it lacks are reported below as `except`, not as failures:

  wasm 11_parallel_sum   the wasm-wasi stdlib has no thread primitive (no Worker,
                         no java.lang.Thread, and node's worker_threads are not
                         reachable from the module)
  wasm 14_file_read      the wasm-wasi stdlib has no file API -- kotlin.io there
  wasm 15_file_write     is print/readln over the three standard descriptors only

Kotlin 2.4.20 needs two compiler invocations per task for both web targets: a
klib cannot be produced and linked in the same K2 invocation, so the task is
compiled to a klib and then linked with `-Xir-produce-js -Xinclude=<klib>`.

Run:  python exec\\kotlin\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
ROW = os.path.basename(HERE)                       # "kotlin"
SRC = {                                            # per toolchain, as the row builds them
    "jvm": os.path.join(ROOT, "sources", "kotlin"),
    "js": os.path.join(ROOT, "sources", "kotlin-js"),
    "wasm": os.path.join(ROOT, "sources", "kotlin-wasm"),
}
DATA = os.path.join(ROOT, "data.bin")

JAVA = "java"                                      # the HotSpot JDK on PATH, as the jvm cell runs it
NODE = os.path.join(ROOT, "tools", "nodejs", "node.exe")
WASMTIME = os.path.join(ROOT, "tools", "wasmtime46", "wasmtime.exe")

TASKS = ["01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
         "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
         "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write"]

# (toolchain, backend id, the command after the task directory is the working directory)
TOOLS = [
    ("jvm", "hotspot", lambda task: [JAVA, "-jar", "prog.jar"]),
    ("js", "v8", lambda task: [NODE, "prog.js"]),
    ("wasm", "wasmtime", lambda task: [
        WASMTIME, "run",
        "-W", "gc=y", "-W", "function-references=y", "-W", "exceptions=y",
        "prog.wasm",
    ]),
]

# The capability boundary of the wasm-wasi standard library: no threads, no files.
EXCEPT = {
    "wasm": ["11_parallel_sum", "14_file_read", "15_file_write"],
}

TIMEOUT = 900

def expected(tool, task):
    """The task's `expected output:` line, read from the source the toolchain builds."""
    src = SRC[tool] if os.path.exists(os.path.join(SRC[tool], task + ".kt")) else SRC["jvm"]
    with open(os.path.join(src, task + ".kt"), encoding="utf-8") as f:
        first = f.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no 'expected output:' header in %s/%s.kt" % (src, task))
    return m.group(1)

def run_tool(tool, backend, command):
    ok = 0
    runnable = [t for t in TASKS if t not in EXCEPT.get(tool, ())]
    for t in runnable:
        d = os.path.join(HERE, t)
        if t in ("14_file_read", "15_file_write") and os.path.exists(DATA):
            dest = os.path.join(d, "data.bin")
            if not os.path.exists(dest) or not os.path.samefile(DATA, dest):
                shutil.copy(DATA, dest)
        out_bin = os.path.join(d, "out.bin")
        if t == "15_file_write" and os.path.exists(out_bin):
            os.remove(out_bin)
        try:
            r = subprocess.run(command(t), cwd=d, capture_output=True, text=True, timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
            print("%-5s %-20s FAIL (timeout after %ds)" % (tool, t, TIMEOUT), flush=True)
            continue
        got = r.stdout.strip()
        tm = re.search(r"TIME_MS=([0-9.eE+-]+)", r.stderr)
        problems = []
        if got != expected(tool, t):
            problems.append("expected %r got %r" % (expected(tool, t), got))
        if not tm:
            problems.append("no TIME_MS on stderr")
        if t == "15_file_write" and not os.path.exists(out_bin):
            problems.append("out.bin missing")
        if problems:
            print("%-5s %-20s FAIL %s" % (tool, t, "; ".join(problems)), flush=True)
            print("      stderr tail: %s" % r.stderr.strip()[-200:].replace("\n", " | "), flush=True)
        else:
            ok += 1
            print("%-5s %-20s OK TIME_MS=%s" % (tool, t, tm.group(1)), flush=True)
    for t in EXCEPT.get(tool, ()):
        print("%-5s %-20s EXCEPT (capability boundary, see this file's header)" % (tool, t), flush=True)
    print("%s %s PASS %d/%d" % (ROW, tool, ok, len(runnable)), flush=True)
    return ok == len(runnable)

def main():
    if not os.path.exists(NODE) or not os.path.exists(WASMTIME):
        print("missing tools/nodejs/node.exe or tools/wasmtime46/wasmtime.exe", flush=True)
        return 1
    worst = True
    for tool, backend, command in TOOLS:
        print("########## kotlin %s -> %s" % (tool, backend), flush=True)
        worst = run_tool(tool, backend, command) and worst
    return 0 if worst else 1

sys.exit(main())
