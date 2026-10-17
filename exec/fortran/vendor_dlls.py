#!/usr/bin/env python3
"""Copy each Fortran program's non-system DLL closure beside it.

Two of the row's four toolchains produce executables that import a DLL from the
toolchain tree rather than the system:

  * lfortran -- every `prog.exe` imports `liblfortran_runtime.dll` (which in turn
    imports `libgcc_s_seh-1.dll`), both in `tools/msys64/.../ucrt64/bin`.
  * ifx task 11 -- OpenMP is linked dynamically, so it imports `libiomp5md.dll`
    from `tools/ifx/Library/bin`.

The cell's `env` prepends those directories to `PATH` as a *relative* path, which
Windows resolves against the cell's working directory rather than the repository
root, so the loader never finds them; its first stop, the executable's own
directory, does.  The registry's PATH entry is still correct for a shell started
at the repository root, so this is belt and braces rather than a workaround.

System DLLs (anything resolved out of %SystemRoot%\\System32) are left alone.

    python exec/fortran/vendor_dlls.py
"""
import os
import re
import shutil
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
RUN = os.path.join(ROOT, "exec", "fortran")
UCRT = os.path.join(ROOT, "tools", "msys64", "msys64", "ucrt64", "bin")
IFX = os.path.join(ROOT, "tools", "ifx", "Library", "bin")
OBJDUMP = os.path.join(UCRT, "objdump.exe")
SYSTEM32 = os.path.join(os.environ.get("SystemRoot", r"C:\Windows"), "System32")
# gfortran on this host is the MinGW-w64 build outside tools/ (`C:\mingw64\bin`),
# and its programs import that tree's libgfortran-5.dll and libgomp-1.dll; the
# compiler's own directory is searched first so a program never picks up a
# runtime from a different GCC.
GFORTRAN = os.path.dirname(shutil.which("gfortran") or "")
SEARCH = {}

DLL_RE = re.compile(r"DLL Name:\s*(\S+)", re.I)
# Windows API sets (`api-ms-win-crt-*`, `ext-ms-*`) are loader contracts rather
# than files on disk, and everything else Windows supplies comes out of System32.
SYSTEM = re.compile(r"^(api-ms-win-|ext-ms-)", re.I)


def imports(path):
    p = subprocess.run([OBJDUMP, "-p", path], capture_output=True, text=True,
                       errors="replace")
    return [m.group(1) for m in DLL_RE.finditer(p.stdout)]


def search_path(tc):
    """Directories to resolve a toolchain's DLLs in, in priority order."""
    if tc == "gfortran":
        return [d for d in (GFORTRAN, UCRT, IFX, SYSTEM32) if d]
    if tc == "ifx":
        return [IFX, UCRT, SYSTEM32]
    return [UCRT, IFX, SYSTEM32]


def find(name, dirs):
    low = name.lower()
    for directory in dirs:
        cand = os.path.join(directory, name)
        if os.path.exists(cand):
            return cand
        try:
            for entry in os.listdir(directory):
                if entry.lower() == low:
                    return os.path.join(directory, entry)
        except OSError:
            continue
    return None


def vendor(exe, dst_dir, dirs, seen=None):
    """Copy `exe`'s non-system DLL closure into `dst_dir`; return what was missing."""
    seen = seen if seen is not None else set()
    missing = []
    for name in imports(exe):
        low = name.lower()
        if low in seen or SYSTEM.match(name):
            continue
        seen.add(low)
        src = find(name, dirs)
        if src is None:
            missing.append(name)
            continue
        if os.path.normcase(os.path.dirname(src)) == os.path.normcase(SYSTEM32):
            continue
        dst = os.path.join(dst_dir, os.path.basename(src))
        if not os.path.exists(dst):
            shutil.copy2(src, dst)
        missing += vendor(dst, dst_dir, dirs, seen)
    return missing


def main():
    problems = 0
    for tc in sorted(os.listdir(RUN)):
        tcdir = os.path.join(RUN, tc)
        if not os.path.isdir(tcdir):
            continue
        for task in sorted(os.listdir(tcdir)):
            cwd = os.path.join(tcdir, task)
            exe = os.path.join(cwd, "prog.exe")
            if not os.path.isfile(exe):
                continue
            missing = vendor(exe, cwd, search_path(tc))
            if missing:
                problems += 1
                print("%s/%s: missing %s" % (tc, task, ", ".join(sorted(set(missing)))))
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
