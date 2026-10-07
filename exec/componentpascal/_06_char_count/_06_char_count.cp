(* task 06 char_count — expected output: 10000000 *)
(* build: gpcp /list- _06_char_count.cp    run: _06_char_count.exe *)
(* note: the whole 100 MB text is built up front by copying the ten character block
   into every tenth slot, nothing is appended in a loop. Component Pascal's CHAR is a
   16 bit character, so the array of 100000000 of them is 200 MB, which is why the
   array is heap allocated with NEW rather than a module level VAR. gpcp will not let a
   string constant be indexed, so the block is a CHAR array. *)
(* note: the if/else chain is the one from the task spec, with the skip branches empty. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _06_char_count.cp" and
   /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT count is printed
   by the local WriteLong. *)
(* timing: Env.Environment.get_TickCount() is .NET's millisecond clock, and the Error module
   writes to stderr, so TIME_MS is reported there and stdout is unchanged. *)

MODULE _06_char_count;
 IMPORT CPmain, Console, Error, Env := mscorlib_System;

 CONST BLOCK_LEN = 10;
       REPEATS = 10000000;
       TEXT_LEN = 100000000;

 VAR text : POINTER TO ARRAY OF CHAR;
     ss_t0, ss_t1 : LONGINT;
     block : ARRAY BLOCK_LEN OF CHAR;
     count : LONGINT;
     i, j, base : INTEGER;

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
  block[0] := "a"; block[1] := "b"; block[2] := "c"; block[3] := "d"; block[4] := "e";
  block[5] := "f"; block[6] := "g"; block[7] := "h"; block[8] := "i"; block[9] := "j";

  NEW(text, TEXT_LEN);

  FOR i := 0 TO REPEATS - 1 DO
    base := i * BLOCK_LEN;
    FOR j := 0 TO BLOCK_LEN - 1 DO
      text[base + j] := block[j]
    END
  END;

  count := 0;
  FOR i := 0 TO TEXT_LEN - 1 DO
    IF text[i] = "a" THEN
      (* skip *)
    ELSIF text[i] = "e" THEN
      (* skip *)
    ELSIF text[i] = "h" THEN
      INC(count)
    ELSE
      (* skip *)
    END
  END;

  ss_t1 := Env.Environment.get_TickCount();
  Error.WriteString("TIME_MS="); WMs(ss_t1 - ss_t0); Error.WriteLn();

  WriteLong(count); Console.WriteLn
END _06_char_count.
