(* task 10 pi — expected output: 44889 *)
(* build: gpcp /list- _10_pi.cp    run: _10_pi.exe *)
(* note: Component Pascal has no big integer library, so this is the same hand written
   sign-magnitude base 10^9 big integer as the C row: little-endian LONGINT limbs, with
   add, subtract, multiply by a small integer, and a quotient that is always a small
   digit found by repeated subtraction. Same Gibbons spigot, same 10000 digits. *)
(* note: the six state values are fixed records of 40000 limbs each, comfortably more
   than the spigot reaches, so no limb array ever has to grow; the arithmetic routines
   read limb i before they write it, which is what makes the in-place calls such as
   Add(u, u, r) safe. Only the sum of the digits is printed. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _10_pi.cp" and /list-
   only suppresses the .lst listing file. *)
(* note: this is by far the slowest task in the row: a full 10000 digit run takes about
   4 minutes 55 seconds on this machine, so the five timed runs plus a warm-up are about
   half an hour. The spigot was also cross-checked against the first 20 digits of pi
   (sum 97) and the first 100 digits (sum 471) before the full run. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT digit sum is
   printed by the local WriteLong. *)

MODULE _10_pi;
 IMPORT CPmain, Console;

 CONST BASE = 1000000000;
       LIMBS = 40000;
       DIGITS = 10000;

 TYPE Big = RECORD
              limb : ARRAY LIMBS OF LONGINT;   (* little-endian, base 1e9 *)
              n : INTEGER;                     (* limb count, no leading zeros *)
              neg : BOOLEAN
            END;
      BigPtr = POINTER TO Big;

 VAR q, r, t, u, v, w : BigPtr;
     k, l, n, next, sum : LONGINT;
     produced : INTEGER;

 PROCEDURE WriteLong(x : LONGINT);
   VAR s : ARRAY 24 OF CHAR;
       i, k : INTEGER;
       t : CHAR;
 BEGIN
   IF x = 0 THEN Console.Write("0"); RETURN END;
   i := 0;
   WHILE x > 0 DO
     s[i] := CHR(SHORT(x MOD 10) + ORD("0"));
     x := x DIV 10;
     INC(i)
   END;
   s[i] := 0X;
   k := 0; DEC(i);
   WHILE k < i DO
     t := s[k]; s[k] := s[i]; s[i] := t;
     INC(k); DEC(i)
   END;
   Console.WriteString(s)
 END WriteLong;

 PROCEDURE Trim(VAR x : Big);
 BEGIN
   WHILE (x.n > 0) & (x.limb[x.n - 1] = 0) DO DEC(x.n) END;
   IF x.n = 0 THEN x.neg := FALSE END
 END Trim;

 PROCEDURE Set(VAR x : Big; v : LONGINT);
 BEGIN
   x.n := 0; x.neg := FALSE;
   WHILE v > 0 DO
     x.limb[x.n] := v MOD BASE;
     INC(x.n);
     v := v DIV BASE
   END
 END Set;

 PROCEDURE Copy(VAR dst : Big; VAR src : Big);
   VAR i : INTEGER;
 BEGIN
   FOR i := 0 TO src.n - 1 DO dst.limb[i] := src.limb[i] END;
   dst.n := src.n;
   dst.neg := src.neg
 END Copy;

 PROCEDURE CmpMag(VAR a : Big; VAR b : Big) : INTEGER;
   VAR i : INTEGER;
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

 PROCEDURE Cmp(VAR a : Big; VAR b : Big) : INTEGER;
   VAR c : INTEGER;
 BEGIN
   IF a.neg # b.neg THEN
     IF a.neg THEN RETURN -1 ELSE RETURN 1 END
   END;
   c := CmpMag(a, b);
   IF a.neg THEN RETURN -c ELSE RETURN c END
 END Cmp;

 (* r := |a| + |b|; index i is read before it is written, so r may alias a or b *)
 PROCEDURE AddMag(VAR r : Big; VAR a : Big; VAR b : Big);
   VAR i, count : INTEGER;
       s, carry : LONGINT;
 BEGIN
   IF a.n > b.n THEN count := a.n ELSE count := b.n END;
   carry := 0;
   FOR i := 0 TO count - 1 DO
     s := carry;
     IF i < a.n THEN s := s + a.limb[i] END;
     IF i < b.n THEN s := s + b.limb[i] END;
     IF s >= BASE THEN s := s - BASE; carry := 1 ELSE carry := 0 END;
     r.limb[i] := s
   END;
   r.limb[count] := carry;
   IF carry # 0 THEN r.n := count + 1 ELSE r.n := count END;
   r.neg := FALSE
 END AddMag;

 (* r := |a| - |b|, requires |a| >= |b| *)
 PROCEDURE SubMag(VAR r : Big; VAR a : Big; VAR b : Big);
   VAR i : INTEGER;
       bi, borrow : LONGINT;
 BEGIN
   borrow := 0;
   FOR i := 0 TO a.n - 1 DO
     IF i < b.n THEN bi := b.limb[i] + borrow ELSE bi := borrow END;
     IF a.limb[i] >= bi THEN
       r.limb[i] := a.limb[i] - bi; borrow := 0
     ELSE
       r.limb[i] := a.limb[i] + BASE - bi; borrow := 1
     END
   END;
   r.n := a.n;
   r.neg := FALSE;
   Trim(r)
 END SubMag;

 PROCEDURE Add(VAR r : Big; VAR a : Big; VAR b : Big);
   VAR an, bn : BOOLEAN;
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

 PROCEDURE Sub(VAR r : Big; VAR a : Big; VAR b : Big);   (* r := a - b *)
   VAR an, bn : BOOLEAN;
 BEGIN
   an := a.neg; bn := b.neg;
   IF an # bn THEN
     AddMag(r, a, b); r.neg := an
   ELSIF CmpMag(a, b) >= 0 THEN
     SubMag(r, a, b); r.neg := an
   ELSE
     SubMag(r, b, a); r.neg := ~an
   END;
   Trim(r)
 END Sub;

 PROCEDURE MulSmall(VAR r : Big; VAR a : Big; m : LONGINT);
   VAR i, count : INTEGER;
       p, carry : LONGINT;
 BEGIN
   IF (m = 0) OR (a.n = 0) THEN r.n := 0; r.neg := FALSE; RETURN END;
   carry := 0;
   FOR i := 0 TO a.n - 1 DO
     p := a.limb[i] * m + carry;
     r.limb[i] := p MOD BASE;
     carry := p DIV BASE
   END;
   count := a.n;
   WHILE carry > 0 DO
     r.limb[count] := carry MOD BASE;
     carry := carry DIV BASE;
     INC(count)
   END;
   r.n := count;
   r.neg := a.neg;
   Trim(r)
 END MulSmall;

 (* floor(a / b) for a >= 0 and b > 0; the spigot only ever asks for a quotient of one
    decimal digit, so counting how often b fits into a is enough *)
 PROCEDURE Quot(VAR a : Big; VAR b : Big; VAR work : Big) : LONGINT;
   VAR q : LONGINT;
 BEGIN
   q := 0;
   IF a.neg OR b.neg OR (b.n = 0) THEN RETURN 0 END;
   Copy(work, b);
   WHILE Cmp(a, work) >= 0 DO
     INC(q);
     AddMag(work, work, b)
   END;
   RETURN q
 END Quot;

BEGIN
  NEW(q); NEW(r); NEW(t); NEW(u); NEW(v); NEW(w);

  Set(q^, 1);
  Set(r^, 0);
  Set(t^, 1);

  k := 1; l := 3; n := 3;
  sum := 0; produced := 0;

  WHILE produced < DIGITS DO
    MulSmall(u^, q^, 4);
    Add(u^, u^, r^);                     (* u = 4q + r *)
    MulSmall(v^, t^, n + 1);             (* v = (n + 1)t *)

    IF Cmp(u^, v^) < 0 THEN
      (* the digit n is settled *)
      sum := sum + n;
      INC(produced);

      MulSmall(u^, q^, 3);
      Add(u^, u^, r^);
      MulSmall(u^, u^, 10);              (* u = 10(3q + r) *)
      next := Quot(u^, t^, w^) - 10 * n;

      MulSmall(v^, t^, n);               (* v = n t *)
      Sub(v^, r^, v^);                   (* v = r - n t *)
      MulSmall(r^, v^, 10);              (* r = 10(r - n t) *)
      MulSmall(q^, q^, 10);              (* q = 10q, t is unchanged *)

      n := next
    ELSE
      (* not settled yet: widen the state by one more term *)
      MulSmall(u^, q^, 7 * k + 2);
      MulSmall(v^, r^, l);
      Add(u^, u^, v^);                   (* u = q(7k + 2) + r l *)
      MulSmall(v^, t^, l);               (* v = t l *)
      next := Quot(u^, v^, w^);

      MulSmall(u^, q^, 2);
      Add(u^, u^, r^);
      MulSmall(u^, u^, l);               (* u = (2q + r) l *)
      Copy(r^, u^);
      MulSmall(q^, q^, k);
      MulSmall(t^, t^, l);

      INC(k);
      l := l + 2;
      n := next
    END
  END;

  WriteLong(sum); Console.WriteLn
END _10_pi.
