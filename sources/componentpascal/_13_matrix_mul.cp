(* task 13 matrix_mul — expected output: 599995000 *)
(* build: gpcp /list- _13_matrix_mul.cp    run: _13_matrix_mul.exe *)
(* note: the plain i, j, k triple loop of the spec, in that order, so B is walked down
   a column and the access pattern is the point of the task; no reordering. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _13_matrix_mul.cp" and
   /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT total is printed
   by the local WriteLong. *)
(* timing: Env.Environment.get_TickCount() is .NET's millisecond clock, and the Error module
   writes to stderr, so TIME_MS is reported there and stdout is unchanged. *)

MODULE _13_matrix_mul;
 IMPORT CPmain, Console, Error, Env := mscorlib_System;

 CONST N = 500;

 VAR a, b, c : POINTER TO ARRAY OF ARRAY OF LONGINT;
     ss_t0, ss_t1 : LONGINT;
     sum, total : LONGINT;
     i, j, k : INTEGER;

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
      a[i][j] := (i + j) MOD 7;
      b[i][j] := (i * j) MOD 5
    END
  END;

  FOR i := 0 TO N - 1 DO
    FOR j := 0 TO N - 1 DO
      sum := 0;
      FOR k := 0 TO N - 1 DO
        sum := sum + a[i][k] * b[k][j]
      END;
      c[i][j] := sum
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
END _13_matrix_mul.
