(* task 03 func_sum (helper module) — expected output: 100000000 *)
(* build: CFLAGS=-O2 voc 03_func_sum_add_one.mod 03_func_sum.mod -m    run: ./FuncSum *)
(* note: the called procedure lives in its own module, so the C backend compiles it *)
(*       to a separate translation unit and gcc cannot inline the call away. *)

MODULE AddOne;

PROCEDURE AddOne*(n: LONGINT): LONGINT;
BEGIN
  RETURN n + 1
END AddOne;

END AddOne.
