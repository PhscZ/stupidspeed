// task 05 alloc_churn — expected output: 1274991808
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 05_alloc_churn.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 05_alloc_churn.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: ATS has no garbage collector unless the program asks for one, so the raw 64-byte buffers come
//       from malloc and the buffer a slot replaces is freed, exactly as in the C reference.

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

staload UN = "prelude/SATS/unsafe.sats"

implement main0 () = let
  val ss_t0 = $extfcall (double, "ss_now_ms")
  val slots = arrszref_make_elt<ptr> (i2sz (256), the_null_ptr)
  var i: int = 0
  var total: llint = 0LL
in
  while (i < 10000000) (
    (let
      val buf = $extfcall (ptr, "malloc", i2sz (64))
      val byte = i mod 256
      val k = i mod 256
    in
      $UN.ptr0_set_at_int<uchar> (buf, 0, int2uchar0 (byte));
      total := total + g0int2int_int_llint (byte);
      $extfcall (void, "free", slots[k]);   (* the buffer this slot replaces is released here *)
      slots[k] := buf                       (* keeping buf reachable stops -O2 deleting it *)
    end);
    i := i + 1
  );
  (let
    var k: int = 0
  in
    while (k < 256) (
      $extfcall (void, "free", slots[k]);
      k := k + 1
    )
  end);
  val () = $extfcall (void, "ss_report", $extfcall (double, "ss_now_ms") - ss_t0)
  $extfcall (void, "printf", "%lld\n", total)
end
