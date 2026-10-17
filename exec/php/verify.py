#!/usr/bin/env python3
"""Row verifier for the php row -- one ZTS PHP 8.5 interpreter, two toolchains.

    zend      ->  exec\\php\\zend\\<task>\\<task>.php
    zend-jit  ->  exec\\php\\zend-jit\\<task>\\<task>.php

Both are the same staged script; the `zend + jit` toolchain adds the opcache/JIT
flags exec/cells.json records.  PHP is interpreted, so there is no build step --
`build_all.bat` only stages the sources.

Checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot leave
the check behind), a TIME_MS value reached stderr, and task 15 left out.bin behind at
its full 52428800 bytes.

    python exec/php/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "php"
SRC = os.path.join(ROOT, "sources", "php")
RUN = os.path.join(ROOT, "exec", "php")
PHP = os.path.join(ROOT, "tools", "php-zts", "php.exe")
TIMEOUT = 600
OUT_BIN_SIZE = 52428800

JIT = ["-d", "opcache.enable_cli=1", "-d", "opcache.jit=tracing",
       "-d", "opcache.jit_buffer_size=64M"]
TOOLCHAINS = {
    "zend": [],
    "zend-jit": JIT,
}

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    # The `expected output:` line is the first comment line, but PHP's sources start
    # with `<?php` on line 1, so scan the header lines instead of just the first.
    with open(os.path.join(SRC, task + ".php"), encoding="utf-8", errors="replace") as fh:
        for _ in range(10):
            line = fh.readline()
            if not line:
                break
            m = EXPECTED.search(line)
            if m:
                return m.group(1)
    raise SystemExit("%s: no `expected output:` line in the source header" % task)

def check(toolchain, task):
    want = expected_output(task)
    cwd = os.path.join(RUN, toolchain, task)
    script = os.path.join(cwd, task + ".php")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    argv = [PHP] + TOOLCHAINS[toolchain] + ["-d", "memory_limit=4096M", task + ".php"]
    try:
        p = subprocess.run(argv, cwd=cwd, capture_output=True, text=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (stderr tail: %r)" % (
            out[:120], want[:120], p.stderr[-200:])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        out_bin = os.path.join(cwd, "out.bin")
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)

def main():
    total = passed = 0
    for toolchain in ("zend", "zend-jit"):
        for task in TASKS:
            ok, detail = check(toolchain, task)
            total += 1
            passed += 1 if ok else 0
            print("%-9s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
    print("%s %s %d/%d" % (ROW, "PASS" if passed == total else "FAIL", passed, total))
    return 0 if passed == total else 1

if __name__ == "__main__":
    sys.exit(main())
