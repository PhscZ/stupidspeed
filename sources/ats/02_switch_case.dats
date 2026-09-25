// task 02 switch_case — expected output: 7500000075000000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 02_switch_case.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 02_switch_case.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: ATS's case+ on an integer becomes a C switch; llint is the 64-bit integer the total needs.

#include "share/atspre_staload.hats"

implement main0 () = let
  var i: llint = 0LL
  var acc: llint = 0LL
in
  while (i < 100000000LL) (
    (case+ (i mod 4LL) of
      | 0LL => acc := acc + 1LL
      | 1LL => acc := acc + i
      | 2LL => acc := acc + 2LL * i
      | 3LL => acc := acc + 3LL * i
      | _ => ());
    i := i + 1LL
  );
  $extfcall (void, "printf", "%lld\n", acc)
end
