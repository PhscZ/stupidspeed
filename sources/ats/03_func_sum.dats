// task 03 func_sum — expected output: 100000000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 03_func_sum.dats 03_func_sum_add_one.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 03_func_sum.dats 03_func_sum_add_one.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: add_one lives in its own translation unit, 03_func_sum_add_one.dats, so -O2 cannot inline
//       the hundred million calls away.

#include "share/atspre_staload.hats"

staload "03_func_sum_add_one.sats"

implement main0 () = let
  var value: llint = 0LL
  var i: int = 0
in
  while (i < 100000000) (
    value := add_one (value);
    i := i + 1
  );
  $extfcall (void, "printf", "%lld\n", value)
end
