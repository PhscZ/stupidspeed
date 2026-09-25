(* task 03 func_sum — expected output: 100000000 *)
(* build: CFLAGS=-O2 voc 03_func_sum_add_one.mod 03_func_sum.mod -m    run: ./FuncSum *)
(* note: AddOne is in its own module (03_func_sum_add_one.mod) so the call is a real *)
(*       call into another translation unit and cannot be inlined. *)

MODULE FuncSum;
IMPORT Out, AddOne;

VAR
  value: LONGINT;
  i: LONGINT;

BEGIN
  value := 0;
  FOR i := 1 TO 100000000 DO
    value := AddOne.AddOne(value)
  END;
  Out.Int(value, 1); Out.Ln
END FuncSum.
