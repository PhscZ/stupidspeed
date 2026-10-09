(* task 08 average — expected output: 0.498046875 *)
(* build: gpcp /list- _08_average.cp    run: _08_average.exe *)
(* note: Component Pascal's REAL is the 64 bit double. The Console module has no
   WriteReal, so the result is formatted by RealStr.RealToFixed with nine places,
   which is the number of digits the expected output has. RealStr is a separately
   compiled Component Pascal module, so RealStr.dll has to sit next to the executable
   as well as RTS.dll. *)
(* note: every reading is a multiple of 1/256 and the running total stays well under
   2^53, so the sum is exact and the printed digits do not depend on the order of the
   additions. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll and %CROOT%\bin\RealStr.dll copied next to the
   executable. gpcp has no optimisation levels; the documented invocation is plain
   "gpcp _08_average.cp" and /list- only suppresses the .lst listing file. *)
(* timing: Env.Environment.get_TickCount() is .NET's millisecond clock, and the Error module
   writes to stderr, so TIME_MS is reported there and stdout is unchanged. *)

MODULE _08_average;
 IMPORT CPmain, Console, Error, Env := mscorlib_System, RealStr;

 VAR total, reading : REAL;
     ss_t0, ss_t1 : LONGINT;
     i : LONGINT;
     s : ARRAY 32 OF CHAR;

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
  total := 0.0;

  FOR i := 0 TO 99999999 DO
    reading := (i MOD 256) / 256.0;
    total := total + reading
  END;

  ss_t1 := Env.Environment.get_TickCount();
  Error.WriteString("TIME_MS="); WMs(ss_t1 - ss_t0); Error.WriteLn();

  RealStr.RealToFixed(total / 100000000.0, 9, s);
  Console.WriteString(s); Console.WriteLn
END _08_average.
