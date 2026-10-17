#!/usr/bin/env python3
"""Row verifier for the python row -- a thin entry point over its two verifiers.

The row is the only one whose four toolchains are two different kinds of thing:
cpython, pypy and graalpy are interpreters that run the fifteen sources
unchanged, while nuitka compiles them into a standalone binary.  Their run
recipes differ enough that each half has its own verifier --

    exec/python/verify_interpreters.py   cpython, pypy, graalpy
    exec/python/verify_compilers.py      nuitka

-- and this script runs both and reports the row as a whole.  A task counts as
passed only when all four toolchains passed it.

    python exec/python/verify.py
"""
import sys

import verify_compilers
import verify_interpreters

TASKS = verify_interpreters.TASKS


def main():
    interp = verify_interpreters.main()
    comp = verify_compilers.main()
    passed = {task: bool(interp.get(task)) and bool(comp.get(task)) for task in TASKS}
    n = sum(1 for task in TASKS if passed[task])
    print("%s %s %d/15" % (verify_interpreters.ROW,
                           "PASS" if n == len(TASKS) else "FAIL", n))
    return 0 if n == len(TASKS) else 1


if __name__ == "__main__":
    sys.exit(main())
