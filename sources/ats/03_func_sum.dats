// task 03 func_sum — expected output: 100000000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 03_func_sum.dats 03_func_sum_add_one.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 03_func_sum.dats 03_func_sum_add_one.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: add_one lives in its own translation unit, 03_func_sum_add_one.dats, so -O2 cannot inline
//       the hundred million calls away.

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

staload "03_func_sum_add_one.sats"

implement main0 () = let
  val ss_t0 = $extfcall (double, "ss_now_ms")
  var value: llint = 0LL
  var i: int = 0
in
  while (i < 100000000) (
    value := add_one (value);
    i := i + 1
  );
  $extfcall (void, "ss_report", $extfcall (double, "ss_now_ms") - ss_t0);
  $extfcall (void, "printf", "%lld\n", value)
end
