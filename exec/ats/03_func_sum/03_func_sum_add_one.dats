// task 03 func_sum — expected output: 100000000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 03_func_sum.dats 03_func_sum_add_one.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 03_func_sum.dats 03_func_sum_add_one.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: this is the second translation unit. Keeping add_one here is what stops the inliner, since
//       the caller in 03_func_sum.dats cannot see the body.
// note: ATS_DYNLOADFLAG 0 says this unit needs no initialisation of its own, which is what lets it
//       link as a separate object with no main0 of its own.

#define ATS_DYNLOADFLAG 0

#include "share/atspre_staload.hats"

staload "03_func_sum_add_one.sats"

implement add_one (n) = n + 1LL
