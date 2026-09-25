(* task 06 char_count -- expected output: 10000000 *)
(* build: m2amd64.exe /sym:<symdir> 06_char_count.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task06;
IMPORT STextIO, SLWholeIO, Storage;
FROM SYSTEM IMPORT ADDRESS, ADRCARD, CAST;

CONST
   n     = 100000000;
   block = "abcdefghij";

TYPE Bytes = ARRAY [0 .. n - 1] OF CHAR;
     BytesPtr = POINTER TO Bytes;

VAR
   blk   : ADDRESS;
   text  : BytesPtr;
   i     : CARDINAL;
   count : LONGCARD;

BEGIN
   Storage.ALLOCATE (blk, VAL (ADRCARD, n));
   text := CAST (BytesPtr, blk);
   FOR i := 0 TO (n DIV 10) - 1 DO
      text^ [i * 10 + 0] := "a";
      text^ [i * 10 + 1] := "b";
      text^ [i * 10 + 2] := "c";
      text^ [i * 10 + 3] := "d";
      text^ [i * 10 + 4] := "e";
      text^ [i * 10 + 5] := "f";
      text^ [i * 10 + 6] := "g";
      text^ [i * 10 + 7] := "h";
      text^ [i * 10 + 8] := "i";
      text^ [i * 10 + 9] := "j"
   END;
   count := 0;
   FOR i := 0 TO n - 1 DO
      IF (text^ [i] # "a") AND (text^ [i] # "e") AND (text^ [i] = "h") THEN
         count := count + 1
      END
   END;
   SLWholeIO.WriteLongCard (count, 0); STextIO.WriteLn;
   Storage.DEALLOCATE (blk, VAL (ADRCARD, n))
END Task06.
