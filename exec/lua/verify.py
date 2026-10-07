#!/usr/bin/env python3
"""Verifier for the Lua (PUC 5.4) row.

Runs each task from exec/lua/, which holds the fifteen scripts flat plus the 50 MiB fixture,
and checks

  1. stripped stdout equals the task's `expected output:` line;
  2. a TIME_MS value is present on stderr;
  3. task 15 additionally leaves out.bin (52428800 bytes) in the working directory.

There is no build step: lua54.exe compiles the chunk to its own bytecode and runs it on the
register VM, so that compile is inside the measured number.

Two toolchain facts, both of which this script checks rather than assumes:

  * the interpreter is tools/lua/lua54.exe, the name the Windows binary distribution uses --
    there is no tools/lua/bin/lua.exe in this tree;
  * **task 11 needs the Lanes C extension**, which is a luarocks rock and not part of the
    interpreter. It is loaded through LUA_PATH/LUA_CPATH pointing at tools/lua-rocks. When
    that tree is absent the row cannot run task 11 at all, and this script says so instead of
    reporting a confusing nil-index error from inside the task.

Run:  python exec\\lua\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", "lua")
D = HERE
LUA = os.path.join(ROOT, "tools", "lua", "lua54.exe")
# The rock tree. This repo's convention is tools/lua-rocks (what `luarocks --tree` names in
# BUILD.md), but the default `luarocks install lanes` lands in %APPDATA%\luarocks, so both
# are searched; LUA_ROCKS overrides.
ROCKS = os.environ.get("LUA_ROCKS") or os.path.join(ROOT, "tools", "lua-rocks")
ROCKS_FALLBACK = os.path.join(os.environ.get("APPDATA", ""), "luarocks")
DATA = os.path.join(ROOT, "data.bin")
ROW = "lua"

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

TIMEOUT = 1800
OUT_SIZE = 52428800
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")

# Lanes lives outside the interpreter's own tree, so the module paths are explicit.
ENV = dict(os.environ)
ENV["LUA_PATH"] = ROCKS + r"\share\lua\5.4\?.lua;" + ROCKS + r"\share\lua\5.4\?\init.lua;;"
ENV["LUA_CPATH"] = ROCKS + r"\lib\lua\5.4\?.dll;;"


def expected(task):
    with open(os.path.join(SRC, task + ".lua"), encoding="utf-8", errors="replace") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected-output line in " + task)
    return m.group(1).strip()


def lanes_available():
    """Lanes anywhere in either rock tree, and return the tree it was found in."""
    for tree in (ROCKS, ROCKS_FALLBACK):
        if not tree or not os.path.isdir(tree):
            continue
        for root, dirs, files in os.walk(tree):
            for f in files:
                if f.lower().startswith("lanes") and f.lower().endswith((".dll", ".lua")):
                    return tree
    return None


def main():
    if not os.path.exists(LUA):
        print("%s FAIL no interpreter at %s" % (ROW, LUA), flush=True)
        return 1
    rock_tree = lanes_available()
    if rock_tree is None:
        print("%s NOTE the Lanes extension is absent from %s and %s, so task 11 cannot run"
              % (ROW, ROCKS, ROCKS_FALLBACK), flush=True)
        print("       here; every other task runs without it. See BUILD.md for the one-line"
              " install.", flush=True)
    elif rock_tree != ROCKS:
        # The default luarocks tree, not this repo's; point the search path at it.
        global ENV
        ENV["LUA_PATH"] = rock_tree + r"\share\lua\5.4\?.lua;" + rock_tree + r"\share\lua\5.4\?\init.lua;;"
        ENV["LUA_CPATH"] = rock_tree + r"\lib\lua\5.4\?.dll;;"
        print("%s NOTE using the Lanes tree at %s" % (ROW, rock_tree), flush=True)

    passed = 0
    failed = []
    for task in TASKS:
        if task == "11_parallel_sum" and rock_tree is None:
            print("%s SKIPPED no Lanes extension" % task, flush=True)
            failed.append(task)
            continue
        src = os.path.join(D, task + ".lua")
        exp = expected(task)
        if not os.path.exists(src):
            print("%s FAIL (no %s.lua)" % (task, task), flush=True)
            failed.append(task)
            continue
        if task == "14_file_read":
            dst = os.path.join(D, "data.bin")
            if not os.path.exists(dst) or not os.path.samefile(DATA, dst):
                shutil.copyfile(DATA, dst)
        if task == "15_file_write":
            outbin = os.path.join(D, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        try:
            p = subprocess.run([LUA, task + ".lua"], cwd=D, capture_output=True,
                               timeout=TIMEOUT, env=ENV)
        except subprocess.TimeoutExpired:
            print("%s FAIL timeout after %ss" % (task, TIMEOUT), flush=True)
            failed.append(task)
            continue

        out = p.stdout.decode("utf-8", "replace").strip()
        err = p.stderr.decode("utf-8", "replace")
        m = TIME_RE.search(err)
        problems = []
        if out != exp:
            problems.append("stdout mismatch: expected %r got %r" % (exp, out[:120]))
        if not m:
            problems.append("no TIME_MS on stderr")
        if task == "15_file_write":
            outbin = os.path.join(D, "out.bin")
            if not os.path.exists(outbin):
                problems.append("out.bin missing")
            elif os.path.getsize(outbin) != OUT_SIZE:
                problems.append("out.bin is %d bytes, expected %d" % (os.path.getsize(outbin), OUT_SIZE))

        if problems:
            failed.append(task)
            print("%s FAIL" % task, flush=True)
            for pr in problems:
                print("    %s" % pr, flush=True)
            if err.strip():
                print("    stderr tail: %s" % " | ".join(err.strip().splitlines()[-4:]), flush=True)
        else:
            passed += 1
            print("%s OK TIME_MS=%s" % (task, m.group(1)), flush=True)

    print("%s PASS %d/%d" % (ROW, passed, len(TASKS)), flush=True)
    if failed:
        print("%s FAILED: %s" % (ROW, " ".join(failed)), flush=True)
    return 0 if passed == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
