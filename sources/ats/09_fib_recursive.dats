// task 09 fib_recursive — expected output: 102334155
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 09_fib_recursive.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 09_fib_recursive.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: no memoisation and no tail call: both calls are real.

#include "share/atspre_staload.hats"

fun fib (n: int): int =
  if n < 2 then n else fib (n - 1) + fib (n - 2)

implement main0 () = $extfcall (void, "printf", "%d\n", fib (40))
