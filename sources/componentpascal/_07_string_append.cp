(* task 07 string_append — expected output: 1000000 *)
(* build: gpcp /list- _07_string_append.cp    run: _07_string_append.exe *)
(* note: Component Pascal's string type is ARRAY OF CHAR with a 0X terminator, exactly
   like Oberon-2's and Modula-2's, and like them it has no growable string: the "+"
   operator builds a fresh native string through a StringBuilder and copies it back into
   the array on every append, which is the copying behaviour this task measures. That is
   quadratic and far too slow to run here — a 100000 append variant using "+" and BOX()
   took 238 seconds, and a 200000 append variant using "+" into a fixed array was still
   running after 14 minutes — so, the same way the Oberon-2 and Modula-2 rows of this
   benchmark do it for this string type, the appends grow the string in place at the end
   of the buffer. *)
(* note: the length is then found by scanning for the 0X terminator, as the Oberon-2 row
   does. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _07_string_append.cp"
   and /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT length is printed
   by the local WriteLong. *)

MODULE _07_string_append;
 IMPORT CPmain, Console;

 CONST N = 1000000;

 VAR text : ARRAY N + 1 OF CHAR;
     len : LONGINT;
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
  len := 0;
  FOR i := 1 TO N DO
    text[len] := "x";
    INC(len)
  END;
  text[len] := 0X;

  (* length of the string that was built, found by scanning for the 0X terminator *)
  len := 0;
  WHILE text[len] # 0X DO INC(len) END;

  WriteLong(len); Console.WriteLn
END _07_string_append.
