(* task 07 string_append -- expected output: 1000000 *)
(* build: m2amd64.exe /sym:<symdir> 07_string_append.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task07;
IMPORT STextIO, SLWholeIO;
VAR
   text : ARRAY [0 .. 1000000] OF CHAR;
   len  : CARDINAL;
   i    : CARDINAL;
BEGIN
   len := 0;
   FOR i := 1 TO 1000000 DO
      text [len] := "x";
      len := len + 1
   END;
   text [len] := 0C;
   SLWholeIO.WriteLongCard (VAL (LONGCARD, len), 0); STextIO.WriteLn
END Task07.
