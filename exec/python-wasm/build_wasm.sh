#!/bin/sh
# Build CPython 3.12.2 for wasm32-wasip1-threads (the python-wasm row).
#
# Run from MSYS2 bash.  Reproduces the recipe in BUILD.md:
#   * download the Python-3.12.2 source release (26 MB) and a Python 3.12
#     Windows build interpreter (needed by --with-build-python; the system
#     3.13 is rejected because configure requires 3.12),
#   * patch configure.ac's WASI pthread branch: the target triple becomes
#     wasm32-wasip1-threads (wasi-sdk 34 has no wasm32-wasi-threads sysroot)
#     and the 10 MiB --max-memory cap becomes 1 GiB,
#   * configure + make python.wasm with the wasi-sdk tree,
#   * install python.wasm, lib/python3.12 and _sysconfigdata into
#     exec/python-wasm/wasip1/.
set -e

ROOT=/c/stupidspeed
WORK=$ROOT/temp/cpython-wasm
SRCDIR=$WORK/Python-3.12.2
WASI=$ROOT/tools/wasi-sdk
BUILDPY=$WORK/py312/python.exe
OUT=$ROOT/exec/python-wasm/wasip1

export WASI_SDK_PATH=C:/stupidspeed/tools/wasi-sdk
# MSYS2 rewrites a bare "--prefix=/" into its own install root, which breaks
# the Makefile; keep that one argument literal.
export MSYS2_ARG_CONV_EXCL="--prefix"

mkdir -p "$WORK"
cd "$WORK"

if [ ! -f Python-3.12.2.tgz ]; then
    echo "== downloading Python-3.12.2.tgz"
    curl -sSL -o Python-3.12.2.tgz https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz
fi

if [ ! -d "$SRCDIR" ]; then
    echo "== extracting source"
    tar -xzf Python-3.12.2.tgz
fi

if [ ! -x "$BUILDPY" ]; then
    echo "== fetching a Python 3.12 build interpreter"
    curl -sSL -o py312.zip https://www.python.org/ftp/python/3.12.2/python-3.12.2-embed-amd64.zip
    mkdir -p py312
    (cd py312 && unzip -oq ../py312.zip)
fi
# The embeddable distribution ships a python312._pth that pins sys.path and
# drops the script's own directory, so Tools/build/deepfreeze.py cannot import
# its sibling umarshal.  Rename it away so the interpreter behaves normally.
if [ -f py312/python312._pth ]; then
    mv py312/python312._pth py312/python312._pth.disabled
fi

cd "$SRCDIR"

# --- patch configure.ac and the pre-generated configure (idempotent) -------
# The tarball ships a generated `configure`; the recipe edits configure.ac,
# but unless autoconf is re-run that edit has no effect, so the same two
# substitutions are applied to `configure` itself.
if grep -q -- "-target wasm32-wasi-threads" configure.ac; then
    echo "== patching configure.ac"
    sed -i \
      -e 's/ -target wasm32-wasi-threads -pthread/ -target wasm32-wasip1-threads -pthread/g' \
      -e 's/-Wl,--max-memory=10485760/-Wl,--max-memory=1073741824/g' \
      configure.ac
fi
if grep -q -- "-target wasm32-wasi-threads" configure; then
    echo "== patching configure"
    sed -i \
      -e 's/ -target wasm32-wasi-threads -pthread/ -target wasm32-wasip1-threads -pthread/g' \
      -e 's/-Wl,--max-memory=10485760/-Wl,--max-memory=1073741824/g' \
      configure
fi

# --- configure -------------------------------------------------------------
if [ ! -f Makefile ]; then
    echo "== configure"
    sh Tools/wasm/wasi-env sh configure -C \
        --host=wasm32-unknown-wasi \
        --build=x86_64-pc-mingw64 \
        --enable-wasm-pthreads \
        --with-build-python=C:/stupidspeed/temp/cpython-wasm/py312/python.exe \
        --prefix=/ \
        CONFIG_SITE=Tools/wasm/config.site-wasm32-wasi
fi

# --- build -----------------------------------------------------------------
echo "== make python.wasm"
sh Tools/wasm/wasi-env make -j12 python.wasm

# --- build-time _sysconfigdata ---------------------------------------------
# `make platform` would do this, but it runs the build interpreter with
# `-S -m sysconfig --generate-posix-vars`, and sysconfig._get_sysconfigdata_name()
# reads sys.abiflags, which official Windows CPython builds never define.
# gen_sysconfig.py supplies it and calls the same function.
SYSCONF=$(find build -name '_sysconfigdata_*.py' 2>/dev/null | head -1)
if [ -z "$SYSCONF" ]; then
    echo "== generating _sysconfigdata"
    cat > "$WORK/gen_sysconfig.py" <<'PYEOF'
# Generate CPython's build-time _sysconfigdata module for the wasm target.
#
# `make pybuilddir.txt` runs the build interpreter with
#     -S -m sysconfig --generate-posix-vars
# but sysconfig._get_sysconfigdata_name() reads sys.abiflags unconditionally,
# and official Windows CPython builds never define that attribute.  This
# wrapper supplies it (the wasm target's ABIFLAGS is the empty string) and
# then calls the same function the make rule does.
import sys

sys.abiflags = ""

import sysconfig

sysconfig._generate_posix_vars()
print("generated", sysconfig._get_sysconfigdata_name())
PYEOF
    _PYTHON_PROJECT_BASE="$PWD" \
    _PYTHON_HOST_PLATFORM=wasi-wasm32 \
    PYTHONPATH="$PWD/Lib" \
    _PYTHON_SYSCONFIGDATA_NAME=_sysconfigdata__wasi_wasm32-wasi \
        "$BUILDPY" "$WORK/gen_sysconfig.py"
    SYSCONF=$(find build -name '_sysconfigdata_*.py' 2>/dev/null | head -1)
fi
if [ -z "$SYSCONF" ]; then
    echo "ERROR: _sysconfigdata_*.py not found in build tree" >&2
    exit 1
fi
echo "== _sysconfigdata: $SYSCONF"

# --- install ---------------------------------------------------------------
echo "== installing into $OUT"
mkdir -p "$OUT"
cp -f python.wasm "$OUT/python.wasm"

rm -rf "$OUT/lib"
mkdir -p "$OUT/lib"
cp -r Lib "$OUT/lib/python3.12"
cp -f "$SYSCONF" "$OUT/lib/python3.12/"

echo "== done: $OUT/python.wasm"
