(* task 10 pi — expected output: 44889 *)
(* build: CFLAGS=-O2 voc 10_pi.mod -m    run: ./Pi *)
(* note: Oberon-2 has no big integers, so the state of Gibbons' unbounded spigot is *)
(*       held in hand written sign-magnitude big integers: little-endian limbs, base *)
(*       10^9, stored in HUGEINT (voc's 64 bit integer, needed because limb * small *)
(*       overflows 32 bit LONGINT). Only add, subtract, multiply by a small integer *)
(*       and a quotient are implemented; the quotient is always small, so repeated *)
(*       subtraction finds it. Only the sum of the digits is printed. *)
(* note: the spigot state reaches roughly 145000 decimal digits by the 10000th digit, *)
(*       so the limb arrays are sized well past that. *)

MODULE Pi;
IMPORT Out;

CONST
  Base  = 1000000000;
  Limbs = 32768;
  Digits = 10000;

TYPE
  Big = RECORD
    n:    LONGINT;                    (* limb count, no leading zero limbs *)
    neg:  BOOLEAN;
    limb: ARRAY Limbs OF HUGEINT
  END;

VAR
  q, r, t, u, v, w: Big;
  k, l, n, next: HUGEINT;
  sum: HUGEINT;
  produced: LONGINT;

PROCEDURE Trim(VAR x: Big);
BEGIN
  WHILE (x.n > 0) & (x.limb[x.n - 1] = 0) DO DEC(x.n) END;
  IF x.n = 0 THEN x.neg := FALSE END
END Trim;

PROCEDURE Set(VAR x: Big; v: HUGEINT);
BEGIN
  x.n := 0; x.neg := FALSE;
  WHILE v > 0 DO
    x.limb[x.n] := v MOD Base;
    INC(x.n);
    v := v DIV Base
  END
END Set;

PROCEDURE CopyLimbs(VAR dst, src: Big);
VAR i: LONGINT;
BEGIN
  i := 0;
  WHILE i < src.n DO dst.limb[i] := src.limb[i]; INC(i) END;
  dst.n := src.n; dst.neg := src.neg
END CopyLimbs;

PROCEDURE CmpMag(VAR a, b: Big): INTEGER;
VAR i: LONGINT;
BEGIN
  IF a.n # b.n THEN
    IF a.n < b.n THEN RETURN -1 ELSE RETURN 1 END
  END;
  i := a.n;
  WHILE i > 0 DO
    DEC(i);
    IF a.limb[i] # b.limb[i] THEN
      IF a.limb[i] < b.limb[i] THEN RETURN -1 ELSE RETURN 1 END
    END
  END;
  RETURN 0
END CmpMag;

PROCEDURE Cmp(VAR a, b: Big): INTEGER;
VAR c: INTEGER;
BEGIN
  IF a.neg # b.neg THEN
    IF a.neg THEN RETURN -1 ELSE RETURN 1 END
  END;
  c := CmpMag(a, b);
  IF a.neg THEN RETURN -c ELSE RETURN c END
END Cmp;

PROCEDURE AddMag(VAR r: Big; VAR a, b: Big);
VAR i, n: LONGINT; carry, s: HUGEINT;
BEGIN
  IF a.n > b.n THEN n := a.n ELSE n := b.n END;
  carry := 0;
  FOR i := 0 TO n - 1 DO
    s := carry;
    IF i < a.n THEN s := s + a.limb[i] END;
    IF i < b.n THEN s := s + b.limb[i] END;
    IF s >= Base THEN s := s - Base; carry := 1 ELSE carry := 0 END;
    r.limb[i] := s
  END;
  r.limb[n] := carry;
  IF carry # 0 THEN r.n := n + 1 ELSE r.n := n END;
  r.neg := FALSE
END AddMag;

PROCEDURE SubMag(VAR r: Big; VAR a, b: Big);   (* requires a >= b >= 0 *)
VAR i: LONGINT; borrow, bi: HUGEINT;
BEGIN
  borrow := 0;
  FOR i := 0 TO a.n - 1 DO
    bi := borrow;
    IF i < b.n THEN bi := bi + b.limb[i] END;
    IF a.limb[i] >= bi THEN
      r.limb[i] := a.limb[i] - bi; borrow := 0
    ELSE
      r.limb[i] := a.limb[i] + Base - bi; borrow := 1
    END
  END;
  r.n := a.n; r.neg := FALSE;
  Trim(r)
END SubMag;

PROCEDURE Add(VAR r: Big; VAR a, b: Big);
VAR an, bn: BOOLEAN;
BEGIN
  an := a.neg; bn := b.neg;
  IF an = bn THEN
    AddMag(r, a, b); r.neg := an
  ELSIF CmpMag(a, b) >= 0 THEN
    SubMag(r, a, b); r.neg := an
  ELSE
    SubMag(r, b, a); r.neg := bn
  END;
  Trim(r)
END Add;

PROCEDURE Sub(VAR r: Big; VAR a, b: Big);      (* r = a - b *)
VAR an: BOOLEAN;
BEGIN
  an := a.neg;
  IF a.neg # b.neg THEN
    AddMag(r, a, b); r.neg := an
  ELSIF CmpMag(a, b) >= 0 THEN
    SubMag(r, a, b); r.neg := an
  ELSE
    SubMag(r, b, a); r.neg := ~an
  END;
  Trim(r)
END Sub;

PROCEDURE MulSmall(VAR r: Big; VAR a: Big; m: HUGEINT);
VAR i, n: LONGINT; carry, p: HUGEINT;
BEGIN
  IF (m = 0) OR (a.n = 0) THEN r.n := 0; r.neg := FALSE; RETURN END;
  carry := 0;
  FOR i := 0 TO a.n - 1 DO
    p := a.limb[i] * m + carry;
    r.limb[i] := p MOD Base;
    carry := p DIV Base
  END;
  n := a.n;
  WHILE carry > 0 DO
    r.limb[n] := carry MOD Base;
    INC(n);
    carry := carry DIV Base
  END;
  r.n := n; r.neg := a.neg;
  Trim(r)
END MulSmall;

(* floor(a / b) for a >= 0 and b > 0. The spigot only ever asks for a small quotient, *)
(* so counting how many times b fits into a is enough. *)
PROCEDURE Quot(VAR a, b: Big; VAR work: Big): HUGEINT;
VAR q: HUGEINT;
BEGIN
  q := 0;
  IF a.neg OR b.neg OR (b.n = 0) THEN RETURN 0 END;
  CopyLimbs(work, b);
  WHILE Cmp(a, work) >= 0 DO
    INC(q);
    AddMag(work, work, b)
  END;
  RETURN q
END Quot;

BEGIN
  Set(q, 1);
  Set(r, 0);
  Set(t, 1);

  k := 1; l := 3; n := 3;
  sum := 0; produced := 0;

  WHILE produced < Digits DO
    MulSmall(u, q, 4);
    Add(u, u, r);                    (* u = 4q + r *)
    MulSmall(v, t, n + 1);           (* v = (n + 1)t *)

    IF Cmp(u, v) < 0 THEN
      (* the digit n is settled *)
      sum := sum + n;
      INC(produced);

      MulSmall(u, q, 3);
      Add(u, u, r);
      MulSmall(u, u, 10);            (* u = 10(3q + r) *)
      next := Quot(u, t, w) - 10 * n;

      MulSmall(v, t, n);             (* v = n t *)
      Sub(v, r, v);                  (* v = r - n t *)
      MulSmall(r, v, 10);            (* r = 10(r - n t) *)
      MulSmall(q, q, 10);            (* q = 10q, t is unchanged *)

      n := next
    ELSE
      (* not settled yet: widen the state by one more term *)
      MulSmall(u, q, 7 * k + 2);
      MulSmall(v, r, l);
      Add(u, u, v);                  (* u = q(7k + 2) + r l *)
      MulSmall(v, t, l);             (* v = t l *)
      next := Quot(u, v, w);

      MulSmall(u, q, 2);
      Add(u, u, r);
      MulSmall(u, u, l);             (* u = (2q + r) l *)
      CopyLimbs(r, u);
      MulSmall(q, q, k);
      MulSmall(t, t, l);

      INC(k);
      l := l + 2;
      n := next
    END
  END;

  Out.Int(sum, 1); Out.Ln
END Pi.
