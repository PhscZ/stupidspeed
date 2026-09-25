// task 15 file_write — expected output: 104857600
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 15_file_write.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 15_file_write.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: out.bin lands in the working directory. ATS's prelude has no bulk write, so the 1 MiB buffer
//       goes out through stdio's fopen/fwrite/fflush/fclose, the same way the C reference writes it.
// note: the buffer is filled with the unchecked pointer accessor from prelude/SATS/unsafe.sats; there
//       is no safe alternative for a raw 1 MiB byte buffer.

#include "share/atspre_staload.hats"

staload UN = "prelude/SATS/unsafe.sats"

%{^
#include <stdio.h>
//
// ATS has no portable sync call, so the last step goes through this two-line shim:
// _commit on a native Windows target, fsync on Cygwin.
//
#if defined(_WIN32)
#include <io.h>
static int ats_fsync (FILE *f) { return _commit (_fileno (f)) ; }
#else
#include <unistd.h>
static int ats_fsync (FILE *f) { return fsync (fileno (f)) ; }
#endif
%}

implement main0 () = let
  val chunk = 1048576
  val buf = $extfcall (ptr, "malloc", i2sz (chunk))
  val f = $extfcall (ptr, "fopen", "out.bin", "wb")
  var i: int = 0
  var rep: int = 0
  var written: llint = 0LL
in
  while (i < chunk) (
    $UN.ptr0_set_at_int<uchar> (buf, i, int2uchar0 (i mod 256));
    i := i + 1
  );
  if $UN.cast{ulint} (f) = 0UL then () else (
    while (rep < 100) (
      written := written
        + g0int2int_int_llint ($extfcall (int, "fwrite", buf, i2sz (1), i2sz (chunk), f));
      rep := rep + 1
    );
    $extfcall (void, "fflush", f);
    $extfcall (void, "ats_fsync", f);
    $extfcall (void, "fclose", f);
    $extfcall (void, "printf", "%lld\n", written)
  )
end
