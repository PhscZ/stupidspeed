#!/usr/bin/env python3
"""Fetch the libstdc++-6.dll the GNUstep runtime needs, once.

`gnustep-base-1_31.dll` (the MSYS2 ucrt64 package the objectivec row links) was
built against gcc-libs **16.1.0-3** and imports five `std::__format` symbols
that the tree's current libstdc++ 16.2.0 no longer exports.  Five of the row's
programs link Foundation and therefore load it, and without the older DLL they
die before `main` with 0xC0000139 (`STATUS_ENTRYPOINT_NOT_FOUND`) and no output.

The DLL is fetched from the MSYS2 archive into `exec/objectivec/vendor/`; the
package is 1.1 MiB and the one file kept from it is 2.6 MiB.  Nothing under
`tools/` is modified.

    python exec/objectivec/fetch_libstdcxx.py
"""
import io
import os
import sys
import tarfile
import urllib.request

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
VENDOR = os.path.join(ROOT, "exec", "objectivec", "vendor")
TARGET = os.path.join(VENDOR, "libstdc++-6.dll")
URL = ("https://repo.msys2.org/mingw/ucrt64/"
       "mingw-w64-ucrt-x86_64-gcc-libs-16.1.0-3-any.pkg.tar.zst")


def main():
    if os.path.exists(TARGET):
        print("%s: present" % TARGET)
        return 0
    os.makedirs(VENDOR, exist_ok=True)
    print("downloading %s" % URL)
    blob = urllib.request.urlopen(URL, timeout=120).read()
    import subprocess
    zstd = os.path.join(ROOT, "tools", "msys64", "msys64", "usr", "bin", "zstd.exe")
    tar = os.path.join(ROOT, "tools", "msys64", "msys64", "usr", "bin", "tar.exe")
    pkg = os.path.join(VENDOR, "gcc-libs.pkg.tar")
    with open(pkg + ".zst", "wb") as fh:
        fh.write(blob)
    subprocess.run([zstd, "-d", "-f", pkg + ".zst", "-o", pkg], check=True)
    with tarfile.open(pkg) as tf:
        member = tf.getmember("ucrt64/bin/libstdc++-6.dll")
        with open(TARGET, "wb") as fh:
            fh.write(tf.extractfile(member).read())
    os.remove(pkg)
    os.remove(pkg + ".zst")
    print("%s: %d bytes" % (TARGET, os.path.getsize(TARGET)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
