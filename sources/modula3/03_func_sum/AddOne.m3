(* task 03 func_sum — expected output: 100000000 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)
(* note: add_one's own module, so the compiler has no body to inline at the call site *)

MODULE AddOne;

PROCEDURE AddOne(n: INTEGER): INTEGER =
  BEGIN
    RETURN n + 1
  END AddOne;

BEGIN
END AddOne.
