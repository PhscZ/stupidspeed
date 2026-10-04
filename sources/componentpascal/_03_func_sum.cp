(* task 03 func_sum — expected output: 100000000 *)
(* build: gpcp /list- _03_func_sum_add_one.cp && gpcp /list- _03_func_sum.cp
   run: _03_func_sum.exe *)
(* note: AddOne lives in its own module (03_func_sum_add_one.cp, beside this file) and
   is called through the assembly boundary, because Component Pascal has no no-inline
   marker. The helper is compiled first and leaves _03_func_sum_add_one.dll next to the
   executable. The .NET JIT may still inline a method this small; that is a property of
   the runtime, like the interpreted rows of this benchmark. *)
(* note: CPSYM has to begin with "." for the helper's symbol file to be found. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT result is printed
   by the local WriteLong. *)
(* timing: Env.Environment.get_TickCount() is .NET's millisecond clock, and the Error module
   writes to stderr, so TIME_MS is reported there and stdout is unchanged. *)

MODULE _03_func_sum;
 IMPORT CPmain, Console, Error, Env := mscorlib_System, AddOne := _03_func_sum_add_one;

 VAR value : LONGINT;
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
  value := 0;

  FOR i := 1 TO 100000000 DO
    value := AddOne.AddOne(value)
  END;

  ss_t1 := Env.Environment.get_TickCount();
  Error.WriteString("TIME_MS="); WMs(ss_t1 - ss_t0); Error.WriteLn();

  WriteLong(value); Console.WriteLn
END _03_func_sum.
