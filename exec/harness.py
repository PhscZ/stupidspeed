#!/usr/bin/env python3
"""StupidSpeed test harness -- runs every built program in `exec/` and measures it.

The registry at `exec/cells.json` says how to run each cell: one entry per
(row, toolchain) giving the exact argv, working directory, environment and
timeout, plus the file whose size is the cell's "program size".  The recipes are
transcribed from each row's own `exec/<row>/verify.py`, which stays the
authority on how a row is built and run.

For every cell the harness runs the program once as a warmup and then `--runs`
times (default 5), and records

  speed      the program's own `TIME_MS` line -- the benchmark contract, which
             brackets only the task's own work -- and, beside it, the harness's
             end-to-end wall clock, which includes process start-up
  memory     the peak working set of the child process
  file size  the built program's size, and the size of the `out.bin` task 15 wrote

`--runs 1` runs the whole suite once, `--runs 5` (the default) five times, and so
on.  The median of the timed runs is reported next to the minimum, maximum and
standard deviation.

Nothing is piped to a terminal: stdout goes to a file or the null device and
stderr to a file, because writing a line to a console can cost more than the
whole benchmark (see RUN.md).  Cells run one at a time, each pinned to a single
core -- four for task 11 -- and the working tree is left exactly as it was found.

Usage
    python exec/harness.py                        # every cell, 5 timed runs
    python exec/harness.py --runs 1                # one pass over the matrix
    python exec/harness.py --runs 3 --rows c,rust  # just those rows
    python exec/harness.py --tasks 01,07           # just those tasks
    python exec/harness.py --check                 # warmup only: pass/fail, no timing
    python exec/harness.py --list                  # print the cells, run nothing
    python exec/harness.py --validate              # check cells.json without running

Results land in `exec/results.json` (every sample) and `exec/results.md` (the
three tables: speed, peak memory, program size).
"""
import argparse
import ctypes
import json
import os
import re
import shutil
import statistics
import subprocess
import sys
import tempfile
import time

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
# Forward slashes: Windows accepts them everywhere, and the registry's paths mix
# `{root}` with the verifiers' own separators.
ROOT_FWD = ROOT.replace("\\", "/")
REGISTRY = os.path.join(HERE, "cells.json")
DATA = os.path.join(ROOT, "data.bin")

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]
# The fifteen answers, identical in every row (the verifiers read them from the
# sources; they are pinned here so the harness needs no source parsing).
EXPECTED = {
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
TIME_RE = re.compile(r"TIME_MS=([0-9]+(?:\.[0-9]+)?(?:[eE][+-]?[0-9]+)?)")
DEFAULT_TIMEOUT = 900


# ---------------------------------------------------------------- peak memory

if os.name == "nt":
    class _PMC(ctypes.Structure):
        _fields_ = [
            ("cb", ctypes.c_ulong),
            ("PageFaultCount", ctypes.c_ulong),
            ("PeakWorkingSetSize", ctypes.c_size_t),
            ("WorkingSetSize", ctypes.c_size_t),
            ("QuotaPeakPagedPoolUsage", ctypes.c_size_t),
            ("QuotaPagedPoolUsage", ctypes.c_size_t),
            ("QuotaPeakNonPagedPoolUsage", ctypes.c_size_t),
            ("QuotaNonPagedPoolUsage", ctypes.c_size_t),
            ("PagefileUsage", ctypes.c_size_t),
            ("PeakPagefileUsage", ctypes.c_size_t),
        ]

    def _load(name):
        try:
            return ctypes.WinDLL(name)
        except OSError:
            return None

    _PSAPI = _load("psapi") or _load("kernel32")
    _KERNEL32 = _load("kernel32")

    # A row that dies in teardown must not put a crash dialog on the screen of
    # an unattended run, and Windows Error Reporting's handling of it costs
    # seconds that would land in the wall clock.  The mode is inherited by every
    # child, so setting it once here covers them all: no GP-fault error box, no
    # critical-error box, no "file not found" box.
    SEM_FAILCRITICALERRORS = 0x0001
    SEM_NOGPFAULTERRORBOX = 0x0002
    SEM_NOOPENFILEERRORBOX = 0x8000
    if _KERNEL32 is not None:
        try:
            _KERNEL32.SetErrorMode(SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX
                                   | SEM_NOOPENFILEERRORBOX)
        except OSError:
            pass

    def peak_memory(proc):
        """PeakWorkingSetSize of the child, in bytes, read from its live handle."""
        if _PSAPI is None or proc._handle is None:
            return None
        counters = _PMC()
        counters.cb = ctypes.sizeof(counters)
        try:
            ok = _PSAPI.GetProcessMemoryInfo(
                ctypes.c_void_p(int(proc._handle)), ctypes.byref(counters), counters.cb
            )
        except OSError:
            return None
        return int(counters.PeakWorkingSetSize) if ok else None
else:
    import resource

    _KERNEL32 = None

    def peak_memory(proc):
        """Best effort on POSIX: the largest child peak seen so far."""
        try:
            return int(resource.getrusage(resource.RUSAGE_CHILDREN).ru_maxrss) * 1024
        except (ValueError, OSError):
            return None


# ------------------------------------------------------------------- registry

def load_registry(path):
    """The task list and the per-row run recipes.

    The fifteen expected answers are pinned above rather than read from the
    registry: they are the same in every row, and the rows' verifiers read them
    from their own source headers, so a copy in the registry could only drift.
    """
    with open(path, encoding="utf-8") as fh:
        reg = json.load(fh)
    return reg.get("tasks", TASKS), reg["rows"]


def expand(rows, tasks):
    """Flatten the registry into cells: one (row, toolchain, task) each.

    Coverage is filled per toolchain: an entry with explicit `tasks` claims those
    and an entry with ["*"] fills that toolchain's remainder, minus any listed in
    `except`.  A toolchain that runs all fifteen tasks therefore needs one
    ["*"] entry, and a toolchain that special-cases a task (wasm thread flags,
    a directory preopen) adds an entry naming it.

    A row may also split its tasks across toolchains, which is what `except` is
    for: the luau row runs luau.exe for twelve tasks and Lute for the three that
    need file I/O or processes, so the Lute entry names those three and the luau
    entry is ["*"] with them in `except`.  Several toolchains covering the same
    tasks is normal -- the C row is four compilers running the same fifteen
    programs -- so the only row-level rule is that no task is left uncovered.
    """
    cells = []
    for row in sorted(rows):
        entries = rows[row]["entries"]
        lang = rows[row].get("language", row)
        toolchains = []
        for e in entries:
            if e["toolchain"] not in toolchains:
                toolchains.append(e["toolchain"])
        covered = {}
        for tc in toolchains:
            claimed = {}
            excepted = set()
            for e in entries:
                if e["toolchain"] != tc:
                    continue
                excepted.update(e.get("except", ()))
                for t in e["tasks"]:
                    if t == "*":
                        continue
                    if t not in tasks:
                        raise SystemExit("%s/%s: unknown task %r" % (row, tc, t))
                    if t in claimed:
                        raise SystemExit("%s/%s: task %s claimed twice" % (row, tc, t))
                    claimed[t] = e
            for e in entries:
                if e["toolchain"] != tc or "*" not in e["tasks"]:
                    continue
                for t in tasks:
                    if t in excepted or t in claimed:
                        continue
                    claimed[t] = e
            for t in tasks:
                if t in claimed:
                    covered.setdefault(t, []).append(tc)
                    cells.append((row, tc, t, claimed[t], lang))
        for t in tasks:
            if t not in covered:
                raise SystemExit("%s: no toolchain covers %s" % (row, t))
    return cells


def norm(value):
    """Give a filesystem path native separators.

    `{root}` is substituted with forward slashes because Windows accepts them
    everywhere and the registry mixes them with the verifiers' own.  One thing
    does not: Unicon reads its own appended image through `argv[0]`, and a
    forward slash there dies with "can't read interpreter file header" (RUN.md).
    So the values that are paths -- the program, the working directory, the
    artifact -- are normalised, and the rest of the argv is left exactly as the
    row wrote it (`--dir=…::/` keeps its trailing slash, for one).
    """
    if os.name != "nt" or not isinstance(value, str):
        return value
    if not value or ("/" not in value and "\\" not in value):
        return value
    return os.path.normpath(value)


def fill(value, root, row, tc, task):
    if isinstance(value, str):
        out = (value.replace("{root}", root).replace("{row}", row)
               .replace("{toolchain}", tc).replace("{task}", task))
        # Rows that prepend to the inherited PATH (and the like) say so with
        # {PATH} / {env:NAME}; a literal value replaces the inherited variable.
        if "{PATH}" in out:
            out = out.replace("{PATH}", os.environ.get("PATH", ""))
        for name in re.findall(r"\{env:([A-Za-z_][A-Za-z0-9_]*)\}", out):
            out = out.replace("{env:%s}" % name, os.environ.get(name, ""))
        return out
    if isinstance(value, list):
        return [fill(v, root, row, tc, task) for v in value]
    if isinstance(value, dict):
        return {k: fill(v, root, row, tc, task) for k, v in value.items()}
    return value


# ------------------------------------------------------------------- affinity

def cpu_count():
    try:
        return os.cpu_count() or 1
    except (ValueError, OSError):
        return 1


def affinity_mask(task, cpu, cores):
    """The logical CPUs a cell may run on: one, or four for task 11."""
    n = cpu_count()
    if task == "11_parallel_sum":
        want = [(cpu + i) % n for i in range(max(1, cores))]
    else:
        want = [cpu % n]
    mask = 0
    for c in want:
        mask |= 1 << c
    return want, mask


def _set_affinity(mask):
    if os.name == "nt":
        if _KERNEL32 is None:
            return False
        try:
            return bool(_KERNEL32.SetProcessAffinityMask(
                _KERNEL32.GetCurrentProcess(), ctypes.c_size_t(mask)))
        except OSError:
            return False
    try:
        os.sched_setaffinity(0, {i for i in range(64) if mask >> i & 1})
        return True
    except (AttributeError, OSError):
        return False


def _get_affinity():
    if os.name == "nt":
        if _KERNEL32 is None:
            return None
        proc_mask = ctypes.c_size_t()
        sys_mask = ctypes.c_size_t()
        try:
            ok = _KERNEL32.GetProcessAffinityMask(
                _KERNEL32.GetCurrentProcess(), ctypes.byref(proc_mask),
                ctypes.byref(sys_mask))
        except OSError:
            return None
        return int(proc_mask.value) if ok else None
    try:
        return sum(1 << c for c in os.sched_getaffinity(0))
    except (AttributeError, OSError):
        return None


class pinned:
    """Pin the harness -- and therefore the child it starts -- to the cell's CPUs.

    The mask is set on this process and restored afterwards rather than on the
    child after it starts, because a child that inherits the mask is pinned from
    its very first instruction: setting it afterwards loses the start of a short
    cell to whatever core the scheduler picked.  Task 11 gets four CPUs, every
    other task one (README: "Everything pinned to one core, except task 11 which
    gets four").
    """

    def __init__(self, task, cpu, cores):
        self.enabled = cpu is not None and cpu >= 0
        self.cpus, self.mask = affinity_mask(task, cpu or 0, cores) if self.enabled else (None, 0)
        self.saved = None

    def __enter__(self):
        if self.enabled:
            self.saved = _get_affinity()
            if not _set_affinity(self.mask):
                self.cpus = None
        return self

    def __exit__(self, *exc):
        if self.enabled and self.saved is not None:
            _set_affinity(self.saved)
        return False


# ------------------------------------------------------------ tool resolution

_TOOL_INDEX = None

# Programs this checkout keeps somewhere other than where the row's verifier
# looks, hand-checked to be the same tool: the layout differs, the tool does not.
# Consulted only when the registered path is missing, so the registry stays a
# faithful transcription of the verifiers and a machine that installs a tool
# where BUILD.md says needs no entry here.
ALIASES = {
    "{root}/tools/dyalog/tree/ProgramFiles64Folder/Dyalog/Dyalog APL-64 20.0 Unicode/dyascript.exe":
        "{root}/tools/dyalog/dyascript.exe",
    "{root}/tools/lua/lua54.exe": "{root}/tools/lua/bin/lua.exe",
    "{root}/tools/ring/ring/bin/ring.exe": "{root}/tools/ring/bin/ring.exe",
    "{root}/tools/terra/bin/terra.exe":
        "{root}/tools/terra/terra-Windows-x86_64-bb02b25/bin/terra.exe",
}


def _tool_index():
    """basename -> paths under tools/ and exec/, built once, on first miss."""
    global _TOOL_INDEX
    if _TOOL_INDEX is None:
        index = {}
        for top in ("tools", "exec"):
            for dirpath, _dirs, names in os.walk(os.path.join(ROOT, top)):
                for name in names:
                    index.setdefault(name.lower(), []).append(
                        os.path.join(dirpath, name).replace("\\", "/"))
        _TOOL_INDEX = index
    return _TOOL_INDEX


def resolve_program(path):
    """Find a registered program that this checkout keeps somewhere else.

    The registry records the path each row's verifier uses, which is the path
    that row was built and validated against.  A different install layout puts
    the same file a directory deeper -- wasmtime is extracted into a
    version-named directory, for one -- so a missing program is looked for under
    tools/ and exec/ by basename, accepting only a single candidate that keeps
    the registered path's directory components.  Nothing else is guessed at: an
    absent toolchain stays absent and the cell is skipped.
    """
    if os.path.exists(path) or os.sep not in path and "/" not in path:
        return path
    alias = ALIASES.get(path.replace(ROOT, "{root}").replace(ROOT_FWD, "{root}"))
    if alias:
        candidate = alias.replace("{root}", ROOT_FWD)
        if os.path.exists(candidate):
            return candidate
    base = os.path.basename(path.replace("\\", "/")).lower()
    want = [p for p in path.replace("\\", "/").lower().split("/") if p and p != ".."]
    want = want[1:-1] if want and want[0].endswith(":") else want[:-1]
    hits = []
    for cand in _tool_index().get(base, []):
        it = iter([p for p in cand.lower().split("/") if p])
        if all(any(c == w for c in it) for w in want):
            hits.append(cand)
    if len(hits) == 1:
        return hits[0]
    return path


# ------------------------------------------------------------------ execution

def kill_tree(proc):
    if proc.poll() is None:
        if os.name == "nt":
            subprocess.run(["taskkill", "/F", "/T", "/PID", str(proc.pid)],
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        else:
            proc.kill()
    try:
        proc.wait(timeout=30)
    except subprocess.TimeoutExpired:
        pass


def spawn(cmd, cwd, env, timeout, capture_stdout=False, pin_to=None):
    """Run one process to completion, killing the tree on timeout.

    Returns (wall_ms, peak_bytes, exit, timed_out, stdout, stderr, cpus); stdout
    is empty unless `capture_stdout`, and `cpus` is the CPU list the child ran
    on, or None.  Raises OSError when the program cannot be started at all -- an
    absent toolchain, which is a fact about the machine and not a failed cell.
    """
    if cmd and cmd[0].lower().endswith((".bat", ".cmd")):
        cmd = ["cmd.exe", "/c"] + cmd
    aff = pinned(*pin_to) if pin_to else pinned(None, -1, 0)
    with aff:
        t0 = time.perf_counter()
        with tempfile.TemporaryFile() as out, tempfile.TemporaryFile() as err, \
                open(os.devnull, "wb") as devnull:
            sink = out if capture_stdout else devnull
            proc = subprocess.Popen(cmd, cwd=cwd, env=env, stdout=sink, stderr=err,
                                    stdin=subprocess.DEVNULL)
            try:
                proc.wait(timeout=timeout)
                timed_out = False
            except subprocess.TimeoutExpired:
                timed_out = True
                kill_tree(proc)
            wall_ms = (time.perf_counter() - t0) * 1000.0
            peak = peak_memory(proc)
            err.seek(0)
            stderr = err.read().decode("utf-8", "replace")
            stdout = ""
            if capture_stdout:
                out.seek(0)
                stdout = out.read().decode("utf-8", "replace")
            code = proc.returncode
    return wall_ms, peak, code, timed_out, stdout, stderr, aff.cpus


def run_once(cmd, cwd, env, timeout, pin_to=None):
    """One timed run.  stdout is discarded, stderr goes to a file.

    The child's stdout is never a terminal (RUN.md: a console write can cost
    more than the whole benchmark), and its stderr is a file so a chatty runtime
    cannot fill a pipe and deadlock the run.
    """
    wall_ms, peak, code, timed_out, _stdout, stderr, cpus = spawn(
        cmd, cwd, env, timeout, pin_to=pin_to)
    return {
        "wall_ms": wall_ms,
        "peak_bytes": peak,
        "stderr": stderr,
        "exit": code,
        "timeout": timed_out,
        "cpus": cpus,
    }


def read_time_ms(stderr, cwd, time_file=None):
    """The contract: TIME_MS on stderr, or in time.txt for rows with no stderr.

    `time_file` overrides where the fallback lives -- AIR keeps it in its own
    application-storage directory, so it is not in the working directory at all.
    """
    m = None
    for m in TIME_RE.finditer(stderr):
        pass
    if m:
        return float(m.group(1)), "stderr"
    path = time_file or os.path.join(cwd, "time.txt")
    if os.path.exists(path):
        try:
            with open(path, encoding="utf-8", errors="replace") as fh:
                text = fh.read()
        except OSError:
            return None, None
        m = None
        for m in TIME_RE.finditer(text):
            pass
        if m:
            return float(m.group(1)), "time.txt"
    return None, None


def stdout_matches(got, expected):
    got = got.strip()
    if got == expected:
        return True
    lines = [ln.strip() for ln in got.splitlines() if ln.strip()]
    return bool(lines) and lines[-1] == expected


def reset(cwd, entry, row, tc, task, time_file):
    """Clear what the row verifiers clear before a run.

    Task 15's answer, the row's own `clean` list, and any timing fallback file.
    This has to happen before *every* run, not once per cell: several task-15
    programs fail outright when `out.bin` is already there (they create it
    exclusively), and a stale `time.txt` would otherwise be read as this run's
    number -- which is exactly the trap the luau row's verifier deletes it for.
    """
    paths = [fill(p, ROOT_FWD, row, tc, task) for p in entry.get("clean", [])]
    # A bare name (dolphin and lobster list `time.txt`) is relative to the cell.
    paths = [norm(p if os.path.isabs(p) else os.path.join(cwd, p)) for p in paths]
    paths.append(time_file or os.path.join(cwd, "time.txt"))
    if task == "15_file_write":
        paths.append(os.path.join(cwd, "out.bin"))
    for path in paths:
        try:
            if os.path.exists(path):
                os.remove(path)
        except OSError:
            pass


def snapshot(path):
    """Remember a file so the tree can be left exactly as it was found."""
    try:
        with open(path, "rb") as fh:
            return fh.read()
    except OSError:
        return None


def restore(path, blob):
    """Put a snapshot back: rewrite it, or delete the file if it was not there."""
    try:
        if blob is None:
            if os.path.exists(path):
                os.remove(path)
        else:
            with open(path, "wb") as fh:
                fh.write(blob)
    except OSError:
        pass


def measure(cell, runs, warmup, timeout_override, check_only, cpu=3, cores=4):
    """Measure one cell, leaving the working tree as it was found.

    A row with no reachable stderr reports its timing through a file in the
    working directory, and several of those files -- and task 15's `out.bin` --
    are committed.  Both are results, so both are put back once the cell is
    done, whether it measured, was skipped, or failed: a run leaves `exec/`
    exactly as it found it.
    """
    row, tc, task, entry, lang = cell
    cwd = norm(fill(entry["cwd"], ROOT_FWD, row, tc, task))
    watch = [norm(fill(entry["time_file"], ROOT_FWD, row, tc, task))
             if entry.get("time_file") else os.path.join(cwd, "time.txt")]
    if task == "15_file_write":
        watch.append(os.path.join(cwd, "out.bin"))
    saved = [(path, snapshot(path)) for path in watch]
    try:
        return _measure(cell, runs, warmup, timeout_override, check_only, cpu, cores)
    finally:
        for path, blob in saved:
            restore(path, blob)


def _measure(cell, runs, warmup, timeout_override, check_only, cpu=3, cores=4):
    row, tc, task, entry, lang = cell
    cmd = fill(entry["cmd"], ROOT_FWD, row, tc, task)
    registered = cmd[0] if cmd else ""
    if cmd:
        cmd[0] = norm(resolve_program(cmd[0]))
    cwd = norm(fill(entry["cwd"], ROOT_FWD, row, tc, task))
    env = dict(os.environ)
    env.update({k: fill(v, ROOT_FWD, row, tc, task)
                for k, v in entry.get("env", {}).items()})
    timeout = timeout_override or entry.get("timeouts", {}).get(task) or entry.get("timeout") \
        or DEFAULT_TIMEOUT
    artifact = norm(fill(entry.get("artifact", ""), ROOT_FWD, row, tc, task))
    time_file = (norm(fill(entry["time_file"], ROOT_FWD, row, tc, task))
                 if entry.get("time_file") else None)
    pin_to = None if cpu is None or cpu < 0 else (task, cpu, cores)

    result = {"row": row, "language": lang, "toolchain": tc, "task": task,
              "status": "OK", "cmd": cmd, "cwd": cwd, "samples": [], "warmup": None,
              "artifact_bytes": None, "out_bytes": None, "timeout_s": timeout}
    if cmd and cmd[0] != registered:
        result["resolved_program"] = cmd[0]

    def fail(status, message):
        result["status"] = status
        result["error"] = message
        return result

    def note(message):
        """Record something a reader has to know that is not a failed cell."""
        if message not in result.setdefault("warnings", []):
            result["warnings"].append(message)

    if not os.path.isdir(cwd):
        return fail("ERROR", "working directory does not exist: %s" % cwd)

    # Fixture, exactly as the row verifiers stage it: task 14 reads the 50 MiB
    # file from its working directory, so it is put there when it is missing --
    # and replaced when what is there is not the fixture's size, which is how the
    # verifiers keep a stale copy from being read as this run's input.  Task 15
    # is not staged: no task-15 program reads it (RUN.md's `--prune` note), and
    # copying 50 MiB into every task-15 directory would be pure waste.
    if task == "14_file_read":
        dest = os.path.join(cwd, "data.bin")
        try:
            fresh = os.path.getsize(dest) == os.path.getsize(DATA)
        except OSError:
            fresh = False
        if not fresh:
            try:
                shutil.copy(DATA, dest)
            except OSError as exc:
                return fail("ERROR", "cannot stage data.bin: %s" % exc)

    if artifact:
        try:
            result["artifact_bytes"] = os.path.getsize(artifact)
        except OSError:
            pass

    # ---- warmup: correctness and the TIME_MS path; its number is thrown away
    for _ in range(warmup):
        reset(cwd, entry, row, tc, task, time_file)
        try:
            wall_ms, peak, code, timed_out, got, stderr, cpus = spawn(
                cmd, cwd, env, timeout, capture_stdout=True, pin_to=pin_to)
        except OSError as exc:
            return fail("SKIP", "cannot start %s: %s" % (cmd[0], exc))
        time_ms, source = read_time_ms(stderr, cwd, time_file)
        result["warmup"] = {"wall_ms": wall_ms, "peak_bytes": peak, "exit": code,
                            "timeout": timed_out, "time_ms": time_ms, "source": source,
                            "cpus": cpus, "stdout": got.strip()[:4000]}
        if timed_out:
            return fail("ERROR", "warmup timed out after %gs" % timeout)
        # The published criterion is the answer, the timing line and task 15's
        # file -- not the exit code.  A row may die in teardown after printing
        # both (hxcpp does, with a heap-corruption code) or after its final
        # statement, which is outside the bracketed region either way; that is
        # recorded and surfaced, not treated as a failed cell.
        if code != 0:
            note("exit code %s on the warmup run (stderr: %s)"
                 % (code, stderr.strip()[-200:].replace("\n", " | ")))
        if not stdout_matches(got, EXPECTED[task]):
            # `WRONG` means the program ran and answered differently, which is a
            # fact about the language.  A non-zero exit with the wrong (or no)
            # answer is a fact about this machine: a missing runtime, a missing
            # jar, a binary built for a different CPU.  The two must not be
            # reported the same way.  Two load-failure codes mean a runtime the
            # toolchain needs is not installed, which is the same kind of fact as
            # an absent toolchain and is reported as a skip.
            if code != 0:
                # Some rows explain themselves on stdout, not stderr (the AIR
                # runtime prints its licence refusal there), so quote whichever
                # stream said something.
                detail = (stderr.strip() or got.strip())[-200:].replace("\n", " | ")
                if code in (0xC0000135, 0xC0000142, 0x80008083):
                    return fail("SKIP", "a runtime it needs is not installed "
                                "(exit code 0x%08X)" % code)
                return fail("ERROR", "did not run to completion (exit code %s = 0x%08X): %s"
                            % (code, code, detail or "no stderr"))
            return fail("WRONG", "stdout %r != expected %r"
                        % (got.strip()[:200], EXPECTED[task]))

    if check_only:
        return result

    # ---- timed runs
    for _ in range(runs):
        reset(cwd, entry, row, tc, task, time_file)
        try:
            rec = run_once(cmd, cwd, env, timeout, pin_to=pin_to)
        except OSError as exc:
            return fail("SKIP", "cannot start %s: %s" % (cmd[0], exc))
        time_ms, source = read_time_ms(rec.pop("stderr"), cwd, time_file)
        if rec["timeout"]:
            return fail("ERROR", "timed out after %gs" % timeout)
        if time_ms is None and rec["exit"] != 0:
            # Died without producing either number: no usable sample.
            note("run %d produced nothing (exit code %s)" % (len(result["samples"]) + 1,
                                                             rec["exit"]))
            continue
        if rec["exit"] != 0:
            note("exit code %s on a timed run" % rec["exit"])
        rec["time_ms"] = time_ms
        rec["time_source"] = source
        rec["speed_ms"] = time_ms if time_ms is not None else rec["wall_ms"]
        rec["self_timed"] = time_ms is not None
        result["samples"].append(rec)

    if not result["samples"]:
        return fail("ERROR", "no run produced a usable measurement")

    # Task 15's side effect, at the size the row verifiers require.
    if task == "15_file_write":
        out_bin = os.path.join(cwd, "out.bin")
        if os.path.exists(out_bin):
            result["out_bytes"] = os.path.getsize(out_bin)
            if result["out_bytes"] != 52428800:
                note("out.bin is %d bytes, not 52428800" % result["out_bytes"])
        else:
            note("task 15 left no out.bin")

    speeds = [s["speed_ms"] for s in result["samples"]]
    walls = [s["wall_ms"] for s in result["samples"]]
    peaks = [s["peak_bytes"] for s in result["samples"] if s["peak_bytes"]]
    if speeds:
        result["median_ms"] = statistics.median(speeds)
        result["min_ms"] = min(speeds)
        result["max_ms"] = max(speeds)
        result["stdev_ms"] = statistics.stdev(speeds) if len(speeds) > 1 else 0.0
        result["self_timed"] = all(s["self_timed"] for s in result["samples"])
    if walls:
        result["median_wall_ms"] = statistics.median(walls)
    if peaks:
        result["peak_bytes"] = max(peaks)
    return result


# ------------------------------------------------------------------ reporting

def fmt_ms(v):
    if v is None:
        return ""
    if v >= 10000:
        return "%.0f" % v
    if v >= 100:
        return "%.1f" % v
    return "%.2f" % v


def fmt_bytes(v, unit=1024.0, suffix="KiB"):
    if v is None:
        return ""
    if unit == 1024.0 and v >= 1024 * 1024:
        return "%.1f MiB" % (v / (1024.0 * 1024))
    return "%.1f %s" % (v / unit, suffix)


def print_cell(r, check=False):
    label = "%s/%s %s" % (r["row"], r["toolchain"], r["task"])
    if r["status"] == "SKIP":
        print("%-40s SKIP: %s" % (label, r.get("error", "")), flush=True)
    elif r["status"] != "OK":
        print("%-40s %s: %s" % (label, r["status"], r.get("error", "")), flush=True)
    elif check:
        w = r.get("warmup") or {}
        print("%-40s OK  warmup %8s ms  mem %10s  size %10s%s" % (
            label, fmt_ms(w.get("wall_ms")), fmt_bytes(w.get("peak_bytes")),
            fmt_bytes(r.get("artifact_bytes")), "  !" if r.get("warnings") else ""),
            flush=True)
    else:
        speed = fmt_ms(r.get("median_ms"))
        kind = "" if r.get("self_timed") else "*"
        print("%-40s %10s%s ms  wall %9s ms  mem %10s  size %10s%s" % (
            label, speed, kind, fmt_ms(r.get("median_wall_ms")),
            fmt_bytes(r.get("peak_bytes")), fmt_bytes(r.get("artifact_bytes")),
            "  !" if r.get("warnings") else ""), flush=True)


def write_json(path, cells, runs, warmup, cpu=None, cores=4):
    doc = {
        "generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "root": ROOT,
        "runs": runs,
        "warmup": warmup,
        "pinned_cpu": cpu,
        "task11_cores": cores,
        "cells": cells,
    }
    with open(path, "w", encoding="utf-8") as fh:
        json.dump(doc, fh, indent=1)
        fh.write("\n")


def _table(rows_order, cells, value, fmt):
    index = {(c["row"], c["toolchain"], c["task"]): c for c in cells}
    head = "| Language | Toolchain | " + " | ".join(t[:2] for t in TASKS) + " |"
    sep = "|" + "---|" * (len(TASKS) + 2)
    lines = [head, sep]
    for row, tc, lang in rows_order:
        vals = []
        for t in TASKS:
            c = index.get((row, tc, t))
            vals.append(fmt(value(c)) if c and c["status"] == "OK" else "")
        lines.append("| %s | %s | %s |" % (lang, tc, " | ".join(vals)))
    return "\n".join(lines)


def write_md(path, cells, runs, warmup, check=False, cpu=None):
    order = []
    for c in cells:
        key = (c["row"], c["toolchain"], c.get("language", c["row"]))
        if key not in order:
            order.append(key)
    ok = sum(1 for c in cells if c["status"] == "OK")
    skipped = [c for c in cells if c["status"] == "SKIP"]
    bad = [c for c in cells if c["status"] not in ("OK", "SKIP")]
    # Task 15's side effect, as the row verifiers check it.
    writers = [c for c in cells if c["task"] == "15_file_write" and c["status"] == "OK"]
    wrote = [c for c in writers if c.get("out_bytes") == 52428800]
    pinned = "no pinning" if cpu is None else "pinned to CPU %d" % cpu
    if check:
        parts = [
            "# StUpIdSpEeD harness check",
            "",
            "Warmup only, no timing: %d cells checked, %d skipped (toolchain not "
            "installed), %d failed.  Generated %s by `exec/harness.py --check`, %s."
            % (ok, len(skipped), len(bad), time.strftime("%Y-%m-%d %H:%M"), pinned),
            "",
        ]
    else:
        parts = [
            "# StUpIdSpEeD results",
            "",
            "%d cells, %d timed runs each (plus %d warmup).  Generated %s by "
            "`exec/harness.py`, %s."
            % (len(cells), runs, warmup, time.strftime("%Y-%m-%d %H:%M"), pinned),
            "",
            "%d cells measured, %d skipped (toolchain not installed), %d failed."
            % (ok, len(skipped), len(bad)),
            "",
            "%d of %d task-15 cells wrote a 52428800-byte `out.bin`."
            % (len(wrote), len(writers)),
            "",
            "## Speed -- median `TIME_MS`, in milliseconds",
            "",
            "The program times its own work, so start-up is outside the number.  A "
            "cell marked `*` in the console output has no `TIME_MS` line at all (the "
            "luau CLI cells, by design), so its end-to-end wall clock is the number "
            "here instead.",
            "",
            _table(order, cells, lambda c: c.get("median_ms"), fmt_ms),
            "",
            "## Peak memory -- peak working set of the child process",
            "",
            _table(order, cells, lambda c: c.get("peak_bytes"), lambda v: fmt_bytes(v, 1024.0)),
            "",
            "## Program size -- the built artifact (or, for interpreted rows, the script)",
            "",
            _table(order, cells, lambda c: c.get("artifact_bytes"), lambda v: fmt_bytes(v, 1024.0)),
            "",
        ]
    if bad:
        parts += ["## Cells that failed", ""]
        for c in bad:
            parts.append("- `%s/%s %s` -- %s: %s" % (
                c["row"], c["toolchain"], c["task"], c["status"], c.get("error", "")))
        parts.append("")
    warned = [c for c in cells if c.get("warnings") and c["status"] == "OK"]
    if warned:
        parts += [
            "## Cells measured, with something to know about them",
            "",
            "Marked `!` on the console. These measured; the note is about how the "
            "run behaved, not about the number.",
            "",
        ]
        for c in warned:
            parts.append("- `%s/%s %s` -- %s" % (
                c["row"], c["toolchain"], c["task"], "; ".join(c["warnings"])))
        parts.append("")
    if skipped:
        parts += ["## Cells skipped -- the toolchain is not installed on this machine", ""]
        seen = []
        for c in skipped:
            key = (c["row"], c["toolchain"])
            if key not in seen:
                seen.append(key)
                parts.append("- `%s/%s`" % key)
        parts.append("")
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(parts) + "\n")


# ----------------------------------------------------------------------- main

def validate(rows, tasks):
    problems = []
    for row in sorted(rows):
        entries = rows[row]["entries"]
        if not entries:
            problems.append("%s: no entries" % row)
            continue
        for e in entries:
            for key in ("toolchain", "tasks", "cmd", "cwd", "artifact"):
                if key not in e:
                    problems.append("%s/%s: missing %r" % (row, e.get("toolchain", "?"), key))
            if not isinstance(e.get("cmd"), list) or not e.get("cmd"):
                problems.append("%s/%s: cmd must be a non-empty list" % (row, e.get("toolchain")))
            for t in e.get("tasks", []):
                if t != "*" and t not in tasks:
                    problems.append("%s/%s: unknown task %r" % (row, e.get("toolchain"), t))
    try:
        cells = expand(rows, tasks)
    except SystemExit as exc:
        problems.append(str(exc))
        cells = []
    return problems, cells


def task_selected(task, wants):
    """Does `--tasks` name this task?

    Accepts the number (`01` or `1`), the name (`branches`) or the whole cell
    name (`01_branches`) -- and nothing looser, so `--tasks 1` does not also
    pick up 10, 11 and 12.
    """
    num, _, name = task.partition("_")
    for want in wants:
        if want == task or want == num or want == name:
            return True
        if want.isdigit() and want.lstrip("0") == num.lstrip("0"):
            return True
    return False


def main():
    ap = argparse.ArgumentParser(description="Run every built program in exec/ and measure it.")
    ap.add_argument("--runs", type=int, default=5,
                    help="timed runs per cell (default 5); --runs 1 runs the whole "
                         "suite once, --runs 3 three times")
    ap.add_argument("--warmup", type=int, default=1, help="warmup runs per cell (default 1)")
    ap.add_argument("--rows", default="", help="comma-separated rows to run (default all)")
    ap.add_argument("--tasks", default="", help="comma-separated task numbers or names")
    ap.add_argument("--timeout", type=float, default=0, help="override every per-cell timeout")
    ap.add_argument("--cpu", type=int, default=3,
                    help="logical CPU every cell is pinned to (default 3, i.e. "
                         "`start /affinity 8`); -1 to disable pinning")
    ap.add_argument("--cores", type=int, default=4,
                    help="logical CPUs task 11 gets, from --cpu upward (default 4)")
    ap.add_argument("--registry", default=REGISTRY, help="cell registry (default exec/cells.json)")
    ap.add_argument("--json", default=os.path.join(HERE, "results.json"))
    ap.add_argument("--md", default=os.path.join(HERE, "results.md"))
    ap.add_argument("--check", action="store_true", help="warmup only: pass/fail, no timing")
    ap.add_argument("--list", action="store_true", help="print the cells and exit")
    ap.add_argument("--validate", action="store_true", help="check the registry and exit")
    args = ap.parse_args()
    if args.runs < 1 and not args.check:
        ap.error("--runs must be at least 1")

    tasks, rows = load_registry(args.registry)
    problems, all_cells = validate(rows, tasks)
    if args.validate:
        for p in problems:
            print("PROBLEM %s" % p)
        print("rows=%d cells=%d problems=%d" % (len(rows), len(all_cells), len(problems)))
        return 1 if problems else 0

    want_rows = [r.strip() for r in args.rows.split(",") if r.strip()]
    want_tasks = [t.strip() for t in args.tasks.split(",") if t.strip()]
    cells = []
    for cell in all_cells:
        row, tc, task, _e, _lang = cell
        if want_rows and row not in want_rows:
            continue
        # `--tasks 01`, `--tasks 1` and `--tasks branches` all select 01_branches.
        if want_tasks and not task_selected(task, want_tasks):
            continue
        cells.append(cell)

    if args.list:
        for row, tc, task, _e, _lang in cells:
            print("%s\t%s\t%s" % (row, tc, task))
        print("%d cells" % len(cells))
        return 0

    if not cells:
        print("no cells selected", file=sys.stderr)
        return 1

    cpu = None if args.cpu < 0 else args.cpu
    print("%d cells: %s, pinned to CPU %s%s" % (
        len(cells),
        "warmup only (--check)" if args.check
        else "%d timed runs each, %d warmup" % (args.runs, args.warmup),
        "none" if cpu is None else cpu,
        "" if cpu is None else " (task 11 gets %d)" % args.cores), flush=True)
    results = []
    try:
        for cell in cells:
            r = measure(cell, args.runs, args.warmup, args.timeout, args.check,
                        cpu if cpu is not None else -1, args.cores)
            results.append(r)
            print_cell(r, args.check)
    except KeyboardInterrupt:
        print("\ninterrupted; writing partial results", file=sys.stderr)

    write_json(args.json, results, args.runs, args.warmup, cpu, args.cores)
    write_md(args.md, results, args.runs, args.warmup, args.check, cpu)
    ok = sum(1 for r in results if r["status"] == "OK")
    skipped = sum(1 for r in results if r["status"] == "SKIP")
    bad = len(results) - ok - skipped
    print("%d measured, %d skipped, %d failed; wrote %s and %s"
          % (ok, skipped, bad, args.json, args.md), flush=True)
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (BrokenPipeError, OSError) as exc:
        # Piped into `head` or the like: the reader is gone.  Windows reports
        # this as OSError EINVAL (22) rather than BrokenPipeError.
        if isinstance(exc, BrokenPipeError) or exc.errno in (22, 32):
            os.dup2(os.open(os.devnull, os.O_WRONLY), sys.stdout.fileno())
            sys.exit(0)
        raise
    except KeyboardInterrupt:
        sys.exit(130)
