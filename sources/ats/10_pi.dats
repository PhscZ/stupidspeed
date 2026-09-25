// task 10 pi — expected output: 44889
// build: patscc -DATS_MEMALLOC_LIBC -O2 -o prog 10_pi.dats    run: ./prog
// note: patscc is a driver: it turns the .dats into C with patsopt and then runs a C compiler,
//       so $PATSHOME/bin has to be on PATH.
// note: mingw-w64 row: patscc -DATS_MEMALLOC_LIBC -O2 -atsccomp "$MINGWCC" -o prog 10_pi.dats
// note:   MINGWCC='x86_64-w64-mingw32-gcc -std=c99 -D_XOPEN_SOURCE -I$PATSHOME -I$PATSHOME/ccomp/runtime -DATS_MEMALLOC_LIBC'
// note: Gibbons' unbounded spigot runs on arbitrary-precision integers, which ATS has no library for,
//       so the state is kept in hand-written big integers: sign-magnitude, little-endian 64-bit limbs,
//       base 1e9. Only the operations the spigot needs are here: add, subtract, multiply by a small
//       int (limb * small + carry fits in 64 bits for small < 2^32), and a quotient, which is always
//       one decimal digit and so comes out of repeated subtraction. The limbs are malloc'd and
//       realloc'd through $extfcall, and read and written with the unchecked pointer accessors from
//       prelude/SATS/unsafe.sats, since the length is a runtime value. The digits themselves are never
//       printed, only their sum.

#include "share/atspre_staload.hats"

staload UN = "prelude/SATS/unsafe.sats"

%{^
#include <stdlib.h>
%}

#define BASE 1000000000LL

typedef big = @{ limb = ptr, n = int, cap = int, neg = int }

(* ****** ****** *)

fun big_init (x: &big >> _): void = let
  val p = $extfcall (ptr, "malloc", i2sz (8 * 8))
in
  x.limb := p; x.n := 0; x.cap := 8; x.neg := 0
end

fun big_reserve (x: &big >> _, need: int): void =
  if need <= x.cap then () else
    (let
      var cap = x.cap
    in
      while (cap < need) (cap := cap * 2);
      x.limb := $extfcall (ptr, "realloc", x.limb, i2sz (cap * 8));
      x.cap := cap
    end)

fun big_trim (x: &big >> _): void = let
  var go: bool = true
in
  while (go) (
    if x.n <= 0 then go := false
    else (if $UN.ptr0_get_at_int<llint> (x.limb, x.n - 1) = 0LL
          then x.n := x.n - 1
          else go := false)
  );
  if x.n = 0 then x.neg := 0 else ()
end

fun big_set (x: &big >> _, v0: llint): void = let
  var v = v0
in
  x.n := 0; x.neg := 0;
  while (v > 0LL) (
    big_reserve (x, x.n + 1);
    $UN.ptr0_set_at_int<llint> (x.limb, x.n, v mod BASE);
    x.n := x.n + 1;
    v := v / BASE
  )
end

fun big_copy (dst: &big >> _, src: &big): void = let
in
  big_reserve (dst, src.n);
  (let
    var i: int = 0
  in
    while (i < src.n) (
      $UN.ptr0_set_at_int<llint> (dst.limb, i, $UN.ptr0_get_at_int<llint> (src.limb, i));
      i := i + 1
    )
  end);
  dst.n := src.n;
  dst.neg := src.neg
end

(* ****** ****** *)

fun big_cmp_mag (a: &big, b: &big): int =
  if a.n != b.n then (if a.n < b.n then ~1 else 1) else
    (let
      var i: int = a.n
      var res: int = 0
      var go: bool = true
    in
      while (go) (
        if i <= 0 then go := false
        else (i := i - 1;
              (let
                val x = $UN.ptr0_get_at_int<llint> (a.limb, i)
                val y = $UN.ptr0_get_at_int<llint> (b.limb, i)
              in
                if x != y then (res := (if x < y then ~1 else 1); go := false) else ()
              end))
      );
      res
    end)

fun big_cmp (a: &big, b: &big): int =
  if a.neg != b.neg then (if a.neg != 0 then ~1 else 1) else
    (let
      val c = big_cmp_mag (a, b)
    in
      if a.neg != 0 then ~c else c
    end)

(* ****** ****** *)

fun big_add_mag (r: &big >> _, a: &big, b: &big): void = let
  val m = (if a.n > b.n then a.n else b.n)
in
  big_reserve (r, m + 1);
  (let
    var i: int = 0
    var carry: llint = 0LL
  in
    while (i < m) (
      (let
        var s = carry
      in
        (if i < a.n then s := s + $UN.ptr0_get_at_int<llint> (a.limb, i) else ());
        (if i < b.n then s := s + $UN.ptr0_get_at_int<llint> (b.limb, i) else ());
        (if s >= BASE then (s := s - BASE; carry := 1LL) else carry := 0LL);
        $UN.ptr0_set_at_int<llint> (r.limb, i, s)
      end);
      i := i + 1
    );
    $UN.ptr0_set_at_int<llint> (r.limb, m, carry);
    r.n := m + (if carry != 0LL then 1 else 0);
    r.neg := 0
  end)
end

(* requires a >= b >= 0 *)
fun big_sub_mag (r: &big >> _, a: &big, b: &big): void = let
in
  big_reserve (r, a.n);
  (let
    var i: int = 0
    var borrow: llint = 0LL
  in
    while (i < a.n) (
      (let
        val bi = (if i < b.n then $UN.ptr0_get_at_int<llint> (b.limb, i) else 0LL) + borrow
        val ai = $UN.ptr0_get_at_int<llint> (a.limb, i)
      in
        if ai >= bi then ($UN.ptr0_set_at_int<llint> (r.limb, i, ai - bi); borrow := 0LL)
        else ($UN.ptr0_set_at_int<llint> (r.limb, i, ai + BASE - bi); borrow := 1LL)
      end);
      i := i + 1
    );
    r.n := a.n;
    r.neg := 0
  end);
  big_trim (r)
end

fun big_add (r: &big >> _, a: &big, b: &big): void = let
  val an = a.neg
  val bn = b.neg
in
  if an = bn then (big_add_mag (r, a, b); r.neg := an)
  else (if big_cmp_mag (a, b) >= 0
        then (big_sub_mag (r, a, b); r.neg := an)
        else (big_sub_mag (r, b, a); r.neg := bn));
  big_trim (r)
end

fun big_sub (r: &big >> _, a: &big, b: &big): void = let
  val an = a.neg
  val bn = b.neg
in
  if an != bn then (big_add_mag (r, a, b); r.neg := an)
  else (if big_cmp_mag (a, b) >= 0
        then (big_sub_mag (r, a, b); r.neg := an)
        else (big_sub_mag (r, b, a); r.neg := (if an = 0 then 1 else 0)));
  big_trim (r)
end

fun big_mul_small (r: &big >> _, a: &big, m: llint): void =
  if m = 0LL then (r.n := 0; r.neg := 0) else
  (if a.n = 0 then (r.n := 0; r.neg := 0) else
    (let
      val an = a.n
      val aneg = a.neg
    in
      big_reserve (r, an + 2);
      (let
        var i: int = 0
        var carry: llint = 0LL
      in
        while (i < an) (
          (let
            val p = $UN.ptr0_get_at_int<llint> (a.limb, i) * m + carry
          in
            $UN.ptr0_set_at_int<llint> (r.limb, i, p mod BASE);
            carry := p / BASE
          end);
          i := i + 1
        );
        (let
          var j: int = an
        in
          while (carry > 0LL) (
            $UN.ptr0_set_at_int<llint> (r.limb, j, carry mod BASE);
            j := j + 1;
            carry := carry / BASE
          );
          r.n := j
        end)
      end);
      r.neg := aneg;
      big_trim (r)
    end))

(* floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a quotient of one decimal
   digit, so counting how many times b fits into a is enough. *)
fun big_quot (a: &big, b: &big, work: &big >> _): llint = let
  var q: llint = 0LL
in
  if a.neg != 0 then 0LL
  else (if b.neg != 0 then 0LL
        else (if b.n = 0 then 0LL
              else (
                big_copy (work, b);
                while (big_cmp (a, work) >= 0) (
                  q := q + 1LL;
                  big_add_mag (work, work, b)
                );
                q
              )))
end

(* ****** ****** *)

implement main0 () = let
  var q: big = @{ limb = the_null_ptr, n = 0, cap = 0, neg = 0 }
  var r: big = @{ limb = the_null_ptr, n = 0, cap = 0, neg = 0 }
  var t: big = @{ limb = the_null_ptr, n = 0, cap = 0, neg = 0 }
  var u: big = @{ limb = the_null_ptr, n = 0, cap = 0, neg = 0 }
  var v: big = @{ limb = the_null_ptr, n = 0, cap = 0, neg = 0 }
  var w: big = @{ limb = the_null_ptr, n = 0, cap = 0, neg = 0 }
  var k: llint = 1LL
  var l: llint = 3LL
  var n: llint = 3LL
  var sum: llint = 0LL
  var produced: int = 0
in
  big_init (q); big_init (r); big_init (t);
  big_init (u); big_init (v); big_init (w);
  big_set (q, 1LL);
  big_set (r, 0LL);
  big_set (t, 1LL);
  while (produced < 10000) (
    big_mul_small (u, q, 4LL);
    big_add (u, u, r);                   (* u = 4q + r *)
    big_mul_small (v, t, n + 1LL);       (* v = (n + 1)t *)
    if big_cmp (u, v) < 0 then (
      (* the digit n is settled *)
      sum := sum + n;
      produced := produced + 1;
      big_mul_small (u, q, 3LL);
      big_add (u, u, r);
      big_mul_small (u, u, 10LL);        (* u = 10(3q + r) *)
      (let
        val next = big_quot (u, t, w) - 10LL * n
      in
        big_mul_small (v, t, n);         (* v = n t *)
        big_sub (v, r, v);               (* v = r - n t *)
        big_mul_small (r, v, 10LL);      (* r = 10(r - n t) *)
        big_mul_small (q, q, 10LL);      (* q = 10q, t is unchanged *)
        n := next
      end)
    ) else (
      (* not settled yet: widen the state by one more term *)
      big_mul_small (u, q, 7LL * k + 2LL);
      big_mul_small (v, r, l);
      big_add (u, u, v);                 (* u = q(7k + 2) + r l *)
      big_mul_small (v, t, l);           (* v = t l *)
      (let
        val next = big_quot (u, v, w)
      in
        big_mul_small (u, q, 2LL);
        big_add (u, u, r);
        big_mul_small (u, u, l);         (* u = (2q + r) l *)
        big_copy (r, u);
        big_mul_small (q, q, k);
        big_mul_small (t, t, l);
        k := k + 1LL;
        l := l + 2LL;
        n := next
      end)
    )
  );
  $extfcall (void, "printf", "%lld\n", sum)
end
