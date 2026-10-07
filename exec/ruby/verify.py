#!/usr/bin/env python3
"""Verify the ruby row: no build step, run each task from exec/ruby/<toolchain>/<task>/.

Two toolchains, reported separately:

  cruby-yjit  tools\\ruby\\bin\\ruby.exe --yjit <task>.rb
  jruby       tools\\jruby\\bin\\jruby.bat <task>.rb   (needs Java 25 -> JAVA_HOME=tools\\graalvm)

Each task prints one expected stdout line and TIME_MS=<ms> on stderr (the row header says so;
there is no time.txt fallback here).  Task 15 must also leave out.bin behind.
"""
import os
import re
import shutil
import subprocess
import sys

ROW = "ruby"
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
SRC = os.path.join(ROOT, "sources", ROW)

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]

# header run: lines -> `ruby --yjit <task>.rb` / `jruby <task>.rb`
CRUBY = os.path.join(ROOT, "tools", "ruby", "bin", "ruby.exe")
JRUBY = os.path.join(ROOT, "tools", "jruby", "bin", "jruby.bat")
GRAALVM_HOME = os.path.join(ROOT, "tools", "graalvm")

# task 09 is naive fib(40) (~331M calls) and 10 is 1000 digits of the Gibbons spigot;
# the perl row documents the same two as the slow ones.  Measured on this box while the
# sibling benchmark rows were loading all 8 cores: CRuby is quick everywhere, but JRuby's
# 13_matrix_mul took 626 s once and 1519 s under load, and 01/02/08 took 175-400 s.
# Everything else stays on the 600 s default.
TIMEOUTS = {
    ("cruby-yjit", "09_fib_recursive"): 1800,
    ("cruby-yjit", "10_pi"): 900,
    ("jruby", "01_branches"): 1200,
    ("jruby", "02_switch_case"): 1200,
    ("jruby", "08_average"): 1200,
    ("jruby", "09_fib_recursive"): 1800,
    ("jruby", "10_pi"): 900,
    ("jruby", "13_matrix_mul"): 3600,
}
DEFAULT_TIMEOUT = 600

TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?)")


def expected_output(task):
    with open(os.path.join(SRC, task + ".rb"), encoding="utf-8") as fh:
        first = fh.readline()
    m = re.search(r"expected output:\s*(.*?)\s*$", first)
    if not m:
        raise RuntimeError("no expected output in header of " + task)
    return m.group(1).strip()


def jruby_env():
    """JRuby 10 needs a modern JVM, and JAVA_HOME is the only lever that works.

    With the box's own environment, jruby.exe resolves a Java 8 (PATH carries the Oracle
    javapath and java8path JREs) and dies with "class file version 65.0 ... this version
    of the Java Runtime only recognizes class file versions up to 52.0".  Of the JDKs
    present, tools\\graalvm is 25.0.4 (what RUN.md's toolchain table names) and
    tools\\openj9 is 21.0.12; the Oracle javapath JRE is 24.  GraalVM 25 is pinned here.
    """
    env = dict(os.environ)
    env["JAVA_HOME"] = GRAALVM_HOME
    env["PATH"] = os.path.join(GRAALVM_HOME, "bin") + os.pathsep + env.get("PATH", "")
    return env


def chains():
    return [
        ("cruby-yjit", [CRUBY, "--yjit"], None),
        ("jruby", ["cmd", "/c", JRUBY], jruby_env()),
    ]


def run_task(cmd, cwd, env, timeout):
    """Run one task; return (returncode, stdout, stderr), or (None, ...) on timeout.

    A plain subprocess.run(timeout=...) is not enough here: the jruby launcher is
    jruby.bat -> jruby.exe -> java.exe, and the grandchild inherits the stdout/stderr
    pipes, so killing only the direct child leaves communicate() blocked on the pipe
    until java.exe exits on its own (measured: a 15 s timeout did not return for 300 s).
    Kill the whole tree with taskkill /T instead.
    """
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

    # one-time reachability probe so an absent interpreter reads as a clear failure
    try:
        probe = subprocess.run(argv + ["-v"],
                               capture_output=True, text=True, errors="replace",
                               env=env, timeout=300)
        print("### %s: %s" % (chain, (probe.stdout or probe.stderr).strip().splitlines()[0]
                              if (probe.stdout or probe.stderr).strip() else "no version output"),
              flush=True)
    except Exception as exc:  # noqa: BLE001 - report, do not die
        print("### %s: probe failed: %s" % (chain, exc), flush=True)

    # The row is named cruby+yjit, so say out loud whether YJIT is really on. The stock
    # Windows CRuby has no YJIT at all: --yjit only warns and the interpreter runs plain.
    yjit_state = None
    if chain == "cruby-yjit":
        try:
            jp = subprocess.run(argv + ["-e", "puts(defined?(RubyVM::YJIT) ? "
                                                  "RubyVM::YJIT.enabled? : 'NO_YJIT')"],
                                capture_output=True, text=True, errors="replace",
                                env=env, timeout=300)
            blob = (jp.stdout.strip() or jp.stderr.strip())
            yjit_state = blob.splitlines()[-1] if blob else "unknown"
            print("### %s: YJIT enabled? %s" % (chain, yjit_state), flush=True)
            if yjit_state != "true":
                print("### %s: BLOCKED as a YJIT row - this Ruby has no YJIT (upstream "
                      "supports it only on macOS/Linux/BSD). The 15/15 below is PLAIN CRuby "
                      "and must NOT be recorded as the cruby+yjit cell." % chain, flush=True)
        except Exception as exc:  # noqa: BLE001
            print("### %s: YJIT probe failed: %s" % (chain, exc), flush=True)

    for task in TASKS:
        workdir = os.path.join(outdir, task)
        exp = expected_output(task)
        timeout = TIMEOUTS.get((chain, task), DEFAULT_TIMEOUT)

        if not os.path.isdir(workdir):
            print("%s FAIL no such directory %s" % (task, workdir), flush=True)
            failed.append(task)
            continue
        if not os.path.exists(os.path.join(workdir, task + ".rb")):
            print("%s FAIL missing %s (run build_all.bat)" % (task, task + ".rb"), flush=True)
            failed.append(task)
            continue
        if task in ("14_file_read", "15_file_write"):
            if not os.path.exists(os.path.join(workdir, "data.bin")) or not os.path.samefile(os.path.join(ROOT, "data.bin"), os.path.join(workdir, "data.bin")): shutil.copyfile(os.path.join(ROOT, "data.bin"), os.path.join(workdir, "data.bin"))
        if task == "15_file_write":
            outbin = os.path.join(workdir, "out.bin")
            if os.path.exists(outbin):
                os.remove(outbin)

        cmd = argv + [task + ".rb"]
        rc, stdout, stderr = run_task(cmd, workdir, env, timeout)
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
    if chain == "cruby-yjit" and yjit_state != "true":
        print("%s %s NOTE: YJIT NOT ENABLED - the number above is plain CRuby, a fallback, "
              "not the cruby+yjit row" % (ROW, chain), flush=True)
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
