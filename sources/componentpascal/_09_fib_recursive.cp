(* task 09 fib_recursive — expected output: 102334155 *)
(* build: gpcp /list- _09_fib_recursive.cp    run: _09_fib_recursive.exe *)
(* note: plain double recursion, about 331 million calls to Fib. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _09_fib_recursive.cp"
   and /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT result is printed
   by the local WriteLong. *)

MODULE _09_fib_recursive;
 IMPORT CPmain, Console;

 PROCEDURE WriteLong(x : LONGINT);
   VAR s : ARRAY 24 OF CHAR;
       n, k : INTEGER;
       t : CHAR;
 BEGIN
   IF x = 0 THEN Console.Write("0"); RETURN END;
   n := 0;
   WHILE x > 0 DO
     s[n] := CHR(SHORT(x MOD 10) + ORD("0"));
     x := x DIV 10;
     INC(n)
   END;
   s[n] := 0X;
   k := 0; DEC(n);
   WHILE k < n DO
     t := s[k]; s[k] := s[n]; s[n] := t;
     INC(k); DEC(n)
   END;
   Console.WriteString(s)
 END WriteLong;

 PROCEDURE Fib(n : LONGINT) : LONGINT;
 BEGIN
   IF n < 2 THEN RETURN n END;
   RETURN Fib(n - 1) + Fib(n - 2)
 END Fib;

BEGIN
  WriteLong(Fib(40)); Console.WriteLn
END _09_fib_recursive.
