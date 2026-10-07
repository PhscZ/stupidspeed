#!/usr/bin/env python3
"""Stage the 50 MiB fixture into the exec tree without duplicating it.

Tasks 14 and 15 are the only ones that touch files, and task 14 is the only one that
*reads* the fixture -- task 15 writes out.bin and never opens data.bin. Both run from a
working directory of their own, so every row needs the fixture beside its program, and
build_all.bat copies it there. Measured, that copy is 17.5 GB of the 23.2 GB in exec/:
215 copies of data.bin plus 144 copies of out.bin.

This script is the alternative to those copies. It walks exec/, and for every directory
that holds a data.bin it replaces that file with a **hard link** to the repository-root
data.bin. A hard link is a second name for the same file: the bytes exist once on disk,
the size of the tree drops to the size of the one fixture, and every program that opens
"data.bin" relative to its working directory still sees an ordinary file. It has to be
the same volume, which it is here (everything under one checkout).

The root fixture is checked against the sha256 RUN.md documents both before and after, so
a run that corrupted it is caught rather than propagated into 200 more directories.

Layouts differ per row and this script does not need to know them: it uses the copies the
build already placed as the source of truth. A flat row (exec/arc/data.bin) and a nested
one (exec/zig/zig/14_file_read/data.bin) are both just "a directory that has a data.bin".

  python exec/stage_fixtures.py            # de-duplicate: replace copies with hard links
  python exec/stage_fixtures.py --prune    # also delete what is never read (see below)
  python exec/stage_fixtures.py --check    # verify only, change nothing

--prune removes two kinds of file, both regenerable and both gitignored:

  * data.bin inside a *15_file_write* directory. No task-15 program reads it -- task 15
    writes out.bin and nothing else -- so those 67 copies are pure waste.
  * out.bin anywhere. It is task 15's output and is overwritten on every run.

Run:  python exec\\stage_fixtures.py [--prune] [--check]
"""
import argparse
import hashlib
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
EXEC = HERE
FIXTURE = os.path.join(ROOT, "data.bin")
FIXTURE_SIZE = 52428800
# The value RUN.md documents for the committed fixture.
FIXTURE_SHA = "624bbe3f61588f97cfaad1af50360bb8c5fc94774d3c15dbf471dcd42b9bea8e"


def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def check_fixture():
    if not os.path.exists(FIXTURE):
        sys.exit("FAIL: no fixture at %s" % FIXTURE)
    size = os.path.getsize(FIXTURE)
    if size != FIXTURE_SIZE:
        sys.exit("FAIL: %s is %d bytes, expected %d" % (FIXTURE, size, FIXTURE_SIZE))
    digest = sha256(FIXTURE)
    if digest != FIXTURE_SHA:
        sys.exit("FAIL: %s has sha256 %s, expected %s\n"
                 "      the committed fixture is not the documented one" % (FIXTURE, digest, FIXTURE_SHA))
    return digest


def is_task15_only(dirname):
    """A directory whose program is task 15 and nothing else."""
    return "15_file_write" in dirname and "14_file_read" not in dirname


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--prune", action="store_true",
                    help="also delete unread data.bin copies and stale out.bin files")
    ap.add_argument("--check", action="store_true",
                    help="report what would change, change nothing")
    args = ap.parse_args()

    check_fixture()
    root_stat = os.stat(FIXTURE)
    root_id = (root_stat.st_dev, root_stat.st_ino)

    links = 0          # copies turned into hard links
    already = 0        # already hard links
    removed_fixtures = 0
    removed_outputs = 0
    reclaimed = 0
    problems = []

    for dirpath, dirnames, filenames in os.walk(EXEC):
        dirnames[:] = [d for d in dirnames if d not in (".git", "__pycache__")]
        name = os.path.basename(dirpath)

        for fn in list(filenames):
            path = os.path.join(dirpath, fn)
            if fn == "data.bin":
                try:
                    st = os.stat(path)
                except OSError as exc:
                    problems.append("stat %s: %s" % (path, exc))
                    continue
                if (st.st_dev, st.st_ino) == root_id:
                    already += 1
                    continue
                if is_task15_only(name) and args.prune:
                    if not args.check:
                        os.remove(path)
                    removed_fixtures += 1
                    reclaimed += st.st_size
                    continue
                if args.check:
                    links += 1
                    reclaimed += st.st_size
                    continue
                try:
                    os.remove(path)
                    os.link(FIXTURE, path)
                    links += 1
                    reclaimed += st.st_size
                except OSError as exc:
                    problems.append("link %s: %s" % (path, exc))
            elif fn == "out.bin" and args.prune:
                try:
                    st = os.stat(path)
                except OSError as exc:
                    problems.append("stat %s: %s" % (path, exc))
                    continue
                if not args.check:
                    os.remove(path)
                removed_outputs += 1
                reclaimed += st.st_size

    # The root fixture is read-only in spirit: nothing in the benchmark writes it. If a run
    # clobbered it, every hard link now points at the damaged bytes, so this is the check
    # that matters.
    after = check_fixture()
    if after != FIXTURE_SHA:
        problems.append("the root fixture changed during staging")

    verb = "would reclaim" if args.check else "reclaimed"
    print("fixture      %s" % FIXTURE)
    print("sha256       %s" % after)
    print("hard-linked  %d data.bin %s" % (links, "(would be)" if args.check else "replaced with links"))
    print("already      %d data.bin" % already)
    if args.prune:
        print("pruned       %d unread data.bin (task 15 never reads it)" % removed_fixtures)
        print("pruned       %d out.bin (task 15 rewrites it every run)" % removed_outputs)
    print("%s    %.2f GB" % (verb, reclaimed / 2 ** 30))
    if problems:
        print("PROBLEMS:")
        for p in problems[:20]:
            print("  " + p)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
