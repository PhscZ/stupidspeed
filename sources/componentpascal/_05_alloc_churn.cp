(* task 05 alloc_churn — expected output: 1274991808 *)
(* build: gpcp /list- _05_alloc_churn.cp    run: _05_alloc_churn.exe *)
(* note: NEW allocates the 64 byte buffer on the .NET managed heap, and the slots array
   keeps the last 256 of them reachable while dropping the one it replaces, so the
   replaced buffers become garbage for the collector; that is the C row's free(). *)
(* note: UBYTE is gpcp's unsigned 8 bit type, and the release notes require the USHORT
   cast when a signed value is narrowed into one. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and %CROOT%\bin\RTS.dll copied next to the executable. gpcp has no
   optimisation levels; the documented invocation is plain "gpcp _05_alloc_churn.cp"
   and /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT total is printed
   by the local WriteLong. *)

MODULE _05_alloc_churn;
 IMPORT CPmain, Console;

 CONST BUF_SIZE = 64;
       SLOTS = 256;

 TYPE Buffer = POINTER TO ARRAY OF UBYTE;

 VAR slots : POINTER TO ARRAY OF Buffer;
     buf : Buffer;
     total : LONGINT;
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

BEGIN
  NEW(slots, SLOTS);
  total := 0;

  FOR i := 0 TO 9999999 DO
    NEW(buf, BUF_SIZE);
    buf[0] := USHORT(i MOD 256);
    total := total + buf[0];
    slots[SHORT(i MOD 256)] := buf
  END;

  WriteLong(total); Console.WriteLn
END _05_alloc_churn.
