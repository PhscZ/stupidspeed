#!/usr/bin/env python3
"""Verifier for the python row, as one entry point over its two halves.

This row is the only one with more than one verifier, because its four toolchains are two
interpreters and two compilers and the two halves need different run recipes:

  * verify_interpreters.py -- cpython, pypy and graalpy, run as
    `<interpreter> <task>.py` from exec/python/<toolchain>/<task>/;
  * verify_compilers.py  -- nuitka, run as the built
    exec/python/nuitka/<task>/<task>.dist/<task>.exe.

Each half prints its own per-task lines and its own final PASS line; this script just runs
both in order and fails if either did. It exists so that `python exec\\<row>\\verify.py` is
the uniform way to verify any row, which is what RUN.md's Measurement tooling section
documents.

Run:  python exec\\python\\verify.py
"""
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
PARTS = ["verify_interpreters.py", "verify_compilers.py"]


def main():
    rc = 0
    for part in PARTS:
        path = os.path.join(HERE, part)
        if not os.path.exists(path):
            print("python FAIL missing %s" % path, flush=True)
            rc = 1
            continue
        print("########## %s" % part, flush=True)
        p = subprocess.run([sys.executable, path], cwd=HERE)
        if p.returncode != 0:
            rc = 1
    print("python TOTAL %s" % ("PASS" if rc == 0 else "FAIL"), flush=True)
    return rc


if __name__ == "__main__":
    sys.exit(main())
