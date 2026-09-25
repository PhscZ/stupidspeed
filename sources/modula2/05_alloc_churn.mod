(* task 05 alloc_churn -- expected output: 1274991808 *)
(* build: m2amd64.exe /sym:<symdir> 05_alloc_churn.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task05;
IMPORT STextIO, SLWholeIO, Storage;
FROM SYSTEM IMPORT ADDRESS, ADRCARD, CAST;

TYPE Buf = ARRAY [0 .. 63] OF CARDINAL;
     BufPtr = POINTER TO Buf;

VAR
   slots : ARRAY [0 .. 255] OF BufPtr;
   blks  : ARRAY [0 .. 255] OF ADDRESS;
   i, k  : CARDINAL;
   total : LONGCARD;
   p     : BufPtr;

BEGIN
   FOR k := 0 TO 255 DO slots [k] := NIL; blks [k] := NIL END;
   total := 0;
   FOR i := 0 TO 9999999 DO
      Storage.ALLOCATE (blks [i MOD 256], VAL (ADRCARD, 256));
      p := CAST (BufPtr, blks [i MOD 256]);
      p^ [0] := i MOD 256;
      total := total + VAL (LONGCARD, p^ [0]);
      IF slots [i MOD 256] # NIL THEN
         Storage.DEALLOCATE (blks [i MOD 256], VAL (ADRCARD, 256))
      END;
      slots [i MOD 256] := p
   END;
   SLWholeIO.WriteLongCard (total, 0); STextIO.WriteLn
END Task05.
