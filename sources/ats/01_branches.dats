// task 01 branches — expected output: 33333334 13333333 7619048 45714285
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 01_branches.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 01_branches.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: the four counters are llint, ATS's 64-bit integer; the loop index is int, which covers 99999999.

#include "share/atspre_staload.hats"

// timing: ss_now_ms() is the monotonic clock of the C reference row (QueryPerformanceCounter on
//         Windows, clock_gettime(CLOCK_MONOTONIC) elsewhere) and ss_report() writes TIME_MS to
//         stderr, so stdout is unchanged. Built and run against ATS 0.4.2 on this machine, so the timing is real.
//         The `int` counts in task 10 needed a syntax pass for 0.4.2 (see BUILD.md).
%{^
#include <stdio.h>
#if defined(_WIN32)
#include <windows.h>
static double ss_now_ms (void) {
  static LARGE_INTEGER ss_freq;
  static int ss_have = 0;
  LARGE_INTEGER now;
  if (!ss_have) { QueryPerformanceFrequency(&ss_freq); ss_have = 1; }
  QueryPerformanceCounter(&now);
  return (double)now.QuadPart * 1000.0 / (double)ss_freq.QuadPart;
}
#else
#include <time.h>
static double ss_now_ms (void) {
  struct timespec ts;
  clock_gettime(CLOCK_MONOTONIC, &ts);
  return (double)ts.tv_sec * 1000.0 + (double)ts.tv_nsec / 1000000.0;
}
#endif
static void ss_report (double ms) {
  fprintf(stderr, "TIME_MS=%.3f\n", ms);
}
%}

implement main0 () = let
  val ss_t0 = $extfcall (double, "ss_now_ms")
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
  $extfcall (void, "ss_report", $extfcall (double, "ss_now_ms") - ss_t0);
  $extfcall (void, "printf", "%lld %lld %lld %lld\n", a, b, c, d)
end
