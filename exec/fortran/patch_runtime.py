#!/usr/bin/env python3
"""Put LFortran's runtime into binary file mode -- the lfortran row's file patch.

LFortran's `_lfortran_open` picks the fopen mode from the OPEN statement's
`status` alone -- `r+` for `old`/`unknown`, `w+` for `new`/`replace`/`scratch` --
and never passes the `b` flag, so on Windows every unit file is a *text* stream.
That breaks both file tasks: task 14's 1 MiB read stops at the first 0x1A byte
(the fixture's byte 26) and reports end-of-file, and task 15 writes 204800 bytes
too many because every LF becomes CRLF.

The mode strings sit in the DLL's read-only data with a NUL terminator, so the
fix is one byte each and nothing moves:

    "r+"  -> "rb"     (the '+' byte becomes 'b'; `old` is opened read-only)
    "w+"  -> "w+b"    (the NUL after "w+" becomes 'b'; there is padding after it)

The pristine DLL is kept beside it as `liblfortran_runtime.dll.orig`, and the
patch is idempotent: running it twice is a no-op.

    python exec/fortran/patch_runtime.py           # apply
    python exec/fortran/patch_runtime.py --check   # report the state
"""
import os
import shutil
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DLL = os.path.join(ROOT, "tools", "msys64", "msys64", "ucrt64", "bin",
                   "liblfortran_runtime.dll")
ORIG = DLL + ".orig"


def state(data):
    if b"\x00rb\x00" in data and b"\x00w+b\x00" in data:
        return "patched"
    if b"\x00r+\x00" in data and b"\x00w+\x00\x00" in data:
        return "pristine"
    return "unknown"


def apply_patch():
    if not os.path.exists(DLL):
        raise SystemExit("no LFortran runtime at %s" % DLL)
    data = bytearray(open(DLL, "rb").read())
    st = state(bytes(data))
    if st == "patched":
        return "already patched"
    if st != "pristine":
        raise SystemExit("%s: unrecognised mode strings -- not touching it" % DLL)
    if not os.path.exists(ORIG):
        shutil.copy2(DLL, ORIG)
    i = data.find(b"\x00r+\x00")
    data[i + 2] = ord("b")
    j = data.find(b"\x00w+\x00\x00")
    data[j + 3] = ord("b")
    open(DLL, "wb").write(bytes(data))
    return "patched"


def main(argv):
    if "--check" in argv:
        if not os.path.exists(DLL):
            print("missing %s" % DLL)
            return 1
        print("%s: %s" % (DLL, state(open(DLL, "rb").read())))
        return 0
    print("%s: %s" % (DLL, apply_patch()))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
