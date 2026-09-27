(* task 14 file_read — expected output: 484442112 *)
(* build: gpcp /list- _14_file_read.cp    run: _14_file_read.exe *)
(* note: data.bin (104857600 bytes) must be in the working directory. The file is read
   one megabyte at a time into a heap allocated UBYTE buffer with GPBinFiles.readNBytes,
   which may return short, so the loop keeps reading until it returns nothing. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and RTS.dll, GPFiles.dll and GPBinFiles.dll from %CROOT%\bin copied next to
   the executable (GPBinFiles is a foreign module and needs its own assembly). gpcp has
   no optimisation levels; the documented invocation is plain "gpcp _14_file_read.cp"
   and /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT total is printed
   by the local WriteLong. *)

MODULE _14_file_read;
 IMPORT CPmain, Console, GPBinFiles;

 CONST CHUNK = 1048576;   (* 1 MiB *)

 VAR f : GPBinFiles.FILE;
     buf : POINTER TO ARRAY OF UBYTE;
     total : LONGINT;
     got, i : INTEGER;

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
  f := GPBinFiles.openFileRO("data.bin");

  IF f # NIL THEN
    NEW(buf, CHUNK);
    total := 0;

    LOOP
      IF GPBinFiles.EOF(f) THEN EXIT END;
      got := GPBinFiles.readNBytes(f, buf^, CHUNK);
      IF got <= 0 THEN EXIT END;
      FOR i := 0 TO got - 1 DO
        total := total + buf[i]
      END
    END;

    GPBinFiles.CloseFile(f);

    WriteLong(total MOD 4294967296); Console.WriteLn
  END
END _14_file_read.
