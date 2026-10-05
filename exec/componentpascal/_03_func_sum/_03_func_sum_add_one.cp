(* task 03 func_sum (helper module) — expected output: 100000000 *)
(* build: gpcp /list- _03_func_sum_add_one.cp    run: (loaded by _03_func_sum.exe) *)
(* note: the procedure the benchmark calls lives here, in its own module, so the call
   from _03_func_sum is a call across an assembly boundary and not a call the compiler
   can fold away. It has no body, so compiling it produces _03_func_sum_add_one.dll
   plus its symbol file rather than an executable. *)

MODULE _03_func_sum_add_one;

 PROCEDURE AddOne*(n : LONGINT) : LONGINT;
 BEGIN
   RETURN n + 1
 END AddOne;

END _03_func_sum_add_one.
