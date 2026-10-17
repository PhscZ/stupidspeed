#!/usr/bin/env python3
"""Copy each built Objective-C program's DLL closure beside it.

The clang/GNUstep programs import `libobjc-4.6.dll`, `libwinpthread-1.dll` and --
for the tasks that actually call into Foundation -- `gnustep-base-1_31.dll` and
its own dependencies.  The cell's `env` prepends `tools/msys64/.../ucrt64/bin` to
`PATH` as a *relative* path, which Windows resolves against the cell's working
directory, so it never finds them; the loader's first stop, the directory of the
executable, does.  Vendoring the closure there is the fix BUILD.md records.

`gnustep-base-1_31.dll` was built against gcc-libs 16.1.0-3 and imports five
`std::__format` symbols that the tree's libstdc++ 16.2.0 no longer exports, so
libstdc++-6.dll is taken from `exec/objectivec/vendor/`, which holds the
`mingw-w64-ucrt-x86_64-gcc-libs-16.1.0-3` copy fetched from repo.msys2.org
(`fetch_libstdcxx.py` puts it there).  Without it the five tasks that link
Foundation -- 06, 10, 11, 14 and 15 -- die at load with 0xC0000139.

DLLs are hardlinked where the filesystem allows it and copied otherwise.

    python exec/objectivec/vendor_dlls.py
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
RUN = os.path.join(ROOT, "exec", "objectivec", "clang")
UCRT = os.path.join(ROOT, "tools", "msys64", "msys64", "ucrt64", "bin")
OBJDUMP = os.path.join(UCRT, "objdump.exe")
# gcc-libs 16.1.0-3: the version gnustep-base-1_31.dll was linked against.
LIBSTDCXX_16_1 = os.path.join(ROOT, "exec", "objectivec", "vendor", "libstdc++-6.dll")
OVERRIDES = {"libstdc++-6.dll": LIBSTDCXX_16_1}

# Everything Windows itself provides; never vendored.
SYSTEM = re.compile(r"^(api-ms-win-|ext-ms-|kernel32|kernelbase|ntdll|user32|"
                    r"advapi32|shell32|ole32|oleaut32|gdi32|ws2_32|mswsock|"
                    r"bcrypt|secur32|crypt32|msvcrt|ucrtbase|vcruntime|shlwapi|"
                    r"psapi|version|winmm|iphlpapi|dbghelp|userenv|dnsapi|"
                    r"normaliz|powrprof|comdlg32|comctl32|setupapi|wldap32|"
                    r"netapi32|winhttp|wininet|imm32|rpcrt4|opengl32|glu32)", re.I)

DLL_RE = re.compile(r"DLL Name:\s*(\S+)", re.I)


def imports(path):
    p = subprocess.run([OBJDUMP, "-p", path], capture_output=True, text=True,
                       errors="replace")
    return [m.group(1) for m in DLL_RE.finditer(p.stdout)]


def find(name):
    if name in OVERRIDES and os.path.exists(OVERRIDES[name]):
        return OVERRIDES[name]
    cand = os.path.join(UCRT, name)
    if os.path.exists(cand):
        return cand
    low = name.lower()
    for entry in os.listdir(UCRT):
        if entry.lower() == low:
            return os.path.join(UCRT, entry)
    return None


def place(src, dst_dir):
    dst = os.path.join(dst_dir, os.path.basename(src))
    if os.path.exists(dst):
        return dst
    try:
        os.link(src, dst)
    except OSError:
        import shutil
        shutil.copy2(src, dst)
    return dst


def vendor(exe, dst_dir, seen=None):
    seen = seen if seen is not None else set()
    missing = []
    for name in imports(exe):
        if name.lower() in seen or SYSTEM.match(name):
            continue
        seen.add(name.lower())
        src = find(name)
        if src is None:
            missing.append(name)
            continue
        dst = place(src, dst_dir)
        vendor(dst, dst_dir, seen)
    return missing


def main():
    problems = 0
    for task in sorted(os.listdir(RUN)):
        cwd = os.path.join(RUN, task)
        exe = os.path.join(cwd, "prog.exe")
        if not os.path.isdir(cwd) or not os.path.exists(exe):
            continue
        missing = vendor(exe, cwd)
        if missing:
            problems += 1
            print("%s: missing %s" % (task, ", ".join(sorted(set(missing)))))
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
