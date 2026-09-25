(* task 09 fib_recursive — expected output: 102334155 *)
(* build: CFLAGS=-O2 voc 09_fib_recursive.mod -m    run: ./FibRecursive *)
(* note: plain double recursion, no memoisation. *)

MODULE FibRecursive;
IMPORT Out;

PROCEDURE Fib(n: LONGINT): LONGINT;
BEGIN
  IF n < 2 THEN
    RETURN n
  END;
  RETURN Fib(n - 1) + Fib(n - 2)
END Fib;

BEGIN
  Out.Int(Fib(40), 1); Out.Ln
END FibRecursive.
