#!/usr/bin/env python3
"""Row verifier for the lua row -- PUC Lua 5.4 and LuaJIT over one set of scripts.

Lua is interpreted, so there is no build step: both toolchain entries of the row
name the same staged script (exec\\lua\\<task>.lua) and differ only in the
interpreter that runs it and in the LUA_PATH/LUA_CPATH that point at the Lanes
extension in tools\\lua-rocks\\.  This verifier runs all fifteen tasks on both
interpreters -- exactly the argv, cwd and env exec/cells.json records -- and
checks the three things every row's verifier checks: stdout equals the task's own
`expected output:` line (read from the source header, so a source edit cannot
leave the check behind), a TIME_MS value reached stderr, and task 15 left out.bin
behind at its full 52428800 bytes.  out.bin is cleared before every run, the way
the harness clears it.

    python exec/lua/verify.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ROW = "lua"
SRC = os.path.join(ROOT, "sources", "lua")
RUN = os.path.join(ROOT, "exec", "lua")
TIMEOUT = 1800
OUT_BIN_SIZE = 52428800

ROCKS = os.path.join(ROOT, "tools", "lua-rocks")

# toolchain -> (interpreter, Lua version directory under tools/lua-rocks)
TOOLCHAINS = {
    "puc-lua": (os.path.join(ROOT, "tools", "lua", "lua54.exe"), "5.4"),
    "luajit": (os.path.join(ROOT, "tools", "luajit", "luajit.exe"), "5.1"),
}

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

EXPECTED = re.compile(r"expected output:\s*(.*?)\s*$")

def expected_output(task):
    with open(os.path.join(SRC, task + ".lua"), encoding="utf-8", errors="replace") as fh:
        head = fh.readline()
    m = EXPECTED.search(head)
    if not m:
        raise SystemExit("%s: no `expected output:` line in the source header" % task)
    return m.group(1)

def env_for(toolchain):
    _, ver = TOOLCHAINS[toolchain]
    env = dict(os.environ)
    env["LUA_PATH"] = os.path.join(ROCKS, "share", "lua", ver, "?.lua") + ";" \
        + os.path.join(ROCKS, "share", "lua", ver, "?", "init.lua") + ";;"
    env["LUA_CPATH"] = os.path.join(ROCKS, "lib", "lua", ver, "?.dll") + ";;"
    return env

def check(toolchain, task):
    want = expected_output(task)
    interp = TOOLCHAINS[toolchain][0]
    cwd = RUN
    script = os.path.join(cwd, task + ".lua")
    if not os.path.exists(script):
        return False, "missing artifact %s" % script
    out_bin = os.path.join(cwd, "out.bin")
    if os.path.exists(out_bin):
        try:
            os.remove(out_bin)
        except OSError:
            pass
    try:
        p = subprocess.run([interp, task + ".lua"], cwd=cwd, capture_output=True,
                           text=True, timeout=TIMEOUT, env=env_for(toolchain))
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT
    out = p.stdout.replace("\r\n", "\n").strip()
    if out != want:
        return False, "stdout %r != expected %r (exit %s, stderr tail %r)" % (
            out[:120], want[:120], p.returncode, p.stderr[-200:])
    m = re.search(r"TIME_MS=([0-9.]+)", p.stderr)
    if not m:
        return False, "no TIME_MS on stderr (stderr tail: %r)" % p.stderr[-200:]
    if task == "15_file_write":
        size = os.path.getsize(out_bin) if os.path.exists(out_bin) else -1
        if size != OUT_BIN_SIZE:
            return False, "out.bin is %d bytes, expected %d" % (size, OUT_BIN_SIZE)
    return True, "TIME_MS=%s" % m.group(1)

def main():
    all_ok = True
    total = checked = 0
    for toolchain in sorted(TOOLCHAINS):
        passed = 0
        for task in TASKS:
            ok, detail = check(toolchain, task)
            passed += 1 if ok else 0
            print("%-9s %-16s %s %s" % (toolchain, task, "OK  " if ok else "FAIL", detail),
                  flush=True)
        print("%s %s %d/15" % (toolchain, "PASS" if passed == len(TASKS) else "FAIL", passed))
        all_ok = all_ok and passed == len(TASKS)
        total += passed
        checked += len(TASKS)
    print("%s %s %d/%d" % (ROW, "PASS" if all_ok else "FAIL", total, checked))
    return 0 if all_ok else 1

if __name__ == "__main__":
    sys.exit(main())
