(* task 08 average — expected output: 0.498046875 *)
(* build: CFLAGS=-O2 voc 08_average.mod -m    run: ./Average *)
(* note: LONGREAL is IEEE 64 bit double. Out.LongReal only writes exponential *)
(*       form, so the fixed point form comes from oocLRealStr.RealToFixed, the *)
(*       string conversion routine of the bundled oo2c library. *)

MODULE Average;
IMPORT Out, LRealStr := oocLRealStr;

VAR
  total, reading: LONGREAL;
  i: LONGINT;
  s: ARRAY 40 OF CHAR;

BEGIN
  total := 0.0;
  FOR i := 0 TO 99999999 DO
    reading := (i MOD 256) / 256.0;
    total := total + reading
  END;

  LRealStr.RealToFixed(total / 100000000.0, 9, s);
  Out.String(s); Out.Ln
END Average.
