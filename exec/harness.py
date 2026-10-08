#!/usr/bin/env python3
"""StupidSpeed test harness -- runs every built program in `exec/` and measures it.

The registry at `exec/cells.json` says how to run each cell: one entry per
(row, toolchain) giving the exact argv, working directory, environment and
timeout, plus the file whose size is the cell's "program size".  The recipes are
transcribed from each row's own `exec/<row>/verify.py`, which stays the
authority on how a row is built and run.

For every cell the harness runs the program `--runs` times (default 5) and records

  speed      the program's own `TIME_MS` line -- the benchmark contract, which
             brackets only the task's own work -- and, beside it, the harness's
             end-to-end wall clock, which includes process start-up
  memory     the peak working set of the child process
  file size  the built program's size, and the size of the `out.bin` task 15 wrote

`--runs 1` runs the whole suite once, `--runs 5` (the default) five times, and so
on.  Every run counts: there is no discarded warmup, so the median of the timed
runs is taken over all of them.  The first run is also where the answer is
checked, so a cell that answers wrongly is reported as `WRONG` rather than
measured.

Every cell has a number -- its position in `--list` order, row then toolchain
then task -- and `--start`/`--end` take an inclusive slice of the matrix by that
number, so a long sweep can be run in chunks and resumed where it stopped.

Results are additive: each run merges into `exec/results.json` rather than
replacing it, so a cell measured again replaces its own older row and a cell not
run this time keeps the number it already had.  The file is written atomically
and flushed every `--flush-every` cells, so a sweep that is killed keeps what it
measured instead of losing the lot.  `--replace` starts the file over.

Nothing is piped to a terminal: stdout goes to a file or the null device and
stderr to a file, because writing a line to a console can cost more than the
whole benchmark (see RUN.md).  Cells run one at a time, each pinned to a single
core -- four for task 11 -- and the working tree is left exactly as it was found.

Usage
    python exec/harness.py                        # every cell, 5 timed runs
    python exec/harness.py --runs 1                # one pass over the matrix
    python exec/harness.py --runs 3 --rows c,rust  # just those rows
    python exec/harness.py --tasks 01,07           # just those tasks
    python exec/harness.py --start 1 --end 200     # items 1-200, by position
    python exec/harness.py --rows 1-30             # the first thirty languages
    python exec/harness.py --check                 # one run each: pass/fail, no timing
    python exec/harness.py --list                  # print the cells, run nothing
    python exec/harness.py --validate              # check cells.json without running

Results land in `exec/results.json` (every sample) and `exec/results.md` (the
three tables: speed, peak memory, program size).  `exec/plot.py` turns the JSON
into `exec/results.html`, the interactive chart.
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

    # Every one of these takes a HANDLE.  Without a prototype ctypes assumes the
    # return type is `int`, and GetCurrentProcess's pseudo-handle does not
    # survive that: it comes back as -1 and is then handed to
    # SetProcessAffinityMask as a 32-bit 0x00000000FFFFFFFF, which is not the
    # handle it means.  The call returns false, pinning is silently skipped, and
    # the results still record the CPU the harness intended to use.  The
    # prototypes are what make the pin real.
    if _KERNEL32 is not None:
        _KERNEL32.GetCurrentProcess.restype = ctypes.c_void_p
        _KERNEL32.GetCurrentProcess.argtypes = []
        _KERNEL32.SetProcessAffinityMask.restype = ctypes.c_int
        _KERNEL32.SetProcessAffinityMask.argtypes = [ctypes.c_void_p, ctypes.c_size_t]
        _KERNEL32.GetProcessAffinityMask.restype = ctypes.c_int
        _KERNEL32.GetProcessAffinityMask.argtypes = [
            ctypes.c_void_p, ctypes.POINTER(ctypes.c_size_t),
            ctypes.POINTER(ctypes.c_size_t),
        ]

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


def can_pin(cpu):
    """Can this process actually be confined to `cpu`?

    A mask the system will not accept -- a CPU that does not exist on a machine
    with fewer cores than `--cpu` names, a restricted process affinity -- makes
    `SetProcessAffinityMask` fail, and a failed pin used to look exactly like a
    successful one.  Asking once, up front, is what turns that into a warning.
    """
    saved = _get_affinity()
    if saved is None:
        return False
    ok = _set_affinity(1 << (cpu % cpu_count()))
    if ok:
        _set_affinity(saved)
    return ok


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


def spawn(cmd, cwd, env, timeout, pin_to=None):
    """Run one process to completion, killing the tree on timeout.

    Returns (wall_ms, peak_bytes, exit, timed_out, stdout, stderr, cpus).  The
    child's stdout is captured rather than left on the console -- writing a line
    to a terminal can cost more than the whole benchmark (RUN.md) -- and it is
    captured on *every* run, not just the first, so that every sample in a cell
    is measured under identical conditions.  stderr goes to a file so a chatty
    runtime cannot fill a pipe and deadlock the run.  `cpus` is the CPU list the
    child ran on, or None.

    Raises OSError when the program cannot be started at all -- an absent
    toolchain, which is a fact about the machine and not a failed cell.
    """
    if cmd and cmd[0].lower().endswith((".bat", ".cmd")):
        cmd = ["cmd.exe", "/c"] + cmd
    aff = pinned(*pin_to) if pin_to else pinned(None, -1, 0)
    with aff:
        t0 = time.perf_counter()
        with tempfile.TemporaryFile() as out, tempfile.TemporaryFile() as err:
            proc = subprocess.Popen(cmd, cwd=cwd, env=env, stdout=out, stderr=err,
                                    stdin=subprocess.DEVNULL)
            try:
                proc.wait(timeout=timeout)
                timed_out = False
            except subprocess.TimeoutExpired:
                timed_out = True
                kill_tree(proc)
            wall_ms = (time.perf_counter() - t0) * 1000.0
            peak = peak_memory(proc)
            out.seek(0)
            stdout = out.read().decode("utf-8", "replace")
            err.seek(0)
            stderr = err.read().decode("utf-8", "replace")
            code = proc.returncode
    return wall_ms, peak, code, timed_out, stdout, stderr, aff.cpus


def judge(task, code, stdout, stderr):
    """Judge one run against the task's expected answer.

    Returns None when the run answered correctly, else (status, message).  The
    published criterion is the answer, the timing line and task 15's file -- not
    the exit code.  A row may die in teardown after printing both (hxcpp does,
    with a heap-corruption code) or after its final statement, which is outside
    the bracketed region either way; that is recorded and surfaced, not treated
    as a failed cell.

    The three failures are three different facts and must not be conflated:

      WRONG  the program ran and answered differently -- a fact about the language
      SKIP   a runtime it needs is not installed -- a fact about this machine, the
             same kind as an absent toolchain
      ERROR  it did not run to completion for any other reason
    """
    if stdout_matches(stdout, EXPECTED[task]):
        return None
    if code != 0:
        # Some rows explain themselves on stdout, not stderr (the AIR runtime
        # prints its licence refusal there), so quote whichever stream spoke.
        detail = (stderr.strip() or stdout.strip())[-200:].replace("\n", " | ")
        if code in (0xC0000135, 0xC0000142, 0x80008083):
            return "SKIP", ("a runtime it needs is not installed "
                            "(exit code 0x%08X)" % code)
        return "ERROR", ("did not run to completion (exit code %s = 0x%08X): %s"
                         % (code, code, detail or "no stderr"))
    return "WRONG", "stdout %r != expected %r" % (stdout.strip()[:200], EXPECTED[task])


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
    """Is `got` the expected answer?

    A leading UTF-8 BOM is an artifact of how the child encodes its stdout, not
    part of the answer: the mono runtime emits one when its standard output is a
    console, which is why the csharp row answered correctly and was still
    reported WRONG.  It is stripped here, from the start of the stream and from
    the start of every line, because a runtime that writes the BOM writes it once
    per stream but the answer may be the last of several lines.
    """
    got = got.lstrip("\ufeff").strip()
    if got == expected:
        return True
    lines = [ln.strip().lstrip("\ufeff") for ln in got.splitlines() if ln.strip()]
    return bool(lines) and lines[-1] == expected


def out_path(entry, cwd, row, tc, task):
    """Where a task-15 program writes its `out.bin`, or None for other tasks.

    Every row but one writes it into the cell's working directory.  AIR's bundle
    is read-only by design, so its `out.bin` lands in the application-storage
    directory instead and the registry says so with `out_file` -- the same
    arrangement as `time_file`.
    """
    if task != "15_file_write":
        return None
    where = entry.get("out_file")
    if where:
        return norm(fill(where, ROOT_FWD, row, tc, task))
    return os.path.join(cwd, "out.bin")


def remove_retry(path, tries=60, delay=0.05):
    """Delete `path`, waiting out a transient Windows sharing violation.

    Windows refuses to delete a file while another handle still holds it open or
    mapped -- error 1224, "the requested operation cannot be performed on a file
    with a user-mapped section open".  A task-15 program that has just written
    and fsync'd 50 MiB keeps that mapping for a few more milliseconds while its
    runtime tears down, and the delete before the next run loses the race.  The
    next program then opens a file the previous process still holds, which fails
    for reasons that have nothing to do with the language -- and, because the
    old code swallowed the error, it was reported as the language producing no
    measurement.  Waiting is the fix; the loop is bounded so a file that is
    genuinely stuck is reported instead of hanging the sweep.

    Returns None on success, or the last OSError.
    """
    if not os.path.exists(path):
        return None
    last = None
    for _ in range(tries):
        try:
            os.remove(path)
            return None
        except OSError as exc:
            last = exc
            time.sleep(delay)
    return last


def reset(cwd, entry, row, tc, task, time_file):
    """Clear what the row verifiers clear before a run.

    Task 15's answer, the row's own `clean` list, and any timing fallback file.
    This has to happen before *every* run, not once per cell: several task-15
    programs fail outright when `out.bin` is already there (they create it
    exclusively), and a stale `time.txt` would otherwise be read as this run's
    number -- which is exactly the trap the luau row's verifier deletes it for.

    Returns the deletions that did not happen, as (path, error) pairs.  They are
    not fatal -- the run is attempted anyway -- but they are a fact about the
    cell that the caller records, because a residue file left behind turns a
    perfectly good program into a failed cell.
    """
    paths = [fill(p, ROOT_FWD, row, tc, task) for p in entry.get("clean", [])]
    # A bare name (dolphin and lobster list `time.txt`) is relative to the cell.
    paths = [norm(p if os.path.isabs(p) else os.path.join(cwd, p)) for p in paths]
    paths.append(time_file or os.path.join(cwd, "time.txt"))
    out = out_path(entry, cwd, row, tc, task)
    if out:
        paths.append(out)
    failures = []
    for path in paths:
        err = remove_retry(path)
        if err is not None:
            failures.append((path, err))
    return failures


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


def measure(cell, runs, timeout_override, check_only, cpu=3, cores=4):
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
    out = out_path(entry, cwd, row, tc, task)
    if out:
        watch.append(out)
    saved = [(path, snapshot(path)) for path in watch]
    try:
        return _measure(cell, runs, timeout_override, check_only, cpu, cores)
    finally:
        for path, blob in saved:
            restore(path, blob)


def _measure(cell, runs, timeout_override, check_only, cpu=3, cores=4):
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
              "status": "OK", "cmd": cmd, "cwd": cwd, "samples": [],
              "artifact_bytes": None, "out_bytes": None, "timeout_s": timeout,
              # Provenance travels with the cell, not with the file: a results
              # file is additive, so it can hold cells measured by different
              # invocations -- different run counts, or a sweep taken before the
              # pinning bug was fixed.  A reader (and the graph tool) has to be
              # able to tell those apart instead of trusting one header for all.
              "runs": 1 if check_only else runs, "check": bool(check_only),
              "pinned_cpu": None if cpu is None or cpu < 0 else cpu,
              "measured": time.strftime("%Y-%m-%dT%H:%M:%S")}
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

    # ---- the runs.  Every run counts: there is no discarded warmup, so `--runs
    # 5` is five runs and the median is over all five.  The first run carries the
    # verdict, which is judged before anything about the cell is measured, so a
    # wrong answer is never reported as a number.
    for i in range(1 if check_only else runs):
        for path, exc in reset(cwd, entry, row, tc, task, time_file):
            note("could not clear %s before a run (%s)" % (path, exc))
        try:
            wall_ms, peak, code, timed_out, got, stderr, cpus = spawn(
                cmd, cwd, env, timeout, pin_to=pin_to)
        except OSError as exc:
            return fail("SKIP", "cannot start %s: %s" % (cmd[0], exc))
        if timed_out:
            return fail("ERROR", "timed out after %gs" % timeout)
        if i == 0:
            verdict = judge(task, code, got, stderr)
            if verdict:
                return fail(*verdict)
        time_ms, source = read_time_ms(stderr, cwd, time_file)
        if code != 0:
            note("exit code %s on a run (stderr: %s)"
                 % (code, stderr.strip()[-200:].replace("\n", " | ")))
        rec = {"wall_ms": wall_ms, "peak_bytes": peak, "exit": code,
               "timeout": timed_out, "cpus": cpus, "time_ms": time_ms,
               "time_source": source,
               "speed_ms": time_ms if time_ms is not None else wall_ms,
               "self_timed": time_ms is not None}
        if i == 0:
            # One copy of the answer per cell, not one per run: it is what the
            # verdict was read from, and a results file is read far more often
            # than it is written.
            rec["stdout"] = got.strip()[:4000]
        if check_only:
            # A single run, judged above: record what it did and stop.  Nothing
            # here is a measurement -- one run has no median to report, and the
            # cell is marked `check` so it can never overwrite a timed cell.
            result["samples"].append(rec)
            return result
        if time_ms is None and code != 0:
            # Died without producing either number: not a usable sample.
            note("run %d produced nothing (exit code %s)" % (i + 1, code))
            continue
        result["samples"].append(rec)

    if not result["samples"]:
        return fail("ERROR", "no run produced a usable measurement")

    # Task 15's side effect, at the size the row verifiers require.
    out_bin = out_path(entry, cwd, row, tc, task)
    if out_bin:
        if os.path.exists(out_bin):
            result["out_bytes"] = os.path.getsize(out_bin)
            result["out_path"] = out_bin
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


def print_cell(r, check=False, number=None):
    """One line per cell, flushed as it finishes.

    `number` is the cell's item number -- the same numbering `--list` prints and
    `--start`/`--end` select.  Printing it is what makes a partial sweep
    resumable: the console says which item it stopped at, and that number is the
    argument to continue from.
    """
    label = "%s/%s %s" % (r["row"], r["toolchain"], r["task"])
    if number is not None:
        label = "[%d] %s" % (number, label)
    label = "%-48s" % label
    if r["status"] == "SKIP":
        print("%s SKIP: %s" % (label, r.get("error", "")), flush=True)
    elif r["status"] != "OK":
        print("%s %s: %s" % (label, r["status"], r.get("error", "")), flush=True)
    elif check:
        w = (r.get("samples") or [{}])[0]
        print("%s OK  %8s ms  mem %10s  size %10s%s" % (
            label, fmt_ms(w.get("wall_ms")), fmt_bytes(w.get("peak_bytes")),
            fmt_bytes(r.get("artifact_bytes")), "  !" if r.get("warnings") else ""),
            flush=True)
    else:
        speed = fmt_ms(r.get("median_ms"))
        kind = "" if r.get("self_timed") else "*"
        print("%s %10s%s ms  wall %9s ms  mem %10s  size %10s%s" % (
            label, speed, kind, fmt_ms(r.get("median_wall_ms")),
            fmt_bytes(r.get("peak_bytes")), fmt_bytes(r.get("artifact_bytes")),
            "  !" if r.get("warnings") else ""), flush=True)


def cell_key(c):
    """What identifies a cell across runs: its row, toolchain and task.

    Accepts either a measured cell (a dict from results.json) or a registry cell
    (the `(row, toolchain, task, entry, language)` tuple `expand` returns), so
    the two can be keyed against each other when the file is put back into
    registry order.
    """
    if isinstance(c, tuple):
        return (c[0], c[1], c[2])
    return (c.get("row"), c.get("toolchain"), c.get("task"))


def load_results(path):
    """The cells already measured into `path`.

    A results file is additive, so every run starts from whatever is already
    there.  A file that cannot be read is treated as empty rather than fatal:
    the numbers can always be regenerated, and refusing to start because a
    previous run was cut off mid-write would be the worst possible answer to a
    crash.
    """
    try:
        with open(path, encoding="utf-8") as fh:
            doc = json.load(fh)
    except (OSError, ValueError):
        return []
    cells = doc.get("cells")
    return cells if isinstance(cells, list) else []


def merge_results(previous, fresh, order=None):
    """`previous` with `fresh` laid over it, keyed by cell.

    A cell measured again replaces the older measurement of that same cell; a
    cell not run this time keeps the number it already had.  That is what lets
    `--start`/`--end` chunks add up to a whole matrix and an interrupted sweep be
    continued instead of repeated.  `order` puts the result back into the
    registry's own cell order, so the tables do not depend on the order the
    chunks happened to run in.

    One exception: a `--check` cell never replaces a timed one.  A check run has
    no samples and no median by design, so letting it overwrite a measured cell
    would quietly throw the measurement away and leave a row that looks measured
    but has no number.  Checking a cell that was never timed still adds it.
    """
    merged = {}
    for c in previous:
        merged[cell_key(c)] = c
    for c in fresh:
        key = cell_key(c)
        old = merged.get(key)
        if old is not None and c.get("check") and not old.get("check"):
            continue
        merged[key] = c
    cells = list(merged.values())
    if order:
        cells.sort(key=lambda c: order.get(cell_key(c), len(order)))
    return cells


def atomic_write(path, text):
    """Write `text` to `path` without ever leaving a partial file behind.

    The results file is rewritten while a sweep is still running, so it is
    written to a sibling temporary file and then moved into place: `os.replace`
    is atomic on NTFS and on POSIX, so a reader sees either the old file or the
    new one and never a half-written one.  A crash between flushes costs the
    cells measured since the last flush, not the whole file.
    """
    directory = os.path.dirname(os.path.abspath(path)) or "."
    fd, tmp = tempfile.mkstemp(dir=directory, prefix=".results-", suffix=".tmp")
    try:
        with os.fdopen(fd, "w", encoding="utf-8", newline="\n") as fh:
            fh.write(text)
        os.replace(tmp, path)
    except BaseException:
        try:
            os.remove(tmp)
        except OSError:
            pass
        raise


def provenance(cells, runs, cpu):
    """How the cells in a merged file were measured, as (runs, pinning) text.

    Because the file is additive its cells need not share a method: a chunk run
    at five runs sits beside one run at one, and a sweep taken before the pinning
    bug was fixed sits beside one taken after.  A single header number would be
    true of only some of the rows, so the header reports the spread instead.
    """
    # Only real measurements count towards the spread: a `--check` cell ran once
    # and carries no number, so letting its single run into this would report a
    # file of measured cells as "1-5 (mixed)" on the strength of cells that were
    # never timed.
    seen_runs = sorted({c["runs"] for c in cells
                        if isinstance(c.get("runs"), int) and not c.get("check")})
    if len(seen_runs) == 1:
        run_text = "%d" % seen_runs[0]
    elif seen_runs:
        run_text = "%d-%d (mixed)" % (seen_runs[0], seen_runs[-1])
    else:
        run_text = "%d" % runs
    seen_cpu = sorted({c.get("pinned_cpu") for c in cells if "pinned_cpu" in c},
                      key=lambda v: -1 if v is None else v)
    if len(seen_cpu) == 1:
        pin_text = ("no pinning" if seen_cpu[0] is None
                    else "pinned to CPU %d" % seen_cpu[0])
    elif seen_cpu:
        pin_text = "mixed pinning (%s)" % ", ".join(
            "none" if v is None else str(v) for v in seen_cpu)
    else:
        pin_text = "no pinning" if cpu is None else "pinned to CPU %d" % cpu
    return run_text, pin_text


def write_json(path, cells, runs, cpu=None, cores=4):
    run_text, pin_text = provenance(cells, runs, cpu)
    doc = {
        "generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "root": ROOT,
        "runs": runs,
        "pinned_cpu": cpu,
        "task11_cores": cores,
        "cells_in_file": len(cells),
        "method": {"runs": run_text, "pinning": pin_text},
        "cells": cells,
    }
    atomic_write(path, json.dumps(doc, indent=1) + "\n")


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


def write_md(path, cells, runs, check=False, cpu=None, expected=()):
    order = []
    for c in cells:
        key = (c["row"], c["toolchain"], c.get("language", c["row"]))
        if key not in order:
            order.append(key)
    ok = sum(1 for c in cells if c["status"] == "OK" and not c.get("check"))
    checked = sum(1 for c in cells if c["status"] == "OK" and c.get("check"))
    skipped = [c for c in cells if c["status"] == "SKIP"]
    bad = [c for c in cells if c["status"] not in ("OK", "SKIP")]
    # Task 15's side effect, as the row verifiers check it.
    writers = [c for c in cells if c["task"] == "15_file_write" and c["status"] == "OK"
               and not c.get("check")]
    wrote = [c for c in writers if c.get("out_bytes") == 52428800]
    run_text, pin_text = provenance(cells, runs, cpu)
    if check:
        parts = [
            "# StUpIdSpEeD harness check",
            "",
            "One run per cell, no timing: %d cells checked, %d skipped (toolchain not "
            "installed), %d failed.  Generated %s by `exec/harness.py --check`, %s."
            % (checked, len(skipped), len(bad), time.strftime("%Y-%m-%d %H:%M"), pin_text),
            "",
        ]
    else:
        parts = [
            "# StUpIdSpEeD results",
            "",
            "%d cells in the file, %s timed runs each.  Generated %s "
            "by `exec/harness.py`, %s."
            % (len(cells), run_text, time.strftime("%Y-%m-%d %H:%M"), pin_text),
            "",
            "This file is additive: a cell measured again replaces its older row, and "
            "a cell not run this time keeps the number it already had, so the counts "
            "above are the whole file rather than this invocation.",
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
    missing = expected - {(c.get("row"), c.get("toolchain"), c.get("task")) for c in cells}
    if missing:
        by_row = {}
        for row, tc, task in sorted(missing):
            by_row.setdefault((row, tc), []).append(task)
        parts += [
            "## Cells not in this file",
            "",
            "The results file is additive, so these are the cells no invocation has "
            "measured yet -- the matrix's expected %d cells minus the %d recorded. "
            "Run `exec/harness.py --start N --end M` over the range that covers them."
            % (len(expected), len(cells)),
            "",
        ]
        for (row, tc), tasks in sorted(by_row.items()):
            parts.append("- `%s/%s` -- %d of 15: %s"
                         % (row, tc, len(tasks), ", ".join(t[:2] for t in tasks)))
        parts.append("")
    atomic_write(path, "\n".join(parts) + "\n")


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
            for key in ("time_file", "out_file"):
                if key in e and not isinstance(e[key], str):
                    problems.append("%s/%s: %s must be a string"
                                    % (row, e.get("toolchain"), key))
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


def row_wanted(row, wants, row_index):
    """Does `--rows` name this row?

    A row can be named (`rust`), numbered (`7`) or given as a range of numbers
    (`1-30`), which is how a chunk of the matrix is asked for by position rather
    than by name.  Numbers are the 1-based positions in `--list`, so `--rows 1-30`
    is the first thirty languages and `--rows 1-114` is all of them.
    """
    if row in wants:
        return True
    n = row_index.get(row)
    if n is None:
        return False
    for want in wants:
        if want.isdigit():
            if int(want) == n:
                return True
            continue
        lo, sep, hi = want.partition("-")
        if sep and lo.strip().isdigit() and hi.strip().isdigit():
            if int(lo) <= n <= int(hi):
                return True
    return False


def item_range(selected, start, end):
    """The `--start`/`--end` slice of `selected`, as a list of (number, cell).

    Item numbers are 1-based positions in the selected list, which is the
    numbering `--list` prints.  Both bounds are optional and inclusive; a bound
    past the end is clamped rather than an error, so `--start 1900` on a full
    matrix and `--end 99999` both mean what they obviously mean.  Numbers are
    kept with the cells so the console can print the number a resumed run should
    continue from.
    """
    total = len(selected)
    first = 1 if start is None else max(1, start)
    last = total if end is None else min(total, end)
    if first > last:
        return []
    return [(n, selected[n - 1]) for n in range(first, last + 1)]


def main():
    ap = argparse.ArgumentParser(
        description="Run every built program in exec/ and measure it.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "Items are numbered 1..N in `--list` order (row, then toolchain, then\n"
            "task), so `--start`/`--end` take a chunk of the matrix by position:\n"
            "\n"
            "  python exec/harness.py --list | head          # see the numbering\n"
            "  python exec/harness.py --start 1 --end 200    # items 1..200\n"
            "  python exec/harness.py --start 201 --end 400  # the next chunk\n"
            "  python exec/harness.py --rows 1-30            # the first 30 languages\n"
            "  python exec/harness.py --start 1500            # 1500 to the end\n"
            "\n"
            "Results are additive: every run merges into exec/results.json, so the\n"
            "chunks above build one complete matrix between them and an interrupted\n"
            "run is continued rather than repeated.  A cell measured again replaces\n"
            "its own older row and nothing else.  Use --replace to start over.\n"
        ))
    ap.add_argument("--runs", type=int, default=5,
                    help="timed runs per cell (default 5); --runs 1 runs the whole "
                         "suite once, --runs 3 three times.  Every run counts: there "
                         "is no discarded warmup")
    ap.add_argument("--rows", default="",
                    help="rows to run: names, 1-based numbers, or ranges of numbers "
                         "(`c,rust`, `7`, `1-30`); default all")
    ap.add_argument("--tasks", default="", help="comma-separated task numbers or names")
    ap.add_argument("--start", type=int, default=None,
                    help="first item to run, 1-based (see `--list`); default the first")
    ap.add_argument("--end", type=int, default=None,
                    help="last item to run, 1-based and inclusive; default the last")
    ap.add_argument("--timeout", type=float, default=0, help="override every per-cell timeout")
    ap.add_argument("--cpu", type=int, default=3,
                    help="logical CPU every cell is pinned to (default 3, i.e. "
                         "`start /affinity 8`); -1 to disable pinning")
    ap.add_argument("--cores", type=int, default=4,
                    help="logical CPUs task 11 gets, from --cpu upward (default 4)")
    ap.add_argument("--registry", default=REGISTRY, help="cell registry (default exec/cells.json)")
    ap.add_argument("--json", default=os.path.join(HERE, "results.json"))
    ap.add_argument("--md", default=os.path.join(HERE, "results.md"))
    ap.add_argument("--flush-every", type=int, default=25,
                    help="write results every N cells (default 25, so a sweep cut off "
                         "mid-way keeps all but the last few); 0 writes only at the end")
    ap.add_argument("--replace", action="store_true",
                    help="discard the cells already in --json instead of merging into them")
    ap.add_argument("--check", action="store_true",
                    help="one run per cell: pass/fail, no timing")
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

    row_names = sorted(rows)
    row_index = {r: i + 1 for i, r in enumerate(row_names)}
    want_rows = [r.strip() for r in args.rows.split(",") if r.strip()]
    want_tasks = [t.strip() for t in args.tasks.split(",") if t.strip()]
    selected = []
    for cell in all_cells:
        row, tc, task, _e, _lang = cell
        if want_rows and not row_wanted(row, want_rows, row_index):
            continue
        # `--tasks 01`, `--tasks 1` and `--tasks branches` all select 01_branches.
        if want_tasks and not task_selected(task, want_tasks):
            continue
        selected.append(cell)

    numbered = item_range(selected, args.start, args.end)

    if args.list:
        for n, (row, tc, task, _e, _lang) in numbered:
            print("%d\t%s\t%s\t%s" % (n, row, tc, task))
        if numbered:
            print("%d of %d cells selected (items %d-%d)"
                  % (len(numbered), len(selected), numbered[0][0], numbered[-1][0]))
        else:
            print("0 of %d cells selected (empty range)" % len(selected))
        return 0

    if not numbered:
        print("no cells selected", file=sys.stderr)
        return 1

    cpu = None if args.cpu < 0 else args.cpu
    if cpu is not None and not can_pin(cpu):
        print("warning: this machine will not confine a process to CPU %d; every "
              "cell runs unpinned and results.json records cpus=null" % cpu,
              file=sys.stderr, flush=True)
    order = {cell_key(c): i for i, c in enumerate(all_cells)}
    expected = set(order)
    previous = [] if args.replace else load_results(args.json)
    print("%d cells (items %d-%d of %d): %s, pinned to CPU %s%s%s" % (
        len(numbered), numbered[0][0], numbered[-1][0], len(selected),
        "one run each (--check)" if args.check
        else "%d timed runs each" % args.runs,
        "none" if cpu is None else cpu,
        "" if cpu is None else " (task 11 gets %d)" % args.cores,
        "" if not previous else "; merging into %d cells already in %s"
        % (len(previous), os.path.basename(args.json))), flush=True)

    results = []

    def flush():
        """Write the file: previous cells, this run's cells, in registry order."""
        merged = merge_results(previous, results, order)
        write_json(args.json, merged, args.runs, cpu, args.cores)
        write_md(args.md, merged, args.runs, args.check, cpu, expected)
        return merged

    try:
        for n, cell in numbered:
            r = measure(cell, args.runs, args.timeout, args.check,
                        cpu if cpu is not None else -1, args.cores)
            results.append(r)
            print_cell(r, args.check, n)
            if args.flush_every and len(results) % args.flush_every == 0:
                merged = flush()
                print("  ... %d cells written, %d in %s"
                      % (len(results), len(merged), os.path.basename(args.json)),
                      flush=True)
    except KeyboardInterrupt:
        print("\ninterrupted after %d cells; writing what was measured"
              % len(results), file=sys.stderr)

    merged = flush()
    ok = sum(1 for r in results if r["status"] == "OK")
    skipped = sum(1 for r in results if r["status"] == "SKIP")
    bad = len(results) - ok - skipped
    print("%d measured, %d skipped, %d failed this run; %d cells now in %s and %s"
          % (ok, skipped, bad, len(merged), args.json, args.md), flush=True)
    if numbered[-1][0] < len(selected):
        print("continue with: --start %d --end %d" % (numbered[-1][0] + 1, len(selected)),
              flush=True)
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
