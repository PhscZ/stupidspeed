// task 04 array_sum — expected output: 499999500000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 04_array_sum.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 04_array_sum.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: arrszref is ATS's array reference, so the subscript carries a bounds check. The unchecked
//       prelude accessors in prelude/SATS/unsafe.sats are deliberately not used.

#include "share/atspre_staload.hats"

implement main0 () = let
  val n = 1000000
  val arr = arrszref_make_elt<llint> (i2sz (n), 0LL)
  var i: int = 0
  var total: llint = 0LL
in
  while (i < n) (
    arr[i] := g0int2int_int_llint (i);
    i := i + 1
  );
  i := 0;
  while (i < n) (
    total := total + arr[i];
    i := i + 1
  );
  $extfcall (void, "printf", "%lld\n", total)
end
