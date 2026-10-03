(* task 07 string_append — expected output: 250000 *)
(* build: gpcp /list- _07_string_append.cp    run: _07_string_append.exe *)
(* note: Component Pascal's string type is ARRAY OF CHAR with a 0X terminator, exactly
   like Oberon-2's and Modula-2's. Two fixed buffers are used here: every append copies
   the complete current text, including its terminator, into the alternate buffer,
   overwrites that copied terminator with x, writes the new terminator, and swaps buffers.
   This preserves the repeated whole-prefix copying measured by the task without requiring
   an impossible 250000-character native immutable-string value. *)
(* note: the final length is found by scanning the active buffer for the 0X terminator. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _07_string_append.cp"
   and /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT length is printed
   by the local WriteLong. *)

MODULE _07_string_append;
 IMPORT CPmain, Console;

 CONST N = 250000;

VAR textA : ARRAY N + 1 OF CHAR;
    textB : ARRAY N + 1 OF CHAR;
    len : LONGINT;
    i, j : INTEGER;
    active : INTEGER;
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
  active := 0;
  textA[0] := 0X;
  FOR i := 1 TO N DO
    IF active = 0 THEN
      FOR j := 0 TO len DO textB[j] := textA[j] END;
      textB[len] := "x";
      INC(len);
      textB[len] := 0X;
      active := 1
    ELSE
      FOR j := 0 TO len DO textA[j] := textB[j] END;
      textA[len] := "x";
      INC(len);
      textA[len] := 0X;
      active := 0
    END
  END;

  (* length of the string that was built, found by scanning for the 0X terminator *)
  len := 0;
  IF active = 0 THEN
    WHILE textA[len] # 0X DO INC(len) END
  ELSE
    WHILE textB[len] # 0X DO INC(len) END
  END;

  WriteLong(len); Console.WriteLn
END _07_string_append.
