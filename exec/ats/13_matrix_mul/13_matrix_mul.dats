// task 13 matrix_mul — expected output: 599995000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 13_matrix_mul.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 13_matrix_mul.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: the three 500x500 matrices are flat 250000-element arrays indexed i*n+j, and the product
//       runs as a plain i, j, k triple loop in that order, the same shape the C reference uses.
// note: the subscript is arrszref's, so it is bounds-checked. The unchecked prelude accessors in
//       prelude/SATS/unsafe.sats are deliberately not used.

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

implement main0 () = let
  val ss_t0 = $extfcall (double, "ss_now_ms")
  val n = 500
  val elems = 250000
  val a = arrszref_make_elt<llint> (i2sz (elems), 0LL)
  val b = arrszref_make_elt<llint> (i2sz (elems), 0LL)
  val c = arrszref_make_elt<llint> (i2sz (elems), 0LL)
  var i: int = 0
  var m: int = 0
  var total: llint = 0LL
in
  while (i < n) (
    (let
      var j: int = 0
    in
      while (j < n) (
        a[i*n+j] := g0int2int_int_llint ((i + j) mod 7);
        b[i*n+j] := g0int2int_int_llint ((i * j) mod 5);
        j := j + 1
      )
    end);
    i := i + 1
  );
  i := 0;
  while (i < n) (
    (let
      var j: int = 0
    in
      while (j < n) (
        (let
          var k: int = 0
          var sum: llint = 0LL
        in
          while (k < n) (
            sum := sum + a[i*n+k] * b[k*n+j];
            k := k + 1
          );
          c[i*n+j] := sum
        end);
        j := j + 1
      )
    end);
    i := i + 1
  );
  while (m < elems) (
    total := total + c[m];
    m := m + 1
  );
  $extfcall (void, "ss_report", $extfcall (double, "ss_now_ms") - ss_t0);
  $extfcall (void, "printf", "%lld\n", total)
end
