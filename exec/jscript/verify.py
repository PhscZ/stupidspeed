#!/usr/bin/env python3
"""Verifier for the jscript row (Windows Script Host, cscript //E:JScript).

No build step: each task directory holds the source staged by build_all.bat,
the 03_func_sum helper file, and data.bin for tasks 14/15.

Checks per task:
  1. stripped stdout == the task's `expected output:` line (read from sources/jscript);
  2. a TIME_MS value is present on stderr (the row writes it with WScript.StdErr);
  3. task 15 leaves out.bin (52428800 bytes) in its working directory.

Run:  python exec\\jscript\\verify.py
"""
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))          # exec/jscript
REPO = os.path.dirname(os.path.dirname(HERE))              # C:\stupidspeed
SRC = os.path.join(REPO, "sources", "jscript")
DATA = os.path.join(REPO, "data.bin")
ROW = "jscript"

TOOLCHAINS = ["wsh"]
CSCRIPT = r"C:\WINDOWS\system32\cscript.exe"

# The row documents its engine as JScript9Legacy, ScriptEngine "JScript" 11.0.16384 --
# explicitly not classic JScript 5.8 (see the source header, BUILD.md and RUN.md).  On
# Windows 11 24H2+ the plain `JScript` ProgID already resolves to jscript9.dll.  This
# host is Windows 10 19045, where that ProgID still points at classic jscript.dll (5.8),
# so the documented engine is selected by its CLSID instead; it reports exactly the
# documented 11.0.16384.  engine_switch() probes for it and returns the //E: argument.
JSCRIPT9_CLSID = "{16d51579-a30b-4c8b-a276-0ff4dc41e755}"

ENGINE_SWITCH = "JScript"          # resolved by engine_switch() at start-up


def probe_engine(switch):
    probe = os.path.join(tempfile.gettempdir(), "ss_engine_probe.js")
    with open(probe, "w", encoding="ascii") as f:
        f.write('WScript.StdErr.Write(ScriptEngine()+" "+ScriptEngineMajorVersion()+"."'
                '+ScriptEngineMinorVersion()+"."+ScriptEngineBuildVersion());')
    try:
        p = subprocess.run([CSCRIPT, "//nologo", "//E:" + switch, probe],
                           capture_output=True, timeout=120)
    except Exception:
        return None
    return p.stderr.decode("utf-8", "replace").strip() or None


def engine_switch():
    """The //E: argument that selects the engine the row documents (11.x)."""
    for switch in ("JScript", JSCRIPT9_CLSID):
        ver = probe_engine(switch)
        if ver and ver.startswith("JScript 11."):
            return switch, ver
    return JSCRIPT9_CLSID, "JScript 11.0.16384 (unverified)"

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# The header documents this row as slow on the shared host (task 09, fib(40), 89-327 s;
# tasks 01/02/03/06/10/14 tens of seconds to ~3 minutes each).  The documented engine
# (JScript 11.0.16384) is far quicker than classic 5.8, but keep a generous ceiling.
TIMEOUT = 1800         # seconds per task
OUT_SIZE = 52428800


def expected(task):
    with open(os.path.join(SRC, task + ".js"), "r", encoding="utf-8", errors="replace") as f:
        first = f.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise SystemExit("no expected output line in %s.js" % task)
    return m.group(1)


def command(tool, task, script):
    return [CSCRIPT, "//nologo", "//E:" + ENGINE_SWITCH, script]


def tail(text, n=600):
    text = text.strip()
    return text[-n:] if len(text) > n else text


def run_one(tool, task):
    d = os.path.join(HERE, tool, task)
    exp = expected(task)
    if task in ("14_file_read", "15_file_write"):
        if not os.path.exists(os.path.join(d, "data.bin")) or not os.path.samefile(DATA, os.path.join(d, "data.bin")): shutil.copyfile(DATA, os.path.join(d, "data.bin"))
    if task == "15_file_write":
        ob = os.path.join(d, "out.bin")
        if os.path.exists(ob):
            os.remove(ob)
    cmd = command(tool, task, task + ".js")
    try:
        p = subprocess.run(cmd, cwd=d, capture_output=True, timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        return False, "timeout after %ds" % TIMEOUT, ""

    out = p.stdout.decode("utf-8", "replace").strip()
    err = p.stderr.decode("utf-8", "replace")
    problems = []
    if out != exp:
        problems.append("expected %r got %r" % (exp, out))
    m = re.search(r"TIME_MS=([0-9.]+)", err)
    time_ms = m.group(1) if m else None
    if time_ms is None:
        problems.append("no TIME_MS on stderr")
    if task == "15_file_write":
        ob = os.path.join(d, "out.bin")
        if not os.path.exists(ob):
            problems.append("out.bin missing")
        elif os.path.getsize(ob) != OUT_SIZE:
            problems.append("out.bin size %d != %d" % (os.path.getsize(ob), OUT_SIZE))
    if p.returncode != 0:
        problems.append("exit code %d" % p.returncode)
    if problems:
        return False, "; ".join(problems) + "\n    stderr tail: " + tail(err), time_ms
    return True, "", time_ms


def main():
    global ENGINE_SWITCH
    ENGINE_SWITCH, ver = engine_switch()
    print("%s engine: %s  (//E:%s)" % (ROW, ver, ENGINE_SWITCH))
    overall = 0
    for tool in TOOLCHAINS:
        print("=== %s/%s ===" % (ROW, tool))
        passed = 0
        for task in TASKS:
            ok, msg, time_ms = run_one(tool, task)
            if ok:
                passed += 1
                print("%s OK TIME_MS=%s" % (task, time_ms))
            else:
                print("%s FAIL" % task)
                print("    " + msg.replace("\n", "\n    "))
        print("%s/%s PASS %d/15" % (ROW, tool, passed))
        overall += passed
    print("%s TOTAL PASS %d/15" % (ROW, overall))
    return 0 if overall == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
