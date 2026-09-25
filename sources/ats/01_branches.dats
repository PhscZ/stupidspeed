// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 01_branches.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 01_branches.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: the four counters are llint, ATS's 64-bit integer; the loop index is int, which covers 99999999.

#include "share/atspre_staload.hats"

implement main0 () = let
  var i: int = 0
  var a: llint = 0LL
  var b: llint = 0LL
  var c: llint = 0LL
  var d: llint = 0LL
in
  while (i < 100000000) (
    if i mod 3 = 0 then a := a + 1LL
    else if i mod 5 = 0 then b := b + 1LL
    else if i mod 7 = 0 then c := c + 1LL
    else d := d + 1LL;
    i := i + 1
  );
  $extfcall (void, "printf", "%lld %lld %lld %lld\n", a, b, c, d)
end
