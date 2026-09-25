(* task 10 pi — expected output: 44889 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)
(* note: the unbounded spigot algorithm on BigInteger; the digit sum is printed *)
(* note: measured at about 206 s on the development machine, by far the slowest cell *)
(*       in this row; everything else here is under 10 s. *)

MODULE Main;
IMPORT IO, Fmt, BigInteger;

VAR q, r, t, nt, num, den, oldq, oldr: BigInteger.T;
    k, n, l, emitted, total, digits: INTEGER;

PROCEDURE I(x: INTEGER): BigInteger.T =
  BEGIN
    RETURN BigInteger.FromInteger(x)
  END I;

PROCEDURE Quot(a, b: BigInteger.T): INTEGER =
  BEGIN
    (* BigInteger.Div only accepts exact division, so use DivMod's quotient *)
    RETURN BigInteger.ToInteger(BigInteger.DivMod(a, b).quot)
  END Quot;

BEGIN
  digits := 10000;
  q := I(1); r := I(0); t := I(1);
  k := 1; n := 3; l := 3; emitted := 0; total := 0;
  WHILE emitted < digits DO
    nt := BigInteger.Mul(t, I(n));
    IF BigInteger.Compare(
         BigInteger.Sub(BigInteger.Add(BigInteger.Mul(q, I(4)), r), t), nt) < 0 THEN
      total := total + n;
      INC(emitted);
      num := BigInteger.Mul(BigInteger.Add(BigInteger.Mul(q, I(3)), r), I(10));
      n := Quot(num, t) - 10 * n;
      q := BigInteger.Mul(q, I(10));
      r := BigInteger.Mul(BigInteger.Sub(r, nt), I(10));
    ELSE
      oldq := q; oldr := r;
      den := BigInteger.Mul(t, I(l));
      num := BigInteger.Add(BigInteger.Mul(oldq, I(7 * k + 2)), BigInteger.Mul(oldr, I(l)));
      n := Quot(num, den);
      q := BigInteger.Mul(oldq, I(k));
      r := BigInteger.Mul(BigInteger.Add(BigInteger.Mul(oldq, I(2)), oldr), I(l));
      t := den;
      INC(k); INC(l, 2);
    END
  END;
  IO.Put(Fmt.Int(total) & "\n");
END Main.
