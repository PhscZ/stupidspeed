(* task 03 func_sum — expected output: 100000000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)
(* note: add_one lives in its own module, so the call cannot be inlined away *)

INTERFACE AddOne;

PROCEDURE AddOne(n: INTEGER): INTEGER;

END AddOne.
