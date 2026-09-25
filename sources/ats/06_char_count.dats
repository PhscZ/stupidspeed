// task 06 char_count — expected output: 10000000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 06_char_count.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 06_char_count.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: ATS's string type is immutable and the prelude has no repeat or builder, so the 100 MB text is
//       a char array and the whole ten-character block is written per iteration. Nothing is appended.
// note: the subscript is arrszref's, so it is bounds-checked. The unchecked prelude accessors in
//       prelude/SATS/unsafe.sats are deliberately not used.

#include "share/atspre_staload.hats"

implement main0 () = let
  val n = 100000000
  val text = arrszref_make_elt<char> (i2sz (n), 'a')
  var i: int = 0
  var count: llint = 0LL
in
  (* the whole 100 MB text is built up front, one ten-character block at a time *)
  while (i < n) (
    text[i] := 'a';
    text[i+1] := 'b';
    text[i+2] := 'c';
    text[i+3] := 'd';
    text[i+4] := 'e';
    text[i+5] := 'f';
    text[i+6] := 'g';
    text[i+7] := 'h';
    text[i+8] := 'i';
    text[i+9] := 'j';
    i := i + 10
  );
  i := 0;
  while (i < n) (
    if text[i] = 'a' then ()
    else if text[i] = 'e' then ()
    else if text[i] = 'h' then count := count + 1LL
    else ();
    i := i + 1
  );
  $extfcall (void, "printf", "%lld\n", count)
end
