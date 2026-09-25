(* task 03 func_sum -- expected output: 100000000 *)
(* build: m2amd64.exe /sym:<symdir> 03_func_sum.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE Task03;
IMPORT STextIO, SLWholeIO, Func;
VAR
   i : CARDINAL;
   value : LONGCARD;
BEGIN
   value := 0;
   FOR i := 1 TO 100000000 DO
      value := Func.AddOne (value)
   END;
   SLWholeIO.WriteLongCard (value, 0); STextIO.WriteLn
END Task03.
