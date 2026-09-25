(* task 09 fib_recursive — expected output: 102334155 *)
(* build: cm3 -build -O    run: AMD64_NT\prog.exe *)

MODULE Main;
IMPORT IO, Fmt;

PROCEDURE Fib(n: INTEGER): INTEGER =
  BEGIN
    IF n < 2 THEN
      RETURN n
    ELSE
      RETURN Fib(n - 1) + Fib(n - 2)
    END
  END Fib;

BEGIN
  IO.Put(Fmt.Int(Fib(40)) & "\n");
END Main.
