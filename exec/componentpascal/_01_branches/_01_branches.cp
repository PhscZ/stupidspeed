(* task 01 branches — expected output: 33333334 13333333 7619048 45714285 *)
(* build: gpcp /list- _01_branches.cp    run: _01_branches.exe *)
(* timing: Env.Environment.get_TickCount() is .NET's millisecond clock, and the Error module
   writes to stderr, so TIME_MS is reported there and stdout is unchanged. *)
(* note: a Component Pascal module name has to equal the file name and cannot start
   with a digit, so both carry the leading underscore the Java/D/Nim rows use. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _01_branches.cp" and
   /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the four LONGINT counters are
   printed by the local WriteLong. *)

MODULE _01_branches;
 IMPORT CPmain, Console, Error, Env := mscorlib_System;

 VAR a, b, c, d : LONGINT;
     ss_t0, ss_t1 : LONGINT;
     i : LONGINT;

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

 PROCEDURE WMs(x : LONGINT);
   VAR s : ARRAY 24 OF CHAR;
       n, k : INTEGER;
       t : CHAR;
 BEGIN
   IF x = 0 THEN Error.Write("0"); RETURN END;
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
   Error.WriteString(s)
 END WMs;

BEGIN
  ss_t0 := Env.Environment.get_TickCount();
  a := 0; b := 0; c := 0; d := 0;

  FOR i := 0 TO 99999999 DO
    IF i MOD 3 = 0 THEN
      INC(a)
    ELSIF i MOD 5 = 0 THEN
      INC(b)
    ELSIF i MOD 7 = 0 THEN
      INC(c)
    ELSE
      INC(d)
    END
  END;

  ss_t1 := Env.Environment.get_TickCount();
  Error.WriteString("TIME_MS="); WMs(ss_t1 - ss_t0); Error.WriteLn();

  WriteLong(a); Console.Write(" ");
  WriteLong(b); Console.Write(" ");
  WriteLong(c); Console.Write(" ");
  WriteLong(d); Console.WriteLn
END _01_branches.
