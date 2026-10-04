// task 15 file_write — expected output: 52428800
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 15_file_write.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 15_file_write.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: out.bin lands in the working directory. ATS's prelude has no bulk write, so the 1 MiB buffer
//       goes out through stdio's fopen/fwrite/fflush/fclose, the same way the C reference writes it.
// note: the buffer is filled with the unchecked pointer accessor from prelude/SATS/unsafe.sats; there
//       is no safe alternative for a raw 1 MiB byte buffer.

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
#include <stdio.h>
//
// ATS has no portable sync call, so the last step goes through this two-line shim:
// _commit on a native Windows target, fsync on Cygwin.
//
#if defined(_WIN32)
#include <io.h>
static int ats_fsync (FILE *f) { return _commit (_fileno (f)) ; }
#else
#include <unistd.h>
static int ats_fsync (FILE *f) { return fsync (fileno (f)) ; }
#endif
%}

implement main0 () = let
  val ss_t0 = $extfcall (double, "ss_now_ms")
  val chunk = 1048576
  val buf = $extfcall (ptr, "malloc", i2sz (chunk))
  val f = $extfcall (ptr, "fopen", "out.bin", "wb")
  var i: int = 0
  var rep: int = 0
  var written: llint = 0LL
in
  while (i < chunk) (
    $UN.ptr0_set_at_int<uchar> (buf, i, int2uchar0 (i mod 256));
    i := i + 1
  );
  if $UN.cast{ulint} (f) = 0UL then () else (
    while (rep < 50) (
      written := written
        + g0int2int_int_llint ($extfcall (int, "fwrite", buf, i2sz (1), i2sz (chunk), f));
      rep := rep + 1
    );
    $extfcall (void, "fflush", f);
    $extfcall (void, "ats_fsync", f);
    $extfcall (void, "fclose", f);
    val () = $extfcall (void, "ss_report", $extfcall (double, "ss_now_ms") - ss_t0)
    $extfcall (void, "printf", "%lld\n", written)
  )
end
