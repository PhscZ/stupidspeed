MODULE Task10;

(* task 10 pi — expected output: 44889
   Modula-2 has no arbitrary precision integers, so the unbounded spigot (Gibbons)
   runs on hand-written base-10^9 limbs: multiply by a small integer, add, subtract,
   and one big division whose quotient is known to be small. Only the digit sum is
   printed.  Same algorithm as the GDScript row. *)

IMPORT STextIO, SLWholeIO;

CONST
   LIMB_BASE = 1000000000;
   MAXL      = 24000;
   DIGITS    = 10000;
   QUOT_MAX  = 1000000;

TYPE
   LimbArr = ARRAY [0 .. MAXL - 1] OF CARDINAL;
   Big = RECORD
            neg : BOOLEAN;
            len : CARDINAL;
            d   : LimbArr
         END;

VAR
   q, r, t       : Big;
   nt, s1, s2, s3, s4, s5 : Big;
   k, l, n       : CARDINAL;
   total         : LONGCARD;
   emitted       : CARDINAL;

PROCEDURE SetZero (VAR x : Big);
BEGIN
   x.neg := FALSE; x.len := 1; x.d [0] := 0
END SetZero;

PROCEDURE SetSmall (VAR x : Big; v : CARDINAL);
BEGIN
   x.neg := FALSE; x.len := 1; x.d [0] := v
END SetSmall;

PROCEDURE Trim (VAR x : Big);
BEGIN
   WHILE (x.len > 1) AND (x.d [x.len - 1] = 0) DO
      x.len := x.len - 1
   END;
   IF (x.len = 1) AND (x.d [0] = 0) THEN x.neg := FALSE END
END Trim;

PROCEDURE CopyBig (VAR dst : Big; a : Big);
VAR i : CARDINAL;
BEGIN
   dst.neg := a.neg; dst.len := a.len;
   FOR i := 0 TO a.len - 1 DO dst.d [i] := a.d [i] END
END CopyBig;

PROCEDURE CmpMag (a, b : Big) : INTEGER;
VAR i : CARDINAL;
BEGIN
   IF a.len # b.len THEN
      IF a.len > b.len THEN RETURN 1 ELSE RETURN -1 END
   END;
   i := a.len;
   WHILE i > 0 DO
      i := i - 1;
      IF a.d [i] # b.d [i] THEN
         IF a.d [i] > b.d [i] THEN RETURN 1 ELSE RETURN -1 END
      END
   END;
   RETURN 0
END CmpMag;

PROCEDURE CmpBig (a, b : Big) : INTEGER;
VAR c : INTEGER;
BEGIN
   IF a.neg # b.neg THEN
      IF a.neg THEN RETURN -1 ELSE RETURN 1 END
   END;
   c := CmpMag (a, b);
   IF a.neg THEN RETURN -c ELSE RETURN c END
END CmpBig;

PROCEDURE AddMag (VAR dst : Big; a, b : Big);
VAR i, n1 : CARDINAL; cur, carry : LONGCARD;
BEGIN
   IF a.len > b.len THEN n1 := a.len ELSE n1 := b.len END;
   carry := 0;
   FOR i := 0 TO n1 - 1 DO
      cur := carry;
      IF i < a.len THEN cur := cur + VAL (LONGCARD, a.d [i]) END;
      IF i < b.len THEN cur := cur + VAL (LONGCARD, b.d [i]) END;
      dst.d [i] := VAL (CARDINAL, cur MOD LIMB_BASE);
      carry := cur DIV LIMB_BASE
   END;
   dst.d [n1] := VAL (CARDINAL, carry);
   dst.len := n1 + 1;
   dst.neg := FALSE;
   Trim (dst)
END AddMag;

(* a >= b required *)
PROCEDURE SubMag (VAR dst : Big; a, b : Big);
VAR i : CARDINAL; cur : LONGCARD; borrow : LONGCARD;
BEGIN
   borrow := 0;
   FOR i := 0 TO a.len - 1 DO
      cur := VAL (LONGCARD, a.d [i]) + LIMB_BASE - borrow;
      IF i < b.len THEN cur := cur - VAL (LONGCARD, b.d [i]) END;
      IF cur >= LIMB_BASE THEN
         dst.d [i] := VAL (CARDINAL, cur - LIMB_BASE); borrow := 0
      ELSE
         dst.d [i] := VAL (CARDINAL, cur); borrow := 1
      END
   END;
   dst.len := a.len;
   dst.neg := FALSE;
   Trim (dst)
END SubMag;

PROCEDURE MulSmall (VAR dst : Big; a : Big; m : CARDINAL);
VAR i : CARDINAL; cur, carry : LONGCARD;
BEGIN
   IF m = 0 THEN SetZero (dst); RETURN END;
   carry := 0;
   FOR i := 0 TO a.len - 1 DO
      cur := VAL (LONGCARD, a.d [i]) * VAL (LONGCARD, m) + carry;
      dst.d [i] := VAL (CARDINAL, cur MOD LIMB_BASE);
      carry := cur DIV LIMB_BASE
   END;
   dst.d [a.len] := VAL (CARDINAL, carry);
   dst.len := a.len + 1;
   dst.neg := a.neg;
   Trim (dst)
END MulSmall;

PROCEDURE AddBig (VAR dst : Big; a, b : Big);
VAR c : INTEGER;
BEGIN
   IF a.neg = b.neg THEN
      AddMag (dst, a, b);
      dst.neg := a.neg;
      Trim (dst)
   ELSE
      c := CmpMag (a, b);
      IF c = 0 THEN SetZero (dst)
      ELSIF c > 0 THEN
         SubMag (dst, a, b); dst.neg := a.neg
      ELSE
         SubMag (dst, b, a); dst.neg := b.neg
      END
   END
END AddBig;

PROCEDURE SubBig (VAR dst : Big; a, b : Big);
VAR nb : Big;
BEGIN
   CopyBig (nb, b);
   nb.neg := NOT b.neg;
   AddBig (dst, a, nb)
END SubBig;

(* compares b * m against a, magnitude only *)
PROCEDURE CmpMagMulSmall (b : Big; m : CARDINAL; a : Big) : INTEGER;
VAR tmp : Big;
BEGIN
   MulSmall (tmp, b, m);
   RETURN CmpMag (tmp, a)
END CmpMagMulSmall;

(* floor(a / b) for a >= 0 and b > 0, with the true quotient known to be <= hi *)
PROCEDURE DivQuot (a, b : Big; hi : CARDINAL) : CARDINAL;
VAR
   la, lb, shift : CARDINAL;
   ta, tb, scale, raw : LONGREAL;
   est : CARDINAL;
BEGIN
   la := a.len; lb := b.len;
   IF la < lb THEN RETURN 0 END;
   ta := VAL (LONGREAL, a.d [la - 1]);
   tb := VAL (LONGREAL, b.d [lb - 1]);
   IF la >= 2 THEN ta := ta * 1000000000.0 + VAL (LONGREAL, a.d [la - 2]) END;
   IF lb >= 2 THEN tb := tb * 1000000000.0 + VAL (LONGREAL, b.d [lb - 2]) END;
   est := hi;
   IF la >= 2 THEN shift := la - 2 ELSE shift := 0 END;
   IF lb >= 2 THEN shift := shift - (lb - 2) END;
   IF (shift <= 2) AND (tb > 0.0) THEN
      scale := 1.0;
      IF shift = 1 THEN scale := 1000000000.0
      ELSIF shift = 2 THEN scale := 1.0E18
      END;
      raw := ta / tb * scale;
      IF raw < 0.0 THEN est := 0
      ELSIF raw >= VAL (LONGREAL, hi) THEN est := hi
      ELSE est := VAL (CARDINAL, raw)
      END
   END;
   WHILE (est > 0) AND (CmpMagMulSmall (b, est, a) > 0) DO est := est - 1 END;
   WHILE (est < hi) AND (CmpMagMulSmall (b, est + 1, a) <= 0) DO est := est + 1 END;
   RETURN est
END DivQuot;

VAR nextn : CARDINAL; tl : CARDINAL; kk : CARDINAL;

BEGIN
   SetSmall (q, 1); SetZero (r); SetSmall (t, 1);
   k := 1; l := 3; n := 3; total := 0; emitted := 0;
   WHILE emitted < DIGITS DO
      MulSmall (nt, t, n);                       (* nt = n * t *)
      MulSmall (s1, q, 4);                       (* s1 = 4q *)
      AddBig (s2, s1, r);                        (* s2 = 4q + r *)
      SubBig (s3, s2, t);                        (* s3 = 4q + r - t *)
      IF CmpBig (s3, nt) < 0 THEN
         total := total + VAL (LONGCARD, n);
         emitted := emitted + 1;
         MulSmall (s1, q, 3);
         AddBig (s2, s1, r);
         MulSmall (s3, s2, 10);
         nextn := DivQuot (s3, t, QUOT_MAX) - 10 * n;
         MulSmall (q, q, 10);
         SubBig (s4, r, nt);
         MulSmall (r, s4, 10);
         n := nextn
      ELSE
         tl := t.len;                          (* keep t alive; compute t*l *)
         MulSmall (s5, t, l);
         kk := 7 * k + 2;
         MulSmall (s1, q, kk);
         MulSmall (s2, r, l);
         AddBig (s3, s1, s2);
         n := DivQuot (s3, s5, QUOT_MAX);
         MulSmall (s4, q, 2);
         AddBig (s1, s4, r);
         MulSmall (s2, s1, l);
         CopyBig (r, s2);
         MulSmall (q, q, k);
         CopyBig (t, s5);
         k := k + 1;
         l := l + 2
      END
   END;
   SLWholeIO.WriteLongCard (total, 0);
   STextIO.WriteLn
END Task10.
