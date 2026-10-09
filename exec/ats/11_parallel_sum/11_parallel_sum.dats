// task 11 parallel_sum — expected output: 7500000075000000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 11_parallel_sum.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 11_parallel_sum.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: ATS has no threading in the prelude, so the four threads are the Win32 ones: CreateThread,
//       WaitForSingleObject, CloseHandle, reached through $extfcall. The worker is a plain ATS
//       function, whose address is what CreateThread is handed.
// note: each thread gets its own 16-byte job block: slot 0 is its range number, slot 1 is where it
//       leaves its partial sum.

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

%{^
#include <windows.h>
%}

fun worker (job: ptr): uint = let
  val t = $UN.ptr0_get_at_int<llint> (job, 0)
  var i: llint = t * 25000000LL
  val hi = i + 25000000LL
  var acc: llint = 0LL
in
  while (i < hi) (
    (case+ (i mod 4LL) of
      | 0LL => acc := acc + 1LL
      | 1LL => acc := acc + i
      | 2LL => acc := acc + 2LL * i
      | 3LL => acc := acc + 3LL * i
      | _ => ());
    i := i + 1LL
  );
  $UN.ptr0_set_at_int<llint> (job, 1, acc);
  0u
end

implement main0 () = let
  val ss_t0 = $extfcall (double, "ss_now_ms")
  val p0 = $extfcall (ptr, "malloc", i2sz (16))
  val p1 = $extfcall (ptr, "malloc", i2sz (16))
  val p2 = $extfcall (ptr, "malloc", i2sz (16))
  val p3 = $extfcall (ptr, "malloc", i2sz (16))
  val () = $UN.ptr0_set_at_int<llint> (p0, 0, 0LL)
  val () = $UN.ptr0_set_at_int<llint> (p1, 0, 1LL)
  val () = $UN.ptr0_set_at_int<llint> (p2, 0, 2LL)
  val () = $UN.ptr0_set_at_int<llint> (p3, 0, 3LL)
  val h0 = $extfcall (ptr, "CreateThread", the_null_ptr, i2sz (0), worker, p0, 0u, the_null_ptr)
  val h1 = $extfcall (ptr, "CreateThread", the_null_ptr, i2sz (0), worker, p1, 0u, the_null_ptr)
  val h2 = $extfcall (ptr, "CreateThread", the_null_ptr, i2sz (0), worker, p2, 0u, the_null_ptr)
  val h3 = $extfcall (ptr, "CreateThread", the_null_ptr, i2sz (0), worker, p3, 0u, the_null_ptr)
in
  $extfcall (void, "WaitForSingleObject", h0, 4294967295u);   (* INFINITE *)
  $extfcall (void, "WaitForSingleObject", h1, 4294967295u);
  $extfcall (void, "WaitForSingleObject", h2, 4294967295u);
  $extfcall (void, "WaitForSingleObject", h3, 4294967295u);
  $extfcall (void, "CloseHandle", h0);
  $extfcall (void, "CloseHandle", h1);
  $extfcall (void, "CloseHandle", h2);
  $extfcall (void, "CloseHandle", h3);
  $extfcall (void, "ss_report", $extfcall (double, "ss_now_ms") - ss_t0);
  $extfcall (void, "printf", "%lld\n",
      $UN.ptr0_get_at_int<llint> (p0, 1)
    + $UN.ptr0_get_at_int<llint> (p1, 1)
    + $UN.ptr0_get_at_int<llint> (p2, 1)
    + $UN.ptr0_get_at_int<llint> (p3, 1))
end
