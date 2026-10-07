#!/usr/bin/env python3
"""Verify the scala (JVM) row: run each task from exec/scala/jvm/<task>/.

  jvm  scalac -release 17 -d out <task>.scala
       java -cp "out;<scala3-library_3-3.9.0.jar>;<scala-library-3.9.0.jar>" Main

JAVACMD is pinned at the Oracle javapath java (24): scala's libexec\\common.bat skips any
java.exe under a "javapath" directory, so with the box's PATH it would pick the Java 8 shim
(java8path) and scalac would die on class file 61.0.  The run uses the same JVM.

Every task prints one expected stdout line and TIME_MS=<ms> on stderr (the row header says
so; there is no time.txt fallback here).  Task 15 must also leave out.bin behind.
"""
import os
import re
import shutil
import subprocess
import sys

ROW = "scala"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", ROW)

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

JAVA = os.path.join(os.environ.get("ProgramFiles", r"C:\Program Files"),
                    "Common Files", "Oracle", "Java", "javapath", "java.exe")
SCALA = os.path.join(ROOT, "tools", "scala")
SCALA3LIB = os.path.join(SCALA, "maven2", "org", "scala-lang",
                         "scala3-library_3", "3.9.0", "scala3-library_3-3.9.0.jar")
SCALALIB = os.path.join(SCALA, "maven2", "org", "scala-lang",
                        "scala-library", "3.9.0", "scala-library-3.9.0.jar")

# The JVM row is fast: the heaviest cells are the 100M-iteration loops, the naive fib(40)
# and the 1000-digit spigot, all of which stay well under a minute on this box.  The 600 s
# default is already generous; the naive-fib cell gets extra headroom under sibling load.
TIMEOUTS = {"09_fib_recursive": 1200, "10_pi": 900}
DEFAULT_TIMEOUT = 600

TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")

def expected_output(task):
    with open(os.path.join(SRC, task + ".scala"), encoding="utf-8") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise RuntimeError("no expected output in header of " + task)
    return m.group(1).strip()

def chains():
    # -cp is relative to the working directory, so "out" resolves per task.
    cp = os.pathsep.join(["out", SCALA3LIB, SCALALIB])
    return [
        ("jvm", [JAVA, "-cp", cp, "Main"], None),
    ]

def run_task(cmd, cwd, env, timeout):
    """Run one task; return (returncode, stdout, stderr), or (None, ...) on timeout."""
    proc = subprocess.Popen(cmd, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            text=True, errors="replace", env=env)
    try:
        out, err = proc.communicate(timeout=timeout)
        return proc.returncode, out or "", err or ""
    except subprocess.TimeoutExpired:
        subprocess.run(["taskkill", "/F", "/T", "/PID", str(proc.pid)],
                       capture_output=True)
        try:
            out, err = proc.communicate(timeout=60)
        except subprocess.TimeoutExpired:
            proc.kill()
            out, err = proc.communicate()
        return None, out or "", err or ""

def verify(chain, argv, env, outdir=None):
    outdir = outdir or os.path.join(HERE, chain)
    passed = 0
    failed = []

    # one-time reachability probe so an absent JVM reads as a clear failure
    try:
        probe = subprocess.run([JAVA, "-version"], capture_output=True, text=True,
                               errors="replace", env=env, timeout=300)
        blob = (probe.stderr or probe.stdout).strip()
        print("### %s: %s" % (chain, blob.splitlines()[0] if blob else "no version output"),
              flush=True)
    except Exception as exc:  # noqa: BLE001 - report, do not die
        print("### %s: probe failed: %s" % (chain, exc), flush=True)

    for task in TASKS:
        workdir = os.path.join(outdir, task)
        exp = expected_output(task)
        timeout = TIMEOUTS.get(task, DEFAULT_TIMEOUT)

        if not os.path.isdir(workdir):
            print("%s FAIL no such directory %s" % (task, workdir), flush=True)
            failed.append(task)
            continue
        if not os.path.exists(os.path.join(workdir, "out", "Main.class")):
            print("%s FAIL missing out\\Main.class (run build_all.bat)" % task, flush=True)
            failed.append(task)
            continue
        if task in ("14_file_read", "15_file_write"):
            if not os.path.exists(os.path.join(workdir, "data.bin")) or not os.path.samefile(os.path.join(ROOT, "data.bin"), os.path.join(workdir, "data.bin")): shutil.copyfile(os.path.join(ROOT, "data.bin"), os.path.join(workdir, "data.bin"))
        if task == "15_file_write":
            outbin = os.path.join(workdir, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        rc, stdout, stderr = run_task(argv, workdir, env, timeout)
        if rc is None:
            print("%s FAIL timeout after %ss" % (task, timeout), flush=True)
            failed.append(task)
            continue

        problems = []
        got = stdout.strip()
        if got != exp:
            problems.append("stdout mismatch: expected %r got %r" % (exp, got[:120]))
        m = TIME_RE.search(stderr)
        if not m:
            problems.append("no TIME_MS on stderr")
        if task == "15_file_write":
            outbin = os.path.join(workdir, "out.bin")
            if not os.path.exists(outbin) or os.path.getsize(outbin) == 0:
                problems.append("out.bin missing or empty")
        if rc not in (0, None) and not problems:
            problems.append("exit code %s" % rc)

        if problems:
            failed.append(task)
            print("%s FAIL" % task, flush=True)
            for p in problems:
                print("    %s" % p, flush=True)
            if stderr.strip():
                print("    stderr tail:", flush=True)
                for line in stderr.strip().splitlines()[-8:]:
                    print("      %s" % line, flush=True)
        else:
            passed += 1
            print("%s OK TIME_MS=%s" % (task, m.group(1)), flush=True)

    print("%s %s PASS %d/%d" % (ROW, chain, passed, len(TASKS)), flush=True)
    if failed:
        print("%s %s FAILED: %s" % (ROW, chain, " ".join(failed)), flush=True)
    return passed, failed

def main():
    rc = 0
    for chain, argv, env in chains():
        print("########## %s" % chain, flush=True)
        passed, failed = verify(chain, argv, env)
        if failed:
            rc = 1
    return rc

if __name__ == "__main__":
    sys.exit(main())
