// task 12 matrix_add — expected output: 999000000
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 12_matrix_add.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 12_matrix_add.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: the three 1000x1000 matrices are flat 1000000-element arrays indexed i*n+j, the same shape
//       the C reference uses.
// note: the subscript is arrszref's, so it is bounds-checked. The unchecked prelude accessors in
//       prelude/SATS/unsafe.sats are deliberately not used.

#include "share/atspre_staload.hats"

implement main0 () = let
  val n = 1000
  val elems = 1000000
  val a = arrszref_make_elt<llint> (i2sz (elems), 0LL)
  val b = arrszref_make_elt<llint> (i2sz (elems), 0LL)
  val c = arrszref_make_elt<llint> (i2sz (elems), 0LL)
  var i: int = 0
  var k: int = 0
  var total: llint = 0LL
in
  while (i < n) (
    (let
      var j: int = 0
    in
      while (j < n) (
        a[i*n+j] := g0int2int_int_llint (i + j);
        b[i*n+j] := g0int2int_int_llint (i - j);
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
        c[i*n+j] := a[i*n+j] + b[i*n+j];
        j := j + 1
      )
    end);
    i := i + 1
  );
  while (k < elems) (
    total := total + c[k];
    k := k + 1
  );
  $extfcall (void, "printf", "%lld\n", total)
end
