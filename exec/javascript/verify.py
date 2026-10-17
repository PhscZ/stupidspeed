#!/usr/bin/env python3
"""Row verifier for the javascript row -- bun and deno.

Both toolchains run one set of fifteen CommonJS sources as they are, so this
verifier reads each task's `expected output:` line from the *source* header
(sources/javascript/<task>.js) and checks it against what each runtime prints.

Every cell of the row is checked the three ways the row contract asks:

  1. stdout, stripped, equals the task's own `expected output:` line;
  2. a TIME_MS value reached stderr;
  3. task 15 additionally left out.bin at its full 52428800 bytes.

Tasks 11, 14 and 15 are the three deno needs an extra permission flag for.

One line is printed per task, naming every toolchain that ran it, and the final
line counts tasks: a task passes when every toolchain covering it passed.

    python exec/javascript/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "javascript"
SRC = os.path.join(ROOT, "sources", "javascript")
OUT = os.path.join(ROOT, "exec", "javascript")
BUN = os.path.join(os.path.expanduser("~"), ".bun", "bin", "bun.exe")
DENO = os.path.join(ROOT, "tools", "deno", "deno.exe")

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]
TOOLCHAINS = [("bun", TASKS), ("deno", TASKS)]

# Per-task subprocess timeout.  The registry gives every cell 600 s; deno's
# start-up and worker_threads boot are the slow part on a loaded host.
TIMEOUT = {"bun": 600, "deno": 900}
OUT_BIN_SIZE = 52428800

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")


def expected_output(task):
    with open(os.path.join(SRC, task + ".js"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)


def argv_for(toolchain, task):
    """The registry's cmd for this cell, verbatim."""
    if toolchain == "bun":
        return [BUN, task + ".js"]
    if toolchain == "deno":
        # --allow-read for tasks 11 and 14 (11's worker_threads re-read the
        # script, 14 reads data.bin), --allow-write for 15, plain otherwise.
        argv = [DENO, "run", "--unstable-detect-cjs"]
        if task in ("11_parallel_sum", "14_file_read"):
            argv.append("--allow-read")
        elif task == "15_file_write":
            argv.append("--allow-write")
        return argv + [task + ".js"]
    raise SystemExit("unknown toolchain %r" % toolchain)


def check(toolchain, task):
    cwd = os.path.join(OUT, toolchain, task)
    argv = argv_for(toolchain, task)
    if not os.path.exists(argv[0]):
        return False, "missing %s" % argv[0]
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True,
                           timeout=TIMEOUT[toolchain])
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT[toolchain]
    out = p.stdout.replace("\r\n", "\n").strip()
    want = expected_output(task)
    if out != want:
        return False, "stdout %r != expected %r" % (out[:120], want[:120])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        out_bin = os.path.join(cwd, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, m.group(1)


def main():
    passed = 0
    for task in TASKS:
        parts = []
        ok = True
        for toolchain, tasks in TOOLCHAINS:
            if task not in tasks:
                continue
            good, detail = check(toolchain, task)
            parts.append("%s %s" % (toolchain, ("TIME_MS=" + detail) if good else detail))
            ok = ok and good
        print("%-16s %s %s" % (task, "OK  " if ok else "FAIL", "  |  ".join(parts)),
              flush=True)
        passed += 1 if ok else 0
    print("%s %s %d/15" % (ROW, "PASS" if passed == len(TASKS) else "FAIL", passed))
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
