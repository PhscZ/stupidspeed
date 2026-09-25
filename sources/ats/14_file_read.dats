// task 14 file_read — expected output: 484442112
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 14_file_read.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 14_file_read.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: data.bin has to be in the working directory. ATS's prelude has no bulk read, so the file goes
//       through stdio's fopen/fread/fclose, the same way the C reference reads it.
// note: the byte sums are read with the unchecked pointer accessor from prelude/SATS/unsafe.sats; there
//       is no safe alternative for a raw 1 MiB byte buffer.

#include "share/atspre_staload.hats"

staload UN = "prelude/SATS/unsafe.sats"

%{^
#include <stdio.h>
%}

implement main0 () = let
  val chunk = 1048576
  val f = $extfcall (ptr, "fopen", "data.bin", "rb")
  val buf = $extfcall (ptr, "malloc", i2sz (chunk))
  var total: llint = 0LL
  var got: int = 1
in
  if $UN.cast{ulint} (f) = 0UL then () else (
    while (got > 0) (
      got := $extfcall (int, "fread", buf, i2sz (1), i2sz (chunk), f);
      (let
        var i: int = 0
      in
        while (i < got) (
          total := total + g0int2int_int_llint (uchar2int0 ($UN.ptr0_get_at_int<uchar> (buf, i)));
          i := i + 1
        )
      end)
    );
    $extfcall (void, "fclose", f);
    $extfcall (void, "printf", "%lld\n", total mod 4294967296LL)
  )
end
