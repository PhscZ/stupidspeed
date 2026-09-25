(* task 09 fib_recursive -- expected output: 102334155 *)
(* build: m2amd64.exe /sym:<symdir> 09_fib_recursive.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task09;
IMPORT STextIO, SLWholeIO;
VAR r : LONGCARD;
PROCEDURE fib (n : CARDINAL) : LONGCARD;
BEGIN
   IF n < 2 THEN RETURN VAL (LONGCARD, n) END;
   RETURN fib (n - 1) + fib (n - 2)
END fib;
BEGIN
   r := fib (40);
   SLWholeIO.WriteLongCard (r, 0); STextIO.WriteLn
END Task09.
