(* task 12 matrix_add — expected output: 999000000 *)
(* build: gpcp /list- _12_matrix_add.cp    run: _12_matrix_add.exe *)
(* note: A, B and C are open two dimensional arrays of LONGINT allocated with
   NEW(p, n, n), eight megabytes each; they are far too big for the cache, so this
   measures memory bandwidth. The final sum walks C in the same order as the C row. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _12_matrix_add.cp" and
   /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT total is printed
   by the local WriteLong. *)
(* timing: Env.Environment.get_TickCount() is .NET's millisecond clock, and the Error module
   writes to stderr, so TIME_MS is reported there and stdout is unchanged. *)

MODULE _12_matrix_add;
 IMPORT CPmain, Console, Error, Env := mscorlib_System;

 CONST N = 1000;

 VAR a, b, c : POINTER TO ARRAY OF ARRAY OF LONGINT;
     ss_t0, ss_t1 : LONGINT;
     total : LONGINT;
     i, j : INTEGER;

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
  NEW(a, N, N);
  NEW(b, N, N);
  NEW(c, N, N);

  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      a[i][j] := i + j;
      b[i][j] := i - j
    END
  END;

  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      c[i][j] := a[i][j] + b[i][j]
    END
  END;

  total := 0;
  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      total := total + c[i][j]
    END
  END;

  ss_t1 := Env.Environment.get_TickCount();
  Error.WriteString("TIME_MS="); WMs(ss_t1 - ss_t0); Error.WriteLn();

  WriteLong(total); Console.WriteLn
END _12_matrix_add.
