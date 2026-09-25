// task 07 string_append — expected output: 1000000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 07_string_append.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 07_string_append.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: ATS's string is immutable and the prelude has no growable string, so text = text + "x" is done
//       the way the C reference does it: realloc to len+2 and strcat, which walks the whole string.
//       The loop is quadratic, which is the point of the task.

#include "share/atspre_staload.hats"

%{^
#include <string.h>
%}

implement main0 () = let
  var text = $extfcall (ptr, "malloc", i2sz (1))
  var len: int = 0
  var i: int = 0
  val () = $extfcall (void, "strcpy", text, "")
in
  while (i < 1000000) (
    len := len + 1;
    text := $extfcall (ptr, "realloc", text, i2sz (len + 2));
    $extfcall (void, "strcat", text, "x");
    i := i + 1
  );
  $extfcall (void, "printf", "%llu\n", $extfcall (ulint, "strlen", text));
  $extfcall (void, "free", text)
end
