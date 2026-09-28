(* task 07 string_append -- expected output: 1000000 *)
(* build: m2amd64.exe /sym:<symdir> 07_string_append.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task07;
IMPORT STextIO, SLWholeIO;
VAR
   textA : ARRAY [0 .. 1000000] OF CHAR;
   textB : ARRAY [0 .. 1000000] OF CHAR;
   len, i, j, active : CARDINAL;
BEGIN
   len := 0;
   active := 0;
   textA [0] := 0C;
   FOR i := 1 TO 1000000 DO
      IF active = 0 THEN
         FOR j := 0 TO len DO textB [j] := textA [j] END;
         textB [len] := "x";
         len := len + 1;
         textB [len] := 0C;
         active := 1
      ELSE
         FOR j := 0 TO len DO textA [j] := textB [j] END;
         textA [len] := "x";
         len := len + 1;
         textA [len] := 0C;
         active := 0
      END
   END;
   len := 0;
   IF active = 0 THEN
      WHILE textA [len] # 0C DO len := len + 1 END
   ELSE
      WHILE textB [len] # 0C DO len := len + 1 END
   END;
   SLWholeIO.WriteLongCard (VAL (LONGCARD, len), 0); STextIO.WriteLn
END Task07.
