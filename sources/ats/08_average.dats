// task 08 average — expected output: 0.498046875
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 08_average.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 08_average.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: the answer is printed through printf with %.9f; ATS's own print_double stops at six decimals.

#include "share/atspre_staload.hats"

implement main0 () = let
  var total: double = 0.0
  var i: int = 0
in
  while (i < 100000000) (
    total := total + g0int2float_int_double (i mod 256) / 256.0;
    i := i + 1
  );
  $extfcall (void, "printf", "%.9f\n", total / 100000000.0)
end
