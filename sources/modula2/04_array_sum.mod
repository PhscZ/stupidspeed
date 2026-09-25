(* task 04 array_sum -- expected output: 499999500000 *)
(* build: m2amd64.exe /sym:<symdir> 04_array_sum.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task04;
IMPORT STextIO, SLWholeIO;
VAR
   arr : ARRAY [0 .. 999999] OF CARDINAL;
   i : CARDINAL;
   total : LONGCARD;
BEGIN
   FOR i := 0 TO 999999 DO arr [i] := i END;
   total := 0;
   FOR i := 0 TO 999999 DO total := total + VAL (LONGCARD, arr [i]) END;
   SLWholeIO.WriteLongCard (total, 0); STextIO.WriteLn
END Task04.
