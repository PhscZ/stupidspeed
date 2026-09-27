(* task 04 array_sum — expected output: 499999500000 *)
(* build: gpcp /list- _04_array_sum.cp    run: _04_array_sum.exe *)
(* note: the array is an open array allocated on the heap (POINTER TO ARRAY OF
   LONGINT), the Component Pascal equivalent of the malloc'd array the C row uses;
   LONGINT is the 64 bit type, since the sum exceeds 2^32. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _04_array_sum.cp" and
   /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT total is printed
   by the local WriteLong. *)

MODULE _04_array_sum;
 IMPORT CPmain, Console;

 CONST N = 1000000;

 VAR data : POINTER TO ARRAY OF LONGINT;
     total : LONGINT;
     i : INTEGER;

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

BEGIN
  NEW(data, N);

  FOR i := 0 TO N - 1 DO
    data[i] := i
  END;

  total := 0;
  FOR i := 0 TO N - 1 DO
    total := total + data[i]
  END;

  WriteLong(total); Console.WriteLn
END _04_array_sum.
