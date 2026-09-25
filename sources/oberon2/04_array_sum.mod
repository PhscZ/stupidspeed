(* task 04 array_sum — expected output: 499999500000 *)
(* build: CFLAGS=-O2 voc 04_array_sum.mod -m    run: ./ArraySum *)
(* note: the elements are LONGINT, the sum is HUGEINT because 499999500000 *)
(*       does not fit in the 32 bit LONGINT of the -O2 size model. *)

MODULE ArraySum;
IMPORT Out;

VAR
  arr: ARRAY 1000000 OF LONGINT;
  total: HUGEINT;
  i: LONGINT;

BEGIN
  FOR i := 0 TO 999999 DO
    arr[i] := i
  END;

  total := 0;
  FOR i := 0 TO 999999 DO
    total := total + arr[i]
  END;

  Out.Int(total, 1); Out.Ln
END ArraySum.
