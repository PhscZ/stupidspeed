(* task 15 file_write — expected output: 52428800 *)
(* build: gpcp /list- _15_file_write.cp    run: _15_file_write.exe *)
(* note: writes out.bin into the working directory: one megabyte of the bytes 0..255
   repeated 4096 times, written 50 times through GPBinFiles.WriteNBytes. GPBinFiles
   buffers the stream, and CloseFile flushes it; .NET's FileStream has no fsync here,
   so the flush at the end of the buffered stream is as far as this library goes. *)
(* note: build and run from the directory holding the source, with CROOT set to the
   gpcp-NET tree, CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem, %CROOT%\bin on
   PATH, and RTS.dll, GPFiles.dll and GPBinFiles.dll from %CROOT%\bin copied next to
   the executable (GPBinFiles is a foreign module and needs its own assembly). gpcp has
   no optimisation levels; the documented invocation is plain "gpcp _15_file_write.cp"
   and /list- only suppresses the .lst listing file. *)
(* note: Console.WriteInt takes a 32 bit INTEGER only, so the LONGINT count is printed
   by the local WriteLong. *)

MODULE _15_file_write;
 IMPORT CPmain, Console, GPBinFiles;

 CONST CHUNK = 1048576;   (* 1 MiB *)
       REPEATS = 50;

 VAR f : GPBinFiles.FILE;
     buf : POINTER TO ARRAY OF UBYTE;
     written : LONGINT;
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
  NEW(buf, CHUNK);
  FOR i := 0 TO CHUNK - 1 DO
    buf[i] := USHORT(i MOD 256)
  END;

  f := GPBinFiles.createFile("out.bin");

  IF f # NIL THEN
    written := 0;
    FOR i := 1 TO REPEATS DO
      GPBinFiles.WriteNBytes(f, buf^, CHUNK);
      written := written + CHUNK
    END;
    GPBinFiles.CloseFile(f);

    WriteLong(written); Console.WriteLn
  END
END _15_file_write.
