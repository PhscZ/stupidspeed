(* task 02 switch_case -- expected output: 7500000075000000 *)
(* build: m2amd64.exe /sym:<symdir> 02_switch_case.mod  then  sblink.exe /machine:amd64 /out:prog.exe <obj> rtl-win-amd64.lib win64api.lib <mod>.lib *)
MODULE T64;

(* task 02 shape, but with 64-bit accumulator: sum must exceed 2^52 *)

IMPORT STextIO, SLWholeIO;

VAR
   i: LONGCARD;
   acc: LONGCARD;

BEGIN
   acc := 0;
   FOR i := 0 TO 99999999 DO
      CASE i MOD 4 OF
         0: acc := acc + 1
      |  1: acc := acc + i
      |  2: acc := acc + 2 * i
      |  3: acc := acc + 3 * i
      END
   END;
   SLWholeIO.WriteLongCard(acc, 0);
   STextIO.WriteLn
END T64.
