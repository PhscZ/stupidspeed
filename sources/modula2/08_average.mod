(* task 08 average -- expected output: 0.498046875 *)
(* build: m2amd64.exe /sym:<symdir> 08_average.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task08;
IMPORT STextIO, SLongIO, LongStr;
VAR
   i : CARDINAL;
   total, reading : LONGREAL;
   buf : ARRAY [0 .. 31] OF CHAR;
BEGIN
   total := 0.0;
   FOR i := 0 TO 99999999 DO
      reading := VAL (LONGREAL, i MOD 256) / 256.0;
      total := total + reading
   END;
   LongStr.RealToFixed (total / 100000000.0, 9, buf);
   STextIO.WriteString (buf); STextIO.WriteLn
END Task08.
