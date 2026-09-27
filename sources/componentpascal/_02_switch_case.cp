(* task 02 switch_case — expected output: 7500000075000000 *)
(* build: gpcp /list- _02_switch_case.cp    run: _02_switch_case.exe *)
(* note: Component Pascal's CASE is the four-way decision; gpcp emits a .NET switch,
   which the JIT turns into a jump table, so this is not an if/else chain. gpcp does not
   allow a LONGINT CASE selector, so the loop index is a 32 bit INTEGER (it only runs to
   99999999) and the accumulator stays a LONGINT. *)
(* note: the total exceeds 2^32, so the accumulator is a LONGINT, which
   Console.WriteInt cannot print; the local WriteLong does it. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _02_switch_case.cp"
   and /list- only suppresses the .lst listing file. *)

MODULE _02_switch_case;
 IMPORT CPmain, Console;

 VAR acc : LONGINT;
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
  acc := 0;

  FOR i := 0 TO 99999999 DO
    CASE i MOD 4 OF
      0: acc := acc + 1
    | 1: acc := acc + i
    | 2: acc := acc + 2 * i
    | 3: acc := acc + 3 * i
    END
  END;

  WriteLong(acc); Console.WriteLn
END _02_switch_case.
