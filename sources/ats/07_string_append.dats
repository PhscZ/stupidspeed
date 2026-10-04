// task 07 string_append — expected output: 250000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 07_string_append.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 07_string_append.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: ATS's string is immutable and the prelude has no growable string, so text = text + "x" is done
//       the way the C reference does it: realloc to len+2 and strcat, which walks the whole string.
//       The loop is quadratic, which is the point of the task.

#include "share/atspre_staload.hats"

// timing: ss_now_ms() is the monotonic clock of the C reference row (QueryPerformanceCounter on
//         Windows, clock_gettime(CLOCK_MONOTONIC) elsewhere) and ss_report() writes TIME_MS to
//         stderr, so stdout is unchanged. Instrumented by inspection: there is no ATS toolchain on
//         this machine, so this row's timing is unverified.
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

%{^
#include <string.h>
%}

implement main0 () = let
  val ss_t0 = $extfcall (double, "ss_now_ms")
  var text = $extfcall (ptr, "malloc", i2sz (1))
  var len: int = 0
  var i: int = 0
  val () = $extfcall (void, "strcpy", text, "")
in
  while (i < 250000) (
    len := len + 1;
    text := $extfcall (ptr, "realloc", text, i2sz (len + 2));
    $extfcall (void, "strcat", text, "x");
    i := i + 1
  );
  val () = $extfcall (void, "ss_report", $extfcall (double, "ss_now_ms") - ss_t0)
  $extfcall (void, "printf", "%llu\n", $extfcall (ulint, "strlen", text));
  $extfcall (void, "free", text)
end
